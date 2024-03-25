-- chunkname: @foundation/scripts/managers/network/lobby_manager_lan.lua

LobbyManagerLan = class(LobbyManagerLan)
LobbyState = LobbyState or {}
LobbyState.OFFLINE = LobbyState.OFFLINE or {}
LobbyState.CREATING = LobbyState.CREATING or {}
LobbyState.JOINING = LobbyState.JOINING or {}
LobbyState.JOINED = LobbyState.JOINED or {}
LobbyState.FAILED = LobbyState.FAILED or {}
LobbyManagerLan.LOBBY_MAX_MEMBERS = 256
LobbyManagerLan.TYPE = "lan"

function LobbyManagerLan:init(options)
	fassert(options.port, "Network port not set")

	self.port = options.port
	self.lobby_name = self:generate_lobby_name()
	self._player_name = self:generate_player_name()
	self.client = nil
	self.lobby = nil
	self.hosting = false
	self.server = false
	self.hot_joining = false
	self.state = LobbyState.OFFLINE
	self.config_file_name = "global"
	self.network_hash = Network.config_hash(self.config_file_name)
	self.project_hash = options.project_hash

	local settings = Application.settings()
	local trunk_revision = settings and settings.content_revision
	local engine_revision = Application.build_identifier()

	self:set_network_hash()
end

function LobbyManagerLan:set_network_hash(extra_hash)
	local trunk_revision = self.content_revision
	local engine_revision = Application.build_identifier()

	if GameSettingsDevelopment.network_revision_check_enabled then
		self.combined_hash = Application.make_hash(self.network_hash, trunk_revision, engine_revision, self.project_hash or "", extra_hash or "")
	else
		self.combined_hash = self.network_hash
	end
end

function LobbyManagerLan:player_name()
	return self._player_name
end

function LobbyManagerLan:set_game_server(val)
	self.lobby:set_game_session_host(val)
end

