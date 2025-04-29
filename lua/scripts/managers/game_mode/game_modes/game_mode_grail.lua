-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_grail.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeGrail = class(GameModeGrail, GameModeBase)

function GameModeGrail:init(settings, world, ...)
	GameModeGrail.super.init(self, settings, world, ...)

	Managers.state.event:register(self, "gm_event_flag_planted", "gm_event_flag_planted")
end

function GameModeGrail:gm_event_flag_planted(planter_player, interactable_unit)
	if not planter_player.team or not Unit.alive(interactable_unit) then
		return
	end
	
	local param1 = planter_player.team.ui_name .. " team has captured the flag"

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeGrail:evaluate_end_conditions()
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

function GameModeGrail:own_score_announcement(local_player)
	local announcement = ""

	if local_player.team.score / self._win_score >= 0.95 then
		announcement = "own_team_is_winning"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeGrail:enemy_score_announcement(local_player)
	local enemy_team_name = local_player.team.name == "red" and "white" or "red"
	local enemy_score = Managers.state.team:team_by_name(enemy_team_name).score
	local announcement = ""

	if enemy_score / self._win_score >= 0.95 then
		announcement = "own_team_is_losing"
	end

	local param1, param2 = GameModeHelper:announcement_parameters(announcement, local_player, self._world)

	return announcement, param1, param2
end

function GameModeGrail:hud_score_text(team_name)
	return Managers.state.team:team_by_name(team_name).score
end

function GameModeGrail:hud_progress(local_player)
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
