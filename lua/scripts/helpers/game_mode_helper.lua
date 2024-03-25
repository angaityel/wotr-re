-- chunkname: @scripts/helpers/game_mode_helper.lua

GameModeHelper = GameModeHelper or {}

function GameModeHelper:announcement_parameters(announcement, player, world)
	local param1_func = Announcements[announcement].param1
	local param2_func = Announcements[announcement].param2
	local param1 = param1_func and GameModeHelper[param1_func](self, player, world)
	local param2 = param2_func and GameModeHelper[param2_func](self, player, world)

	return param1, param2
end

function GameModeHelper:objective_parameters(objective, player, world)
	local param1_func = GameModeObjectives[objective].param1
	local param2_func = GameModeObjectives[objective].param2
	local param1 = param1_func and GameModeHelper[param1_func](self, player, world)
	local param2 = param2_func and GameModeHelper[param2_func](self, player, world)

	return param1, param2
end

function GameModeHelper:own_team_ui_name(player)
	return player.team.ui_name
end

function GameModeHelper:enemy_team_ui_name(player)
	local enemy_team_name = player.team.name == "red" and "white" or "red"
	local enemy_team = Managers.state.team:team_by_name(enemy_team_name)

	return enemy_team.ui_name
end

function GameModeHelper:enemy_team_ui_name_definite_plural(player)
	local enemy_team_name = player.team.name == "red" and "white" or "red"
	local enemy_team = Managers.state.team:team_by_name(enemy_team_name)

	return enemy_team.ui_name_definite_plural
end

function GameModeHelper:round_time_left(player)
	return Managers.state.game_mode:hud_timer_text()
end

function GameModeHelper:current_level_name(player)
	local level_settings = LevelHelper:current_level_settings()

	return L(level_settings.display_name)
end

function GameModeHelper:attackers_objectives_grouped_on_interaction(player)
	local active_objectives = Managers.state.game_mode:active_objectives_by_side("attackers")
	local interactions = {}

	for i, objective in ipairs(active_objectives) do
		local interaction = Unit.get_data(objective, "hud", "ui_interaction")
		local name = Unit.get_data(objective, "hud", "ui_name")

		interactions[interaction] = interactions[interaction] or {}
		interactions[interaction][#interactions[interaction] + 1] = name
	end

	local str = ""
	local size = table.size(interactions)
	local cnt = 0

	for interaction_name, objective_names in pairs(interactions) do
		cnt = cnt + 1
		str = str .. L(interaction_name)

		for i, objective_name in ipairs(objective_names) do
			if #objective_names > 1 and i == #objective_names then
				str = str .. " & "
			elseif i > 1 then
				str = str .. ", "
			else
				str = str .. " "
			end

			str = str .. L(objective_name)
		end

		if size > 1 and cnt < size then
			str = str .. " " .. L("and") .. " "
		end
	end

	return str
end

function GameModeHelper:sp_objectives_grouped_on_interaction(player)
	local active_objectives = Managers.state.game_mode:active_objectives_by_side("defenders")
	local interactions = {}

	for i, objective in ipairs(active_objectives) do
		local interaction = Unit.get_data(objective, "hud", "ui_interaction")
		local name = Unit.get_data(objective, "hud", "ui_name")

		interactions[interaction] = interactions[interaction] or {}
		interactions[interaction][#interactions[interaction] + 1] = name
	end

	local str = ""
	local size = table.size(interactions)
	local cnt = 0

	for interaction_name, objective_names in pairs(interactions) do
		cnt = cnt + 1
		str = str .. L(interaction_name)

		for i, objective_name in ipairs(objective_names) do
			if #objective_names > 1 and i == #objective_names then
				str = str .. " & "
			elseif i > 1 then
				str = str .. ", "
			else
				str = str .. " "
			end

			str = str .. L(objective_name)
		end

		if size > 1 and cnt < size then
			str = str .. " " .. L("and") .. " "
		end
	end

	return str
end

function GameModeHelper:attackers_objective_ui_names(player)
	local active_objectives = Managers.state.game_mode:active_objectives_by_side("attackers")
	local str = ""

	for i, objective in ipairs(active_objectives) do
		local objective_name = Unit.get_data(objective, "hud", "ui_name")

		if #active_objectives > 1 and i == #active_objectives then
			str = str .. " & "
		elseif i > 1 then
			str = str .. ", "
		else
			str = str .. " "
		end

		str = str .. L(objective_name)
	end

	return str
end

function GameModeHelper:last_objective_ui_name(player)
	local objective_units = Managers.state.game_mode:not_owned_objectives(player.team.name)

	if #objective_units > 0 then
		local objective_name = Unit.get_data(objective_units[#objective_units], "hud", "ui_name")

		return L(objective_name)
	end

	return ""
end

function GameModeHelper:player_unit_tagged_by_own_squad_corporal(player)
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if not game then
		return
	end

	local squad = player.team.squads[player.squad_index]

	if squad and squad:corporal() then
		local tagged_player_object_id = GameSession.game_object_field(game, squad:corporal().game_object_id, "tagged_player_object_id")

		if tagged_player_object_id ~= 0 then
			local tagged_unit = network_manager:game_object_unit(tagged_player_object_id)

			return tagged_unit
		end
	end
end

function GameModeHelper:objective_unit_tagged_by_own_squad_corporal(player, world)
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if not game then
		return
	end

	local squad = player.team.squads[player.squad_index]

	if squad and squad:corporal() then
		local tagged_objective_level_id = GameSession.game_object_field(game, squad:corporal().game_object_id, "tagged_objective_level_id")

		if tagged_objective_level_id ~= 0 then
			local level = LevelHelper:current_level(world)
			local tagged_unit = Level.unit_by_index(level, tagged_objective_level_id)

			return tagged_unit
		end
	end
end

function GameModeHelper:name_of_player_tagged_by_squad_corporal(player)
	local tagged_unit = self:player_unit_tagged_by_own_squad_corporal(player)

	if tagged_unit then
		local tagged_player = Managers.player:owner(tagged_unit)

		return tagged_player:name()
	end

	return ""
end

function GameModeHelper:name_of_objective_tagged_by_squad_corporal(player, world)
	local tagged_unit = self:objective_unit_tagged_by_own_squad_corporal(player, world)

	if tagged_unit then
		return L(Unit.get_data(tagged_unit, "hud", "ui_name"))
	end
end

function GameModeHelper:interaction_of_objective_tagged_by_squad_corporal(player, world)
	local tagged_unit = self:objective_unit_tagged_by_own_squad_corporal(player, world)

	if tagged_unit then
		return L(Unit.get_data(tagged_unit, "hud", "ui_interaction"))
	end

	return ""
end
