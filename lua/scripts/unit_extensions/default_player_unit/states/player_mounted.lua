-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_mounted.lua

require("scripts/unit_extensions/human/base/states/human_mounted")

PlayerMounted = class(PlayerMounted, HumanMounted)

local UP_JUMP_VERTICAL_SPEED = 5.5
local FWD_JUMP_VERTICAL_SPEED = 5.5
local FWD_JUMP_MINIMUM_HORIZONTAL_SPEED = 3
local BUTTON_THRESHOLD = 0.5

function PlayerMounted:init(...)
	PlayerMounted.super.init(self, ...)

	self._fall_height = nil
	self._forceful_dismount_anim_finished = true
	self._mount_dead_fall_velocity = Vector3Box()
end

function PlayerMounted:update(dt, t)
	PlayerMounted.super.update(self, dt, t)
	self:update_aim_rotation(dt, t)
	self:_update_fall_height(dt, t)

	if not self._stunned then
		self:_update_velocity(dt, t)
		self:_update_officer_buff_activation(dt, t)
		self:_update_tagging(dt, t)
		self:_update_crouch(dt, t)
		self:_update_weapons(dt, t)
	end

	if self._mount_dead then
		self:_update_movement_mount_dead(dt, t)
	elseif self._internal.dismounting then
		self:_update_movement(dt, t)
	else
		self:_update_mover_position(dt, t)
	end

	self:_update_lean_swing_variable(dt, t)
	self:_update_transition(dt, t)

	self._transition = nil
end

function PlayerMounted:_update_fall_height(dt, t)
	local internal = self._internal
	local mount_unit = internal.mounted_unit

	if Unit.alive(mount_unit) then
		local ext = ScriptUnit.extension(mount_unit, "locomotion_system")

		self._fall_height = ext:fall_height()
	end
end

function PlayerMounted:stun(hit_zone, impact_direction, impact_type, speed)
	if self._stunned then
		return
	end

	local internal = self._internal

	if internal.dismounting then
		return
	end

	local mount_unit = internal.mounted_unit

	if self._fall_height then
		local pos = Unit.alive(mount_unit) and Unit.local_position(mount_unit, 0) or Unit.world_position(self._unit, 0)
		local fall_distance = PlayerMechanicsHelper.calculate_fall_distance(internal, self._fall_height, pos)

		if fall_distance > PlayerUnitMovementSettings.fall.heights.dead then
			PlayerMechanicsHelper.suicide(internal)

			return
		elseif PlayerMechanicsHelper._pick_landing(internal, fall_distance) == "knocked_down" then
			self:change_state("inair", self._fall_height)

			return
		end
	end

	if impact_type == "mount_dead" then
		local unit = self._unit
		local player_manager = Managers.player

		World.unlink_unit(internal.world, unit)

		self._mount_dead = true
		self._dismount_velocity = Vector3Box(ScriptUnit.extension(mount_unit, "locomotion_system"):get_velocity())

		if internal.game and internal.id then
			GameSession.set_game_object_field(internal.game, internal.id, "movement_state", NetworkLookup.movement_states["mounted/mount_dead"])
		end

		self:_unmount_husk(mount_unit, internal)
	elseif internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "movement_state", NetworkLookup.movement_states["mounted/dismounting"])
	end

	self._stunned = true
	internal.movement_state = "mounted/dismounting"

	self:_enter_dismount(Managers.time:time("game"))

	if not Unit.alive(mount_unit) then
		self:anim_event("mounted_stun_backward")

		return
	end

	local mount_rot = Unit.local_rotation(mount_unit, 0)
	local forward = Quaternion.forward(mount_rot)
	local right = Quaternion.right(mount_rot)
	local flat_fwd = Vector3.normalize(Vector3.flat(forward))
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))
	local right_dot = Vector3.dot(right, flat_impact_dir)
	local forward_dot = Vector3.dot(flat_fwd, flat_impact_dir)
	local anim_event

	anim_event = impact_type == "mount_dead" and (speed > 2 and "mounted_stun_forward" or speed < -2 and "mounted_stun_backward" or right_dot < 0 and "mounted_stun_right" or "mounted_stun_left") or math.abs(right_dot) > math.abs(forward_dot) and (right_dot < 0 and "mounted_stun_right" or "mounted_stun_left") or forward_dot > 0 and "mounted_stun_forward" or "mounted_stun_backward"

	self:anim_event(anim_event)
