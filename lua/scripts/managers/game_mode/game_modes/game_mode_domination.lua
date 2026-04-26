-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_domination.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeDomination = class(GameModeDomination, GameModeBase)

function GameModeDomination:init(settings, world, ...)
	GameModeDomination.super.init(self, settings, world, ...)

	self._side_domination_status = {
		attackers = {
			dominating = false,
			timer = math.huge
		},
		defenders = {
			dominating = false,
			timer = math.huge
		}
	}

	Managers.state.event:register(self, "gm_event_side_dominating", "gm_event_side_dominating")
	Managers.state.event:register(self, "gm_event_objective_captured", "gm_event_objective_captured")
	Managers.state.event:register(self, "event_round_started", "on_round_started")

	self._start_score = settings.start_score
	self._point_tick_interval = 8
	self._tick_timer = 0
	self._win_score = 0
	self._my_team = false
	self._team_dominating = false
	self._team_dominating_timer = math.huge
end

function GameModeDomination:on_round_started()
	Managers.state.team:team_by_side("attackers"):set_score(100)
	Managers.state.team:team_by_side("defenders"):set_score(100)

	local level = LevelHelper:current_level(self._world)
	local zones = {
		{ index = 423, name = "capture_zone_3" },
		{ index = 424, name = "capture_zone_2" },
		{ index = 425, name = "capture_zone_1" },
	}

	for _, zone in ipairs(zones) do
		local unit = Level.unit_by_index(level, zone.index)
		
		flow_callback_objective_activate({
			self_unit = unit,
			team = "defenders"
		})
		flow_callback_objective_activate({
			self_unit = unit,
			team = "attackers"
		})
		flow_callback_set_zone_name({
			unit = unit,
			volume_name = zone.name
		})
	end
end

function GameModeDomination:update_mode(dt, t)
	local objectives = {
		attackers = Managers.state.game_mode:num_owned_objectives("red"),
		defenders = Managers.state.game_mode:num_owned_objectives("white")
	}

	for side, count in pairs(objectives) do
		local is_dominating = (count == 3)
		if self._side_domination_status[side].dominating ~= is_dominating then
			Managers.state.game_mode:flow_cb_side_dominating(side, is_dominating)
		end
	end

	self._tick_timer = self._tick_timer + dt
	
	if self._tick_timer >= self._point_tick_interval then
		self._tick_timer = 0
		self:_give_score(objectives)
	end
end

function GameModeDomination:_give_score(objectives)
	if objectives.attackers > 0 then
		Managers.state.team:flow_cb_give_score("defenders", -objectives.attackers)
	end
	
	if objectives.defenders > 0 then
		Managers.state.team:flow_cb_give_score("attackers", -objectives.defenders)
	end
end

function GameModeDomination:gm_event_side_dominating(side, dominating)
	if Managers.lobby.server then
		local status = self._side_domination_status[side]
		local team = Managers.state.team:team_by_side(side)
		local game = Managers.state.network:game()

		if game then
			GameSession.set_game_object_field(game, team.game_object_id, "dominating", dominating)
		end

		if dominating then
			local domination_time = Managers.time:time("round") + self._settings.domination_timer

			status.dominating = true
			status.timer = domination_time

			if game then
				GameSession.set_game_object_field(game, team.game_object_id, "domination_time", domination_time)
			end
		else
			status.dominating = false
			status.timer = math.huge

			if game then
				GameSession.set_game_object_field(game, team.game_object_id, "domination_time", -1)
			end
		end
	end

	if dominating then
		self._team_dominating = true
		self._team_dominating_timer = Managers.time:time("round") + self._settings.domination_timer
	else
		self._team_dominating = false
		self._team_dominating_timer = math.huge
	end
end

function GameModeDomination:start_score()
	return self._start_score
end

function GameModeDomination:win_scale()
	local team_manager = Managers.state.team
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if game then
		for _, side in pairs(team_manager:sides()) do
			local team = team_manager:team_by_side(side)

			if team.game_object_id and GameSession.game_object_field(game, team.game_object_id, "dominating") then
				return 1
			end
		end
	end

	local score = 1
	local team_manager = Managers.state.team

	for _, side in pairs(team_manager:sides()) do
		local team = team_manager:team_by_side(side)

		score = math.min(score, team.score)
	end

	local win_scale = math.clamp(score / self._start_score, 0, 1)

	return 1 - win_scale
end

