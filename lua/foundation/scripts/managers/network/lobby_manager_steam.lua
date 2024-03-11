-- chunkname: @foundation/scripts/managers/network/lobby_manager_steam.lua

LobbyManagerSteam = class(LobbyManagerSteam)
local argv = {
	Application.argv()
}
LobbyState = LobbyState or {}
LobbyState.OFFLINE = "offline"
LobbyState.CREATING = "creating"
LobbyState.JOINING = "joining"
LobbyState.JOINED = "joined"
LobbyState.FAILED = "failed"

LobbyManagerSteam.LOBBY_TYPE = Network.STEAM_LOBBY_PUBLIC

if table.find(argv, "-lobbyprivate") then
	LobbyManagerSteam.LOBBY_TYPE = Network.STEAM_LOBBY_PRIVATE
end

if table.find(argv, "-lobbyfriends") then
	LobbyManagerSteam.LOBBY_TYPE = Network.STEAM_LOBBY_FRIENDSONLY
end

LobbyManagerSteam.LOBBY_MAX_MEMBERS = 256

for i,v in ipairs(argv) do
	if argv[i] == "-lobbymaxmembers" then
		LobbyManagerSteam.LOBBY_MAX_MEMBERS = tonumber(argv[i + 1])
	end
end

LobbyManagerSteam.TYPE = "steam"
LobbyManagerSteam.GAME_TAGS_SEPARATOR = ";"
LobbyManagerSteam.GAME_TAG_SEPARATOR = "="

local QOS_MIN_CLIENT = 30
local QOS_MIN_GAME_SERVER = 30
local QOS_MIN_LOBBY_SERVER = 30

function LobbyManagerSteam:init(options)
	self.lobby_name = self:custom_lobby_name()
	self.client = nil
	self.lobby = nil
	self.hosting = false
	self.server = false
	self.hot_joining = false
	self._game_server_mode = nil
	self.state = LobbyState.OFFLINE
	self.config_file_name = "global"
	self.network_hash = Network.config_hash(self.config_file_name)

	local settings = Application.settings()

	self.content_revision = settings.content_revision
	self.project_hash = options.project_hash
	self.game_server_settings = settings.steam and settings.steam.game_server_settings
	self.network_settings = settings.steam and settings.steam.network or {}

	local default_filter_settings = self.network_settings.default_filter_settings

	self.server_filter_settings = default_filter_settings and table.clone(default_filter_settings) or {}

	self:set_server_browse_mode(self.network_settings.default_browse_mode or "lan")
	self:set_network_hash()

	self._refreshed_server_index = -1
	self.game_tags = {}
end

function LobbyManagerSteam:set_network_hash(extra_hash)
	local trunk_revision = self.content_revision
	local engine_revision = Application.build_identifier()

	if GameSettingsDevelopment.network_revision_check_enabled then
		self.combined_hash = Application.make_hash(self.network_hash, trunk_revision, engine_revision, self.project_hash or "", extra_hash or "")
	else
		self.combined_hash = self.network_hash
	end
end

function LobbyManagerSteam:set_game_tag(key, value)
	if self.lobby and (not self.game_tags[key] or self.game_tags[key] ~= value) then
		self.game_tags[key] = value

		local tag_str = self:game_tag_table_to_string(self.game_tags)

		SteamGameServer.set_game_tags(self.lobby, tag_str)
	end
end

function LobbyManagerSteam:player_name()
	local settings = Application.settings()

	return settings.dedicated_server and self.game_server_settings.server_init_settings.server_name or Steam.user_name()
end

function LobbyManagerSteam:custom_lobby_name()
	local lobbyname = ""

	for i,v in ipairs(argv) do
		if argv[i] == "-lobbyname" then
			lobbyname = argv[i + 1]
		end
	end

	if lobbyname ~= "" then
		return lobbyname
	else
		lobbyname = self:generate_lobby_name()
		return lobbyname
	end
end

function LobbyManagerSteam:generate_lobby_name()
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

