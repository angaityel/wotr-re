-- chunkname: @scripts/managers/admin/script_anti_cheat.lua

ScriptAntiCheat = class(ScriptAntiCheat)

local ANTI_CHEAT_DNS = "client.easyanticheat.net"
local ANTI_CHEAT_PORT = 27015
local SERVER_BAN_DURATION = 3600

ScriptAntiCheat.game_id = 13

local PEER_TABLE = {
	kicked = false
}
local DISCONNECT_GRACE_TIME = 30

function ScriptAntiCheat:init(settings)
	self._settings = settings

	if settings.enforce and GameSettingsDevelopment.anti_cheat_enabled then
		self:_connect(self._settings.anti_cheat_dns or ANTI_CHEAT_DNS)

		self._enforce = true
	end

	self._unauthorized_peers = {}
	self._peers = {}
end

function ScriptAntiCheat:destroy()
	if self._enforce then
		AntiCheatServer.disconnect()
	end
end

function ScriptAntiCheat:_connect()
	AntiCheatServer.connect(ScriptAntiCheat.game_id, ANTI_CHEAT_DNS, ANTI_CHEAT_PORT, callback(self, "cb_connection_status"))
end

function ScriptAntiCheat:cb_connection_status(connected)
	if connected and not self._connected then
		for peer, peer_data in pairs(self._peers) do
			self:_set_authorized(peer, false)
		end
	elseif not connected and self._connected then
		for peer, peer_data in pairs(self._peers) do
			AntiCheatServer.query_peer(peer, peer_data.key)
			self:_set_authorized(peer, true)
		end
	end

	self._connected = connected
end

function ScriptAntiCheat:cb_peer_status_changed(peer, status)
	Managers.state.event:trigger("anti_cheat_status_changed", peer, status)

	local peer_data = self._peers[peer]

	peer_data.status = status

	printf("cb_peer_status_changed %s %i", peer, status)

	if status == AntiCheat.USER_BANNED and not peer_data.kicked then
		peer_data.kicked = true

		Managers.admin:ban_player(peer, "Anti Cheat Banned", SERVER_BAN_DURATION)
		print("AntiCheat.USER_BANNED", peer)
	elseif status == AntiCheat.USER_DISCONNECTED then
		print("AntiCheat.USER_DISCONNECTED", peer)
		self:_set_authorized(peer, false)
	elseif status == AntiCheat.USER_AUTHENTICATING then
		print("AntiCheat.USER_AUTHENTICATING", peer)
		self:_set_authorized(peer, false)
	elseif status == AntiCheat.USER_AUTHENTICATED then
		print("AntiCheat.USER_AUTHENTICATED", peer)
		self:_set_authorized(peer, true)
	end
end

function ScriptAntiCheat:_set_authorized(peer, authorized)
	if authorized then
		self._unauthorized_peers[peer] = nil
	else
		self._unauthorized_peers[peer] = self._unauthorized_peers[peer] or Managers.time:time("main")
	end
end

function ScriptAntiCheat:register_peer(peer, key)
	if not self._enforce then
		return
	end

	assert(not self._peers[peer], "Peer %s already exists in peer table.", peer)
	Managers.state.event:trigger("anti_cheat_connect", peer)

	local peer_table = table.clone(PEER_TABLE)

	peer_table.status = AntiCheat.USER_AUTHORIZING
	peer_table.key = key
	self._peers[peer] = peer_table

	if self._connected then
		self:_set_authorized(peer, false)
	else
		self:_set_authorized(peer, true)
	end

	AntiCheatServer.register_peer(peer, key, callback(self, "cb_peer_status_changed"))
end

function ScriptAntiCheat:unregister_peer(peer)
	if not self._enforce then
		return
	end

	if self._peers[peer] then
		AntiCheatServer.unregister_peer(peer)
		self:_set_authorized(peer, true)

		self._peers[peer] = nil
	end
end

function ScriptAntiCheat:update(dt, t)
	if not self._connected or not self._enforce then
		return
	end

	for peer, disconnect_time in pairs(self._unauthorized_peers) do
		local peer_data = self._peers[peer]

		if peer_data.kicked then
			-- block empty
		elseif t > disconnect_time + DISCONNECT_GRACE_TIME then
			peer_data.kicked = true

			Managers.state.event:trigger("anti_cheat_kick", peer)

			if self._settings.enforce_by_kick then
				Managers.admin:kick_player(peer, "Anti Cheat Disconnect")
			end
		elseif math.floor(disconnect_time - t) ~= math.floor(disconnect_time - t + dt) then
			printf("time until kick <%s>: %i", peer, disconnect_time + DISCONNECT_GRACE_TIME - t)
			AntiCheatServer.query_peer(peer, peer_data.key)
		end
	end
end
