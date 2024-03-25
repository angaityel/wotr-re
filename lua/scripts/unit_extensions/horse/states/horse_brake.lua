-- chunkname: @scripts/unit_extensions/horse/states/horse_brake.lua

require("scripts/unit_extensions/horse/horse_onground_behaviour")

HorseBrake = class(HorseBrake, HorseMovementStateBase)

local ROTATION_MAX_SPEED = HorseUnitMovementSettings.hand_brake.turn_speed
local ROTATION_ACCELERATION = ROTATION_MAX_SPEED * 4
local ANIM_ROTATION_MAX_SPEED = 1
local IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD = 0.01
local ANIM_ROTATION_ACCELERATION = ANIM_ROTATION_MAX_SPEED * 6
local BUTTON_THRESHOLD = 0.5

function HorseBrake:init(unit, locomotion)
	HorseBrake.super.init(self, unit, locomotion)
end

function HorseBrake:update(unit, internal, controller, dt, context, t)
	HorseBrake.super.update(self, unit, internal, controller, dt, context, t)

	self._controller = controller

	self:ground_raycast(unit, internal)
	self:update_rotation(dt, t)
	self:update_cruise_control(dt, t)
	self:update_movement(dt, t)
	self:update_transition(dt)

	self._transition = nil
end

function HorseBrake:ground_raycast(unit, internal)
	local rot = Unit.local_rotation(unit, 0)
	local dir = -Vector3.up()
	local pos = Unit.local_position(unit, 0)
	local from = pos + Vector3.normalize(Vector3.flat(Quaternion.forward(rot))) * 0.4 + Vector3(0, 0, 1.5)
	local cb = callback(self, "ground_raycast_cb", internal, pos.x, pos.y, pos.z)
	local physics_world = World.physics_world(internal.world)
	local raycast = PhysicsWorld.make_raycast(physics_world, cb, "types", "statics", "collision_filter", "horse_landing_overlap")

	Raycast.cast(raycast, from, dir, 2)
end

function HorseBrake:ground_raycast_cb(internal, pos_x, pos_y, pos_z, any_hit, position, distance, normal, actor)
	if any_hit then
		local dir = position - Vector3(pos_x, pos_y, pos_z)
		local dir_norm = Vector3.normalize(dir)

		internal.new_pitch = math.min(math.asin(Vector3.dot(dir_norm, Vector3.up())), math.pi / 4)
	else
		internal.pitch = -math.pi / 32
	end
end

function HorseBrake:enter(old_state)
	HorseBrake.super.enter(self, old_state)

	local internal = self._internal

	internal.acceleration = 0
	self._transition_timer = Managers.time:time("game") + HorseUnitMovementSettings.hand_brake.duration

	self:anim_event("horse_break")

	self._initial_direction = Vector3Box(Vector3.normalize(Vector3.flat(Quaternion.forward(Unit.local_rotation(self._unit, 0)))))
	self._initial_speed = internal.speed
end

function HorseBrake:exit(new_state)
	HorseBrake.super.exit(self, new_state)

	self._transition = nil
	self._internal.gait_index = 2
end

function HorseBrake:update_transition(dt)
	local brake_input = self._controller and self._controller:get("mount_brake") > 0.5

	if not brake_input and (self._transition_timer < Managers.time:time("game") or HorseUnitMovementSettings.hand_brake.allow_interrupt) then
		self._transition = "onground"
	end

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

function HorseBrake:cb_evaluate_inair_transition(actor_list)
	local internal = self._internal
	local unit = self._unit

	if internal.current_state_name ~= "brake" then
		return
	end

	if #actor_list == 0 then
		self:change_state("inair")
	end
end

function HorseBrake:_update_brake_speed(dt, t)
	local brake_settings = HorseUnitMovementSettings.hand_brake
	local time_step = math.max((self._transition_timer - t) / brake_settings.duration - brake_settings.full_stop, 0)
	local new_speed = self._initial_speed * math.sin(math.pi * 0.5 * time_step)

	return new_speed
end

function HorseBrake:update_movement(dt, t)
	local internal = self._internal

	internal.speed = self:_update_brake_speed(dt, t)

	local unit = self._unit
	local mover = Unit.mover(unit)
	local wanted_pose = Unit.animation_wanted_root_pose(unit)
	local wanted_position = Matrix4x4.translation(wanted_pose)
	local current_position = Unit.local_position(unit, 0)
	local z_velocity = Vector3.z(internal.velocity:unbox())
	local inv_drag_force = 0.00225 * math.abs(z_velocity) * z_velocity
	local fall_velocity = z_velocity - (9.82 + inv_drag_force) * dt

	if fall_velocity > 0 then
		fall_velocity = 0
	end

	local move_speed = self._initial_direction:unbox() * internal.speed
	local delta = (move_speed + Vector3(0, 0, fall_velocity)) * dt

	if delta.z > 0 then
		Vector3.set_z(delta, 0)
	end

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)
	local new_delta = final_position - current_position

	internal.velocity:store(Vector3(new_delta.x, new_delta.y, math.max(new_delta.z, delta.z)) / dt)
	self:set_local_position(final_position)
end

function HorseBrake:update_rotation(dt, t)
	local internal = self._internal

	internal.pitch = internal.pitch
	internal.new_pitch = internal.new_pitch
	internal.lerp_pitch = math.lerp(internal.pitch, internal.new_pitch, dt * 5)
	internal.pitch = internal.lerp_pitch
	internal.yaw = internal.yaw

	local unit = self._unit
	local internal = self._internal
	local move = self._controller and self._controller:get("mount_move") or Vector3.zero()
	local rot = Unit.local_rotation(unit, 0)

	self:_update_yaw(internal, unit, move, dt, t)

	local rot_delta_x = Quaternion(Vector3.right(), internal.lerp_pitch)

	internal.pitch_delta = 0

	local rot_delta_y = Quaternion(Vector3.up(), internal.yaw)
	local new_rot = Quaternion.multiply(Quaternion.multiply(rot_delta_y, Quaternion.identity()), rot_delta_x)

	self:set_local_rotation(new_rot)
end

function HorseBrake:_update_yaw(internal, unit, move, dt, t)
	local brake_settings = HorseUnitMovementSettings.hand_brake
	local time_step = math.sin(math.max((self._transition_timer - t) / brake_settings.duration - brake_settings.full_stop, 0) * math.half_pi)

	internal.rot_speed = math.lerp(internal.rot_speed, move.x * ROTATION_MAX_SPEED * time_step, ROTATION_ACCELERATION * dt)
	internal.anim_rot_speed = math.clamp(math.lerp(internal.anim_rot_speed, move.x * ANIM_ROTATION_MAX_SPEED * time_step, ANIM_ROTATION_ACCELERATION * dt), -ANIM_ROTATION_MAX_SPEED, ANIM_ROTATION_MAX_SPEED)

	local rider = Unit.get_data(unit, "user_unit")

	internal.yaw = internal.yaw - internal.rot_speed * dt

	Unit.animation_set_variable(unit, self._rotation_speed_anim_var, internal.anim_rot_speed)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "rotation_speed", internal.anim_rot_speed)
	end

	if rider then
		Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_rotation_speed"), internal.anim_rot_speed)
	end
end
