-- chunkname: @scripts/unit_extensions/horse/states/horse_onground.lua

require("scripts/unit_extensions/horse/horse_onground_behaviour")

HorseOnground = class(HorseOnground, HorseMovementStateBase)

local ROTATION_MAX_SPEED = 2
local ROTATION_ACCELERATION = ROTATION_MAX_SPEED * 4
local ANIM_ROTATION_MAX_SPEED = 1
local IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD = 0.01
local ANIM_ROTATION_ACCELERATION = ANIM_ROTATION_MAX_SPEED * 6
local BUTTON_THRESHOLD = 0.5
local EPSILON = 0.001
local DRAWER = {
	mode = "immediate",
	name = "horse_feeler"
}

function HorseOnground:init(unit, locomotion)
	HorseOnground.super.init(self, unit, locomotion)

	self._behaviour = HorseOngroundBehaviour:new(locomotion)
end

function HorseOnground:destroy(...)
	HorseOnground.super.destroy(self, ...)
	self._behaviour:destroy()
end

function HorseOnground:impact_obstacle()
	local internal = self._internal

	internal.speed = internal.speed * (1 - HorseUnitMovementSettings.obstacle_impact.energy_transfer_rate)
end

function HorseOnground:update(unit, internal, controller, dt, context, t)
	HorseOnground.super.update(self, unit, internal, controller, dt, context, t)

	self._controller = controller

	self._behaviour:update(t, dt)
	self:ground_raycast(unit, internal)
	self:update_rotation(dt)
	self:check_charge(dt, t)
	self:_update_stamina(dt, t)
	self:_update_speed_cap(dt, t)

	if internal.charging then
		self:update_charge(dt, t)
	else
		self:update_gait(dt, t)
	end

	self:update_movement(dt)
	self:update_transition(dt, t)

	self._transition = nil

	if script_data.mount_debug then
		Managers.state.debug_text:output_screen_text(string.format("s: %.1f v: %.1f %.1f %.1f", internal.speed, internal.velocity.x, internal.velocity.y, internal.velocity.z), 40, 0, Vector3(255, 255, 255))
	end
end

function HorseOnground:cap_speed(speed)
	self._behaviour_speed_cap = speed
end

function HorseOnground:_update_stamina(dt, t)
	local internal = self._internal
	local mount_profile = internal._mount_profile

	if internal.charging then
		internal.charge_stamina = internal.charge_stamina - dt
	else
		internal.charge_stamina = internal.charge_stamina + dt

		if internal.charge_stamina > mount_profile.max_charge_stamina then
			internal.charge_stamina = mount_profile.max_charge_stamina
			self._fatigue_speed_cap = math.huge
		else
			self._fatigue_speed_cap = HorseUnitMovementSettings.charge.speed_when_out_of_stamina
		end
	end
end

function HorseOnground:_update_speed_cap(dt, t)
	self._speed_cap = math.min(self._behaviour_speed_cap, self._fatigue_speed_cap, self._area_speed_cap)
end

function HorseOnground:ground_raycast(unit, internal)
	local rot = Unit.local_rotation(unit, 0)
	local dir = -Vector3.up()
	local pos = Unit.local_position(unit, 0)
	local from = pos + Vector3.normalize(Vector3.flat(Quaternion.forward(rot))) * 0.4 + Vector3(0, 0, 1.5)
	local cb = callback(self, "ground_raycast_cb", internal, pos.x, pos.y, pos.z)
	local physics_world = World.physics_world(internal.world)
	local raycast = PhysicsWorld.make_raycast(physics_world, cb, "types", "statics", "collision_filter", "horse_landing_overlap")

	if HorseUnitMovementSettings.behaviour.debug then
		Managers.state.debug:drawer(DRAWER):vector(from, dir * 2, Color(255, 0, 0))
	end

	Raycast.cast(raycast, from, dir, 2)
end

function HorseOnground:ground_raycast_cb(internal, pos_x, pos_y, pos_z, any_hit, position, distance, normal, actor)
	if any_hit and internal.current_state_name == "onground" then
		local dir = position - Vector3(pos_x, pos_y, pos_z)
		local dir_norm = Vector3.normalize(dir)

		internal.new_pitch = math.clamp(math.asin(Vector3.dot(dir_norm, Vector3.up())), -math.pi / 4, math.pi / 4)
	else
		internal.pitch = 0
	end