end

function PlayerMounted:_update_stamina(dt, t)
	local internal = self._internal
	local mount = internal.mounted_unit

	if Unit.alive(mount) and ScriptUnit.has_extension(mount, "locomotion_system") then
		local mount_locomotion = ScriptUnit.extension(mount, "locomotion_system")
		local stamina = mount_locomotion.charge_stamina
		local max_stamina = mount_locomotion._mount_profile.max_charge_stamina
		local bb = internal.mount_hud_blackboard

		bb.shader_value = stamina / max_stamina
		bb.cooldown_shader_value = 1 - stamina / max_stamina
		bb.mount_locomotion = mount_locomotion
	end
end

function PlayerMounted:_aim_ranged_weapon(...)
	PlayerMounted.super._aim_ranged_weapon(self, ...)

	local internal = self._internal
	local unit = self._unit
	local mount = internal.mounted_unit
	local mount_node = Unit.node(mount, "camera_attach")

	World.link_unit(internal.world, unit, mount, mount_node)
	Unit.set_local_position(unit, 0, Vector3(0, 0, -0.38))
end

function PlayerMounted:_unaim_ranged_weapon(...)
	PlayerMounted.super._unaim_ranged_weapon(self, ...)

	local internal = self._internal
	local unit = self._unit
	local mount = internal.mounted_unit
	local mount_node = Unit.node(mount, "CharacterAttach")

	World.link_unit(internal.world, unit, mount, mount_node)
end

local DEGREES_TO_RADIANS = math.pi / 180
local HEIGHT_TOP = PlayerUnitMovementSettings.swing.mounted_lean_swing_top * DEGREES_TO_RADIANS
local HEIGHT_RANGE = PlayerUnitMovementSettings.swing.mounted_lean_swing_range * DEGREES_TO_RADIANS
local LOOK_ANGLE_DEAD_ZONE = math.pi * 0.25
local LOOK_ANGLE_DEAD_ZONE_START = 0
local LEAN_BLEND_SPEED = 1
local HIGH_SWING_LEAN = 0.5
local LERP_SPEED = 1

function PlayerMounted:_calculate_new_lean_state(dt, t, look_angle, direction)
	if direction == "left" and look_angle < LOOK_ANGLE_DEAD_ZONE_START then
		return "left"
	elseif direction == "left" and look_angle < LOOK_ANGLE_DEAD_ZONE then
		return "left_border"
	elseif direction == "right" and look_angle > -LOOK_ANGLE_DEAD_ZONE_START then
		return "right"
	elseif direction == "right" and look_angle > -LOOK_ANGLE_DEAD_ZONE then
		return "right_border"
	else
		return "middle"
	end
end

function PlayerMounted:_set_game_object_lean_values(lean_value, swing_height)
	local internal = self._internal

	GameSession.set_game_object_field(internal.game, internal.id, "pose_lean_anim_blend_value", Vector3(lean_value, swing_height, 0))
end

function PlayerMounted:update_left(dt, t, unit, look_angle)
	local swing_height = self:_swing_height()

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean_swing_height"), swing_height)

	local lean_value = swing_height * HIGH_SWING_LEAN - 1

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean"), lean_value)

	local aim_target_lerp = math.max(self._aim_target_lerp - LERP_SPEED * dt, 0)
	local internal = self._internal

	if internal.game and internal.id then
		self:_set_game_object_lean_values(lean_value, swing_height)
	end

	return 0, aim_target_lerp
end

function PlayerMounted:update_left_border(dt, t, unit, look_angle)
	local look_t = math.smoothstep(look_angle, LOOK_ANGLE_DEAD_ZONE_START, LOOK_ANGLE_DEAD_ZONE)
	local swing_height = math.lerp(self:_swing_height(), 1, look_t)

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean_swing_height"), swing_height)

	local lean_value = math.lerp(swing_height * HIGH_SWING_LEAN - 1, 0, look_t)

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean"), lean_value)

	local internal = self._internal

	if internal.game and internal.id then
		self:_set_game_object_lean_values(lean_value, swing_height)
	end

	return LOOK_ANGLE_DEAD_ZONE * look_t, look_t
