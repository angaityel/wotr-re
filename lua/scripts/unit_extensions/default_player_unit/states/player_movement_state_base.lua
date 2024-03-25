-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_movement_state_base.lua

require("scripts/settings/player_effect_settings")
require("scripts/settings/player_action_settings")
require("scripts/settings/sp_tutorial_settings")
require("scripts/helpers/area_buff_helper")

PlayerMovementStateBase = class(PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5
local PARRY_ATTEMPT_THRESHOLD = 0.003
local POSE_ATTEMPT_THRESHOLD = 0.003

ROTATION_LERP_FACTOR = 10
ROTATION_ANIM_LERP_FACTOR = 5

function PlayerMovementStateBase:init(unit, internal)
	self._unit = unit
	self._internal = internal
	self._aim_constraint_anim_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")
	self._look_direction_anim_var = Unit.animation_find_variable(unit, "aim_direction")
	self._ranged_weapon_reload_functions = {
		bow = self._start_reloading_bow,
		crossbow = self._start_reloading_crossbow,
		handgonne = self._start_reloading_handgonne
	}

	Managers.state.event:register(self, "player_parried", "_activate_parry_perks")

	self._voice_node = Unit.node(unit, "Head")
end

function PlayerMovementStateBase:_max_stamina(internal, encumbrance)
	local stamina_capacity_multiplier = (internal:has_perk("infantry") and Perks.infantry.stamina_capacity_multiplier or 1) * PlayerUnitMovementSettings.encumbrance.functions.stamina_regen(encumbrance)

	return PlayerUnitMovementSettings.rush.max_rush_stamina
end

function PlayerMovementStateBase:_activate_parry_perks(hit_gear_unit, hitting_gear_unit, fully_charged_attack)
	local internal = self._internal
	local t = Managers.time:time("game")
	local hit_gear_owner_unit = Unit.get_data(hit_gear_unit, "user_unit")
	local hitting_gear_owner_unit = Unit.get_data(hitting_gear_unit, "user_unit")
	local hit_gear_player = Managers.player:owner(hit_gear_owner_unit)
	local hitting_gear_player = Managers.player:owner(hitting_gear_owner_unit)

	if hit_gear_player == internal.player then
		if internal:has_perk("riposte") then
			local blackboard = internal.perk_fast_swings.riposte

			if t >= blackboard.cooldown then
				blackboard.timer = t + Perks.riposte.timer
				blackboard.can_use = true
			end
		end

		local hitting_gear_owner_unit_locomotion = ScriptUnit.extension(hitting_gear_owner_unit, "locomotion_system")

		if hitting_gear_owner_unit_locomotion:has_perk("break_block") and fully_charged_attack then
			local perk = Perks.break_block

			internal.block_broken = true
		end
	end
end

function PlayerMovementStateBase:update(dt, t)
	self._controller = self._internal.controller

	self:update_look_angle(dt)
	self:update_parry_helper()
	self:update_call_horse_decals(dt, t)
	self:update_wounded_camera_effect(dt, t)
	self:update_switch_weapon_grip(dt, t)

	if self._internal.swinging then
		Unit.set_data(self._unit, "camera", "dynamic_max_yaw_speed", 2 * math.pi)
	else
		Unit.set_data(self._unit, "camera", "dynamic_max_yaw_speed", nil)
	end
end

function PlayerMovementStateBase:_update_stamina(dt, t)
	return
end

function PlayerMovementStateBase:post_update(dt)
	self:update_camera(dt)
	self:_update_stamina(dt)
	self:update_look_anim_var(dt)
	self:update_aim_target(dt)

	if script_data.player_debug then
		local unit = self._unit
		local internal = self._internal

		internal.debug_drawer:reset()

		local mover = Unit.mover(unit)
		local pos = Mover.position(mover)

		internal.debug_drawer:sphere(pos, 0.02, Color(internal.debug_color, 0, 255 - internal.debug_color))

		internal.debug_color = (internal.debug_color + 255 * dt) % 256
	end

	local internal = self._internal

	if internal.id and internal.game then
		local velocity = internal.velocity:unbox()

		velocity = Vector3.clamp(velocity, NetworkConstants.velocity.min, NetworkConstants.velocity.max)

		GameSession.set_game_object_field(internal.game, internal.id, "velocity", velocity)
	end
end

function PlayerMovementStateBase:enter(old_state)
	return
end

function PlayerMovementStateBase:exit(new_state)
	if new_state == "dead" then
		local player = self._internal.player

		Managers.state.event:trigger("event_handgonne_reload_deactivated", player)
		Managers.state.event:trigger("event_lance_recharge_deactivated", player)
		Managers.state.event:trigger("event_parry_helper_deactivated", player)
		Managers.state.event:trigger("buffs_deactivated", player)
		Managers.state.event:trigger("event_pose_charge_deactivated", player)
		self:safe_action_interrupt("dead")
	end
end

function PlayerMovementStateBase:destroy()
	return
end

function PlayerMovementStateBase:change_state(new_state, ...)
	local internal = self._internal

	self:exit(new_state)

	internal.current_state = internal._states[new_state]

	if script_data.state_debug then
		print("Transition: ", internal.current_state_name, " -> ", new_state)
	end

	fassert(internal.current_state, "[PlayerMovementStateBase:change_state] Trying to switch to non-existing state '%s'", new_state)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "movement_state", NetworkLookup.movement_states[new_state])
	else
		internal.movement_state = new_state
	end

	local old_state = internal.current_state_name

	internal.current_state_name = new_state

	internal.current_state:enter(old_state, ...)
end

function PlayerMovementStateBase:set_target_rotation(target_rot)
	local internal = self._internal

	internal.target_rotation:store(target_rot)
	internal.move_rot:store(target_rot)
end

function PlayerMovementStateBase:set_local_position(new_pos)
	local internal = self._internal

	Unit.set_local_position(self._unit, 0, new_pos)

	if internal.game and internal.id and Vector3.length(new_pos) < 1000 then
		GameSession.set_game_object_field(internal.game, internal.id, "position", new_pos)
	end
end

function PlayerMovementStateBase:set_local_rotation(new_rot)
	local internal = self._internal

	Unit.set_local_rotation(self._unit, 0, new_rot)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "rotation", new_rot)
	end
end

function PlayerMovementStateBase:aim_direction()
	local unit = self._unit
	local aim_target = self._internal.aim_target:unbox()
	local aim_from_pos = Mover.position(Unit.mover(unit)) + Unit.local_position(unit, Unit.node(unit, "camera_attach"))

	return aim_target - aim_from_pos
end

function PlayerMovementStateBase:aim_rotation()
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(self._unit, "viewport_name")

	return camera_manager:aim_rotation(viewport_name)
end

function PlayerMovementStateBase:update_camera_target(dt)
	local internal = self._internal
	local old_unit_type = internal.camera_follow_unit_type
	local unit_type
	local mount = internal.mounted_unit

	unit_type = Unit.alive(mount) and not internal.aiming and "mount" or "player"

	if old_unit_type ~= unit_type then
		local unit

		if unit_type == "mount" then
			unit = mount
		elseif unit_type == "player" then
			unit = self._unit
		else
			ferror("PlayerMounted:_set_camera_unit() incorrect unit type %s", tostring(unit_type))
		end

		internal.camera_follow_unit_type = unit_type

		local player = internal.player

		player:set_camera_follow_unit(unit)
	end
end

function PlayerMovementStateBase:update_camera(dt)
	local camera_node = "onground"
	local internal = self._internal
	local inventory = internal:inventory()
	local unit = self._unit

	self:update_camera_target(dt)

	if internal.execute_camera then
		camera_node = internal.execute_camera
	elseif internal.executed_camera then
		camera_node = internal.executed_camera
	elseif internal.current_state_name == "knocked_down" then
		camera_node = "knocked_down"
	elseif internal.current_state_name == "stunned" then
		camera_node = "stunned"
	elseif internal.landing then
		if internal.land_type == "dead" then
			camera_node = "land_dead"
		elseif internal.land_type == "knocked_down" then
			camera_node = "land_knocked_down"
		elseif internal.land_type == "heavy" then
			camera_node = "land_heavy"
		elseif internal.land_type == "light" then
			camera_node = "land_light"
		end
	elseif internal.current_state_name == "climbing" then
		camera_node = "climbing"
	elseif internal.current_state_name == "planting_flag" then
		camera_node = "planting_flag"
	elseif internal.current_state_name == "reviving_teammate" then
		camera_node = "reviving_teammate"
	elseif internal.current_state_name == "bandaging_self" then
		camera_node = "bandaging_self"
	elseif internal.current_state_name == "bandaging_teamamte" then
		camera_node = "bandaging_teammate"
	elseif internal.camera_follow_unit_type == "mount" then
		unit = internal.mounted_unit

		if internal.dismounting then
			camera_node = "dismounting"
		elseif internal.couching then
			camera_node = "couch"
		elseif internal.mounting then
			camera_node = "mounting"
		elseif Unit.get_data(unit, "current_state_name") == "jumping" then
			if internal.aiming then
				camera_node = "jump_zoom"
			elseif internal.parrying then
				camera_node = "jump_parry_pose_" .. internal.block_direction
			elseif internal.posing then
				camera_node = "jump_swing_pose_" .. internal.pose_direction
			else
				camera_node = "jump"
			end
		elseif internal.aiming then
			local slot_name = inventory:wielded_ranged_weapon_slot()
			local gear = inventory:_gear(slot_name)
			local extensions = gear:extensions()
			local weapon_ext = extensions.base

			camera_node = "zoom_" .. weapon_ext:category()
		elseif ScriptUnit.extension(unit, "locomotion_system").charging then
			if internal.posing then
				camera_node = "charge_swing_pose_" .. internal.pose_direction
			elseif internal.attempting_pose or internal.pose_ready then
				camera_node = "charge_swing_pose_blend"
			else
				camera_node = "charge"
			end
		elseif internal.parrying then
			camera_node = "parry_pose_" .. internal.block_direction
		elseif internal.posing then
			camera_node = "swing_pose_" .. internal.pose_direction
		elseif internal.attempting_pose or internal.pose_ready then
			camera_node = "swing_pose_blend"
		end
	elseif internal.jumping then
		camera_node = "jump"
	elseif internal.falling then
		camera_node = "fall"
	elseif internal.aiming then
		local slot_name = inventory:wielded_ranged_weapon_slot()
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		camera_node = "zoom_" .. weapon_ext:category()
	elseif internal.parrying then
		camera_node = "parry_pose_" .. internal.block_direction
	elseif internal.posing then
		camera_node = "swing_pose_" .. internal.pose_direction
	elseif internal.attempting_pose or internal.pose_ready then
		camera_node = "swing_pose_blend"
	elseif internal.crouching then
		camera_node = "crouch"
	end

	if script_data.camera_debug and Unit.get_data(unit, "camera", "settings_node") ~= camera_node then
		print("PlayerMovementStateBase:update_camera() Change to camera: ", internal.camera_follow_unit_type, camera_node)
	end

	Unit.set_data(unit, "camera", "settings_node", camera_node)
end