function LobbyManagerSteam:create_lobby(cb_lobby_created, no_chat)
	if not self.client then
		self:create_network_client()
	end

	self.lobby = Network.create_steam_lobby(self.LOBBY_TYPE, self.LOBBY_MAX_MEMBERS)
	self.hosting = true
	self.cb_lobby_created = cb_lobby_created
	self.state = LobbyState.CREATING

	local network_settings = self.network_settings

	if network_settings.qos then
		Network.enable_qos(network_settings.qos_min or QOS_MIN_LOBBY_SERVER, network_settings.qos_start or network_settings.qos, network_settings.qos)
	end

	if not no_chat then
		Managers.chat:register_channel(1, callback(self, "lobby_members"))
	end
end

function LobbyManagerSteam:join_server_by_ip(ip_port, password)
	if not self.client then
		self:create_network_client()
	end

	self._game_server_mode = "client"
	self.lobby = Network.join_steam_server(ip_port, password)

	Presence.advertise_playing(ip_port)
	self:_post_join_lobby()
end

function LobbyManagerSteam:join_lobby(lobby_num)
	local lobby = self.client:lobby_browser():lobby(lobby_num)

	self.lobby = Network.join_steam_lobby(lobby.id)

	self:_post_join_lobby()
end

function LobbyManagerSteam:join_server(lobby_num, password)
	self._game_server_mode = "client"

	local lobby = self.client:server_browser():server(lobby_num)

	self.lobby = Network.join_steam_server(lobby.ip_address, lobby.query_port, password)

	Presence.advertise_playing(lobby.ip_address .. ":" .. lobby.query_port, nil, password)
	self:_post_join_lobby()

	return lobby
end

function LobbyManagerSteam:_post_join_lobby()
	self.hosting = false
	self.state = LobbyState.JOINING

	local network_settings = self.network_settings

	if network_settings.qos then
		Network.enable_qos(QOS_MIN_CLIENT, network_settings.qos, network_settings.qos)
	end
end

function LobbyManagerSteam:set_server(value)
	self.server = value
end

function LobbyManagerSteam:num_lobby_clients()
	local members = SteamLobby.members()
	local num = 0

	for index, member in ipairs(members) do
		if member ~= SteamLobby.lobby_host(self.lobby) then
			num = num + 1
		end
	end

	return num
end

function LobbyManagerSteam:destroy()
	self:reset()
end

function LobbyManagerSteam:abort_join_server()
	if self.lobby then
		if self._game_server_mode == "server" then
			Network.shutdown_steam_server(self.lobby)

			self._game_server_mode = nil
		elseif self._game_server_mode == "client" then
			Network.leave_steam_server(self.lobby)

			self._game_server_mode = nil
		else
			Network.leave_steam_lobby(self.lobby)
		end
	end

	self.lobby = nil
	self.hot_joining = false
	self.state = LobbyState.OFFLINE

	Managers.chat:unregister_channel(1)

	if rawget(_G, "Presence") then
		Presence.stop_advertise_playing()
	end
end

function LobbyManagerSteam:reset()
	if self.lobby then
		if self._game_server_mode == "server" then
			Network.shutdown_steam_server(self.lobby)

			self._game_server_mode = nil
		elseif self._game_server_mode == "client" then
			Network.leave_steam_server(self.lobby)

			self._game_server_mode = nil
		else
			Network.leave_steam_lobby(self.lobby)
		end
	end

	if self.client then
		Network.shutdown_steam_client(self.client)
	end

	self.client = nil
	self.lobby = nil
	self.hosting = false
	self.server = false
	self.hot_joining = false
	self._game_server_set = nil
	self._refreshing_server = nil
	self.state = LobbyState.OFFLINE

	Managers.chat:unregister_channel(1)

	if rawget(_G, "Presence") then
		Presence.stop_advertise_playing()
	end
end

