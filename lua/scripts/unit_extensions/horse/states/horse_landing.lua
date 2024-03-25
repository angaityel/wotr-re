-- chunkname: @scripts/unit_extensions/horse/states/horse_landing.lua

HorseLanding = class(HorseLanding, HorseMovementStateBase)

function HorseLanding:update(unit, internal, controller, dt, context, t)
	HorseLanding.super.update(self, unit, unit, internal, controller, dt, context, t)

	self._controller = controller

	self:update_cruise_control(dt, t)
	self:update_movement(dt)
	self:update_transition(dt)

	self._transition = nil
	self._movement_type = nil
end

function HorseLanding:enter(old_state)
	HorseLanding.super.enter(self, old_state)
	self:anim_event("horse_landing")
end

function HorseLanding:exit(new_state)
	HorseLanding.super.exit(self, new_state)

	self._transition = nil
	self._movement_type = nil
end

function HorseLanding:update_transition(dt)
	if self._transition then
		self:anim_event("horse_to_" .. self._transition)
		self:change_state(self._transition)

		return
	end

	local mover = Unit.mover(self._unit)
end

function HorseLanding:cb_evaluate_inair_transition(actor_list)
	if self._internal.current_state_name ~= "landing" then
		return
	end

	if #actor_list == 0 then
		self:change_state("inair")
	end
end

function HorseLanding:anim_cb_landing_to_onground()
	self._transition = "onground"
end

function HorseLanding:update_movement(dt)
	local internal = self._internal
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

	local anim_delta = Vector3.flat(wanted_position - current_position)
	local anim_delta_length = Vector3.length(anim_delta)
	local delta = anim_delta + Vector3(0, 0, fall_velocity) * dt

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	delta = final_position - current_position

	internal.velocity:store(delta / dt)
	self:set_local_position(final_position)
end