end

function HorseOnground:enter(old_state)
	HorseOnground.super.enter(self, old_state)

	self._behaviour_speed_cap = math.huge
	self._fatigue_speed_cap = math.huge
	self._area_speed_cap = math.huge
	self._speed_cap = math.huge

	if old_state == "landing" then
		self._internal.gait_index = HorseUnitMovementSettings.gait_lookup.canter
	end

	self._gait_direction_pressed = nil
	self._gait_tap_timer = nil
end

function HorseOnground:exit(new_state)
	HorseOnground.super.exit(self, new_state)
	self:go()

	self._transition = nil
end

function HorseOnground:update_transition(dt, t)
	self:check_jump(dt, t)
	self:check_brake(dt, t)

	if self._transition then
		self:change_state(self._transition)

		return
	end

	local mover = Unit.mover(self._unit)

	local function callback(actors)
		self:cb_evaluate_inair_transition(actors)
	end

	local physics_world = World.physics_world(self._internal.world)

	PhysicsWorld.overlap(physics_world, callback, "shape", "sphere", "position", Mover.position(mover), "size", Vector3(0.5, 0.5, 1), "types", "both", "collision_filter", "horse_landing_overlap")
end

function HorseOnground:cb_evaluate_inair_transition(actor_list)
	local internal = self._internal
	local unit = self._unit

	if internal.current_state_name ~= "onground" then
		return
	end

	if #actor_list == 0 then
		self:change_state("inair")
	end
end

function HorseOnground:check_jump(dt, t)
	if self._controller and self._controller:get("jump") and not self._transition then
		local internal = self._internal

		if internal.charging then
			self._transition = "jumping"
		end
	end
end

function HorseOnground:check_brake(dt, t)
	if self._controller and self._controller:get("mount_brake") > 0.5 and not self._transition then
		local internal = self._internal

		if self:can_brake(dt) then
			self._transition = "brake"
		else
			internal.speed = 0
			internal.acceleration = 0
		end

		if internal.charging then
			self:end_charge(t)
		end
	end
end

function HorseOnground:can_brake(dt)
	local internal = self._internal

	return HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]].allow_brake
end

local MOVE_AXIS_THRESHOLD = 0.3

function HorseOnground:update_movement_speed(dt)
	local move = self._controller and self._controller:get("mount_move") or Vector3(0, 0, 0)
	local internal = self._internal

	if move.y > 0 then
		internal.speed = HorseUnitMovementSettings.acceleration_function(internal.speed, dt)
		internal.acceleration = 0
	elseif move.y < 0 then
		internal.speed = HorseUnitMovementSettings.brake_function(internal.speed, dt)
		internal.acceleration = 0
	else
		internal.acceleration = internal.acceleration + internal.acceleration_change * dt

		local wanted_acceleration = internal._mount_profile.wanted_acceleration * math.sign(internal.speed)

		if wanted_acceleration >= internal.acceleration and internal.acceleration_change < 0 then
			internal.acceleration_change = -internal._mount_profile.acceleration_change
		elseif wanted_acceleration <= internal.acceleration and internal.acceleration_change > 0 then
			internal.acceleration_change = internal._mount_profile.acceleration_change
		end

		local speed_sign_before = math.sign(internal.speed)

		internal.speed = internal.speed + internal.acceleration * dt

		local speed_sign_after = math.sign(internal.speed)

		if speed_sign_before * speed_sign_after < 0 then
			internal.speed = 0
			internal.acceleration = 0
		end
	end

	internal.speed = math.min(internal.speed, self._speed_cap)

	local current_gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]]

	if internal.speed > self:_gait_speed_max(current_gait) then
		self:change_gait(1)
	elseif internal.speed < current_gait.speed_min then
		self:change_gait(-1)
	end
end

function HorseOnground:can_charge(t)
	local internal = self._internal

	return not internal.charging and not self._stop and internal.charge_stamina >= internal._mount_profile.max_charge_stamina
end

