-- chunkname: @scripts/unit_extensions/horse/states/horse_inair.lua

HorseInair = class(HorseInair, HorseMovementStateBase)

function HorseInair:update(unit, internal, controller, dt, context, t)
	HorseInair.super.update(self, unit, internal, controller, dt, context, t)

	self._controller = controller

	self:update_cruise_control(dt, t)
	self:update_movement(dt)
	self:update_rotation(dt)
	self:update_transition(dt)
end

function HorseInair:fall_height()
	return self._fall_height
end

function HorseInair:update_transition(dt, world)
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

function HorseInair:enter(old_state)
	HorseInair.super.enter(self, old_state)

	local internal = self._internal

	internal.new_pitch = 0

	self:anim_event("horse_to_inair")

	self._fall_height = Unit.local_position(internal.unit, 0).z
end

function HorseInair:update_animation(dt)
	return
end

function HorseInair:update_movement(dt)
	local position = PlayerMechanicsHelper:horse_update_movement_inair(self._unit, self._internal, dt)

	self:set_local_position(position)
end

function HorseInair:update_rotation(dt)
	local internal = self._internal

	internal.lerp_pitch = math.lerp(internal.pitch, internal.new_pitch, dt * 5)
	internal.pitch = internal.lerp_pitch

	local unit = self._unit
	local rot_delta_x = Quaternion(Vector3.right(), internal.lerp_pitch)

	internal.pitch_delta = 0

	local rot_delta_y = Quaternion(Vector3.up(), internal.yaw)
	local new_rot = Quaternion.multiply(Quaternion.multiply(rot_delta_y, Quaternion.identity()), rot_delta_x)

	self:set_local_rotation(new_rot)
end
