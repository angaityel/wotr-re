-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_ffa.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeFFA = class(GameModeFFA, GameModeBase)

function GameModeFFA:init(settings, world, ...)
	GameModeFFA.super.init(self, settings, world, ...)

	Managers.state.event:register(self, "update_combat_log", "on_combat_log")
end

function GameModeFFA:on_combat_log(attacker, victim, gear_name)
	if not attacker or not victim or attacker == victim then
		return
	end

	flow_callback_give_score_to_side({
		game_mode_side = "defenders",
		score = 1
	})
end

function GameModeFFA:evaluate_end_conditions()
	local team_manager = Managers.state.team
	local unassigned_team = team_manager:team_by_name("unassigned")

	if not unassigned_team then
		return
	end

	local win_score = self._win_score
	local time_limit = self._time_limit
	local score_limit_reached = win_score <= unassigned_team.score
	local time_limit_reached = time_limit and time_limit <= Managers.time:time("round")

	if score_limit_reached or time_limit_reached then
		if unassigned_team.score >= 0 then
			return true, unassigned_team
		else
			return true, false
		end
	end

	return false, false
end

function GameModeFFA:objective(local_player)
	if local_player.spawn_data.state ~= "spawned" then
		return "", nil, nil
	end

	local objective = "bow_head_barbed_fluff"

	local param1, param2 = GameModeHelper:objective_parameters(objective, local_player, self._world)

	return objective, param1, param2
end

function GameModeFFA:hud_score_text(team_name)
	return Managers.state.team:team_by_name(team_name).score
end

function GameModeFFA:hud_progress(local_player)
	local own_team_name = "unassigned"
	local own_score = Managers.state.team:team_by_name(own_team_name).score
	local win_score = self._win_score
	local left = 0.5 - own_score / win_score * 0.5
	local center = 0.5
	local right = 0.5 + own_score / win_score * 0.5

	return left, center, right, false
end
