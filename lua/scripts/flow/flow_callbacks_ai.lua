-- chunkname: @scripts/flow/flow_callbacks_ai.lua

function flow_callback_create_ai_player(params)
	local player_name = params.player_name

	if not Managers.player:player_exists(player_name) then
		Managers.player:add_ai_player(player_name)
	end

	local player = Managers.player:player(player_name)

	if Managers.state.network:game() then
		player:create_game_object()
	end

	Managers.state.team:add_player_to_team_by_side(player, params.side_name)
end

function flow_callback_activate_ai_spawner(params)
	local spawner_unit = params.spawner_unit

	Managers.state.event:trigger("activate_ai_spawner", spawner_unit)
end

function flow_callback_deactivate_ai_spawner(params)
	local spawner_unit = params.spawner_unit

	Managers.state.event:trigger("deactivate_ai_spawner", spawner_unit)
end

function flow_callback_ai_move_group_command(params)
	Managers.state.event:trigger("ai_move_group", params.player_name, params.group_name, params.target_unit, params.on_arrived_event_name)
end

function flow_callback_ai_move_single_command(params)
	Managers.state.event:trigger("ai_move_single", params.move_unit, params.target_unit)
end

function flow_callback_ai_despawn(params)
	local spawner_unit = params.spawner_unit
	local spawner = ScriptUnit.extension(spawner_unit, "spawner_system")

	spawner:despawn()
end

function flow_callback_ai_kill(params)
	local spawner_unit = params.spawner_unit
	local spawner = ScriptUnit.extension(spawner_unit, "spawner_system")

	spawner:kill()
end

function flow_callback_ai_follow_path(params)
	local ai_entity = params.ai_entity
	local spline_name = params.spline_name
	local finish_event = params.finish_event

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:blackboard().move_orders[spline_name] = {
				name = "follow",
				finish_event = finish_event
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:blackboard().move_orders[spline_name] = {
			name = "follow",
			finish_event = finish_event
		}
	end
end

function flow_callback_ai_patrol_path(params)
	local ai_entity = params.ai_entity
	local spline_name = params.spline_name

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:blackboard().move_orders[spline_name] = {
				name = "patrol"
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:blackboard().move_orders[spline_name] = {
			name = "patrol"
		}
	end
end

function flow_callback_ai_move_to_command(params)
	local ai_entity = params.ai_entity
	local waypoint_unit = params.waypoint_unit
	local finish_event = params.finish_event

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:blackboard().move_orders[waypoint_unit] = {
				name = "move",
				finish_event = finish_event
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:blackboard().move_orders[waypoint_unit] = {
			name = "move",
			finish_event = finish_event
		}
	end
end

function flow_callback_ai_detect_player(params)
	local ai_entity = params.ai_entity
	local player_unit = Managers.player:player(1).player_unit

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:blackboard().players[player_unit] = true
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:blackboard().players[player_unit] = true
	end
end

function flow_callback_ai_hold_position(params)
	local ai_entity = params.ai_entity

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:steering():reset()

			local brain = ai_base:brain()

			brain:change_behaviour("avoidance", "nil_tree")
			brain:change_behaviour("pathing", "nil_tree")
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:steering():reset()

		local brain = ai_base:brain()

		brain:change_behaviour("avoidance", "nil_tree")
		brain:change_behaviour("pathing", "nil_tree")
	end
end

function flow_callback_set_ai_properties(params)
	local ai_entity = params.ai_entity

	params.ai_entity = nil

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:set_properties(params)
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:set_properties(params)
	end
end

function flow_callback_set_ai_perception(params)
	local ai_entity = params.ai_entity

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner:spawned_units()) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base:perception():set_config(params)
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base:perception():set_config(params)
	end
end

function flow_callback_ai_set_waypoint(params)
	local waypoint_name = params.waypoint_name
	local waypoint_unit = params.waypoint_unit
	local world = Managers.world:world("level_world")
	local level = LevelHelper:current_level(world)

	Level.set_flow_variable(level, waypoint_name, waypoint_unit)
end

function flow_callback_ai_set_areas(params)
	flow_callback_set_ai_properties(params)
end

function flow_callback_set_ai_spawner_mode(params)
	Managers.state.entity:system("spawner_system"):set_deterministic(params.deterministic)
end