function LobbyManagerSteam:is_refreshing_lobby_browser()
	assert(self.client, "[LobbyManagerSteam] Trying to check if lobby browser is still refreshing without first refreshing")

	local lobby_browser = self.client:lobby_browser()

	return lobby_browser:is_refreshing()
end

function LobbyManagerSteam:is_refreshing_server_browser()
	assert(self.client, "[LobbyManagerSteam] Trying to check if server browser is still refreshing without first refreshing")

	local server_browser = self.client:server_browser()

	return server_browser:is_refreshing()
end

function LobbyManagerSteam:create_network_client()
	self.client = Network.init_steam_client(self.config_file_name)

	self.client:server_browser():add_filter(self.server_filter_settings)
end

function LobbyManagerSteam:add_lobby_browser_filter(key, value, compare)
	local browser = self.client:lobby_browser()

	browser:add_filter(key, value, browser[compare])
end

function LobbyManagerSteam:clear_lobby_browser_filters()
	self.client:lobby_browser():clear_filters()
end

function LobbyManagerSteam:refresh_lobby_browser()
	self._lobby_data = {}

	if not self.client then
		self:create_network_client()
	end

	local lobby_browser = self.client:lobby_browser()

	lobby_browser:refresh()
end

function LobbyManagerSteam:refresh_server_browser()
	self._server_data = {}

	if not self.client then
		self:create_network_client()
	end

	self._refreshed_server_index = -1

	self:abort_server_browser_refresh()

	local server_browser = self.client:server_browser()

	if self.server_browse_mode == "lan" then
		server_browser:refresh(SteamServerBrowser.LAN)
	elseif self.server_browse_mode == "internet" then
		server_browser:refresh(SteamServerBrowser.INTERNET)
	elseif self.server_browse_mode == "friends" then
		server_browser:refresh(SteamServerBrowser.FRIENDS)
	elseif self.server_browse_mode == "favorites" then
		server_browser:refresh(SteamServerBrowser.FAVORITES)
	elseif self.server_browse_mode == "history" then
		server_browser:refresh(SteamServerBrowser.HISTORY)
	else
		ferror("[LobbyManagerSteam] Invalid server browse mode: %s ", tostring(self.server_browse_mode))
	end
end

function LobbyManagerSteam:abort_server_browser_refresh()
	local server_browser = self.client:server_browser()

	if server_browser:is_refreshing() then
		server_browser:abort_refresh()

		self._refreshing_server = nil
	end
end

function LobbyManagerSteam:refresh_server(server_index)
	self:abort_server_browser_refresh()

	local server_browser = self.client:server_browser()

	server_browser:refresh_server(server_index)
	server_browser:request_data(server_index)

	local server_data = self._server_data[server_index + 1]

	for key, _ in pairs(server_data) do
		server_data[key] = nil
	end

	self._refreshing_server = server_index
end

function LobbyManagerSteam:set_server_browse_mode(mode)
	fassert(mode == "lan" or mode == "internet" or mode == "favorites" or mode == "history" or mode == "friends", "[LobbyManagerSteam] Invalid server browse mode: %s ", tostring(mode))

	self.server_browse_mode = mode
end

function LobbyManagerSteam:lobby_browser_content(requested_variables)
	local lobby_browser = self.client:lobby_browser()
	local num_lobbies = lobby_browser:num_lobbies()
	local lobby_data = self._lobby_data

	for i = 1, num_lobbies do
		local lobby_index = i - 1
		local lobby = lobby_data[i]

		if not lobby then
			lobby = {}
			lobby_data[i] = lobby
		end

		lobby.lobby_name = lobby_browser:data(lobby_index, "lobby_name")
		lobby.lobby_num = lobby_index

		if requested_variables then
			for _, var in ipairs(requested_variables) do
				lobby[var] = lobby_browser:data(lobby_index, var)
			end
		end

		local lobby_network_hash = lobby_browser:data(lobby_index, "network_hash")

		if lobby_network_hash == self.combined_hash then
			lobby.valid = true
		else
			lobby.valid = false
		end
	end

	return lobby_data