function HorseOnground:check_charge(dt, t)
	local internal = self._internal
	local hold = self._controller and self._controller:get("mounted_charge") > BUTTON_THRESHOLD
	local toggle = self._controller and self._controller:get("mounted_charge_pressed")
	local trigger_mode = HorseUnitMovementSettings.charge.trigger_mode

	if (trigger_mode == "hold" and hold or trigger_mode == "toggle" and toggle) and self:can_charge(t) then
		self:begin_charge(t)
	elseif internal.charging and (trigger_mode == "hold" and not hold or trigger_mode == "toggle" and toggle or internal.charge_stamina <= 0) then
		self:end_charge(t)
	end
end

function HorseOnground:begin_charge(t)
	local internal = self._internal

	internal.charging = true
	internal.charge_acceleration_start = t
	internal.gait_index = #HorseUnitMovementSettings.gait_order
	internal.speed = math.min(HorseUnitMovementSettings.charge.speed_min, self._speed_cap)

	self:anim_event(HorseUnitMovementSettings.charge.anim_event)

	local rider = Unit.get_data(self._unit, "user_unit")
	local rider_locomotion = ScriptUnit.extension(rider, "locomotion_system")

	rider_locomotion.current_state:begin_charge(t)
end

function HorseOnground:end_charge(t)
	local internal = self._internal

	internal.charging = false

	local gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]]

	internal.speed = self:_gait_speed_max(gait)

	self:_play_gait_animation(gait, internal)

	local rider = Unit.get_data(self._unit, "user_unit")
	local rider_locomotion = rider and ScriptUnit.extension(rider, "locomotion_system")

	if rider_locomotion then
		rider_locomotion.current_state:end_charge()
	end
end

function HorseOnground:update_charge(dt, t)
	local internal = self._internal
	local speed_multiplier = self:_speed_multiplier()

	internal.speed = math.min(self._speed_cap, math.lerp(HorseUnitMovementSettings.charge.speed_min * speed_multiplier, HorseUnitMovementSettings.charge.speed_max * speed_multiplier, math.min((t - internal.charge_acceleration_start) / HorseUnitMovementSettings.charge.charge_acceleration_time, 1)))

	self:set_movement_speed_anim_var(internal.speed)
	self:set_movement_speed_anim_var(internal.speed)
	self:_update_gait_anim_rotation_state()
end

function HorseOnground:_update_gait_anim_rotation_state()
	local internal = self._internal
	local gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]]

	if gait.anim_rot_left_event and internal.anim_rot_speed < -IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD and internal.gait_anim_rotation_state ~= "left" then
		self:anim_event(gait.anim_rot_left_event)

		internal.gait_anim_rotation_state = "left"
	elseif gait.anim_rot_right_event and internal.anim_rot_speed > IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD and internal.gait_anim_rotation_state ~= "right" then
		self:anim_event(gait.anim_rot_right_event)

		internal.gait_anim_rotation_state = "right"
	elseif math.abs(internal.anim_rot_speed) < IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD and internal.gait_anim_rotation_state then
		self:anim_event(gait.anim_event)

		internal.gait_anim_rotation_state = nil
	end
end

function HorseOnground:_enter_cruise_control()
	HorseOnground.super._enter_cruise_control(self)

	self._gait_direction_pressed = nil
	self._gait_tap_timer = nil
end

function HorseOnground:_update_cruise_control(dt, t)
	local internal = self._internal
	local wanted_speed = HorseUnitMovementSettings.cruise_control.gears[internal.cruise_control_gear].speed

	wanted_speed = internal.gait_index == #HorseUnitMovementSettings.gait_order and wanted_speed * self:_speed_multiplier() or wanted_speed

	local old_speed = internal.speed
	local profile = self._internal._mount_profile
	local new_speed = math.clamp(wanted_speed, old_speed - profile.cruise_control_brake_speed * dt, old_speed + profile.cruise_control_accelerate_speed * dt)

	internal.speed = math.min(new_speed, self._speed_cap)

	local current_gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]]

	if internal.speed > self:_gait_speed_max(current_gait) then
		self:change_gait(1)
	elseif internal.speed < current_gait.speed_min then
		self:change_gait(-1)
	end
end