end

function PlayerMounted:update_right(dt, t, unit)
	local swing_height = self:_swing_height()

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean_swing_height"), swing_height)

	local lean_value = 1 - swing_height * HIGH_SWING_LEAN

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean"), lean_value)

	local aim_target_lerp = math.max(self._aim_target_lerp - LERP_SPEED * dt, 0)
	local internal = self._internal

	if internal.game and internal.id then
		self:_set_game_object_lean_values(lean_value, swing_height)
	end

	return 0, aim_target_lerp
end

function PlayerMounted:update_right_border(dt, t, unit, look_angle)
	local look_t = math.smoothstep(look_angle, -LOOK_ANGLE_DEAD_ZONE_START, -LOOK_ANGLE_DEAD_ZONE)
	local swing_height = math.lerp(self:_swing_height(), 1, look_t)

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean_swing_height"), swing_height)

	local lean_value = math.lerp(1 - swing_height * HIGH_SWING_LEAN, 0, look_t)

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean"), lean_value)

	local internal = self._internal

	if internal.game and internal.id then
		self:_set_game_object_lean_values(lean_value, swing_height)
	end

	return -LOOK_ANGLE_DEAD_ZONE * look_t, look_t
end

function PlayerMounted:update_middle(dt, t, unit, look_angle)
	local var = Unit.animation_get_variable(unit, Unit.animation_find_variable(unit, "horse_lean"))

	if var > 0 then
		var = math.max(var - LERP_SPEED * dt, 0)
	else
		var = math.min(var + LERP_SPEED * dt, 0)
	end

	Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "horse_lean"), var)

	local aim_target_lerp = math.min(self._aim_target_lerp + LERP_SPEED * dt, 1)
	local internal = self._internal

	if internal.game and internal.id then
		self:_set_game_object_lean_values(var, Unit.animation_get_variable(unit, Unit.animation_find_variable(unit, "horse_lean_swing_height")))
	end

	return look_angle, aim_target_lerp
end

function PlayerMounted:enter_left(old_state)
	self:anim_event("lean")
end

function PlayerMounted:enter_left_border(old_state)
	self:anim_event("lean")
end

function PlayerMounted:enter_right(old_state)
	self:anim_event("lean")
end

function PlayerMounted:enter_right_border(old_state)
	self:anim_event("lean")
end

function PlayerMounted:enter_middle(old_state)
	self:anim_event("unlean")
end

function PlayerMounted:_swing_height()
	local internal = self._internal
	local aim_dir = Vector3.normalize(Quaternion.forward(Managers.state.camera:aim_rotation(internal.player.viewport_name)))
	local pitch = math.asin(aim_dir.z)
	local t = math.smoothstep(pitch, HEIGHT_TOP - HEIGHT_RANGE, HEIGHT_TOP)

	return t
end

function PlayerMounted:_update_lean_swing_variable(dt, t)
	local internal = self._internal
	local unit = self._unit
	local internal = self._internal
	local look_angle = internal.look_angle
	local anim_var = Unit.animation_find_variable(unit, "horse_lean")
	local height_anim_var = Unit.animation_find_variable(unit, "horse_lean_swing_height")
	local direction = internal.swing_direction or internal.pose_direction

	if PlayerUnitMovementSettings.mounted.use_lean then
		local new_lean_state = self:_calculate_new_lean_state(dt, t, look_angle, direction)

		if new_lean_state ~= self._lean_state then
			self["enter_" .. new_lean_state](self, self._lean_state)

			self._lean_state = new_lean_state
		end
	end

	local new_look_angle, aim_dir_lerp = self["update_" .. self._lean_state](self, dt, t, unit, look_angle)

	internal.look_angle = new_look_angle
	self._aim_target_lerp = aim_dir_lerp
	self._real_look_angle = look_angle
end

