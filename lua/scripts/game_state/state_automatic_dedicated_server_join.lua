-- chunkname: @scripts/game_state/state_automatic_dedicated_server_join.lua

require("scripts/managers/network/automatic_dedicated_server_join_network_manager")
require("scripts/settings/level_settings")

StateAutomaticDedicatedServerJoin = class(StateAutomaticDedicatedServerJoin)

function StateAutomaticDedicatedServerJoin:on_enter()
	self:setup_state_context()

	local lobby_data = {
		game_started = "false"
	}

	Managers.lobby:refresh_server_browser()

	self._auto_join_server_name = script_data.settings.auto_join_server_name
end

function StateAutomaticDedicatedServerJoin:update(dt)
	local lobby_manager = Managers.lobby

	lobby_manager:update(dt)
	Managers.state.network:update(dt)

	if lobby_manager.state == LobbyState.JOINED then
		local drop_in_settings = Managers.state.network:drop_in_settings()

		if drop_in_settings then
			self.loading_context = {}
			self.loading_context.state = StateLoading
			self.loading_context.level_key = drop_in_settings.level_key
			self.loading_context.game_mode_key = drop_in_settings.game_mode_key
			self.loading_context.level_cycle = drop_in_settings.level_cycle
			self.loading_context.time_limit = drop_in_settings.time_limit
			self.loading_context.win_score = drop_in_settings.win_score
			self.loading_context.level_cycle_count = drop_in_settings.level_cycle_count
			self.loading_context.game_start_countdown = drop_in_settings.game_start_countdown
			self.parent.loading_context = self.loading_context

			return self.loading_context.state
		end
	elseif lobby_manager.state == LobbyState.JOINING then
		-- block empty
	else
		local lobbies = lobby_manager:lobby_browser_content({})
		local server_name = self._auto_join_server_name

		for key, lobby in ipairs(lobbies) do
			if lobby.lobby_name == server_name then
				Managers.lobby:join_lobby(lobby.lobby_num)

				break
			end
		end
	end
end

function StateAutomaticDedicatedServerJoin:on_exit()
	Managers.state:destroy()
end

function StateAutomaticDedicatedServerJoin:setup_state_context()
	Managers.state.network = AutomaticDedicatedServerJoinNetworkManager:new(self, Managers.lobby.lobby)
end