function HorseOnground:_speed_multiplier()
	local rider = Unit.get_data(self._unit, "user_unit")
	local speed_multiplier = 1

	if rider then
		local locomotion = ScriptUnit.extension(rider, "locomotion_system")
		local area_buff_ext = ScriptUnit.has_extension(rider, "area_buff_system") and ScriptUnit.extension(rider, "area_buff_system")

		speed_multiplier = locomotion and locomotion:has_perk("horse_racer") and Perks.horse_racer.move_speed_multiplier or speed_multiplier
		speed_multiplier = area_buff_ext and speed_multiplier * area_buff_ext:buff_multiplier("mounted_speed") or speed_multiplier
	end

	return speed_multiplier
end

function HorseOnground:_gait_speed_max(gait)
	if self._internal.gait_index == #HorseUnitMovementSettings.gait_order then
		return gait.speed_max * self:_speed_multiplier()
	end

	return gait.speed_max
end

function HorseOnground:update_gait(dt, t)
	local internal = self._internal
	local move = self._controller and self._controller:get("mount_move") or Vector3(0, 0, 0)
	local move_pressed = self._controller and (self._controller:get("mount_move_forward_pressed") or self._controller:get("mount_move_back_pressed"))
	local cruise_control_gear_up = self._controller and self._controller:get("mount_cruise_control_gear_up")
	local cruise_control_gear_down = self._controller and self._controller:get("mount_cruise_control_gear_down")
	local mount_profile = internal._mount_profile

	if not internal.cruise_control and (cruise_control_gear_up or cruise_control_gear_down) then
		self:_enter_cruise_control()
	elseif internal.cruise_control and move_pressed then
		self:_exit_cruise_control()
	end

	if internal.cruise_control then
		self:_update_cruise_control_gear(dt, t, (cruise_control_gear_up and 1 or 0) - (cruise_control_gear_down and 1 or 0))
	end

	if self._stop and internal.speed >= 0 and (not internal.cruise_control or internal.cruise_control_gear ~= 1) and (internal.speed > EPSILON or move.y > -EPSILON) then
		internal.speed = 0
		internal.acceleration = 0

		self:_match_gait()
	elseif internal.cruise_control then
		self:_update_cruise_control(dt, t)
	else
		local move_y_pressed = math.abs(move.y) > MOVE_AXIS_THRESHOLD
		local direction_pressed = math.sign(move.y)

		if self._gait_direction_pressed and self._gait_direction_pressed ~= direction_pressed then
			if t < self._gait_tap_timer then
				internal.acceleration = self._gait_direction_pressed * mount_profile.burst_acceleration
				internal.acceleration_change = mount_profile.acceleration_change
			end

			if move_y_pressed then
				self._gait_direction_pressed = direction_pressed
				self._gait_tap_timer = t + HorseUnitMovementSettings.gait_tap_threshold
			else
				self._gait_direction_pressed = nil
				self._gait_tap_timer = nil
			end
		elseif move_y_pressed and self._gait_direction_pressed == direction_pressed and t > self._gait_tap_timer then
			self:update_movement_speed(dt)
		elseif not self._gait_direction_pressed and move_y_pressed then
			self._gait_tap_timer = t + HorseUnitMovementSettings.gait_tap_threshold
			self._gait_direction_pressed = direction_pressed
		elseif not self._gait_direction_pressed then
			self:update_movement_speed(dt)
		end
	end

	self:set_movement_speed_anim_var(internal.speed)
	self:_update_gait_anim_rotation_state()
end

function HorseOnground:_play_gait_animation(gait, internal)
	if gait.anim_rot_left_event and internal.anim_rot_speed < -IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD then
		self:anim_event(gait.anim_rot_left_event)

		internal.gait_anim_rotation_state = "left"
	elseif gait.anim_rot_right_event and internal.anim_rot_speed > IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD then
		self:anim_event(gait.anim_rot_right_event)

		internal.gait_anim_rotation_state = "right"
	else
		self:anim_event(gait.anim_event)

		internal.gait_anim_rotation_state = nil
	end
end