function PlayerMovementStateBase:update_lerped_rotation(dt)
	local unit = self._unit
	local internal = self._internal
	local target_rot = internal.target_world_rotation:unbox()
	local current_rot = Unit.local_rotation(unit, 0)
	local anim_rotation_var_index = Unit.animation_find_variable(unit, "rotation_speed")
	local anim_rotation_speed = Unit.animation_get_variable(unit, anim_rotation_var_index)
	local diff_quaternion = Quaternion.multiply(Quaternion.inverse(current_rot), target_rot)
	local diff_fwd = Quaternion.forward(diff_quaternion)
	local angle = math.sign(diff_fwd[1]) * math.acos(Vector3.dot(diff_fwd, Vector3(0, 1, 0)))

	anim_rotation_speed = math.lerp(anim_rotation_speed, angle * 2 / math.pi, dt * ROTATION_ANIM_LERP_FACTOR)
	anim_rotation_speed = math.clamp(anim_rotation_speed, -1, 1)

	Unit.animation_set_variable(unit, anim_rotation_var_index, anim_rotation_speed)

	local abs_angle = math.abs(angle)
	local lerp_factor = math.min(dt * ROTATION_LERP_FACTOR, abs_angle > 1 and internal.max_rotation_speed and math.min(internal.max_rotation_speed * dt / abs_angle, 1) or 1)
	local new_rot = Quaternion.lerp(current_rot, target_rot, lerp_factor)
	local aim_vector = self._aim_vector
	local aim_vector_flat = Vector3.normalize(Vector3.flat(aim_vector))
	local aim_rot_flat = Quaternion.look(aim_vector_flat, Vector3.up())

	internal.current_rotation:store(Quaternion.multiply(Quaternion.inverse(aim_rot_flat), new_rot))

	if script_data.rotation_debug then
		local drawer = Managers.state.debug:drawer({
			name = "player_rotation",
			mode = "immediate"
		})

		drawer:quaternion(Unit.local_position(self._unit, 0) + Quaternion.up(new_rot) * 0.05, new_rot)
		drawer:quaternion(Unit.local_position(self._unit, 0), Quaternion.multiply(aim_rot_flat, internal.current_rotation:unbox()))
	end

	self:_set_rotation(new_rot)
end

function PlayerMovementStateBase:set_target_world_rotation(target_rot)
	local internal = self._internal

	internal.target_world_rotation:store(target_rot)

	local aim_vector = self._aim_vector
	local aim_vector_flat = Vector3.normalize(Vector3.flat(aim_vector))
	local aim_rot_flat = Quaternion.look(aim_vector_flat, Vector3.up())

	internal.target_rotation:store(Quaternion.multiply(target_rot, Quaternion.inverse(aim_rot_flat)))
end

local MIN_ANGLE_SPEED = math.pi * 2
local ASYMPTOTIC_INTERPOLATION_SPEED = 5

function PlayerMovementStateBase:_update_current_rotation(dt)
	local internal = self._internal
	local target_rot = internal.target_rotation:unbox()
	local current_rot = internal.current_rotation:unbox()
	local diff_rotation = Quaternion.multiply(Quaternion.inverse(target_rot), current_rot)
	local diff_vector = Quaternion.forward(diff_rotation)
	local angle = math.abs(math.atan2(diff_vector.x, diff_vector.y))
	local angle_change = math.min(angle, MIN_ANGLE_SPEED * dt)

	if angle > 0 then
		local lerp_step = math.max(dt * ASYMPTOTIC_INTERPOLATION_SPEED, angle_change / angle)
		local current_rot = Quaternion.lerp(current_rot, target_rot, lerp_step)

		internal.current_rotation:store(current_rot)
	end

	local aim_vector = self._aim_vector
	local aim_vector_flat = Vector3.normalize(Vector3.flat(aim_vector))
	local aim_rot_flat = Quaternion.look(aim_vector_flat, Vector3.up())
	local new_rot = Quaternion.multiply(aim_rot_flat, current_rot)

	internal.move_rot:store(Quaternion.multiply(aim_rot_flat, internal.move_rotation_local:unbox()))

	if script_data.animation_debug then
		local drawer = Managers.state.debug:drawer({
			name = "player_rotation",
			mode = "immediate"
		})

		drawer:vector(Unit.local_position(self._unit, 0) + Vector3(0, 0, 0.02), Quaternion.forward(new_rot), Color(255, 0, 0))
		drawer:vector(Unit.local_position(self._unit, 0), Quaternion.forward(Quaternion.multiply(aim_rot_flat, target_rot)), Color(0, 255, 0))
		drawer:vector(Unit.local_position(self._unit, Unit.node(self._unit, "Hips")) + Unit.local_position(self._unit, 0), Quaternion.forward(Quaternion.multiply(Unit.local_rotation(self._unit, 0), Unit.local_rotation(self._unit, Unit.node(self._unit, "Hips")))), Color(255, 0, 0))
		drawer:vector(Unit.local_position(self._unit, 0) + Vector3(0, 0, 0.01), Quaternion.forward(internal.move_rot:unbox()), Color(0, 0, 255))
	end

	if script_data.rotation_debug then
		local drawer = Managers.state.debug:drawer({
			name = "player_rotation",
			mode = "immediate"
		})

		drawer:quaternion(Unit.local_position(self._unit, 0), new_rot)
	end

	self:_set_rotation(new_rot)
end

function PlayerMovementStateBase:set_world_rotation(new_rot)
	self:set_target_world_rotation(new_rot)
	self:_set_rotation(new_rot)
end

function PlayerMovementStateBase:_set_rotation(new_rot)
	local unit = self._unit
	local internal = self._internal

	Unit.set_local_rotation(unit, 0, new_rot)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "rotation", new_rot)
	end
end

function PlayerMovementStateBase:anim_event(event, force_local)
	local unit = self._unit

	if not Unit.has_animation_state_machine(unit) then
		return
	end

	local internal = self._internal
	local event_id = NetworkLookup.anims[event]

	if not force_local and internal.game and internal.id then
		if Managers.lobby.server then
			Managers.state.network:send_rpc_clients("rpc_anim_event", event_id, internal.id)
		else
			Managers.state.network:send_rpc_server("rpc_anim_event", event_id, internal.id)
		end
	end

	Unit.animation_event(unit, event)
end

function PlayerMovementStateBase:anim_event_with_variable_float(event, variable_name, variable_value, force_local)
	local unit = self._unit

	if not Unit.has_animation_state_machine(unit) then
		return
	end

	local internal = self._internal
	local event_id = NetworkLookup.anims[event]
	local variable_id = NetworkLookup.anims[variable_name]

	if not force_local and internal.game and internal.id then
		if Managers.lobby.server then
			Managers.state.network:send_rpc_clients("rpc_anim_event_variable_float", event_id, internal.id, variable_id, variable_value)
		else
			Managers.state.network:send_rpc_server("rpc_anim_event_variable_float", event_id, internal.id, variable_id, variable_value)
		end
	end

	local variable_index = Unit.animation_find_variable(unit, variable_name)

	Unit.animation_set_variable(unit, variable_index, variable_value)
	Unit.animation_event(unit, event)
end

function PlayerMovementStateBase:bow_draw_animation_event(event, draw_time, tense_time, hold_time)
	local unit = self._unit

	if not Unit.has_animation_state_machine(unit) then
		return
	end

	local draw_variable_name = "bow_draw_time"
	local tense_variable_name = "bow_tense_time"
	local hold_variable_name = "bow_hold_time"
	local internal = self._internal
	local event_id = NetworkLookup.anims[event]
	local draw_time_id = NetworkLookup.anims[draw_variable_name]
	local tense_time_id = NetworkLookup.anims[tense_variable_name]
	local hold_time_id = NetworkLookup.anims[hold_variable_name]

	if internal.game and internal.id then
		if Managers.lobby.server then
			Managers.state.network:send_rpc_clients("rpc_bow_draw_animation_event", event_id, internal.id, draw_time_id, draw_time, tense_time_id, tense_time, hold_time_id, hold_time)
		else
			Managers.state.network:send_rpc_server("rpc_bow_draw_animation_event", event_id, internal.id, draw_time_id, draw_time, tense_time_id, tense_time, hold_time_id, hold_time)
		end
	end

	local draw_index = Unit.animation_find_variable(unit, draw_variable_name)
	local tense_index = Unit.animation_find_variable(unit, tense_variable_name)
	local hold_index = Unit.animation_find_variable(unit, hold_variable_name)

	Unit.animation_set_variable(unit, draw_index, draw_time)
	Unit.animation_set_variable(unit, tense_index, tense_time)
	Unit.animation_set_variable(unit, hold_index, hold_time)
	Unit.animation_event(unit, event)
end

function PlayerMovementStateBase:update_aim_rotation(dt, t)
	local aim_rot = self:aim_rotation()

	self._aim_rot = aim_rot
	self._aim_vector = Quaternion.forward(aim_rot)
end

function PlayerMovementStateBase:_move_speed()
	local internal = self._internal
	local inventory = internal:inventory()
	local enc = inventory:encumbrance()
	local multiplier = PlayerUnitMovementSettings.encumbrance.functions.movement_speed(enc)

	if internal:has_perk("man_at_arms") then
		multiplier = multiplier * Perks.man_at_arms.move_speed_multiplier
	end

	return PlayerUnitMovementSettings.move_speed * multiplier
end

function PlayerMovementStateBase:update_look_angle(dt)
	local unit = self._unit
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(unit, "viewport_name")

	if viewport_name then
		local u_rotation = Unit.world_rotation(unit, 0)
		local u_forward = Quaternion.forward(u_rotation)
		local u_forward_flat = Vector3(u_forward.x, u_forward.y, 0)
		local u_rotation_flat = Quaternion.look(u_forward_flat, Vector3.up())
		local aim_rotation = camera_manager:aim_rotation(viewport_name)
		local aim_forward = Quaternion.forward(aim_rotation)
		local aim_forward_flat = Vector3(aim_forward.x, aim_forward.y, 0)
		local aim_rotation_flat = Quaternion.look(aim_forward_flat, Vector3.up())
		local diff_quaternion = Quaternion.multiply(Quaternion.inverse(u_rotation_flat), aim_rotation_flat)
		local diff_forward = Quaternion.forward(diff_quaternion)
		local angle = math.atan2(diff_forward.x, diff_forward.y)

		self._internal.look_angle = angle
	end
end

function PlayerMovementStateBase:update_look_anim_var(dt)
	local internal = self._internal
	local unit = self._unit
	local aim_direction = 2 * internal.look_angle / math.pi

	Unit.animation_set_variable(unit, self._look_direction_anim_var, aim_direction)

	if script_data.debug_aim_direction then
		print("aim_direction", aim_direction)
	end
end

function PlayerMovementStateBase:update_aim_target(dt)
	local unit = self._unit
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(unit, "viewport_name")

	if viewport_name then
		local internal = self._internal
		local aim_from_pos = Mover.position(Unit.mover(unit)) + Unit.local_position(unit, Unit.node(unit, "camera_attach"))
		local aim_rotation = camera_manager:aim_rotation(viewport_name)
		local max_z = 2
		local dir = Quaternion.forward(aim_rotation)
		local flat_rel_aim_dir = Vector3(dir.x, dir.y, 0)
		local flat_length = Vector3.length(flat_rel_aim_dir)
		local unmodified_rel_aim_dir = dir / flat_length
		local unnormalized_rel_aim_dir = Vector3(unmodified_rel_aim_dir.x, unmodified_rel_aim_dir.y, math.min(unmodified_rel_aim_dir.z, max_z))
		local rel_aim_dir = Vector3.normalize(unnormalized_rel_aim_dir) * 3
		local aim_target = aim_from_pos + rel_aim_dir

		internal.aim_target:store(aim_target)

		if script_data.aim_constraint_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "constraint debug"
			})

			drawer:sphere(aim_target, 0.05, Color(255, 255, 0))
		end

		Unit.animation_set_constraint_target(unit, self._aim_constraint_anim_var, aim_target)

		if internal.game and internal.id then
			GameSession.set_game_object_field(internal.game, internal.id, "aim_target", rel_aim_dir)
		end
	end
