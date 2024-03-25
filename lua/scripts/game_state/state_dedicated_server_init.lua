-- chunkname: @scripts/game_state/state_dedicated_server_init.lua

require("scripts/managers/network/dedicated_server_init_network_manager")
require("scripts/settings/level_settings")

StateDedicatedServerInit = class(StateDedicatedServerInit)

function StateDedicatedServerInit:on_enter()
	self:setup_state_context()
	fassert(Managers.lobby.create_game_server, "Trying to start dedicated server with network mode %q that doesn't have a dedicated server implementation", GameSettingsDevelopment.network_mode)

	local args = {
		Application.argv()
	}
	local settings_table = {}

	for i = 1, #args do
		local arg = args[i]
		local start_idx, end_idx = string.find(arg, "-server_")

		if start_idx == 1 then
			local param = string.sub(arg, end_idx + 1)

			if param ~= "" then
				settings_table[param] = args[i + 1]
				i = i + 1
			end
		end
	end

	local lobby_manager = Managers.lobby
	local server_port = lobby_manager.game_server_settings.server_init_settings.server_port

	settings_table.query_port = settings_table.server_port and settings_table.server_port + 10 or server_port and server_port + 10 or 27025

	Managers.lobby:create_game_server(settings_table)
	Managers.persistence:post_init()
end

function StateDedicatedServerInit:update(dt)
	local lobby_manager = Managers.lobby

	lobby_manager:update(dt)
	Managers.state.network:update(dt)

	if lobby_manager.state == LobbyState.JOINED then
		local game_server_settings = lobby_manager.game_server_settings
		local map_rotation = game_server_settings.map_rotation.maps

		for _, map in ipairs(map_rotation) do
			local level_key = map.level
			local game_mode_key = map.game_mode
			local level = LevelSettings[level_key]

			fassert(level, "Added level to map rotation with key %q that doesn't exist in LevelSettings", level_key)

			local has_game_mode = false

			for _, game_mode in ipairs(level.game_modes) do
				has_game_mode = has_game_mode or game_mode.key == game_mode_key
			end

			fassert(has_game_mode, "Added game mode with key %q to map rotation that doesn't exist for level with key %q", game_mode_key, level_key)
		end

		local first_map = map_rotation[1]
		local level_key = first_map.level
		local game_mode_key = first_map.game_mode
		local win_score = first_map.win_score
		local time_limit = first_map.time_limit
		local level = LevelSettings[level_key]
		local map = level.game_server_map_name

		lobby_manager.lobby:set_map(map)
		lobby_manager:set_game_tag("game_mode_key", game_mode_key)
		lobby_manager:set_lobby_data("level_key", level_key)
		lobby_manager:set_lobby_data("game_mode_key", game_mode_key)
		lobby_manager:set_lobby_data("game_started", "true")
		lobby_manager:set_lobby_data("win_score", win_score)
		lobby_manager:set_lobby_data("time_limit", time_limit)

		local loading_context = {}

		loading_context.state = StateLoading
		loading_context.level_key = level_key
		loading_context.game_mode_key = game_mode_key
		loading_context.win_score = win_score
		loading_context.time_limit = time_limit
		loading_context.level_cycle = map_rotation
		loading_context.level_cycle_count = 1
		loading_context.game_start_countdown = game_server_settings.game_start_countdown
		loading_context.disable_loading_screen_menu = true
		self.parent.loading_context = loading_context

		return loading_context.state
	end
end

function StateDedicatedServerInit:on_exit()
	Managers.state:destroy()
end

function StateDedicatedServerInit:setup_state_context()
	Managers.state.network = DedicatedServerInitNetworkManager:new(self, Managers.lobby.lobby)
end
