-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_tdm.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeTDM = class(GameModeTDM, GameModeBase)

function GameModeTDM:init(settings, world, ...)
	GameModeTDM.super.init(self, settings, world, ...)
end

function GameModeTDM:evaluate_end_conditions()
	local team_manager = Managers.state.team
	local red_team = team_manager:team_by_name("red")
	local white_team = team_manager:team_by_name("white")

	if not red_team or not white_team then
		return
	end

	local win_score = self._win_score
	local time_limit = self._time_limit
	local score_limit_reached = win_score <= red_team.score or win_score <= white_team.score
	local time_limit_reached = time_limit and time_limit <= Managers.time:time("round")

	if score_limit_reached or time_limit_reached then
		if red_team.score > white_team.score then
			return true, red_team
		elseif white_team.score > red_team.score then
			return true, white_team
		else
			return true, false
		end
	end

	return false, false
end

function GameModeTDM:objective(local_player)
	if local_player.spawn_data.state ~= "spawned" then
		return "", nil, nil
	end

	local objective = "kill_the_enemy_team"
	local tagged_player_unit = GameModeHelper:player_unit_tagged_by_own_squad_corporal(local_player)

	if tagged_player_unit and self._settings.tagging_objectives then
		local damage_ext = ScriptUnit.extension(tagged_player_unit, "damage_system")
		local tagged_player = Managers.player:owner(tagged_player_unit)

		objective = tagged_player.team == local_player.team and (damage_ext._knocked_down and "revive_tagged_team_member" or "defend_tagged_team_member") or damage_ext._knocked_down and "execute_tagged_enemy" or "kill_tagged_enemy"
	end

	local param1, param2 = GameModeHelper:objective_parameters(objective, local_player, self._world)

	return objective, param1, param2
end

function GameModeTDM:own_score_announcement(local_player)
	local announcement = ""

	if local_player.team.score / self._win_score >= 0.95 then
		announcement = "own_team_is_winning"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeTDM:enemy_score_announcement(local_player)
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local announcement = ""

	if enemy_score / self._win_score >= 0.95 then
		announcement = "own_team_is_losing"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeTDM:hud_score_text(team_name)
	return Managers.state.team:team_by_name(team_name).score
end

function GameModeTDM:hud_progress(local_player)
	local own_team_name = local_player.team.name
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local own_score = Managers.state.team:team_by_name(own_team_name).score
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local win_score = self._win_score
	local left = 0.5 - own_score / win_score * 0.5
	local center = 0.5
	local right = 0.5 + enemy_score / win_score * 0.5

	return left, center, right, false
end