end

function PlayerMovementStateBase:_update_officer_buff_activation(dt, t)
	local internal = self._internal
	local controller = self._controller
	local officer_buff_one_input = controller and controller:get("officer_buff_one")
	local officer_buff_two_input = controller and controller:get("officer_buff_two")
	local buff_index = officer_buff_one_input and 1 or officer_buff_two_input and 2 or 0
	local cooldown_time = buff_index ~= 0 and internal.officer_buff_activation_blackboard[buff_index].cooldown

	if internal.player.is_corporal then
		local blackboards = internal.officer_buff_activation_blackboard

		for key, blackboard in ipairs(blackboards) do
			if blackboard.buff_type then
				local units_in_squad = AreaBuffHelper:alive_units_in_squad(internal.player)
				local level = 0

				for key, unit in ipairs(units_in_squad) do
					level = Unit.alive(unit) and AreaBuffHelper:unit_in_buff_area(unit, self._unit, "sphere", AreaBuffSettings.RANGE) and level + 1 or level
				end

				blackboard.level = level
			end
		end
	end

	if self:_can_activate_officer_buff(buff_index, t) and cooldown_time <= t then
		local buff_type = internal.officer_buffs[buff_index]
		local buff_settings = Buffs[buff_type]

		self:safe_action_interrupt("officer_buff_activation")
		self:anim_event("banner_bonus_charge")

		internal.activating_officer_buff_index = buff_index
		internal.charging_officer_buff = true
		internal.officer_buff_charge_time = t + buff_settings.charge_time
	end

	if internal.charging_officer_buff and t >= internal.officer_buff_charge_time then
		local buff_index = internal.activating_officer_buff_index
		local buff_type = internal.officer_buffs[buff_index]
		local buff_settings = Buffs[buff_type]
		local player = internal.player
		local network_manager = Managers.state.network

		internal.officer_buff_activation_blackboard[buff_index].cooldown = t + buff_settings.cooldown_time
		internal.activating_officer_buff_index = nil
		internal.charging_officer_buff = false
		internal.officer_buff_charge_time = 0
		internal.activating_officer_buff = true
		internal.officer_buff_activation_time = t + buff_settings.activation_time

		self:anim_event("banner_bonus_action")

		local unit = self._unit

		AreaBuffHelper:play_squad_area_buff_voice_over(unit, buff_type, internal.world)

		if internal.game and internal.id and not Managers.lobby.server then
			network_manager:send_rpc_server("rpc_create_squad_area_buff", player:player_id(), internal.id, NetworkLookup.buff_types[buff_type])

			return
		end

		AreaBuffHelper:create_squad_area_buff(player, unit, buff_type)
	end

	if internal.activating_officer_buff and t >= internal.officer_buff_activation_time then
		self:_abort_officer_buff_activation("finished")
	end
end

function PlayerMovementStateBase:_update_weapons(dt, t)
	self:_update_block(dt, t)
	self:_update_swing(dt, t)
	self:_update_ranged_weapons(dt, t)
	self:_update_weapon_wield(dt, t)
end

function PlayerMovementStateBase:_update_block(dt, t)
	local internal = self._internal
	local controller = self._controller
	local block_input = controller and controller:get("block") > BUTTON_THRESHOLD
	local unbreak_block = controller and controller:get("raise_block")

	if unbreak_block then
		internal.block_broken = false
	end

	if block_input and not internal.blocking and not internal.parrying then
		local can_raise, slot_name = self:can_raise_block(t)

		if can_raise then
			local inventory = internal:inventory()
			local block_type = inventory:block_type(slot_name)

			if block_type == "shield" then
				self:safe_action_interrupt("block")
				self:_raise_shield_block(slot_name)
			elseif block_type == "buckler" or block_type == "weapon" then
				self:safe_action_interrupt("parry_attempt")
				self:_update_parry_attempt(dt, slot_name, block_type)
			else
				assert(false, "Invalid block type: " .. tostring(block_type))
			end
		end
	elseif internal.attempting_parry and (not block_input or internal.crouching or internal.block_unit and not Unit.alive(internal.block_unit)) then
		self:_abort_parry_attempt()
	elseif (internal.blocking or internal.parrying) and (not block_input or internal.crouching or internal.block_unit and not Unit.alive(internal.block_unit) or internal.block_broken) then
		self:_lower_block()
	end
end

function PlayerMovementStateBase:_update_parry_attempt(dt, slot_name, block_type)
	if PlayerUnitMovementSettings.parry.keyboard_controlled then
		self:_update_parry_attempt_keyboard(dt, slot_name, block_type)
	else
		self:_update_parry_attempt_mouse(dt, slot_name, block_type)
	end
end

function PlayerMovementStateBase:_update_parry_attempt_keyboard(dt, slot_name, block_type)
	local move = self._controller and self._controller:get("move")
	local invert_x = PlayerUnitMovementSettings.parry.invert_parry_control_x
	local invert_y = PlayerUnitMovementSettings.parry.invert_parry_control_y
	local dir

	if move.y > 0 then
		dir = invert_y and "down" or "up"
	elseif move.y < 0 then
		dir = invert_y and "up" or "down"
	elseif move.x > 0 then
		dir = invert_x and "right" or "left"
	elseif move.x < 0 then
		dir = invert_x and "left" or "right"
	end

	if dir then
		self:_raise_parry_block(slot_name, block_type, dir)
	end
end

function PlayerMovementStateBase:_update_parry_attempt_mouse(dt, slot_name, block_type)
	local internal = self._internal
	local look_vec_raw = self._controller:get("look")

	if PlayerUnitMovementSettings.parry.invert_parry_control_x then
		look_vec_raw.x = -look_vec_raw.x
	end

	if PlayerUnitMovementSettings.parry.invert_parry_control_y then
		look_vec_raw.y = -look_vec_raw.y
	end

	local y_scale = look_vec_raw.y < 0 and PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_DOWN or PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_UP
	local look_vec = Vector3(look_vec_raw.x, look_vec_raw.y * y_scale, 0)
	local acc_parry_dir = internal.accumulated_parry_direction:unbox()

	acc_parry_dir = acc_parry_dir + look_vec

	internal.accumulated_parry_direction:store(acc_parry_dir)

	internal.attempting_parry = true

	local acc_parry_dir_x_abs = math.abs(acc_parry_dir.x)
	local acc_parry_dir_y_abs = math.abs(acc_parry_dir.y)

	if Vector3.length(acc_parry_dir) > PARRY_ATTEMPT_THRESHOLD then
		local direction

		direction = acc_parry_dir_y_abs < acc_parry_dir.x and "left" or acc_parry_dir_y_abs < acc_parry_dir_x_abs and "right" or acc_parry_dir.y > 0 and "up" or "down"

		self:_raise_parry_block(slot_name, block_type, direction)
	end
end

function PlayerMovementStateBase:_update_swing(dt, t)
	local internal = self._internal
	local controller = self._controller
	local pose_input = controller and controller:get("melee_pose") > BUTTON_THRESHOLD
	local swing_input = not controller or controller:get("melee_swing")

	if internal.swing_recovery_time and t > internal.swing_recovery_time then
		self:_end_swing_recovery()
	end

	local can_pose, pose_slot_name = self:can_pose_melee_weapon()

	if pose_input and self:can_attempt_pose_melee_weapon(t) then
		self:_update_pose_attempt(dt)
	elseif can_pose then
		self:_pose_melee_weapon(pose_slot_name, t)
	elseif not pose_input and self:can_swing_melee_weapon() then
		if self:_swing_ready(t) then
			self:_swing_melee_weapon(t)
		else
			self:_update_pose(dt, t)
		end
	elseif not pose_input and (internal.posing or internal.attempting_pose) then
		self:_abort_pose()
	elseif internal.posing then
		self:_update_pose(dt, t)
	end
end

function PlayerMovementStateBase:_swing_ready(t)
	local internal = self._internal
	local posed_time = t - internal.pose_time
	local direction = internal.pose_direction
	local gear = internal:inventory():_gear(internal.pose_slot_name)
	local min_pose_time = gear:settings().attacks[direction].minimum_pose_time

	return min_pose_time < posed_time
end

function PlayerMovementStateBase:_update_pose_attempt(dt)
	if PlayerUnitMovementSettings.swing.keyboard_controlled then
		self:_update_pose_attempt_keyboard(dt)
	else
		self:_update_pose_attempt_mouse(dt)
	end
end

function PlayerMovementStateBase:_update_pose_attempt_keyboard(dt)
	local internal = self._internal
	local move = self._controller and self._controller:get("move")
	local invert_x = PlayerUnitMovementSettings.swing.invert_pose_control_x
	local invert_y = PlayerUnitMovementSettings.swing.invert_pose_control_y
	local dir
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()
	local gear_settings = inventory:gear_settings(slot_name)
	local has_shield = inventory:wielded_block_slot() ~= slot_name

	if gear_settings.only_thrust_with_shield and has_shield then
		dir = "down"
	elseif move.y > 0 then
		dir = invert_y and "down" or "up"
	elseif move.y < 0 then
		dir = invert_y and "up" or "down"
	elseif move.x > 0 then
		dir = invert_x and "left" or "right"
	elseif move.x < 0 then
		dir = invert_x and "right" or "left"
	end

	Managers.state.camera:set_variable(internal.player.viewport_name, "swing_x", 1)
	Managers.state.camera:set_variable(internal.player.viewport_name, "swing_y", 1)

	if dir then
		internal.pose_ready = true
		internal.pose_direction = dir

		self:anim_event("swing_pose_blend")
	end
end