function LobbyManagerLan:generate_lobby_name()
	local adj = {
		"Aggressive",
		"Serious",
		"Humiliating",
		"Sub-par",
		"Humorous",
		"Scary",
		"Humdrum",
		"Crazy",
		"Intense"
	}
	local loc = {
		"Beach",
		"Forest",
		"Knoll",
		"Mountain",
		"Sea",
		"Cave",
		"Castle",
		"Lava",
		"Winter",
		"Desert"
	}
	local act = {
		"Fight",
		"Skirmish",
		"Party",
		"Gathering",
		"Ruckus",
		"Dance",
		"Showdown",
		"Trouble",
		"Conundrum"
	}

	local function r(t)
		return t[Math.random(1, #t)]
	end

	return "The " .. r(adj) .. " " .. r(loc) .. " " .. r(act)
end

function LobbyManagerLan:generate_player_name()
	local s1 = {
		"Bo",
		"Ro",
		"Fa",
		"Jo",
		"La",
		"So",
		"Wea"
	}
	local s2 = {
		"ger",
		"land",
		"rry",
		"hn",
		"toya",
		"to",
		"ton"
	}
	local s3 = {
		"Mure",
		"Robinson",
		"Forell",
		"Jones",
		"Jackson",
		"Mayor",
		"Will"
	}

	local function r(t)
		return t[Math.random(1, #t)]
	end

	return r(s1) .. r(s2) .. " " .. r(s3)
end

function LobbyManagerLan:debug_print_hashes()
	local settings = Application.settings()
	local trunk_revision = settings and settings.content_revision
	local engine_revision = Application.build_identifier()

	print("[LobbyManagerSteam] Revision check enabled:", GameSettingsDevelopment.network_revision_check_enabled, "Combined hash:", self.combined_hash, "Network hash:", self.network_hash, "Trunk revision:", trunk_revision, "Engine revision:", engine_revision)
end

function LobbyManagerLan:create_lobby(cb_lobby_created)
	self.client = Network.init_lan_client(self.config_file_name)
	self.lobby = Network.create_lan_lobby(self.port, self.LOBBY_MAX_MEMBERS)

	fassert(self.lobby, "[LobbyManagerLan] Network.create_lobby returned nil")

	if LanLobby.state(self.lobby) == LanLobby.FAILED then
		print("[LobbyManagerLan] Creation of lobby FAILED, probably due to already existing lobby on that port.")
		self:reset()

		return false
	end

	self.hosting = true
	self.cb_lobby_created = cb_lobby_created

	self:set_lobby_data("network_hash", self.combined_hash)
	self:set_lobby_data("host", Network.peer_id())
	self:set_lobby_data("server_name", self.lobby_name)
	fassert(self.state == LobbyState.OFFLINE, "[LobbyManagerLan] Trying to create lobby while lobby is running")

	self.state = LobbyState.CREATING

	return true
end

function LobbyManagerLan:join_lobby(lobby_num)
	local lobby = Network.join_lan_lobby(self.client:lobby_browser():lobby(lobby_num).address)

	fassert(lobby, "[LobbyManagerLan] Network.join_lan_lobby returned nil")

	self.lobby = lobby
	self.hosting = false
	self.state = LobbyState.JOINING
end

function LobbyManagerLan:join_lobby_by_ip(address)
	if not self.client then
		Network.init_lan_client(self.config_file_name)
	end

	self.lobby = Network.join_lan_lobby(address)
	self.hosting = false
	self.state = LobbyState.JOINING
end

function LobbyManagerLan:set_server(value)
	self.server = value
end

function LobbyManagerLan:num_lobby_clients()
	local members = LanLobby.members()
	local num = 0

	for index, member in ipairs(members) do
		if member ~= LanLobby.lobby_host(self.lobby) then
			num = num + 1
		end
	end

	return num
end

function LobbyManagerLan:destroy()
	self:reset()
end

function LobbyManagerLan:reset()
	if script_data and script_data.network_debug then
		print("[LobbyManagerLan] RESETTING LOBBY MANAGER!")
	end

	if self.lobby then
		Network.leave_lan_lobby(self.lobby)
	end

	if self.client then
		Network.shutdown_lan_client(self.client)
	end

	self.client = nil
	self.lobby = nil
	self.hosting = false
	self.server = false
	self.hot_joining = false
	self._game_server_set = nil
	self.state = LobbyState.OFFLINE
end

function LobbyManagerLan:refresh_lobby_browser()
	if not self.client then
		self.client = Network.init_lan_client(self.config_file_name)
	end

	self.client:lobby_browser():refresh(self.port)
end

function LobbyManagerLan:lobby_browser_content()
	local lobby_datas = {}

	for i = 1, self.client:lobby_browser():num_lobbies() do
		local lobby_data = self.client:lobby_browser():lobby(i - 1)

		lobby_data.lobby_num = i - 1

		if lobby_data.network_hash == self.combined_hash then
			lobby_data.valid = true
		else
			lobby_data.valid = false
		end

		lobby_datas[#lobby_datas + 1] = lobby_data
	end

	return lobby_datas
end

function LobbyManagerLan:lobby_members()
	return LanLobby.members(self.lobby)
end

function LobbyManagerLan:is_lobby_owner(player_id)
	return self.lobby:lobby_host() == player_id
end

function LobbyManagerLan:player_id()
	return Network.peer_id()
end

function LobbyManagerLan:set_lobby_data(key, value)
	self.lobby:set_data(key, tostring(value))
end

function LobbyManagerLan:get_lobby_data(key)
	return self.lobby:data(key)
end

function LobbyManagerLan:game_server_set()
	if self._game_server_set ~= nil then
		return self._game_server_set and self.lobby:game_session_host()
	else
		return self.lobby:game_session_host()
	end
end

function LobbyManagerLan:set_game_server_set(is_set)
	self._game_server_set = is_set
end

function LobbyManagerLan:update(dt)
	if self.state == LobbyState.JOINED and not self.hosting and not self.hot_joining then
		local host = self.lobby:data("host")

		if host then
			RPC.rpc_notify_lobby_joined(host)

			self.hot_joining = true
		end
	end

	self:_update_lobby_state()
end

function LobbyManagerLan:_update_lobby_state()
	local lobby = self.lobby

	if self.state == LobbyState.CREATING and LanLobby.state(lobby) == LanLobby.JOINED then
		if self.cb_lobby_created then
			self.cb_lobby_created()
		end

		print("im LOBBY HOST", Network.peer_id())

		self.state = LobbyState.JOINED
	end

	if self.state == LobbyState.JOINING and LanLobby.state(lobby) == LanLobby.JOINED then
		print("im LOBBY CLIENT", Network.peer_id())

		self.state = LobbyState.JOINED
	end

	if lobby and LanLobby.state(lobby) == LanLobby.FAILED then
		self.state = LobbyState.FAILED
	end
end

function LobbyManagerLan:is_dedicated_server()
	return false
end

function LobbyManagerLan:server_name()
	return self:get_lobby_data("server_name")
end

function LobbyManagerLan:game_description()
	return
end