function PlayerMounted:enter(old_state)
	PlayerMounted.super.enter(self, old_state)

	self._fall_height = nil
	self._inair = false
	self._stunned = false
	self._mount_dead = false
	self._aim_target_lerp = 1
	self._lean_state = "middle"
	self._transition_parameters = {}

	local internal = self._internal

	internal.posing = false
	internal.swinging = false

	local unit = self._unit
	local mount = internal.mounted_unit
	local mount_node = Unit.node(mount, "CharacterAttach")

	World.link_unit(internal.world, unit, mount, mount_node)
	self:anim_event("mount_horse")

	if internal.game and internal.id then
		local network_manager = Managers.state.network
		local mount_id = network_manager:unit_game_object_id(mount)
		local player_id = internal.player.temp_random_user_id

		network_manager:send_rpc_server("rpc_request_mount", internal.id, mount_id, player_id)
	else
		Managers.player:assign_unit_ownership(mount, Unit.get_data(unit, "owner_player_index"))
		Unit.set_data(mount, "user_unit", unit)
	end

	internal.mounting = true
	self._real_look_angle = internal.look_angle

	Managers.state.event:trigger("local_player_mounted", internal.player, ScriptUnit.extension(mount, "locomotion_system"), internal.mount_hud_blackboard)
end

function PlayerMounted:can_crouch(t)
	local internal = self._internal
	local mount_locomotion = ScriptUnit.extension(internal.mounted_unit, "locomotion_system")

	return false and not internal.posing and not internal.swinging and not mount_locomotion.charging and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.attempting_pose and not internal.aiming and not internal.wielding and not internal.reloading and (not internal.swing_recovery_time or t > internal.swing_recovery_time)
end

function PlayerMounted:_update_crouch(dt, t)
	local internal = self._internal

	if self._controller and self._controller:get("crouch") then
		if internal.crouching then
			self:_abort_crouch()
		elseif self:can_crouch(t) then
			self:safe_action_interrupt("crouch")
			self:_crouch()
		end
	elseif internal.crouching then
		local mount_locomotion = ScriptUnit.extension(internal.mounted_unit, "locomotion_system")

		if mount_locomotion.charging then
			self:_abort_crouch()
		end
	end
end

function PlayerMounted:_crouch()
	self:anim_event("to_crouch")

	self._internal.crouching = true
end

function PlayerMounted:force_unmount(reason)
	if self._fall_height then
		self:change_state("inair", self._fall_height)
	else
		self:change_state("onground")
	end
end

function PlayerMounted:anim_cb_forceful_dismount_anim_finished()
	self._forceful_dismount_anim_finished = true
end

function PlayerMounted:anim_cb_mounting_complete()
	local internal = self._internal

	internal.mounting = false

	if PlayerUnitMovementSettings.mounted.auto_align_camera_on_mount then
		local fwd_vector = Quaternion.forward(Unit.local_rotation(internal.mounted_unit, 0))
		local yaw = -math.atan2(fwd_vector.x, fwd_vector.y)

		Managers.state.camera:set_pitch_yaw(internal.player.viewport_name, 0, yaw)
	end

	self:anim_event("horse_mounted")
end

function PlayerMounted:exit(new_state)
	PlayerMounted.super.exit(self, new_state)

	self._fall_height = nil

	local internal = self._internal
	local inventory = internal:inventory()
	local couch_weapon_slot = inventory:allows_couch()

	if couch_weapon_slot and new_state and new_state ~= "dead" and new_state ~= "none" then
		internal:gear_dead(inventory:gear_unit(couch_weapon_slot))
	end

	Managers.state.event:trigger("local_player_dismounted", internal.player)

	if internal.couching then
		self:_end_couch(Managers.time:time("game"))
	end

	if internal.aiming then
		self:_unaim_ranged_weapon()
	end

	local unit = self._unit
	local player_manager = Managers.player
	local mount = internal.mounted_unit

	if not self._horse_dead then
		World.unlink_unit(internal.world, unit)
	end

	local mover = Unit.mover(unit)

	self:set_local_position(Mover.position(mover))

	if not self._stunned or new_state == "knocked_down" then
		self:anim_event("horse_dismounted")
	end

	self._stunned = false
	internal.dismounting = false

	if not self._horse_dead then
		if Unit.alive(mount) and ScriptUnit.has_extension(mount, "locomotion_system") then
			internal.velocity:store(ScriptUnit.extension(mount, "locomotion_system"):get_velocity())
		end

		self:_unmount_husk(mount, internal)
	end

	if Unit.get_data(mount, "user_unit") == self._unit then
		Unit.set_data(mount, "user_unit", nil)
	end

	internal.mounting = false

	if internal.mount_charging then
		self:end_charge()
	end

	self:safe_action_interrupt("state_" .. new_state)

	internal.mounted_unit = nil

	if new_state == "inair" then
		self:anim_event("to_inair")
	end

	self._forceful_dismount_anim_finished = false

	self._mount_dead_fall_velocity:store(Vector3(0, 0, 0))