function PlayerMovementStateBase:_update_pose_attempt_mouse(dt)
	local internal = self._internal

	if not internal.attempting_pose then
		self:anim_event("swing_pose_blend")

		internal.pose_accumulated_dt = 0

		self:safe_action_interrupt("attempting_pose")
	end

	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()
	local gear_settings = inventory:gear_settings(slot_name)
	local acc_pose = internal.accumulated_pose:unbox()
	local has_shield = inventory:wielded_block_slot() ~= slot_name
	local look_vec_raw = self._controller:get("look")

	if PlayerUnitMovementSettings.swing.invert_pose_control_x then
		look_vec_raw.x = -look_vec_raw.x
	end

	if PlayerUnitMovementSettings.swing.invert_pose_control_y then
		look_vec_raw.y = -look_vec_raw.y
	end

	if gear_settings.only_thrust_with_shield and has_shield then
		look_vec_raw = Vector3(0, -1, 0)
	end

	local y_scale = look_vec_raw.y < 0 and PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_DOWN or PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_UP
	local look_vec = Vector3(look_vec_raw.x, look_vec_raw.y * y_scale, 0)
	local look_vec_len = Vector3.length(look_vec)

	if look_vec_len > 0 then
		local total_dt = internal.pose_accumulated_dt + dt
		local max_len = PlayerUnitMovementSettings.swing.MAX_MOVEMENT_TO_POSE_SPEED * total_dt
		local delta_vec = Vector3.normalize(look_vec) * math.clamp(look_vec_len, -max_len, max_len)

		internal.pose_accumulated_dt = 0
		acc_pose = acc_pose + delta_vec
	else
		internal.pose_accumulated_dt = internal.pose_accumulated_dt + dt

		if internal.pose_accumulated_dt > 0.1 then
			internal.pose_accumulated_dt = 0
		end
	end

	internal.accumulated_pose:store(acc_pose)

	internal.attempting_pose = true

	local acc_pose_x_abs = math.abs(acc_pose.x)
	local acc_pose_y_abs = math.abs(acc_pose.y)
	local length = Vector3.length(acc_pose)
	local proportion = math.min(length / PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE, 1)
	local sq_root_weight_x, sq_root_weight_y

	if acc_pose_y_abs < acc_pose_x_abs then
		sq_root_weight_x = 1
		sq_root_weight_y = 0
	else
		sq_root_weight_x = 0
		sq_root_weight_y = 1
	end

	local scale_proportion_x = acc_pose_x_abs / (acc_pose_y_abs + acc_pose_x_abs + 0.001)
	local scale_proportion_y = acc_pose_y_abs / (acc_pose_y_abs + acc_pose_x_abs + 0.001)
	local sq_factor = proportion * proportion
	local scale_factor = 1 - sq_factor
	local attack_max_val_x, attack_max_val_y

	if acc_pose.x > 0 then
		attack_max_val_x = gear_settings.attacks.right.normal_swing_pose_anim_blend_value
	else
		attack_max_val_x = gear_settings.attacks.left.normal_swing_pose_anim_blend_value
	end

	if acc_pose.y > 0 then
		attack_max_val_y = gear_settings.attacks.up.normal_swing_pose_anim_blend_value
	else
		attack_max_val_y = gear_settings.attacks.down.normal_swing_pose_anim_blend_value
	end

	local x_weight = sq_root_weight_x * sq_factor * attack_max_val_x + scale_proportion_x * scale_factor * attack_max_val_x
	local y_weight = sq_root_weight_y * sq_factor * attack_max_val_y + scale_proportion_y * scale_factor * attack_max_val_y
	local final_x_weight = x_weight * proportion * math.sign(acc_pose.x)
	local final_y_weight = y_weight * proportion * math.sign(acc_pose.y)
	local x_variable_index = Unit.animation_find_variable(self._unit, "pose_x")
	local y_variable_index = Unit.animation_find_variable(self._unit, "pose_y")

	Unit.animation_set_variable(self._unit, x_variable_index, final_x_weight)
	Unit.animation_set_variable(self._unit, y_variable_index, final_y_weight)
	Managers.state.camera:set_variable(internal.player.viewport_name, "swing_x", final_x_weight / attack_max_val_x)
	Managers.state.camera:set_variable(internal.player.viewport_name, "swing_y", final_y_weight / attack_max_val_y)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "pose_anim_blend_value", Vector3(final_x_weight, final_y_weight, 0))
	end

	if proportion >= 1 then
		internal.pose_ready = true
		internal.attempting_pose = false

		internal.accumulated_pose:store(Vector3(0, 0, 0))

		if acc_pose_y_abs < acc_pose.x then
			internal.pose_direction = "right"
		elseif acc_pose_y_abs < acc_pose_x_abs then
			internal.pose_direction = "left"
		elseif acc_pose.y > 0 then
			internal.pose_direction = "up"
		else
			internal.pose_direction = "down"
		end
	end
end

function PlayerMovementStateBase:_update_pose(dt, t)
	local internal = self._internal
	local dir = internal.pose_direction
	local inventory = internal:inventory()
	local gear_settings = inventory:gear_settings(inventory:wielded_melee_weapon_slot())
	local attack_settings = gear_settings.attacks[dir]
	local gear = inventory:_gear(internal.pose_slot_name)
	local pose_duration = t - internal.pose_time
	local pose_speed_multiplier = gear:attachment_multiplier("pose_speed")
	local blackboard = internal.perk_fast_swings

	for perk_name, perk_blackboard in pairs(blackboard) do
		local perk_settings = Perks[perk_name]

		if internal:has_perk(perk_name) and perk_blackboard.can_use and t < perk_blackboard.timer then
			pose_speed_multiplier = pose_speed_multiplier * perk_settings.pose_speed_multiplier
			perk_blackboard.cooldown = t + perk_settings.cooldown

			break
		end
	end

	local charge_time = attack_settings.charge_time * PlayerUnitMovementSettings.encumbrance.functions.pose_time(inventory:encumbrance()) * pose_speed_multiplier
	local blend_value_start = attack_settings.normal_swing_pose_anim_blend_value
	local x_blend, y_blend
	local pose_factor = pose_duration / charge_time

	internal.pose_charge_blackboard.pose_factor = math.min(pose_factor, 1)

	if dir == "up" then
		x_blend = 0
		y_blend = blend_value_start + (1 - blend_value_start) * math.min(math.sqrt(pose_factor), 1)
	elseif dir == "down" then
		x_blend = 0
		y_blend = -(blend_value_start + (1 - blend_value_start) * math.min(math.sqrt(pose_factor), 1))
	elseif dir == "left" then
		y_blend = 0
		x_blend = -(blend_value_start + (1 - blend_value_start) * math.min(math.sqrt(pose_factor), 1))
	elseif dir == "right" then
		y_blend = 0
		x_blend = blend_value_start + (1 - blend_value_start) * math.min(math.sqrt(pose_factor), 1)
	else
		assert(false, "[PlayerOnground] Incorrect swing direction " .. internal.pose_direction)
	end

	local x_variable_index = Unit.animation_find_variable(self._unit, "pose_x")
	local y_variable_index = Unit.animation_find_variable(self._unit, "pose_y")

	Unit.animation_set_variable(self._unit, x_variable_index, x_blend)
	Unit.animation_set_variable(self._unit, y_variable_index, y_blend)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "pose_anim_blend_value", Vector3(x_blend, y_blend, 0))
	end
end

function PlayerMovementStateBase:_update_ranged_weapons(dt, t)
	local controller = self._controller
	local aim_input = controller and controller:get("ranged_weapon_aim") > BUTTON_THRESHOLD
	local fire_input = controller and controller:get("ranged_weapon_fire")
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()

	if slot_name then
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		if weapon_ext:loaded() and internal.reloading then
			self:_finish_reloading_weapon(true)
		elseif weapon_ext:loaded() then
			if aim_input and not internal.aiming then
				local can_aim = self:can_aim_ranged_weapon()

				if can_aim and not internal.reloading then
					self:_aim_ranged_weapon(slot_name, t)
				end
			end

			if fire_input and self:can_fire_ranged_weapon() then
				self:_fire_ranged_weapon(t)

				local camera_manager = Managers.state.camera

				camera_manager:camera_effect_sequence_event("fired_" .. weapon_ext:category(), t)
			end
		elseif self:can_reload(slot_name, aim_input) then
			if internal.reloading then
				weapon_ext:update_reload(dt, t, fire_input)
			else
				self:_start_reloading_weapon(dt, t, slot_name)
			end
		elseif internal.reloading then
			self:_finish_reloading_weapon(false)
		end

		if internal.aiming and not aim_input or weapon_ext:needs_unaiming() then
			weapon_ext:set_needs_unaiming(false)
			self:_unaim_ranged_weapon()

			internal.hold_breath_timer = 0
			internal.breathing_transition_time = 0
			internal.current_breathing_state = "normal"

			if weapon_ext:can_steady() then
				local settings = gear:settings()

				internal.current_sway_settings = nil
			end
		elseif internal.aiming and weapon_ext:can_steady() then
			if not internal.current_sway_settings then
				local settings = gear:settings()

				internal.current_sway_settings = table.clone(settings.sway.breath_normal)
			end

			self:_update_breathing_state(dt, t, slot_name)
		end

		if internal.aiming then
			self:_update_ranged_weapon_zoom(dt, t)
		end
	end
end

function PlayerMovementStateBase:_update_weapon_wield(dt, t)
	local inventory = self._internal:inventory()
	local controller = self._controller

	for slot_name, slot in pairs(inventory:slots()) do
		local wield_input = controller and controller:get(slot.settings.wield_input)

		if wield_input then
			if self:can_wield_weapon(slot_name, t) then
				self:safe_action_interrupt("wield")
				self:_wield_weapon(slot_name)
			elseif self:can_toggle_weapon(slot_name, t) then
				self:safe_action_interrupt("wield")
				self:_set_slot_wielded_instant(slot_name, false)
			end
		end
	end
end

function PlayerMovementStateBase:_update_tagging(dt, t)
	local internal = self._internal
	local controller = self._controller
	local unit_being_tagged = internal.unit_being_tagged
	local tagging_input = controller and controller:has("activate_tag") and controller:get("activate_tag") > BUTTON_THRESHOLD
	local player = internal.player

	if tagging_input and self:_can_tag(t, player) then
		local camera_manager = Managers.state.camera
		local viewport_name = Unit.get_data(self._unit, "viewport_name")
		local camera_position = camera_manager:camera_position(viewport_name)
		local camera_rotation = camera_manager:camera_rotation(viewport_name)
		local final_rotation = Quaternion.forward(camera_rotation)
		local physics_world = World.physics_world(internal.world)
		local cb = callback(self, "tagging_raycast_cb")
		local tagging_raycast

		if player.is_corporal then
			tagging_raycast = PhysicsWorld.make_raycast(physics_world, cb, "all", "collision_filter", "ray_tagging_corporal")
		else
			tagging_raycast = PhysicsWorld.make_raycast(physics_world, cb, "all", "collision_filter", "ray_tagging")
		end

		tagging_raycast:cast(camera_position, final_rotation)

		internal.tagging = true
		internal.tag_start_time = t

		Managers.state.event:trigger("started_tagging", player)

		if script_data.tagging_debug then
			local drawer = Managers.state.debug:drawer("tagging")

			drawer:line(camera_position, camera_position + final_rotation * 200, Color(0, 255, 0))
		end
	elseif tagging_input and unit_being_tagged then
		if t >= internal.time_to_tag then
			self:_process_tag(player, unit_being_tagged)
		end
	elseif unit_being_tagged and not tagging_input then
		self:_abort_tagging()
	elseif internal.tagging and not tagging_input then
		self:_abort_tagging()
	elseif internal.tagging and not unit_being_tagged then
		self:_update_tagging_nothing(dt, t)
	end
end

function PlayerMovementStateBase:_process_tag(player, unit_being_tagged)
	local internal = self._internal
	local network_manager = Managers.state.network
	local player_game_object_id = player.game_object_id
	local has_objective_system = ScriptUnit.has_extension(unit_being_tagged, "objective_system")
	local tagging_blackboard = internal.tagging_blackboard

	if has_objective_system then
		local objective_system = ScriptUnit.extension(unit_being_tagged, "objective_system")
		local level_index_id = objective_system:level_index()

		network_manager:send_rpc_server("rpc_request_to_tag_objective", player_game_object_id, level_index_id)

		internal.tagging_cooldown = Managers.time:time("game") + PlayerActionSettings.tagging.objective_cooldown
		tagging_blackboard.cooldown_duration = PlayerActionSettings.tagging.objective_cooldown
		tagging_blackboard.cooldown_time = internal.tagging_cooldown
	else
		local tagged_unit_id = network_manager:game_object_id(unit_being_tagged)

		network_manager:send_rpc_server("rpc_request_to_tag_player_unit", player_game_object_id, tagged_unit_id)

		internal.tagging_cooldown = Managers.time:time("game") + PlayerActionSettings.tagging.player_cooldown
		tagging_blackboard.cooldown_duration = PlayerActionSettings.tagging.player_cooldown
		tagging_blackboard.cooldown_time = internal.tagging_cooldown
	end

	internal.unit_being_tagged = nil
	internal.time_to_tag = 0
	internal.tagging = false

	Managers.state.event:trigger("stopped_tagging", player)
