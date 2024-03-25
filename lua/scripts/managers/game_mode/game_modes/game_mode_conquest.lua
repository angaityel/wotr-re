-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_conquest.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeConquest = class(GameModeConquest, GameModeBase)

function GameModeConquest:init(settings, world, ...)
	GameModeConquest.super.init(self, settings, world, ...)
	Managers.state.event:register(self, "gm_event_flag_planted", "gm_event_flag_planted")
	Managers.state.event:register(self, "gm_event_objective_captured", "gm_event_objective_captured")

	self._score_multiplier = 100 / self._win_score
	self._win_score = 100
end

function GameModeConquest:evaluate_end_conditions()
	local team_manager = Managers.state.team
	local red_team = team_manager:team_by_name("red")
	local white_team = team_manager:team_by_name("white")

	if not red_team or not white_team then
		return
	end

	local win_score = self._win_score
	local time_limit = self._time_limit
	local score_limit_reached = win_score <= math.floor(red_team.score) or win_score <= math.floor(white_team.score)
	local time_limit_reached = time_limit and time_limit <= Managers.time:time("round")

	if score_limit_reached or time_limit_reached then
		if math.floor(red_team.score) > math.floor(white_team.score) then
			return true, red_team
		elseif math.floor(white_team.score) > math.floor(red_team.score) then
			return true, white_team
		else
			return true, false
		end
	end

	local spawn_manager = Managers.state.spawn
	local num_red_spawn_areas = table.size(spawn_manager:valid_spawn_areas_per_team("red"))
	local num_white_spawn_areas = table.size(spawn_manager:valid_spawn_areas_per_team("white"))

	if num_red_spawn_areas == 0 or num_white_spawn_areas == 0 then
		local num_red_squad_spawn_targets = #spawn_manager:valid_squad_spawn_targets_per_team("red")
		local num_white_squad_spawn_targets = #spawn_manager:valid_squad_spawn_targets_per_team("white")

		if num_red_spawn_areas == 0 and num_white_spawn_areas == 0 and num_red_squad_spawn_targets == 0 and num_white_squad_spawn_targets == 0 then
			return true, false
		elseif num_red_squad_spawn_targets == 0 and num_red_spawn_areas == 0 then
			return true, white_team
		elseif num_white_squad_spawn_targets == 0 and num_white_spawn_areas == 0 then
			return true, red_team
		end
	end

	return false, false
end

function GameModeConquest:gm_event_flag_planted(planter_player, interactable_unit)
	if not planter_player.team or not Unit.alive(interactable_unit) then
		return
	end

	local interacted = Unit.get_data(interactable_unit, "hud", "ui_interacted")
	local objective_name = Unit.get_data(interactable_unit, "hud", "ui_name")
	local param1 = planter_player.team.ui_name .. " " .. L(interacted) .. " " .. L(objective_name)

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeConquest:gm_event_objective_captured(capuring_player, captured_unit)
	if not capuring_player.team or not Unit.alive(captured_unit) then
		return
	end

	local interacted = Unit.get_data(captured_unit, "hud", "ui_interacted")
	local objective_name = Unit.get_data(captured_unit, "hud", "ui_name")
	local param1 = capuring_player.team.ui_name .. " " .. L(interacted) .. " " .. L(objective_name)

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeConquest:objective(local_player)
	if local_player.spawn_data.state ~= "spawned" then
		return "", nil, nil
	end

	local objective = "capture_level"

	if self._settings.tagging_objectives then
		local tagged_player_unit = GameModeHelper:player_unit_tagged_by_own_squad_corporal(local_player)

		if tagged_player_unit then
			local damage_ext = ScriptUnit.extension(tagged_player_unit, "damage_system")
			local tagged_player = Managers.player:owner(tagged_player_unit)

			if tagged_player.team == local_player.team then
				if damage_ext._knocked_down then
					objective = "revive_tagged_team_member"
				else
					objective = "defend_tagged_team_member"
				end
			elseif damage_ext._knocked_down then
				objective = "execute_tagged_enemy"
			else
				objective = "kill_tagged_enemy"
			end
		else
			local tagged_objective_unit = GameModeHelper:objective_unit_tagged_by_own_squad_corporal(local_player, self._world)

			if tagged_objective_unit then
				local objectiv_ext = ScriptUnit.extension(tagged_objective_unit, "objective_system")

				objective = objectiv_ext._owner == local_player.team.side and "defend_tagged_objective" or "attack_tagged_objective"
			end
		end
	end

	local param1, param2 = GameModeHelper:objective_parameters(objective, local_player, self._world)

	return objective, param1, param2
end

function GameModeConquest:own_score_announcement(local_player)
	local announcement = ""

	if local_player.team.score / self._win_score >= 0.95 then
		announcement = "own_team_have_nearly_won"
	elseif local_player.team.score / self._win_score >= 0.75 then
		announcement = "own_team_is_winning"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeConquest:enemy_score_announcement(local_player)
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local announcement = ""

	if enemy_score / self._win_score >= 0.95 then
		announcement = "own_team_have_nearly_lost"
	elseif enemy_score / self._win_score >= 0.75 then
		announcement = "own_team_is_losing"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeConquest:own_capture_point_announcement(local_player)
	local not_owned_objectives = Managers.state.game_mode:not_owned_objectives(local_player.team.name)
	local announcement = ""

	if #not_owned_objectives == 0 then
		announcement = "own_team_have_captured_all_points"
	elseif #not_owned_objectives == 1 then
		announcement = "own_team_only_need_last_point"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeConquest:enemy_capture_point_announcement(local_player)
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local not_owned_objectives = Managers.state.game_mode:not_owned_objectives(enemy_team_name)
	local announcement = ""

	if #not_owned_objectives == 0 then
		announcement = "enemy_team_have_captured_all_points"
	elseif #not_owned_objectives == 1 then
		announcement = "enemy_team_only_need_last_point"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeConquest:hud_score_text(team_name)
	return Managers.state.game_mode:num_owned_objectives(team_name)
end

function GameModeConquest:hud_progress(local_player)
	local own_team_name = local_player.team.name
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local own_score = Managers.state.team:team_by_name(own_team_name).score
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local total_score = own_score + enemy_score
	local center

	center = total_score == 0 and 0.5 or 0.5 + (own_score - enemy_score) / total_score * 0.5

	return 0, center, 1, true
end