end

function LobbyManagerSteam:server_browser_content(requested_variables)
	local server_browser = self.client:server_browser()
	local num_servers = server_browser:num_servers()
	local server_data = self._server_data

	for i = 1, num_servers do
		local server_index = i - 1
		local server = server_data[i]

		if not server then
			server = server_browser:server(server_index)
			server_data[i] = server

			server_browser:request_data(server_index)
		end

		if self._refreshing_server == server_index and not server_browser:is_refreshing() then
			local refreshed_server = server_browser:server(server_index)

			for key, value in pairs(refreshed_server) do
				server[key] = value
			end

			self._refreshing_server = nil
		end

		for _, var in ipairs(requested_variables) do
			server[var] = server_browser:data(server_index, var)
		end

		server.lobby_name = server.server_name
		server.lobby_num = i - 1

		local lobby_network_hash = server_browser:data(server_index, "network_hash")

		if lobby_network_hash == self.combined_hash then
			server.valid = true
		else
			server.valid = false
		end
	end

	return server_data
end

function LobbyManagerSteam:server_browser_content_no_data_request(requested_variables)
	local server_browser = self.client:server_browser()
	local num_servers = server_browser:num_servers()
	local server_data = self._server_data

	for i = 1, num_servers do
		local server_index = i - 1
		local server = server_data[i]

		if not server then
			server = server_browser:server(server_index)
			server_data[i] = server
		end

		if self._refreshing_server == server_index and not server_browser:is_refreshing() then
			local refreshed_server = server_browser:server(server_index)

			for key, value in pairs(refreshed_server) do
				server[key] = value
			end

			self._refreshing_server = nil
		end

		for _, var in ipairs(requested_variables) do
			server[var] = server_browser:data(server_index, var)
		end

		if server.tags and server.tags ~= "" then
			local tag_table = self:game_tag_string_to_table(server.tags)

			for key, value in pairs(tag_table) do
				server[key] = value
			end
		end

		server.lobby_name = server.server_name
		server.lobby_num = i - 1

		local lobby_network_hash = server.network_hash

		if lobby_network_hash == self.combined_hash then
			server.valid = true
		else
			server.valid = false
		end
	end

	return server_data
end

function LobbyManagerSteam:request_server_data(server_index)
	local server_browser = self.client:server_browser()

	server_browser:request_data(server_index)
end

function LobbyManagerSteam:request_players(server_index, query_port)
	local server_browser = self.client:server_browser()

	server_browser:request_players(server_index, query_port)
end

function LobbyManagerSteam:players(server_index)
	local server_browser = self.client:server_browser()

	return server_browser:players(server_index)
end

function LobbyManagerSteam:lobby_members()
	return self.lobby:members()
end

function LobbyManagerSteam:is_lobby_owner(player_id)
	if self._game_server_mode then
		return self.server
	else
		return self.lobby:lobby_host() == player_id
	end
end

function LobbyManagerSteam:player_id()
	return Network.peer_id()
end

function LobbyManagerSteam:set_lobby_data(key, value)
	self.lobby:set_data(key, value)
end

function LobbyManagerSteam:get_lobby_data(key)
	return self.lobby:data(key)
end

function LobbyManagerSteam:game_server_set()
	if self._game_server_set ~= nil then
		return self._game_server_set and self.lobby:game_session_host()
	elseif self._game_server_mode ~= "server" then
		return self.lobby:game_session_host()
	end
end

function LobbyManagerSteam:set_game_server(val)
	if not self._game_server_mode then
		self.lobby:set_game_session_host(val)
	end
end

function LobbyManagerSteam:set_game_server_set(is_set)
	self._game_server_set = is_set
end