function HorseOnground:change_gait(change)
	local internal = self._internal
	local current_gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index]]

	if change < 0 and internal.gait_index == 1 then
		internal.speed = current_gait.speed_min

		return
	elseif change > 0 and internal.gait_index == #HorseUnitMovementSettings.gait_order then
		internal.speed = self:_gait_speed_max(current_gait)

		return
	end

	local new_gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[internal.gait_index + change]]

	if new_gait.speed_min > self._speed_cap and change > 0 then
		return
	end

	self:_play_gait_animation(new_gait, internal)

	if internal.speed < new_gait.speed_min then
		internal.speed = new_gait.speed_min
	elseif internal.speed > new_gait.speed_max then
		internal.speed = self:_gait_speed_max(new_gait)
	end

	internal.gait_index = internal.gait_index + change
end

function HorseOnground:_match_gait()
	local wanted_gait_name, wanted_gait
	local current_gait = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[self._internal.gait_index]]

	for name, gait in pairs(HorseUnitMovementSettings.gaits) do
		if self._internal.speed >= gait.speed_min and self._internal.speed <= self:_gait_speed_max(gait) then
			wanted_gait_name, wanted_gait = name, gait

			break
		end
	end

	if wanted_gait ~= current_gait then
		local wanted_gait_index = HorseUnitMovementSettings.gait_lookup[wanted_gait_name]

		if wanted_gait_index < self._internal.gait_index then
			self._internal.speed = self:_gait_speed_max(wanted_gait)
		elseif wanted_gait_index > self._internal.gait_index then
			self._internal.speed = wanted_gait.speed_min
		end

		self._internal.gait_index = wanted_gait_index

		self:_play_gait_animation(wanted_gait, self._internal)
	end
end

function HorseOnground:update_movement(dt)
	local internal = self._internal
	local unit = self._unit
	local mover = Unit.mover(unit)
	local current_position = Unit.local_position(unit, 0)
	local z_velocity = Vector3.z(internal.velocity:unbox())
	local inv_drag_force = 0.00225 * math.abs(z_velocity) * z_velocity
	local fall_velocity = z_velocity - (9.82 + inv_drag_force) * dt

	if fall_velocity > 0 then
		fall_velocity = 0
	end

	local movement_delta = Quaternion.forward(Unit.local_rotation(unit, 0)) * internal.speed * dt
	local strafe_modifier

	if internal.charging and HorseUnitMovementSettings.charge.lateral_movement_type == "strafe" then
		strafe_modifier = self:_calculate_charge_strafe(unit, dt)
	else
		strafe_modifier = Vector3(0, 0, 0)
	end

	local delta = movement_delta + Vector3(0, 0, fall_velocity) * dt + strafe_modifier

	if delta.z > 0 then
		Vector3.set_z(delta, 0)
	end

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)
	local new_delta = final_position - current_position

	internal.velocity:store(Vector3(new_delta.x, new_delta.y, math.max(new_delta.z, delta.z)) / dt)
	self:set_local_position(final_position)
end

function HorseOnground:_calculate_charge_strafe(unit, dt)
	local move = self._controller and self._controller:get("mount_move") or Vector3.zero()

	return Quaternion.right(Unit.local_rotation(unit, 0)) * move.x * dt * HorseUnitMovementSettings.charge.strafe_speed
end

function HorseOnground:update_rotation(dt)
	local internal = self._internal
	local unit = self._unit

	internal.lerp_pitch = math.lerp(internal.pitch, internal.new_pitch, dt * 5)
	internal.pitch = internal.lerp_pitch

	local move = self._controller and self._controller:get("mount_move") or Vector3.zero()

	if not internal.charging or HorseUnitMovementSettings.charge.lateral_movement_type ~= "strafe" then
		self:_update_yaw(internal, unit, move, dt)
	end

	local rot_delta_x = Quaternion(Vector3.right(), internal.lerp_pitch)

	internal.pitch_delta = 0

	local rot_delta_y = Quaternion(Vector3.up(), internal.yaw)
	local new_rot = Quaternion.multiply(Quaternion.multiply(rot_delta_y, Quaternion.identity()), rot_delta_x)

	self:set_local_rotation(new_rot)
end

function HorseOnground:anim_event(event, ...)
	HorseOnground.super.anim_event(self, event, ...)
end