end

function PlayerMounted:_unmount_husk(mount, internal)
	local player_manager = Managers.player
	local mount_owner = player_manager:owner(mount)

	if mount_owner and mount_owner.index == Unit.get_data(self._unit, "owner_player_index") then
		if internal.game and internal.id then
			local network_manager = Managers.state.network
			local mount_id = network_manager:unit_game_object_id(internal.mounted_unit)

			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_unmounted_husk", internal.id, mount_id)
			else
				network_manager:send_rpc_server("rpc_unmounted_husk", internal.id, mount_id)
			end
		end

		player_manager:relinquish_unit_ownership(mount)
	end
end

function PlayerMounted:_update_velocity(dt, t)
	local internal = self._internal

	internal.velocity:store(ScriptUnit.extension(internal.mounted_unit, "locomotion_system"):get_velocity())
end

function PlayerMounted:_update_movement_mount_dead(dt, t)
	local unit = self._unit
	local mover = Unit.mover(unit)
	local wanted_pose = Unit.animation_wanted_root_pose(unit)
	local wanted_position = Matrix4x4.translation(wanted_pose)
	local current_position = Unit.local_position(unit, 0)
	local anim_delta

	if self._forceful_dismount_anim_finished then
		self._mount_dead_fall_velocity:store(self._mount_dead_fall_velocity:unbox() + Vector3(0, 0, -9.82) * dt)

		anim_delta = self._mount_dead_fall_velocity:unbox() * dt
	else
		anim_delta = wanted_position - current_position

		self._mount_dead_fall_velocity:store(Vector3.lerp(self._mount_dead_fall_velocity:unbox(), anim_delta / dt, dt * 10))
	end

	local velocity = self._dismount_velocity:unbox()
	local speed = Vector3.length(velocity)
	local drag = speed * speed * 0.00225 * Vector3.normalize(-velocity)
	local new_velocity = velocity + drag * dt

	self._dismount_velocity:store(new_velocity)

	local delta = anim_delta + new_velocity * dt

	Mover.move(mover, delta, dt)

	local new_pos = Mover.position(mover)

	self:set_local_position(new_pos)
	self:_set_rotation(Matrix4x4.rotation(wanted_pose))
end

function PlayerMounted:_update_movement(dt, t)
	local unit = self._unit
	local mover = Unit.mover(unit)
	local wanted_pose = Unit.animation_wanted_root_pose(unit)
	local wanted_position = Matrix4x4.translation(wanted_pose)
	local current_position = Unit.local_position(unit, 0)
	local anim_delta = wanted_position - current_position

	self:set_local_position(current_position + anim_delta)

	local mount = self._internal.mounted_unit
	local mount_node = Unit.node(mount, "CharacterAttach")
	local parent_rotation = Unit.world_rotation(mount, mount_node)
	local transformed_anim_delta = Quaternion.forward(parent_rotation) * anim_delta.y + Quaternion.right(parent_rotation) * anim_delta.x + Quaternion.up(parent_rotation) * anim_delta.z
	local mover_delta = transformed_anim_delta + ScriptUnit.extension(mount, "locomotion_system"):get_velocity() * dt

	Mover.move(mover, mover_delta, dt)

	local new_pos = Mover.position(mover)

	self._dismount_error:store(current_position - new_pos)
end

function PlayerMounted:_update_mover_position(dt, t)
	local internal = self._internal
	local unit = self._unit
	local mover = Unit.mover(unit)
	local world_pos = Unit.world_position(unit, 0)

	Mover.set_position(mover, world_pos)

	if internal.game and internal.id and Vector3.length(world_pos) < 1000 then
		GameSession.set_game_object_field(internal.game, internal.id, "position", world_pos)
	end