function LobbyManagerSteam:update(dt)
	if self._game_server_mode == "server" then
		local state = SteamGameServer.state(self.lobby)

		SteamGameServer.run_callbacks(self.lobby, self)

		if state == SteamGameServer.CONNECTED then
			if self.state ~= LobbyState.JOINED then
				CommandWindow.print("Server is connected")
			end

			self.state = LobbyState.JOINED

			self:set_lobby_data("network_hash", self.combined_hash)
			self:set_game_tag("network_hash", self.combined_hash)
		elseif state == SteamGameServer.DISCONNECTED then
			print("[QF] Connection lost to Steam, shutting down the boutique...")
			Application.quit()
		end
	elseif self.state == LobbyState.JOINED and not self.hosting and not self.hot_joining then
		if self._game_server_mode == "client" then
			Managers.chat:register_channel(1, callback(self, "lobby_members"))

			local game_server = self.lobby:game_session_host()

			RPC.rpc_notify_lobby_joined(game_server)

			self.hot_joining = true
		else
			local host = self.lobby:data("host")

			if host then
				Managers.chat:register_channel(1, callback(self, "lobby_members"))
				RPC.rpc_notify_lobby_joined(host)

				self.hot_joining = true
			end
		end
	end

	self:_update_lobby_state()
end

function LobbyManagerSteam:debug_print_hashes()
	local settings = Application.settings()
	local trunk_revision = settings and settings.content_revision
	local engine_revision = Application.build_identifier()

	print("[LobbyManagerSteam] Revision check enabled:", GameSettingsDevelopment.network_revision_check_enabled, "Combined hash:", self.combined_hash, "Network hash:", self.network_hash, "Trunk revision:", trunk_revision, "Engine revision:", engine_revision)
end

function LobbyManagerSteam:_update_lobby_state()
	local lobby = self.lobby

	if self._game_server_mode == "client" then
		if self.state == LobbyState.JOINING and SteamGameServerLobby.state(lobby) == SteamGameServerLobby.JOINED then
			self.state = LobbyState.JOINED

			print("[LobbyManagerSteam] im GAME SERVER LOBBY CLIENT", Network.peer_id())
		elseif lobby and lobby:state() == SteamGameServerLobby.FAILED and self.state ~= LobbyState.FAILED then
			self.state = LobbyState.FAILED

			print("[LobbyManagerSteam] GAME SERVER JOIN FAILED")
		end
	elseif not self._game_server_mode then
		if self.state == LobbyState.CREATING and SteamLobby.state(lobby) == SteamLobby.JOINED then
			if self.cb_lobby_created then
				self.cb_lobby_created()
			end

			self:set_lobby_data("network_hash", self.combined_hash)
			self:set_lobby_data("host", Network.peer_id())
			self:set_lobby_data("server_name", self.lobby_name)
			print("[LobbyManagerSteam] im LOBBY HOST", Network.peer_id())

			self.state = LobbyState.JOINED
		end

		if self.state == LobbyState.JOINING and SteamLobby.state(lobby) == SteamLobby.JOINED then
			print("[LobbyManagerSteam] im LOBBY CLIENT", Network.peer_id())

			self.state = LobbyState.JOINED
		end

		if lobby and SteamLobby.state(lobby) == SteamLobby.FAILED then
			self.state = LobbyState.FAILED
		end
	end
end

function LobbyManagerSteam:create_game_server(server_settings)
	local game_server_settings = self.game_server_settings
	local settings = table.clone(game_server_settings.server_init_settings)

	for setting_name, setting_value in pairs(server_settings) do
		settings[setting_name] = setting_value
	end

	table.dump(settings)

	self.server = true
	self._game_server_mode = "server"
	self.lobby_name = settings.server_name
	self.lobby = Network.init_steam_server(self.config_file_name, settings)

	if game_server_settings.qos then
		Network.enable_qos(game_server_settings.qos_min or QOS_MIN_GAME_SERVER, game_server_settings.qos_start or game_server_settings.qos, game_server_settings.qos)
	end

	Managers.chat:register_channel(1, callback(self, "lobby_members"))
end

