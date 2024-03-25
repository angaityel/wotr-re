-- chunkname: @scripts/game_state/state_invite_join.lua

require("scripts/settings/level_settings")

StateInviteJoin = class(StateInviteJoin)

function StateInviteJoin:on_enter()
	self._failed = false
	self._fail_reason = ""

	self:setup_state_context()

	local loading_context = self.parent.loading_context

	if loading_context.invite_type == "server" then
		self._server_ip = loading_context.invite_ip
		loading_context.invite_ip = nil
		loading_context.invite_type = nil
	elseif loading_context.invite_type == "lobby" then
		self._lobby_id = loading_context.invite_lobby_id
		loading_context.invite_lobby_id = nil
		loading_context.invite_type = nil
	elseif loading_context.invite_type == "lobby2" then
		self._lobby_ip = loading_context.invite_ip
		loading_context.invite_ip = nil
		loading_context.invite_type = nil
	end

	Managers.state.event:register(self, "denied_to_enter_game", "event_denied_to_enter_game")
end

function StateInviteJoin:setup_state_context()
	Managers.state.network = MenuNetworkManager:new(self, Managers.lobby.lobby)
end

function StateInviteJoin:update(dt)
	local lobby_manager = Managers.lobby

	lobby_manager:update(dt)
	Managers.state.network:update(dt)

	if lobby_manager.state == LobbyState.FAILED or self._failed then
		self.parent.loading_context.reload_packages = true
		self.parent.loading_context.leave_reason = sprintf("Server connection failed. %s", self._fail_reason)

		return StateSplashScreen
	elseif lobby_manager.state == LobbyState.JOINED then
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
	elseif self._server_ip then
		local ip_game_port = self._server_ip

		self._server_ip = nil

		local index = string.find(ip_game_port, ":")
		local port = tostring(tonumber(string.sub(ip_game_port, index + 1)) + 10)
		local ip_query_port = string.sub(ip_game_port, 1, index) .. port

		Managers.lobby:join_server_by_ip(ip_query_port)
	elseif self._lobby_id then
		local lobby_id = self._lobby_id

		self._lobby_id = nil

		Managers.lobby:join_lobby(lobby_id)
	elseif self._lobby_ip then
		local lobby_ip = self._lobby_ip

		self._lobby_id = nil

		Managers.lobby:join_lobby_by_ip(lobby_ip)
	end
end

function StateInviteJoin:event_denied_to_enter_game(reason)
	self._failed = true
	self._fail_reason = reason and L("menu_reason_" .. reason) or ""
end

function StateInviteJoin:on_exit()
	Managers.state:destroy()
end