end

function PlayerMounted:update_aim_target(dt)
	local internal = self._internal
	local unit = self._unit

	if internal.couching then
		local mounted_unit = internal.mounted_unit
		local aim_from_pos = Unit.world_position(unit, Unit.node(unit, "camera_attach"))
		local aim_target = internal.aim_target:unbox()
		local rel_aim_dir = aim_target - aim_from_pos

		if script_data.aim_constraint_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "constraint debug"
			})

			drawer:sphere(aim_target, 0.05, Color(255, 255, 0))
		end

		Unit.animation_set_constraint_target(unit, self._aim_constraint_anim_var, aim_target)

		if internal.game and internal.id then
			GameSession.set_game_object_field(internal.game, internal.id, "aim_target", aim_target - Unit.world_position(unit, Unit.node(unit, "camera_attach")))
		end
	else
		local camera_manager = Managers.state.camera
		local viewport_name = Unit.get_data(unit, "viewport_name")

		if viewport_name and not self._stunned then
			local aim_from_pos = Unit.world_position(unit, Unit.node(unit, "camera_attach")) - Vector3(0, 0, 1)
			local aim_rotation = camera_manager:aim_rotation(viewport_name)
			local look_angle = internal.look_angle
			local real_aim_target = aim_rotation
			local horse_aim_target = Unit.local_rotation(internal.mounted_unit, 0)

			aim_rotation = Quaternion.lerp(horse_aim_target, real_aim_target, self._aim_target_lerp)

			local rel_aim_dir = Quaternion.forward(aim_rotation) * 3
			local aim_target = aim_from_pos + rel_aim_dir

			internal.aim_target:store(aim_target)

			if script_data.aim_constraint_debug then
				local drawer = Managers.state.debug:drawer({
					name = "constraint debug"
				})

				drawer:reset()
				drawer:sphere(aim_target, 0.05, Color(255, 255, 0))
			end

			Unit.animation_set_constraint_target(unit, self._aim_constraint_anim_var, aim_target)

			if internal.game and internal.id then
				GameSession.set_game_object_field(internal.game, internal.id, "aim_target", aim_target - Unit.world_position(unit, Unit.node(unit, "camera_attach")))
			end
		end
	end
end

function PlayerMounted:aim_direction()
	local internal = self._internal
	local aim_target = internal.aim_target:unbox()
	local mounted_unit = internal.mounted_unit
	local unit = self._unit
	local aim_from_pos = Unit.world_position(unit, Unit.node(unit, "camera_attach"))

	return aim_target - aim_from_pos
end

function PlayerMounted:_update_swing(dt, t)
	local internal = self._internal
	local controller = self._controller
	local can_couch, couch_slot = self:can_couch(t)
	local couch_input = controller and controller:get("couch_lance") > BUTTON_THRESHOLD

	if can_couch and not internal.couching and couch_input then
		self:_begin_couch(t, couch_slot)

		return
	elseif can_couch and couch_input then
		self:_update_couch(dt, t)

		return
	elseif internal.couching then
		self:_end_couch(t)
	end

	PlayerMounted.super._update_swing(self, dt, t)
end

function PlayerMounted:_check_interact(dt, t)
	local interact = self._controller and self._controller:get("interact")
	local internal = self._internal

	if interact and not self._transition then
		local interaction = ScriptUnit.extension(self._unit, "interaction_system")
		local target, interact_type = interaction:get_interaction_target()

		if not target then
			return
		end

		if interact_type == "dismount" and self:can_unmount(t) then
			self:_enter_dismount(t)
			self:_play_dismount_animation(target)
		end
	end
end

function PlayerMounted:_enter_dismount(t)
	local internal = self._internal

	internal.dismounting = true
	self._dismount_timer = t + 0.7
	self._dismount_error = Vector3Box()

	self:safe_action_interrupt("dismounting")
end

