-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_assault.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeAssault = class(GameModeAssault, GameModeBase)

function GameModeAssault:init(settings, world, ...)
	GameModeAssault.super.init(self, settings, world, ...)

	self._win_score = 100

	Managers.state.event:register(self, "gm_event_flag_planted", "gm_event_flag_planted")
	Managers.state.event:register(self, "gm_event_objective_captured", "gm_event_objective_captured")
	Managers.state.event:register(self, "gm_event_time_extended", "gm_event_time_extended")
	Managers.state.event:register(self, "gm_event_assault_announcement", "gm_event_assault_announcement")
end

function GameModeAssault:evaluate_end_conditions()
	local team_manager = Managers.state.team
	local attacking_team = team_manager:team_by_side("attackers")
	local defending_team = team_manager:team_by_side("defenders")

	if not attacking_team or not defending_team then
		return
	end

	local win_score = self._win_score
	local round_time = Managers.time:time("round")

	defending_team:set_score(math.clamp(win_score * round_time / self._time_limit, 0, win_score))

	if win_score <= attacking_team.score then
		return true, attacking_team
	elseif win_score <= defending_team.score then
		return true, defending_team
	end
end

function GameModeAssault:gm_event_time_extended(side, seconds)
	local remainder_seconds = seconds % 60
	local time_string = string.format("%i:%i", math.floor(seconds / 60), remainder_seconds)

	if remainder_seconds < 10 then
		time_string = string.gsub(time_string, ":", ":0")
	end

	if side == "attackers" then
		Managers.state.event:trigger("game_mode_announcement", "attackers_time_extended", time_string)
	elseif side == "defenders" then
		Managers.state.event:trigger("game_mode_announcement", "defenders_time_extended", time_string)
	end
end

function GameModeAssault:gm_event_assault_announcement(side, announcement)
	Managers.state.event:trigger("game_mode_side_announcement", side, announcement)
end

function GameModeAssault:gm_event_flag_planted(planter_player, interactable_unit)
	if not planter_player.team or not Unit.alive(interactable_unit) then
		return
	end

	local interacted = Unit.get_data(interactable_unit, "hud", "ui_interacted")
	local objective_name = Unit.get_data(interactable_unit, "hud", "ui_name")
	local param1 = planter_player.team.ui_name .. " " .. L(interacted) .. " " .. L(objective_name)

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeAssault:gm_event_objective_captured(capuring_player, captured_unit)
	if not capuring_player.team or not Unit.alive(captured_unit) then
		return
	end

	local interacted = Unit.get_data(captured_unit, "hud", "ui_interacted")
	local objective_name = Unit.get_data(captured_unit, "hud", "ui_name")
	local param1 = capuring_player.team.ui_name .. " " .. L(interacted) .. " " .. L(objective_name)

	Managers.state.event:trigger("game_mode_announcement", "team_interacted_with_objective", param1)
end

function GameModeAssault:objective(local_player)
	if local_player.spawn_data.state ~= "spawned" or not local_player.team.side then
		return "", nil, nil
	end

	local side = local_player.team.side
	local objectives = Managers.state.game_mode:active_objectives_by_side(side)
	local objective = ""
	local priority = -math.huge

	for _, objective_unit in ipairs(objectives) do
		if ScriptUnit.has_extension(objective_unit, "objective_system") then
			local objective_ext = ScriptUnit.extension(objective_unit, "objective_system")

			if type(objective_ext.objective) == "function" then
				local objective_unit_objective, objective_unit_priority = objective_ext:objective(side)

				if objective_unit_objective and priority < objective_unit_priority then
					objective = objective_unit_objective
					priority = objective_unit_priority
				end
			end
		end
	end

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

function GameModeAssault:hud_score_text(team_name)
	return ""
end

function GameModeAssault:hud_progress(local_player)
	local team_manager = Managers.state.team
	local attackers_score = team_manager:team_by_side("attackers").score
	local defenders_score = team_manager:team_by_side("defenders").score
	local left, right

	if local_player.team.side == "attackers" then
		left = 0.5 - 0.5 * attackers_score / self._win_score
		right = 0.5 + 0.5 * defenders_score / self._win_score
	else
		right = 0.5 + 0.5 * attackers_score / self._win_score
		left = 0.5 - 0.5 * defenders_score / self._win_score
	end

	return left, 0.5, right, false
end

function GameModeAssault:hot_join_synch(sender, player)
	RPC.rpc_synch_game_mode_time_limit(sender, self._time_limit)
end
