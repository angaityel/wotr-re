-- chunkname: @scripts/unit_extensions/horse/states/horse_jumping.lua

HorseJumping = class(HorseJumping, HorseMovementStateBase)

function HorseJumping:update(unit, internal, controller, dt, context, t)
	HorseJumping.super.update(self, unit, internal, controller, dt, context, t)

	self._controller = controller

	self:update_animation(dt)
	self:update_cruise_control(dt, t)
	self:update_movement(dt)
	self:update_rotation(dt)
	self:update_transition()
end

function HorseJumping:update_transition()
	local unit = self._unit
	local mover = Unit.mover(unit)

	if self._movement_type == "falling" then
		local function callback(actors)
			self:cb_evaluate_landing_transition(actors)
		end

		local physics_world = World.physics_world(self._internal.world)

		PhysicsWorld.overlap(physics_world, callback, "shape", "sphere", "position", Mover.position(mover), "size", Vector3(0.5, 0.5, 0.1), "types", "both", "collision_filter", "horse_landing_overlap")
	end
end

function HorseJumping:fall_height()
	return self._fall_height
end

function HorseJumping:update_transition(dt, world)
	local unit = self._unit
	local mover = Unit.mover(unit)
	local internal = self._internal
	local pos = Mover.position(mover)
	local fall_distance = PlayerMechanicsHelper.calculate_fall_distance(internal, self._fall_height, pos)

	if fall_distance > PlayerUnitMovementSettings.fall.heights.dead and not self._suicided then
		PlayerMechanicsHelper.suicide(internal)

		self._suicided = true
	elseif Mover.collides_down(mover) then
		self:change_state("landing")
	end
end

function HorseJumping:enter(old_state)
	HorseJumping.super.enter(self, old_state)

	self._movement_type = "jumping"

	self:anim_event("horse_jump")

	local internal = self._internal

	internal.new_pitch = 0
	self._temp_t = 0
	self._fall_height = Unit.local_position(internal.unit, 0).z

	internal.velocity:store(Vector3(internal.velocity.x, internal.velocity.y, internal._mount_profile.jump_vertical_velocity))
end

function HorseJumping:exit(new_state)
	HorseJumping.super.exit(self, new_state)
end

function HorseJumping:anim_cb_jump_top()
	self._movement_type = "falling"
end

function HorseJumping:anim_cb_to_inair()
	self:change_state("inair")
end

function HorseJumping:update_animation(dt)
	return
end

function HorseJumping:update_rotation(dt)
	local internal = self._internal

	internal.lerp_pitch = math.lerp(internal.pitch, internal.new_pitch, dt * 2)
	internal.pitch = internal.lerp_pitch

	local unit = self._unit
	local rot_delta_x = Quaternion(Vector3.right(), internal.lerp_pitch)

	internal.pitch_delta = 0

	local rot_delta_y = Quaternion(Vector3.up(), internal.yaw)
	local new_rot = Quaternion.multiply(Quaternion.multiply(rot_delta_y, Quaternion.identity()), rot_delta_x)

	self:set_local_rotation(new_rot)
end

function HorseJumping:update_movement(dt)
	local position = PlayerMechanicsHelper:horse_update_movement_inair(self._unit, self._internal, dt)

	self:set_local_position(position)

	self._fall_height = math.max(self._fall_height, position.z)
end