function PlayerMounted:_play_dismount_animation(mount)
	local mount_right = Quaternion.right(Unit.local_rotation(mount, 0))
	local left = Vector3.dot(self._aim_vector, mount_right) > 0
	local moving = Vector3.length(self._internal.velocity:unbox()) > 4.5
	local internal = self._internal

	internal.movement_state = "mounted/dismounting"

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "movement_state", NetworkLookup.movement_states["mounted/dismounting"])
	end

	if left and moving then
		self:anim_event("dismount_horse_moving_left")

		self._inair = true
	elseif left then
		self:anim_event("dismount_horse_idle_left")

		self._inair = false
	elseif moving then
		self:anim_event("dismount_horse_moving_right")

		self._inair = true
	else
		self:anim_event("dismount_horse_idle_right")

		self._inair = false
	end
end

function PlayerMounted:anim_cb_dismounting_complete()
	self:_set_transition()
end

function PlayerMounted:_set_transition()
	if self._stunned then
		self._transition = "stunned"
		self._transition_parameters = {
			"legs",
			Vector3(0, 0, 0),
			"mounted_stun_dismount",
			self._fall_height
		}
	elseif self._fall_height then
		self._transition = "inair"
		self._transition_parameters = {
			self._fall_height
		}
	elseif self._inair then
		self._transition = "inair"
	else
		self._transition = "onground"
	end
end

function PlayerMounted:_update_transition(dt, t)
	if self._internal.dismounting and t > self._dismount_timer then
		local unit = self._unit
		local mover = Unit.mover(unit)
		local internal = self._internal
		local pos = Mover.position(mover)

		if Mover.collides_down(mover) then
			self:_set_transition()
		end
	end

	self:_check_interact(dt, t)

	if self._transition then
		self:change_state(self._transition, unpack(self._transition_parameters))

		return true
	end
end

function PlayerMounted:_begin_couch(t, couch_slot)
	self:safe_action_interrupt("couch")

	local internal = self._internal
	local inventory = internal:inventory()

	internal.couching = true

	inventory:start_couch(couch_slot, callback(self, "gear_cb_abort_couch"))

	self._couch_slot = couch_slot

	local gear = inventory:_gear(couch_slot)
	local settings = inventory:gear_couch_settings(couch_slot)
	local multiplier = gear:attachment_multipliers().lance_couch_time
	local couch_time = settings.couch_time * multiplier

	self:anim_event_with_variable_float("lance_couch", "lance_couch_time", couch_time)
end