end

function PlayerMovementStateBase:tagging_raycast_cb(hits)
	local internal = self._internal
	local tagged_unit
	local hit_non_taggable_object = false

	if not hits then
		return
	end

	for _, hit in ipairs(hits) do
		local unit = Actor.unit(hit[4])

		if unit ~= self._unit then
			local is_player = ScriptUnit.has_extension(unit, "locomotion_system")
			local is_objective = ScriptUnit.has_extension(unit, "objective_system")

			if is_player or is_objective then
				if hit_non_taggable_object then
					local player = self._internal.player

					if player.is_corporal then
						if is_player then
							if PlayerMechanicsHelper.player_unit_tagged(player, unit) then
								tagged_unit = unit
							end
						else
							tagged_unit = unit
						end
					end
				else
					tagged_unit = unit
				end
			else
				hit_non_taggable_object = true
			end
		end

		if tagged_unit then
			break
		end
	end

	if tagged_unit and self:_tag_valid(tagged_unit) then
		internal.unit_being_tagged = tagged_unit
		internal.time_to_tag = Managers.time:time("game") + PlayerMechanicsHelper.time_to_tag(self._unit, tagged_unit)

		local tagging_blackboard = internal.tagging_blackboard

		tagging_blackboard.max_time = PlayerMechanicsHelper.time_to_tag(self._unit, tagged_unit)
		tagging_blackboard.timer = internal.time_to_tag
	end
end

function PlayerMovementStateBase:_tag_valid(tagged_unit)
	local player = self._internal.player
	local is_player = ScriptUnit.has_extension(tagged_unit, "locomotion_system")
	local is_objective = ScriptUnit.has_extension(tagged_unit, "objective_system") and ScriptUnit.extension(tagged_unit, "objective_system").level_index
	local is_valid

	if player.is_corporal then
		is_valid = is_player or is_objective
	else
		local tagged_player = Managers.player:owner(tagged_unit)

		is_valid = is_player and tagged_player.team ~= player.team
	end

	if is_valid and (is_objective or not ScriptUnit.extension(tagged_unit, "damage_system"):is_dead()) then
		return true
	end

	return false
end

function PlayerMovementStateBase:_update_tagging_nothing()
	return
end

function PlayerMovementStateBase:_can_switch_weapon_grip(t)
	local internal = self._internal

	return not internal.swinging and (not internal.swing_recovery_time or t > internal.swing_recovery_time or true) and not internal.parrying and not internal.attempting_parry
end

function PlayerMovementStateBase:_can_tag(t, tagging_player)
	local internal = self._internal

	return t >= internal.tagging_cooldown and tagging_player.squad_index and not internal.tagging and not internal.ghost_mode
end

function PlayerMovementStateBase:_can_activate_officer_buff(buff_index, t)
	return false
end

function PlayerMovementStateBase:can_wield_weapon()
	return false
end

function PlayerMovementStateBase:can_toggle_weapon()
	return false
end

function PlayerMovementStateBase:can_attempt_pose_melee_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_pose_melee_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_swing_melee_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_abort_melee_swing()
	return false, nil
end

function PlayerMovementStateBase:can_aim_ranged_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_unaim_ranged_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_fire_ranged_weapon()
	return false, nil
end

function PlayerMovementStateBase:can_raise_block()
	return false, nil
end

function PlayerMovementStateBase:can_lower_block()
	return false, nil
end

function PlayerMovementStateBase:can_crouch()
	return false
end

function PlayerMovementStateBase:can_rush()
	return false
end

function PlayerMovementStateBase:can_mount()
	return false
end

function PlayerMovementStateBase:can_unmount()
	return false
end

function PlayerMovementStateBase:can_jump()
	return false
end

function PlayerMovementStateBase:can_pickup_flag()
	return false
end

function PlayerMovementStateBase:can_drop_flag()
	return false
end

function PlayerMovementStateBase:can_plant_flag()
	return false
end

function PlayerMovementStateBase:can_shield_bash()
	return false
end

function PlayerMovementStateBase:can_push()
	return false
end

function PlayerMovementStateBase:can_call_horse()
	return false
end

function PlayerMovementStateBase:_dual_wield_right_hand_fallback()
	local fallback_slot
	local inventory = self._internal:inventory()

	for _, slot_name in ipairs(InventorySlotPriority) do
		if inventory:is_equipped(slot_name) and inventory:is_right_handed(slot_name) then
			if inventory:is_wielded(slot_name) then
				return nil
			else
				fallback_slot = fallback_slot or slot_name
			end
		end
	end

	return fallback_slot
end

function PlayerMovementStateBase:_wield_weapon(slot_name)
	local internal = self._internal
	local inventory = internal:inventory()

	self:_unwield_slots_on_wield(slot_name)

	local left_hand_wielded = inventory:is_left_handed(slot_name)
	local right_hand_wielded = inventory:is_right_handed(slot_name)
	local one_handed_wielded = inventory:is_one_handed(slot_name)
	local left_config = internal.dual_wield_config.left
	local right_config = internal.dual_wield_config.right
	local left_hand_slot = one_handed_wielded and left_hand_wielded and slot_name or left_config and inventory:is_equipped(left_config) and inventory:is_left_handed(left_config) and left_config
	local right_hand_slot = one_handed_wielded and (right_hand_wielded and slot_name or right_config and inventory:is_equipped(right_config) and right_config or self:_dual_wield_right_hand_fallback())

	if left_hand_slot and right_hand_slot and not inventory:is_wielded(right_hand_slot) then
		local left_wield_time = inventory:weapon_wield_time(left_hand_slot)
		local right_wield_time = inventory:weapon_wield_time(right_hand_slot)

		if right_wield_time < left_wield_time then
			self:anim_event_with_variable_float(inventory:weapon_wield_anim(left_hand_slot), "wield_time", left_wield_time)
		else
			self:anim_event_with_variable_float(inventory:weapon_wield_anim(right_hand_slot), "wield_time", right_wield_time)
		end

		internal.wielding = true
		internal.wield_slot_name = right_hand_slot
		internal.secondary_wield_slot_name = left_hand_slot
	else
		local wield_anim_event = inventory:weapon_wield_anim(slot_name)
		local wield_time = inventory:weapon_wield_time(slot_name)

		self:anim_event_with_variable_float(wield_anim_event, "wield_time", wield_time)

		internal.wielding = true
		internal.wield_slot_name = slot_name
	end

	if one_handed_wielded then
		internal.dual_wield_config.left = nil

		if right_hand_wielded then
			internal.dual_wield_config.right = slot_name
		end
	end
end