function GameModeDomination:evaluate_end_conditions()
	local team_manager = Managers.state.team
	local red_team = team_manager:team_by_name("red")
	local white_team = team_manager:team_by_name("white")

	if not red_team or not white_team then
		return
	end

	local round_time = Managers.time:time("round")

	for side, status in pairs(self._side_domination_status) do
		if round_time > status.timer then
			local winning = Managers.state.team:team_by_side(side)
			local losing = Managers.state.team:team_by_side(side == "defenders" and "attackers" or "defenders")

			losing:set_score(0)

			return true, winning
		end
	end

	local start_score = self._start_score
	local time_limit = self._time_limit
	local score_limit_reached = red_team.score <= 0 or white_team.score <= 0
	local time_limit_reached = time_limit and time_limit <= round_time

	if score_limit_reached or time_limit_reached then
		if math.ceil(red_team.score) > math.ceil(white_team.score) then
			return true, red_team
		elseif math.ceil(white_team.score) > math.ceil(red_team.score) then
			return true, white_team
		else
			return true, false
		end
	end

	return false, false
end

function GameModeDomination:gm_event_objective_captured(capuring_player, captured_unit)
	if not capuring_player.team or not Unit.alive(captured_unit) then
		return
	end

	local interacted = Unit.get_data(captured_unit, "hud", "ui_interacted")
	local objective_name = Unit.get_data(captured_unit, "hud", "ui_name")
	local param1 = capuring_player.team.ui_name .. " " .. L(interacted) .. " " .. L(objective_name)

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeDomination:objective(local_player)
	return ""
end

function GameModeDomination:own_score_announcement(local_player)
	local announcement = ""
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local enemy_team = Managers.state.team:team_by_name(enemy_team_name)
	local enemy_score = enemy_team.score
	local own_score = local_player.team.score
	local game = Managers.state.network:game()
	local dominating, domination_time
	local round_time = Managers.time:time("round")

	if round_time and game and enemy_team.game_object_id then
		dominating = GameSession.game_object_field(game, enemy_team.game_object_id, "dominating")
		domination_time = GameSession.game_object_field(game, enemy_team.game_object_id, "domination_time")
	end

	if own_score / self._start_score <= 0.1 and own_score < enemy_score or dominating and domination_time - round_time < 10 then
		announcement = "own_team_is_losing"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeDomination:enemy_score_announcement(local_player)
	local local_team = local_player.team
	local enemy_team_name = local_team.name == "red" and "white" or "red"
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local announcement = ""
	local game = Managers.state.network:game()
	local dominating, domination_time
	local round_time = Managers.time:time("round")

	if round_time and game and local_team.game_object_id then
		dominating = GameSession.game_object_field(game, local_team.game_object_id, "dominating")
		domination_time = GameSession.game_object_field(game, local_team.game_object_id, "domination_time")
	end

	if enemy_score / self._start_score <= 0.1 and enemy_score < local_player.team.score or dominating and domination_time - round_time < 10 then
		announcement = "own_team_is_winning"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeDomination:own_capture_point_announcement(local_player)
	local not_owned_objectives = Managers.state.game_mode:not_owned_objectives(local_player.team.name)
	local announcement = ""

	if #not_owned_objectives == 0 then
		announcement = "own_team_have_captured_all_points"
		self._my_team = true
	elseif #not_owned_objectives == 1 then
		announcement = "own_team_only_need_last_point"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeDomination:enemy_capture_point_announcement(local_player)
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local not_owned_objectives = Managers.state.game_mode:not_owned_objectives(enemy_team_name)
	local announcement = ""

	if #not_owned_objectives == 0 then
		announcement = "enemy_team_have_captured_all_points"
		self._my_team = false
	elseif #not_owned_objectives == 1 then
		announcement = "enemy_team_only_need_last_point"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeDomination:hud_score_text(team_name)
	return Managers.state.team:team_by_name(team_name).score
end

function GameModeDomination:hud_timer_text()
	local t, t_alert

	if self._time_limit then
		t = self._time_limit - math.max(Managers.time:time("round"), 0)
		t_alert = t >= 0 and self._settings.time_limit_alert and t < self._settings.time_limit_alert
	else
		t = math.max(Managers.time:time("round"), 0)
	end

	if t < math.huge then
		local minutes = math.floor(math.max(t, 0) / 60)
		local seconds = math.floor(math.max(t, 0) % 60)

		local timer_text_domination = ""
		if self._team_dominating then
			local time_left = self._team_dominating_timer - Managers.time:time("round")
			local seconds = math.floor(math.max(time_left, 0) % 60)
			local result = self._my_team and "Victory" or "Defeat"
			timer_text_domination = string.format("%s by domination in: %02.f", result, seconds)
		end

		return string.format("%02.f:%02.f", minutes, seconds), t_alert, timer_text_domination
	else
		return "", false
	end
end

function GameModeDomination:hud_progress(local_player)
	local own_team_name = local_player.team.name
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local own_score = Managers.state.team:team_by_name(own_team_name).score
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local win_score = self._win_score
	local left = 0.5 - own_score / 100 * 0.5
	local center = 0.5
	local right = 0.5 + enemy_score / 100 * 0.5

	return left, center, right, false
end