function PlayerMounted:_update_couch(dt, t)
	local internal = self._internal
	local unit = self._unit
	local couch_slot = self._couch_slot
	local inventory = internal:inventory()
	local settings = inventory:gear_couch_settings(couch_slot)
	local node = Unit.node(unit, settings.user_unit_align_node)
	local gear_unit = inventory:gear_unit(couch_slot)
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(unit, "viewport_name")
	local cam_pos = camera_manager:camera_position(viewport_name)
	local viewport = ScriptWorld.viewport(internal.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local screen_target_point = settings.screen_space_target_point
	local x, z = Application.resolution()
	local camera_x = x * screen_target_point[1]
	local camera_z = z * screen_target_point[2]
	local cam_focus_pos = Camera.screen_to_world(camera, Vector3(camera_x, 20, camera_z))
	local cam_fwd = Vector3.normalize(cam_focus_pos - cam_pos)
	local gear_pos = Unit.world_position(gear_unit, 0)
	local gear_rot = Unit.world_rotation(gear_unit, 0)
	local gear_target_node = Unit.node(gear_unit, settings.screen_space_target_point_unit_node)
	local gear_target_node_pos = Unit.world_position(gear_unit, gear_target_node)
	local lance_length_vect = gear_target_node_pos - gear_pos
	local gear_length = Vector3.dot(lance_length_vect, Quaternion.up(gear_rot))
	local gear_camera_plane_offset = Vector3.dot(gear_pos - cam_pos, cam_fwd)
	local dist_to_camera = Vector3.length(cam_pos + gear_camera_plane_offset * cam_fwd - gear_pos)
	local target_point_camera_depth = math.sqrt(gear_length * gear_length - dist_to_camera * dist_to_camera) + gear_camera_plane_offset
	local pos = Vector3(camera_x, target_point_camera_depth, camera_z)
	local target_point = Camera.screen_to_world(camera, pos)

	internal.aim_target:store(target_point)
end

function PlayerMounted:post_world_update(dt, t)
	local internal = self._internal

	if not internal.couching or not self._couch_ready then
		return
	end

	local unit = self._unit
	local couch_slot = self._couch_slot
	local inventory = internal:inventory()
	local settings = inventory:gear_couch_settings(couch_slot)
	local node = Unit.node(unit, settings.user_unit_align_node)
	local gear_unit = inventory:gear_unit(couch_slot)
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(unit, "viewport_name")
	local cam_pos = camera_manager:camera_position(viewport_name)
	local viewport = ScriptWorld.viewport(internal.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local screen_target_point = settings.screen_space_target_point
	local x, z = Application.resolution()
	local camera_x = x * screen_target_point[1]
	local camera_z = z * screen_target_point[2]
	local cam_focus_pos = Camera.screen_to_world(camera, Vector3(camera_x, 5, camera_z))
	local cam_fwd = Vector3.normalize(cam_focus_pos - cam_pos)
	local gear_pos = Unit.world_position(gear_unit, 0)
	local gear_rot = Unit.world_rotation(gear_unit, 0)
	local gear_target_node = Unit.node(gear_unit, settings.screen_space_target_point_unit_node)
	local gear_target_node_pos = Unit.world_position(gear_unit, gear_target_node)
	local lance_length_vect = gear_target_node_pos - gear_pos
	local gear_length = Vector3.dot(lance_length_vect, Quaternion.up(gear_rot))
	local gear_camera_plane_offset = Vector3.dot(gear_pos - cam_pos, cam_fwd)
	local dist_to_camera = Vector3.length(cam_pos + gear_camera_plane_offset * cam_fwd - gear_pos)
	local target_point_camera_depth = math.sqrt(gear_length * gear_length - dist_to_camera * dist_to_camera) + gear_camera_plane_offset
	local pos = Vector3(camera_x, target_point_camera_depth, camera_z)
	local target_point = Camera.screen_to_world(camera, pos)
	local align_point_dir = target_point - gear_pos
	local align_rot = Quaternion.look(align_point_dir, Vector3.up())
	local align_node_world_rotation = Unit.world_rotation(unit, node)
	local new_rot = Quaternion.multiply(Quaternion.multiply(Quaternion.inverse(align_node_world_rotation), align_rot), Quaternion(Vector3.right(), -math.pi / 2))
	local time_step = math.clamp((t - self._couch_ready_time) * 3, 0, 1)
	local lerped_rot = Quaternion.lerp(Quaternion.identity(), new_rot, time_step)

	Unit.set_local_rotation(gear_unit, 0, lerped_rot)
	World.update_unit(internal.world, gear_unit)
end

function PlayerMounted:anim_cb_enter_couch()
	if self._internal.couching then
		self._couch_ready = true
		self._couch_ready_time = Managers.time:time("game")
	end
end

function PlayerMounted:gear_cb_abort_couch(reason)
	assert(self._internal.couching)
	self:anim_event("hit_reaction_lance_impact")
	self:_end_couch(Managers.time:time("game"))
end

function PlayerMounted:_end_couch(t)
	local internal = self._internal
	local inventory = internal:inventory()

	internal.couching = false

	local couch_slot = self._couch_slot
	local gear_unit = inventory:gear_unit(couch_slot)

	inventory:end_couch(couch_slot)

	local settings = inventory:gear_couch_settings(couch_slot)

	self._couch_slot = nil
	self._couch_ready = false

	self:anim_event_with_variable_float("lance_uncouch", "lance_uncouch_time", settings.uncouch_time)

	internal.couch_cooldown_time = t + settings.uncouch_time

	Unit.set_local_rotation(gear_unit, 0, Quaternion.identity())
end

function PlayerMounted:begin_charge(t)
	self._internal.mount_charging = true

	local camera_manager = Managers.state.camera

	camera_manager:camera_effect_sequence_event("charging", t)

	self._charging_camera_effect_id = camera_manager:camera_effect_shake_event("charging", t)
end

function PlayerMounted:end_charge()
	self._internal.mount_charging = false

	local camera_manager = Managers.state.camera

	if self._charging_camera_effect_id then
		camera_manager:stop_camera_effect_shake_event(self._charging_camera_effect_id)

		self._charging_camera_effect_id = nil
	end
end