function HorseOnground:_update_yaw(internal, unit, move, dt)
	if self._deflect then
		if math.abs(self._wanted_yaw - internal.yaw) < math.pi / 256 then
			self._deflect = false
			internal.yaw = self._wanted_yaw
		else
			local yaw_diff = internal.yaw - self._wanted_yaw

			if yaw_diff < 0 and yaw_diff > -math.pi or yaw_diff > math.pi then
				move = -Vector3.right()
			elseif yaw_diff > 0 and yaw_diff < math.pi or yaw_diff < -math.pi then
				move = Vector3.right()
			end
		end
	end

	local rider = Unit.get_data(unit, "user_unit")

	internal.rot_speed = math.lerp(internal.rot_speed, move.x * ROTATION_MAX_SPEED, ROTATION_ACCELERATION * dt)

	if not internal.gait_anim_rotation_state or math.sign(internal.anim_rot_speed) == math.sign(move.x * ANIM_ROTATION_MAX_SPEED) and math.abs(internal.anim_rot_speed) < math.abs(move.x * ANIM_ROTATION_MAX_SPEED) then
		internal.anim_rot_speed = math.clamp(math.lerp(internal.anim_rot_speed, move.x * ANIM_ROTATION_MAX_SPEED, ANIM_ROTATION_ACCELERATION * dt), -ANIM_ROTATION_MAX_SPEED, ANIM_ROTATION_MAX_SPEED)
	else
		internal.anim_rot_speed = math.clamp(move.x * ANIM_ROTATION_MAX_SPEED, -ANIM_ROTATION_MAX_SPEED, ANIM_ROTATION_MAX_SPEED)
	end

	local gait_name = HorseUnitMovementSettings.gait_order[internal.gait_index]
	local gait = HorseUnitMovementSettings.gaits[gait_name]

	if gait.animation_driven_rotation and internal.gait_anim_rotation_state then
		Unit.set_animation_root_mode(unit, "ignore")

		local rotation_speed = math.abs(internal.rot_speed * 180) / math.pi

		Unit.animation_set_variable(unit, self._anim_driven_rotation_speed_var, rotation_speed)

		if internal.game and internal.id then
			GameSession.set_game_object_field(internal.game, internal.id, "idle_rotation_speed", rotation_speed)
		end

		if rider then
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_idle_rotation_speed"), rotation_speed)
		end

		local wanted_pose = Unit.animation_wanted_root_pose(unit)
		local wanted_rotation = Matrix4x4.rotation(wanted_pose)
		local current_rotation = Unit.local_rotation(unit, 0)
		local rotation_delta = Quaternion.multiply(wanted_rotation, Quaternion.inverse(current_rotation))
		local x, y, z, w = Quaternion.to_elements(rotation_delta)
		local delta_yaw = math.atan2(2 * (x * y + w * z), w * w + x * x - y * y - z * z)

		internal.yaw = internal.yaw + delta_yaw
	elseif gait_name == "idle" then
		local rotation_speed = math.abs(internal.rot_speed * 180) / math.pi

		Unit.animation_set_variable(unit, self._anim_driven_rotation_speed_var, rotation_speed)

		if internal.game and internal.id then
			GameSession.set_game_object_field(internal.game, internal.id, "idle_rotation_speed", rotation_speed)
		end

		if Unit.alive(rider) then
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_idle_rotation_speed"), rotation_speed)
		end
	else
		internal.yaw = internal.yaw - internal.rot_speed * dt
	end

	Unit.animation_set_variable(unit, self._rotation_speed_anim_var, internal.anim_rot_speed)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "rotation_speed", internal.anim_rot_speed)
	end

	if rider then
		Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_rotation_speed"), internal.anim_rot_speed)
	end

	internal.yaw = (internal.yaw + math.pi) % (math.pi * 2) - math.pi
end

function HorseOnground:stop()
	self._stop = true

	local internal = self._internal

	if internal.charging then
		self:end_charge(Managers.time:time("game"))
	end
end

function HorseOnground:go()
	self._stop = false
end

function HorseOnground:set_deflect(flag)
	self._deflect = flag
end

function HorseOnground:set_align_direction(direction)
	local wanted_rot = Quaternion.look(direction, Vector3.up())
	local x, y, z, w = Quaternion.to_elements(wanted_rot)
	local wanted_yaw = math.atan2(2 * (x * y + w * z), w^2 + x^2 - y^2 - z^2)
	local current_yaw = self._internal.yaw

	self._wanted_yaw = wanted_yaw
end