function LobbyManagerSteam:set_server_browser_filters(filter_table)
	local default_filter_settings = self.network_settings.default_filter_settings

	self.server_filter_settings = default_filter_settings and table.clone(default_filter_settings) or {}

	table.merge(self.server_filter_settings, filter_table)

	if self.client then
		self.client:server_browser():clear_filters()
	else
		self.client = Network.init_steam_client(self.config_file_name)
	end

	self.client:server_browser():add_filter(self.server_filter_settings)
end

function LobbyManagerSteam:add_server_browser_filter(filter_table)
	table.merge(self.server_filter_settings, filter_table)
	self.client:server_browser():add_filter(self.server_filter_settings)
end

function LobbyManagerSteam:clear_to_default_server_browser_filters()
	local default_filter_settings = self.network_settings.default_filter_settings

	self.server_filter_settings = default_filter_settings and table.clone(default_filter_settings) or {}

	self.client:server_browser():clear_filters()
	self.client:server_browser():add_filter(self.server_filter_settings)
end

function LobbyManagerSteam:add_favorite(server_index)
	local server = self.client:server_browser():server(server_index)

	self.client:server_browser():add_favorite(server.ip_address, server.connection_port, server.query_port)
end

function LobbyManagerSteam:remove_favorite(server_index)
	local server = self.client:server_browser():server(server_index)

	self.client:server_browser():remove_favorite(server.ip_address, server.connection_port, server.query_port)
end

function LobbyManagerSteam:set_score(peer, score)
	SteamGameServer.set_score(self.lobby, peer, score)
end

function LobbyManagerSteam:is_dedicated_server()
	return self._game_server_mode == "server"
end

function LobbyManagerSteam:kick_member(peer)
	SteamGameServer.remove_member(self.lobby, peer)
end

function LobbyManagerSteam:fail_reason()
	local reason = SteamGameServerLobby.fail_reason(self.lobby)

	if reason == SteamGameServerLobby.TIMEOUT then
		return "timeout"
	elseif reason == SteamGameServerLobby.SERVER_IS_FULL then
		return "server_full"
	end
end

function LobbyManagerSteam:server_name()
	if not self.lobby then
		return
	end

	if self._game_server_mode == "client" then
		return self.lobby:server_name()
	elseif self._game_server_mode == "server" then
		return self.lobby_name
	else
		return self:get_lobby_data("server_name")
	end
end

function LobbyManagerSteam:game_description()
	if self.lobby and self._game_server_mode == "client" then
		return self.lobby:game_description()
	end
end

function LobbyManagerSteam:server_member_added(peer)
	return
end

function LobbyManagerSteam:server_member_kicked(peer)
	return
end

function LobbyManagerSteam:server_disconnected()
	return
end

function LobbyManagerSteam:game_tag_table_to_string(tag_table)
	local str

	for key, value in pairs(tag_table) do
		if not str then
			str = key .. self.GAME_TAG_SEPARATOR .. value
		else
			str = str .. self.GAME_TAGS_SEPARATOR .. key .. self.GAME_TAG_SEPARATOR .. value
		end
	end

	return str
end

function LobbyManagerSteam:game_tag_string_to_table(tag_string)
	local tags_sep = self.GAME_TAGS_SEPARATOR
	local tag_sep = self.GAME_TAG_SEPARATOR
	local tag_sep_len = string.len(tag_sep)
	local t = {}
	local pos = 1

	while true do
		local b, e = tag_string:find(tags_sep, pos)

		if not b then
			local tag = tag_string:sub(pos)
			local tag_sep_pos = tag:find(tag_sep)
			local key = tag:sub(1, tag_sep_pos - 1)
			local value = tag:sub(tag_sep_pos + tag_sep_len)

			t[key] = value

			break
		end

		local tag = tag_string:sub(pos, b - 1)
		local tag_sep_pos = tag:find(tag_sep)
		local key = tag:sub(1, tag_sep_pos - 1)
		local value = tag:sub(tag_sep_pos + tag_sep_len)

		t[key] = value
		pos = e + 1
	end

	return t
end