function PlayerMovementStateBase:_unwield_slots_on_wield(wield_slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local unwield_slots, exception_gear_types = inventory:unwield_slots_on_wield(wield_slot_name)

	for _, unwield_slot_name in ipairs(unwield_slots) do
		if inventory:can_unwield(unwield_slot_name) and not exception_gear_types[inventory:gear_settings(unwield_slot_name).gear_type] then
			self:_set_slot_wielded_instant(unwield_slot_name, false)

			if inventory:is_one_handed(unwield_slot_name) and inventory:is_two_handed(wield_slot_name) and inventory:is_left_handed(unwield_slot_name) then
				internal.dual_wield_config.left = unwield_slot_name
			end
		end
	end
end

function PlayerMovementStateBase:_set_slot_wielded_instant(slot_name, wielded)
	local inventory = self._internal:inventory()

	if not wielded and slot_name ~= "shield" then
		self:anim_event("weapon_unflip")
		inventory:set_grip_switched(false)
	end

	local main_body_state, hand_anim = inventory:set_gear_wielded(slot_name, wielded, false)

	if main_body_state then
		self:anim_event(main_body_state, true)
	end

	if hand_anim then
		self:anim_event(hand_anim, true)
	end
end

function PlayerMovementStateBase:anim_cb_wield()
	local internal = self._internal
	local slot_name = internal.wield_slot_name
	local secondary_slot_name = internal.secondary_wield_slot_name

	if not slot_name and not secondary_slot_name then
		assert(not internal.wielding, "PlayerMovementStateBase:anim_cb_wield(), no wield slots assigned but player is wielding.")

		return
	end

	local inventory = internal:inventory()

	self:_set_slot_wielded_instant(slot_name, true)

	if secondary_slot_name then
		self:_set_slot_wielded_instant(secondary_slot_name, true)
	end
end

function PlayerMovementStateBase:anim_cb_wield_finished()
	local internal = self._internal

	if not internal.wielding then
		return
	end

	local inventory = internal:inventory()
	local slot_name = internal.wield_slot_name
	local wield_reload_anim = inventory:wield_reload_anim(slot_name)

	internal.wielding = false
	internal.wield_slot_name = nil
	internal.secondary_wield_slot_name = nil

	self:anim_event("wield_finished")

	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local finish_wield_anim = weapon_ext:wield_finished_anim_name()
	local category = weapon_ext:category()

	if category == "bow" and self:can_reload(slot_name) then
		self:_start_reloading_bow(nil, nil, slot_name)
	elseif finish_wield_anim and not category == "bow" then
		self:anim_event(finish_wield_anim)
	end
end

function PlayerMovementStateBase:_pose_melee_weapon(slot_name, t)
	local internal = self._internal
	local inventory = internal:inventory()
	local unit = self._unit
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local direction = internal.pose_direction

	self:safe_action_interrupt("pose")

	internal.posing = true
	internal.pose_slot_name = slot_name
	internal.pose_time = t

	weapon_ext:pose(t, direction)

	local network_manager = Managers.state.network

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_pose_melee_weapon", user_object_id, NetworkLookup.directions[direction])
		else
			network_manager:send_rpc_server("rpc_pose_melee_weapon", user_object_id, NetworkLookup.directions[direction])
		end
	end

	Unit.flow_event(unit, "lua_enter_weapon_pose")
end

function PlayerMovementStateBase:_play_voice(event)
	local internal = self._internal
	local voice = internal:inventory():voice()
	local unit = self._unit
	local timpani_world = World.timpani_world(internal.world)
	local id = TimpaniWorld.trigger_event(timpani_world, event, unit, self._voice_node)

	TimpaniWorld.set_parameter(timpani_world, id, "character_vo", voice)
end

function PlayerMovementStateBase:_swing_melee_weapon(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.pose_slot_name
	local charge_time = t - internal.pose_time
	local pose_direction = internal.pose_direction
	local swing_direction = inventory:weapon_grip_switched() and pose_direction .. "_switched" or pose_direction
	local gear = inventory:_gear(slot_name)
	local swing_speed_multiplier = gear:attachment_multiplier("swing_speed")
	local attack_time, quick_swing = inventory:start_melee_attack(slot_name, charge_time, swing_direction, callback(self, "gear_cb_abort_swing"), swing_speed_multiplier)
	local swing_anim = quick_swing and "quick_swing_attack_" .. pose_direction or "swing_attack_" .. pose_direction

	self:anim_event_with_variable_float(swing_anim, "attack_time", attack_time)
	self:_end_pose()

	internal.swinging = true
	internal.swing_direction = pose_direction
	internal.swing_slot_name = slot_name
	internal.swing_abort_time = t + attack_time * gear:settings().attacks[swing_direction].abort_time_factor

	for perk_name, perk_blackboard in pairs(internal.perk_fast_swings) do
		perk_blackboard.can_use = false
	end

	self:_play_voice("chr_vce_start_swing")
	Unit.flow_event(self._unit, "lua_exit_weapon_pose")
end

function PlayerMovementStateBase:anim_cb_swing_finished()
	if not self._internal.swinging then
		return
	end

	self:swing_finished()
end

function PlayerMovementStateBase:gear_cb_abort_swing(reason)
	self:_abort_swing(reason)
end

function PlayerMovementStateBase:gear_cb_abort_shield_bash_swing(reason)
	self:_abort_shield_bash_swing(reason)
end

function PlayerMovementStateBase:gear_cb_abort_push_swing(reason)
	self:_abort_push_swing(reason)
end

function PlayerMovementStateBase:swing_finished(reason)
	local internal = self._internal

	assert(internal.swinging, "PlayerMovementStateBase:swing_finished() Trying to finish swing when not swinging")

	local inventory = internal:inventory()

	self:anim_event("swing_attack_penalty_start")

	local swing_recovery, swing_recovery_parry_penalty = inventory:end_melee_attack(internal.swing_slot_name, reason)
	local t = Managers.time:time("game")

	internal.swing_recovery_time = t + swing_recovery
	internal.swing_parry_recovery_time = t + swing_recovery_parry_penalty
	internal.swinging = false
	internal.swing_slot_name = nil
	internal.swing_direction = nil
end

function PlayerMovementStateBase:shield_bash_swing_finished(reason)
	local internal = self._internal
	local inventory = internal:inventory()
	local swing_recovery = inventory:end_melee_attack(inventory:wielded_block_slot(), reason)

	internal.swinging_shield_bash = false

	if reason == "hard" then
		self:anim_event_with_variable_float("shield_bash_hit_hard", "shield_bash_hit_hard_penalty_time", swing_recovery)
	elseif reason == "soft" then
		self:anim_event("shield_bash_hit", "shield_bash_hit_penalty_time", PlayerUnitDamageSettings.stun_shield_bash.hit_penalty)
	else
		self:anim_event_with_variable_float("shield_bash_miss", "shield_bash_miss_penalty_time", swing_recovery)
	end

	internal.shield_bash_cooldown = Managers.time:time("game") + PlayerUnitDamageSettings.stun_shield_bash.cooldown
end

function PlayerMovementStateBase:push_swing_finished(reason)
	local internal = self._internal
	local inventory = internal:inventory()
	local swing_recovery = inventory:end_melee_attack(inventory:wielded_block_slot(), reason)

	internal.swinging_push = false

	if reason == "hard" then
		self:anim_event_with_variable_float("push_hit_hard", "push_hit_hard_penalty_time", swing_recovery)
	elseif reason == "soft" then
		self:anim_event("push_hit")
	else
		self:anim_event_with_variable_float("push_miss", "push_miss_penalty_time", swing_recovery)
	end

	internal.push_cooldown = Managers.time:time("game") + PlayerUnitDamageSettings.stun_push.cooldown
end

function PlayerMovementStateBase:_aim_ranged_weapon(slot_name, t)
	local internal = self._internal
	local inventory = internal:inventory()
	local draw_time = inventory:ranged_weapon_draw_time(slot_name)
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	self:safe_action_interrupt("aim")
	Unit.set_data(self._unit, "camera", "settings_node", "zoom")

	local anim_name, anim_var_name = weapon_ext:aim(t)

	if weapon_ext:category() == "bow" then
		local settings = gear:settings()
		local attack_settings = settings.attacks.ranged
		local tense_time = attack_settings.bow_tense_time
		local hold_time = internal:has_perk("strong_of_arm") and Perks.strong_of_arm.bow_hold_time or 0.3

		self:bow_draw_animation_event(anim_name, draw_time, tense_time, hold_time)
	elseif anim_name then
		if anim_var_name then
			self:anim_event_with_variable_float(anim_name, anim_var_name, draw_time)
		else
			self:anim_event(anim_name)
		end
	end

	internal.aiming = true
	internal.aim_slot_name = slot_name
	internal.aim_time = t
	internal.aim_unit = inventory:gear_unit(slot_name)
	internal.ranged_weapon_zoom_value = 1

	local timpani_world = World.timpani_world(internal.world)
	local event_id = TimpaniWorld.trigger_event(timpani_world, "enter_stance_foley", self._unit)
end

function PlayerMovementStateBase:_unaim_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local anim_name = weapon_ext:unaim()

	if anim_name then
		self:anim_event(anim_name)
	end

	internal.aiming = false
	internal.aim_slot_name = nil
	internal.aim_time = nil
	internal.aim_unit = nil

	local timpani_world = World.timpani_world(internal.world)
	local event_id = TimpaniWorld.trigger_event(timpani_world, "Stop_enter_stance_foley", self._unit)

	self:_play_voice("chr_vce_aim_choke_new_stop")

	local event_id = TimpaniWorld.trigger_event(timpani_world, "Stop_bow_aim_fatigue")
end

function PlayerMovementStateBase:_fire_ranged_weapon(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local draw_time = t - internal.aim_time
	local slot_name = internal.aim_slot_name
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	if weapon_ext:firing_event() then
		local callback = callback(self, "_firing_event_callback")

		weapon_ext:start_release_projectile(slot_name, draw_time, callback, t)
	else
		weapon_ext:release_projectile(slot_name, draw_time)
	end

	local anim_name = weapon_ext:fire_anim_name()

	if anim_name then
		self:anim_event(anim_name)
	elseif weapon_ext:category() == "bow" then
		internal.release_reload = true
	end
end

function PlayerMovementStateBase:_firing_event_callback(gear_category)
	if gear_category == "handgonne" then
		self:anim_event("handgonne_recoil")
	elseif gear_category == "bow" then
		self:_unaim_ranged_weapon()
	end
end

function PlayerMovementStateBase:_start_reloading_bow_on_wield_or_new_ammo(slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local reload_time = inventory:ranged_weapon_reload_time(slot_name)
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local finish_wield_anim = extensions.base:wield_finished_anim_name()

	self:anim_event_with_variable_float(finish_wield_anim, "bow_reload_time", reload_time)
end

function PlayerMovementStateBase:_start_reloading_bow_on_release(slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local reload_time = inventory:ranged_weapon_reload_time(slot_name)

	self:anim_event_with_variable_float("bow_release_reload", "bow_reload_time", reload_time)
end

function PlayerMovementStateBase:_start_reloading_bow(dt, t, slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local reload_time = inventory:ranged_weapon_reload_time(slot_name)
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	weapon_ext:set_loaded(false)

	internal.reloading = true
	internal.reload_slot_name = slot_name

	if internal.release_reload then
		self:_start_reloading_bow_on_release(slot_name)

		internal.release_reload = false
	else
		self:_start_reloading_bow_on_wield_or_new_ammo(slot_name)
	end

	return reload_time
end

function PlayerMovementStateBase:_start_reloading_crossbow(dt, t, slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local blackboard = internal.crossbow_reload_blackboard

	internal.reloading = true
	internal.reload_slot_name = slot_name

	self:safe_action_interrupt("reload")
	self:_unaim_ranged_weapon()
	self:anim_event("crossbow_hand_reload")
	Managers.state.event:trigger("event_crossbow_minigame_activated", dt, t, internal.player, blackboard)

	local timpani_world = World.timpani_world(self._internal.world)
	local event_id = TimpaniWorld.trigger_event(timpani_world, "crossbow_load_loop")

	return inventory:ranged_weapon_reload_time(slot_name), blackboard
end

function PlayerMovementStateBase:_start_reloading_handgonne(dt, t, slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local fallback_slot = inventory:fallback_slot()

	internal.reload_slot_name = slot_name

	self:_unaim_ranged_weapon()
	self:_wield_weapon(fallback_slot)

	local blackboard = internal.handgonne_reload_blackboard
	local timer = t + inventory:ranged_weapon_reload_time(slot_name)

	return timer, blackboard
end

function PlayerMovementStateBase:_start_reloading_weapon(dt, t, slot_name)
	local inventory = self._internal:inventory()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local reload_time, reload_blackboard = self._ranged_weapon_reload_functions[weapon_ext:category()](self, dt, t, slot_name)

	reload_time = reload_time * gear:attachment_multiplier("reload_speed")

	weapon_ext:start_reload(reload_time, reload_blackboard)
end

function PlayerMovementStateBase:_finish_reloading_weapon(reloading_successful)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local anim_name = weapon_ext:finish_reload(reloading_successful, slot_name)

	if anim_name then
		self:anim_event(anim_name)
	end

	local player = internal.player

	Managers.state.event:trigger("event_crossbow_minigame_deactivated", player)

	internal.reloading = false

	if internal.aiming and self:can_aim_ranged_weapon() then
		self:_aim_ranged_weapon(internal.aim_slot_name, Managers.time:time("game"))
	end
end

function PlayerMovementStateBase:anim_cb_ready_arrow()
	local internal = self._internal

	if not internal.reload_slot_name then
		return
	end

	local inventory = internal:inventory()
	local gear = inventory:_gear(internal.reload_slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	weapon_ext:ready_projectile(internal.reload_slot_name)
end

function PlayerMovementStateBase:anim_cb_bow_ready()
	local internal = self._internal
	local inventory = internal:inventory()
	local gear = inventory:_gear(internal.reload_slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions and extensions.base

	weapon_ext:set_loaded(true)

	internal.reload_slot_name = nil

	self:anim_event("bow_action_finished")
end

function PlayerMovementStateBase:anim_cb_bow_action_finished()
	self:anim_event("bow_action_finished")
end

function PlayerMovementStateBase:_raise_shield_block(slot_name)
	local internal = self._internal
	local network_manager = Managers.state.network
	local unit = self._unit
	local block_unit = internal:inventory():gear_unit(slot_name)
	local t = Managers.time:time("game")

	internal.block_start_time = t
	internal.block_raised_time = t + PlayerUnitMovementSettings.block.raise_delay
	internal.block_unit = block_unit
	internal.blocking = true
	internal.block_slot_name = slot_name
	internal.block_type = "shield"

	Unit.set_data(self._unit, "camera", "dynamic_pitch_scale", 1)
	Unit.set_data(self._unit, "camera", "dynamic_yaw_scale", 1)

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(unit)
		local block_object_id = network_manager:unit_game_object_id(block_unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_raise_shield_block", user_object_id, NetworkLookup.inventory_slots[slot_name])
		else
			network_manager:send_rpc_server("rpc_raise_shield_block", user_object_id, NetworkLookup.inventory_slots[slot_name])
		end
	end

	self:anim_event("shield_up", true)
end

function PlayerMovementStateBase:_raise_parry_block(slot_name, block_type, direction)
	self:safe_action_interrupt("parry")

	local internal = self._internal
	local inventory = internal:inventory()
	local network_manager = Managers.state.network
	local unit = self._unit
	local block_unit = inventory:gear_unit(slot_name)
	local t = Managers.time:time("game")
	local delay_time = PlayerUnitMovementSettings.parry.raise_delay

	internal.block_start_time = t
	internal.block_raised_time = t + delay_time
	internal.block_unit = block_unit
	internal.block_direction = direction
	internal.parrying = true
	internal.block_slot_name = slot_name
	internal.block_type = block_type

	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	weapon_ext:parry(direction, internal.block_raised_time, delay_time)
	Unit.set_data(self._unit, "camera", "dynamic_pitch_scale", 1)
	Unit.set_data(self._unit, "camera", "dynamic_yaw_scale", 1)

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(unit)
		local block_object_id = network_manager:unit_game_object_id(block_unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_raise_parry_block", user_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.directions[direction], delay_time)
		else
			network_manager:send_rpc_server("rpc_raise_parry_block", user_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.directions[direction], delay_time)
		end
	end

	local parry_dir = "parry_pose_" .. direction

	self:anim_event(parry_dir, true)
end

function PlayerMovementStateBase:_lower_block()
	local internal = self._internal

	if internal.block_type == "shield" then
		self:_lower_shield_block(internal.block_slot_name)
	elseif internal.block_type == "buckler" or internal.block_type == "weapon" then
		self:_lower_parry_block(internal.block_slot_name)
	end

	internal.block_or_parry = false
	internal.block_slot_name = nil
	internal.block_type = nil
end

function PlayerMovementStateBase:_lower_shield_block()
	local internal = self._internal
	local network_manager = Managers.state.network
	local unit = self._unit

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_lower_shield_block", user_object_id)
		else
			network_manager:send_rpc_server("rpc_lower_shield_block", user_object_id)
		end
	end

	self:anim_event("shield_down", true)

	internal.blocking = false
	internal.block_unit = nil
end

function PlayerMovementStateBase:_lower_parry_block(slot_name)
	local internal = self._internal
	local inventory = internal:inventory()
	local network_manager = Managers.state.network
	local unit = self._unit
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base

	weapon_ext:stop_parry()

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_lower_parry_block", user_object_id)
		else
			network_manager:send_rpc_server("rpc_lower_parry_block", user_object_id)
		end
	end

	self:anim_event("parry_pose_exit", true)

	internal.parrying = false
	internal.block_unit = nil
	internal.block_direction = nil
end

function PlayerMovementStateBase:_convert_swing_to_parry_direction()
	local direction = self._internal.swing_direction

	if direction == "left" then
		direction = "right"
	elseif direction == "right" then
		direction = "left"
	end

	return direction
end

function PlayerMovementStateBase:safe_action_interrupt(interrupting_action)
	local internal = self._internal
	local t = Managers.time:time("game")

	if (internal.blocking or internal.parrying) and interrupting_action ~= "block" and interrupting_action ~= "parry" and interrupting_action ~= "rush" then
		self:_lower_block()
	end

	if internal.interacting then
		self:change_state("onground")
	end

	if internal.double_time_timer and interrupting_action ~= "rush" and interrupting_action ~= "state_inair" and interrupting_action ~= "state_onground" and interrupting_action ~= "state_jumping" and interrupting_action ~= "pose" and interrupting_action ~= "attempting_pose" and interrupting_action ~= "reload" and interrupting_action ~= "wield" and interrupting_action ~= "officer_buff_activation" then
		internal.double_time_timer = t + PlayerUnitMovementSettings.double_time.timer_time
	end

	if internal.attempting_parry and interrupting_action ~= "parry_attempt" and interrupting_action ~= "crouch" and interrupting_action ~= "parry" then
		self:_abort_parry_attempt()
	end

	if (internal.posing or internal.attempting_pose) and interrupting_action ~= "pose" and interrupting_action ~= "attempting_pose" and interrupting_action ~= "crouch" and interrupting_action ~= "rush" then
		self:_abort_pose()
	end

	if internal.swinging and interrupting_action ~= "rush" and interrupting_action ~= "parry" then
		self:_abort_swing()
	end

	if internal.swinging_shield_bash then
		self:_abort_shield_bash_swing()
	end

	if internal.posing_shield_bash then
		self:_abort_shield_bash_pose()
	end

	if internal.swinging_push then
		self:_abort_push_swing()
	end

	if internal.calling_horse then
		self:_abort_calling_horse()
	end

	if internal.wielding and interrupting_action ~= "wield" and interrupting_action ~= "block" then
		self:_abort_wield()
	end

	if internal.reloading and interrupting_action ~= "reload" then
		self:_abort_reload()
	end

	if internal.aiming and interrupting_action ~= "aim" then
		self:_unaim_ranged_weapon()
	end

	if internal.couching then
		self:_end_couch(t)
	end

	if internal.swing_recovery_time and interrupting_action ~= "rush" then
		self:_end_swing_recovery()
	end

	if internal.crouching and interrupting_action ~= "crouch" and interrupting_action ~= "parry_attempt" then
		self:_abort_crouch()
	end

	if internal.carried_flag and (interrupting_action == "knocked_down" or interrupting_action == "dead") then
		self:_drop_flag()
	end

	if internal.charging_officer_buff and interrupting_action ~= "activate_buff" then
		self:_abort_officer_buff_activation("charging")
	end

	if internal.activating_officer_buff and interrupting_action ~= "activate_buff" then
		self:_abort_officer_buff_activation("activating")
	end

	if internal.tagging and interrupting_action == "state_jumping" or interrupting_action == "knocked_down" then
		self:_abort_tagging()
	end
end

function PlayerMovementStateBase:_end_swing_recovery()
	self._internal.swing_recovery_time = nil

	self:anim_event("swing_attack_penalty_finished")
end

function PlayerMovementStateBase:_abort_pose()
	local internal = self._internal

	if internal.accumulated_pose then
		internal.accumulated_pose:store(Vector3(0, 0, 0))
	end

	if internal.posing or internal.attempting_pose then
		self:anim_event("swing_pose_exit")
	end

	self:_end_pose()
	self:_play_voice("stop_chr_vce_charge_swing")
	Unit.flow_event(self._unit, "lua_exit_weapon_pose")
end

function PlayerMovementStateBase:_end_pose()
	local internal = self._internal
	local network_manager = Managers.state.network

	if internal.pose_direction then
		local inventory = internal:inventory()
		local gear = inventory:_gear(inventory:wielded_melee_weapon_slot())
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		weapon_ext:stop_pose()
	end

	internal.pose_ready = false
	internal.pose_slot_name = nil
	internal.pose_direction = nil
	internal.attempting_pose = false
	internal.posing = false

	if network_manager:game() then
		local user_object_id = network_manager:unit_game_object_id(self._unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_stop_posing_melee_weapon", user_object_id)
		else
			network_manager:send_rpc_server("rpc_stop_posing_melee_weapon", user_object_id)
		end
	end
end

function PlayerMovementStateBase:_abort_parry_attempt()
	local internal = self._internal

	if internal.accumulated_parry_direction then
		internal.accumulated_parry_direction:store(Vector3(0, 0, 0))
	end

	internal.attempting_parry = false
end

function PlayerMovementStateBase:_abort_swing(reason)
	self:anim_event("swing_attack_interrupt")

	if reason ~= "hard" then
		self:_play_voice("stop_chr_vce_charge_swing")
	end

	self:swing_finished(reason)
end

function PlayerMovementStateBase:_abort_shield_bash_swing(reason)
	self:shield_bash_swing_finished(reason)
end

function PlayerMovementStateBase:_abort_shield_bash_pose()
	return
end

function PlayerMovementStateBase:_abort_push_swing(reason)
	self:push_swing_finished(reason)
end

function PlayerMovementStateBase:_abort_calling_horse()
	self:finish_calling_horse("interupted")
end

function PlayerMovementStateBase:_abort_reload()
	self:_finish_reloading_weapon(false)
end

function PlayerMovementStateBase:_abort_crouch()
	self:anim_event("to_uncrouch")

	self._internal.crouching = false
end

function PlayerMovementStateBase:_abort_officer_buff_activation(progress)
	local internal = self._internal

	if progress == "charging" then
		internal.charging_officer_buff = false
		internal.officer_buff_charge_time = 0
		internal.activating_officer_buff_index = nil
	elseif progress == "activating" or progress == "finished" then
		internal.activating_officer_buff = false
		internal.officer_buff_activation_time = 0
	end

	self:anim_event("banner_bonus_finished")
end

function PlayerMovementStateBase:wielded_weapon_destroyed(slot_name)
	self:safe_action_interrupt("wielded_weapon_destroyed")

	local inventory = self._internal:inventory()

	if slot_name == "shield" then
		self:anim_event("to_unshield")
	else
		local fallback_slot = inventory:fallback_slot()

		if self:can_wield_weapon(fallback_slot, Managers.time:time("game")) then
			self:_wield_weapon(fallback_slot)
		else
			self:_set_slot_wielded_instant(fallback_slot, true)
		end
	end
end

function PlayerMovementStateBase:_abort_wield()
	local internal = self._internal

	internal.wielding = false

	local primary_wield_slot = internal.wield_slot_name
	local secondary_wield_slot = internal.secondary_wield_slot_name

	internal.secondary_wield_slot_name = nil
	internal.wield_slot_name = nil

	local inventory = internal:inventory()

	if primary_wield_slot and not inventory:is_wielded(primary_wield_slot) then
		self:_set_slot_wielded_instant(primary_wield_slot, true)

		local wield_reload_anim = inventory:wield_reload_anim(primary_wield_slot)

		if wield_reload_anim and inventory:can_reload(primary_wield_slot) then
			internal.reload_slot_name = primary_wield_slot

			self:anim_cb_ready_arrow()
		end
	elseif primary_wield_slot then
		local wield_reload_anim = inventory:wield_reload_anim(primary_wield_slot)

		if wield_reload_anim and inventory:can_reload(primary_wield_slot) then
			internal.reload_slot_name = primary_wield_slot

			self:anim_cb_ready_arrow()
		end
	end

	if secondary_wield_slot and not inventory:is_wielded(secondary_wield_slot) then
		self:_set_slot_wielded_instant(secondary_wield_slot, true)
	end

	internal.wielding = false
	internal.wield_slot_name = nil
	internal.secondary_wield_slot_name = nil

	self:anim_event("wield_finished")
end

function PlayerMovementStateBase:_abort_tagging()
	local internal = self._internal

	internal.unit_being_tagged = nil
	internal.time_to_tag = 0
	internal.tagging = false

	Managers.state.event:trigger("stopped_tagging", internal.player)
end

function PlayerMovementStateBase:_drop_flag()
	local internal = self._internal
	local flag_unit = internal.carried_flag
	local flag_ext = ScriptUnit.extension(flag_unit, "flag_system")

	flag_ext:drop()

	internal.carried_flag = nil

	if internal.id and internal.game then
		local network_manager = Managers.state.network
		local flag_id = network_manager:game_object_id(flag_unit)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_drop_flag", internal.id, flag_id)
		else
			network_manager:send_rpc_server("rpc_drop_flag", internal.id, flag_id)
		end
	end
end

function PlayerMovementStateBase:update_wounded_camera_effect(dt, t)
	local unit = self._unit
	local internal = self._internal
	local damage_ext = ScriptUnit.extension(unit, "damage_system")

	if damage_ext:is_wounded() and not damage_ext.wounded_camera_effect_active then
		local world = internal.world
		local camera_manager = Managers.state.camera

		damage_ext.wounded_camera_particle_effect_id = World.create_particles(world, "fx/screenspace_damage_indicator", Vector3(0, 0, 0))

		camera_manager:camera_effect_sequence_event("wounded", t)

		damage_ext.wounded_camera_shake_effect_id = camera_manager:camera_effect_shake_event("wounded", t)
		damage_ext.wounded_camera_effect_active = true
	elseif not damage_ext:is_wounded() and damage_ext.wounded_camera_effect_active then
		local camera_manager = Managers.state.camera
		local world = internal.world

		World.destroy_particles(world, damage_ext.wounded_camera_particle_effect_id)

		damage_ext.wounded_camera_particle_effect_id = nil

		camera_manager:stop_camera_effect_shake_event(damage_ext.wounded_camera_shake_effect_id)

		damage_ext.wounded_camera_shake_effect_id = nil
		damage_ext.wounded_camera_effect_active = false
	end
end

function PlayerMovementStateBase:update_switch_weapon_grip(dt, t)
	local controller = self._controller
	local inventory = self._internal:inventory()
	local switch_grip_input = controller and controller:get("switch_weapon_grip")

	if switch_grip_input and inventory:can_switch_weapon_grip() and self:_can_switch_weapon_grip(t) then
		if inventory:weapon_grip_switched() then
			self:anim_event("weapon_unflip")
			inventory:set_grip_switched(false)
		else
			self:anim_event("weapon_flip")
			inventory:set_grip_switched(true)
		end
	end
end

function PlayerMovementStateBase:update_call_horse_decals(dt, t)
	local internal = self._internal

	if internal.display_call_horse_overlap_fail == true and t >= internal.call_horse_overlap_fail_timer then
		World.destroy_unit(internal.world, internal.call_horse_top_projector)

		internal.display_call_horse_overlap_fail = false
		internal.call_horse_top_projector = nil
	end
end

function PlayerMovementStateBase:update_parry_helper(dt, t)
	local physics_world = World.physics_world(self._internal.world)
	local callback = callback(self, "cb_near_human")
	local mover = Unit.mover(self._unit)
	local position = Mover.position(mover)

	PhysicsWorld.overlap(physics_world, callback, "position", position, "size", HUDSettings.parry_helper.scan_radius, "types", "dynamics", "collision_filter", "ai_husk_scan")
end

function PlayerMovementStateBase:cb_near_human(actors)
	local target_enemy = self:_calculate_closest_enemy(actors)
	local target_locomotion = target_enemy and ScriptUnit.extension(target_enemy, "locomotion_system")
	local internal = self._internal
	local parry_helper_blackboard = internal.parry_helper_blackboard

	if target_locomotion and internal.player.team ~= target_locomotion.player.team then
		local pose_direction = target_locomotion.pose_direction

		if pose_direction and self:_looking_at_eachother(target_enemy, target_locomotion) then
			local rot_angle = 0

			if pose_direction == "down" then
				rot_angle = math.pi
			elseif pose_direction == "left" then
				rot_angle = math.pi / 2
			elseif pose_direction == "right" then
				rot_angle = math.pi * 1.5
			end

			parry_helper_blackboard.attack_direction = rot_angle
		else
			parry_helper_blackboard.attack_direction = nil
		end
	else
		parry_helper_blackboard.attack_direction = nil
	end
end

function PlayerMovementStateBase:_calculate_closest_enemy(actors)
	local units = {}
	local own_pos = Unit.world_position(self._unit, 0)
	local nearest_player, nearest_distance = nil, math.huge

	for _, actor in ipairs(actors) do
		local unit = Actor.unit(actor)
		local damage = ScriptUnit.has_extension(unit, "damage_system")

		if damage then
			local target_pos = Unit.world_position(unit, 0)
			local distance = Vector3.distance(own_pos, target_pos)

			if distance < nearest_distance then
				nearest_player = unit
				nearest_distance = distance
			end
		end
	end

	return nearest_player
end

function PlayerMovementStateBase:_looking_at_eachother(target_unit, target_locomotion)
	local locomotion = self._internal
	local aim_dir = locomotion:aim_direction() or Vector3.zero()
	local target_aim_dir = target_locomotion:aim_direction()
	local aim_dir_flat = Vector3.normalize(Vector3.flat(aim_dir))
	local target_aim_dir_flat = Vector3.normalize(Vector3.flat(target_aim_dir))
	local dot = Vector3.dot(aim_dir_flat, target_aim_dir_flat)
	local mover = Unit.mover(self._unit)
	local position = Mover.position(mover)
	local target_position = Unit.world_position(target_unit, 0)
	local difference_vector_flat = Vector3.normalize(Vector3.flat(position - target_position))
	local dot_two = Vector3.dot(aim_dir_flat, difference_vector_flat)

	return dot < 1 - HUDSettings.parry_helper.activation_angle / 360 * 2 and dot_two <= 0
end

function PlayerMovementStateBase:_update_ranged_weapon_zoom(dt, t)
	local internal = self._internal

	if self._internal:has_perk("eagle_eyed") then
		local controller = self._controller
		local zoom_input = controller and controller:get("ranged_weapon_zoom")
		local current_value = internal.ranged_weapon_zoom_value

		if zoom_input then
			if current_value == 0 then
				internal.ranged_weapon_zoom_value = 1
			elseif current_value == 1 then
				internal.ranged_weapon_zoom_value = 0.5
			elseif current_value == 0.5 then
				internal.ranged_weapon_zoom_value = 0
			end
		end
	end

	local viewport_name = internal.player.viewport_name
	local camera_manager = Managers.state.camera

	camera_manager:set_variable(viewport_name, "aim_zoom", internal.ranged_weapon_zoom_value)
end

function PlayerMovementStateBase:_update_breathing_state(dt, t, slot_name)
	local controller = self._controller
	local hold_breath_input = controller and controller:get("hold_breath") > BUTTON_THRESHOLD
	local internal = self._internal
	local inventory = internal:inventory()
	local current_breathing_state = internal.current_breathing_state
	local next_breathing_state = current_breathing_state
	local gear = inventory:_gear(slot_name)
	local settings = gear:settings()
	local timpani_world = World.timpani_world(self._internal.world)

	if t >= internal.breathing_transition_time then
		if current_breathing_state == "normal" and hold_breath_input then
			next_breathing_state = "held"
			internal.hold_breath_timer = t + settings.length_of_breath_hold

			self:_play_voice("chr_vce_aim_enter")
		elseif current_breathing_state == "held" and not hold_breath_input then
			next_breathing_state = "normal"

			self:_play_voice("chr_vce_aim_exit_new")
		elseif current_breathing_state == "held" and t >= internal.hold_breath_timer then
			next_breathing_state = "fast"

			self:_play_voice("chr_vce_aim_choke_new")
		elseif current_breathing_state == "fast" then
			next_breathing_state = "normal"
		end
	end

	self:_update_sway_camera(dt, t, settings, current_breathing_state, next_breathing_state)
end

function PlayerMovementStateBase:_update_sway_camera(dt, t, settings, current_breathing_state, next_breathing_state)
	local internal = self._internal

	if current_breathing_state ~= next_breathing_state then
		local transition_time = settings.sway["breath_" .. current_breathing_state].transition_time_to["breath_" .. next_breathing_state]

		internal.breathing_transition_time = t + transition_time
		internal.breathing_transition_increments = self:_calculate_transition_increments(t, settings, current_breathing_state, next_breathing_state, transition_time)
		internal.breathing_transition = true
		internal.current_breathing_state = next_breathing_state
	end

	if internal.breathing_transition and t >= internal.breathing_transition_time then
		internal.breathing_transition = false
		internal.current_sway_settings = table.clone(settings.sway["breath_" .. next_breathing_state])
	elseif internal.breathing_transition then
		self:_update_breathing_transition(dt)
	end

	local current_sway_settings = internal.current_sway_settings
	local sway_camera_settings = internal.sway_camera
	local current_pitch_angle = sway_camera_settings.pitch_angle
	local current_yaw_angle = sway_camera_settings.yaw_angle
	local pitch_speed = self:_calculate_pitch_speed(current_pitch_angle)

	sway_camera_settings.pitch_angle = self:_increment_angle(dt, current_pitch_angle, pitch_speed, current_sway_settings.time.vertical)
	sway_camera_settings.yaw_angle = self:_increment_angle(dt, current_yaw_angle, 360, current_sway_settings.time.horizontal)

	local pitch_angle = sway_camera_settings.pitch_angle
	local yaw_angle = sway_camera_settings.yaw_angle

	self:_update_breathing_sounds(pitch_angle, internal.current_breathing_state)

	local offset_pitch = current_sway_settings.distance.vertical * (math.sin(pitch_angle) / 180) * math.pi
	local offset_yaw = current_sway_settings.distance.horizontal * (math.sin(yaw_angle) / 180) * math.pi
	local offset_pitch_rot = Quaternion(Vector3.right(), offset_pitch)
	local offset_yaw_rot = Quaternion(Vector3.up(), offset_yaw)
	local final_rot = QuaternionBox()

	final_rot:store(Quaternion.multiply(offset_yaw_rot, offset_pitch_rot))
	Managers.state.camera:set_variable(internal.player.viewport_name, "final_rotation", final_rot)
end

function PlayerMovementStateBase:_calculate_transition_increments(t, settings, current_breathing_state, next_breathing_state, transition_time)
	local transition_increments = {}
	local current_sway_settings = settings.sway["breath_" .. current_breathing_state]
	local next_sway_settings = settings.sway["breath_" .. next_breathing_state]

	for modifier, modifier_table in pairs(current_sway_settings) do
		if modifier == "time" or modifier == "distance" then
			transition_increments[modifier] = {}

			for direction, current_value in pairs(modifier_table) do
				local new_value = next_sway_settings[modifier][direction]
				local difference = new_value - current_value

				transition_increments[modifier][direction] = difference / transition_time
			end
		end
	end

	return transition_increments
end

function PlayerMovementStateBase:_update_breathing_transition(dt)
	local internal = self._internal

	for modifier, modifier_table in pairs(internal.breathing_transition_increments) do
		for direction, value in pairs(modifier_table) do
			internal.current_sway_settings[modifier][direction] = internal.current_sway_settings[modifier][direction] + value * dt
		end
	end
end

function PlayerMovementStateBase:_increment_angle(dt, angle, increment_value, sway_time)
	local value = increment_value * (1 / sway_time)

	if angle >= math.pi * 2 then
		return value / 180 * math.pi * dt
	else
		return angle + value / 180 * math.pi * dt
	end
end

function PlayerMovementStateBase:_calculate_pitch_speed()
	local internal = self._internal
	local pitch_angle = internal.sway_camera.pitch_angle
	local pitch_speed = 0

	pitch_speed = pitch_angle > math.pi / 2 and pitch_angle < math.pi * 3 / 2 and 720 or pitch_angle > math.pi / 2 - math.pi / 4 and pitch_angle < math.pi / 2 and 450 or 360

	return pitch_speed
end

function PlayerMovementStateBase:anim_cb_knockdown_finished()
	return
end

function PlayerMovementStateBase:_update_breathing_sounds(angle, state)
	local internal = self._internal
	local value = math.pi / 2
	local timpani_world = World.timpani_world(internal.world)
	local sway_camera_settings = internal.sway_camera
	local previous_angle = sway_camera_settings.previous_angle

	if state == "normal" and not internal.breathing_transition then
		if value <= angle and previous_angle < value then
			local event_id = TimpaniWorld.trigger_event(timpani_world, "chr_vce_breathe_down")
		elseif angle >= math.pi + value and previous_angle < math.pi + value then
			local event_id = TimpaniWorld.trigger_event(timpani_world, "chr_vce_breathe_up")
		end
	end

	sway_camera_settings.previous_angle = angle
end
