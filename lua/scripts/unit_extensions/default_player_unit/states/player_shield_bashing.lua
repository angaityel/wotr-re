-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_shield_bashing.lua

PlayerShieldBashing = class(PlayerShieldBashing, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5

function PlayerShieldBashing:update(dt, t)
	PlayerShieldBashing.super.update(self, dt, t)
	self:_update_shield_bash(dt, t)
	self:update_movement(dt, t)
	self:update_rotation(dt, t)
	self:_update_transition(dt, t)
end

function PlayerShieldBashing:_update_transition(dt, t)
	local mover = Unit.mover(self._unit)
	local physics_world = World.physics_world(self._internal.world)
	local actors = PhysicsWorld.overlap(physics_world, nil, "shape", "sphere", "position", Mover.position(mover), "size", 0.4, "types", "both", "collision_filter", "landing_overlap")

	self:evaluate_inair_transition(actors)
end

function PlayerShieldBashing:evaluate_inair_transition(actor_list)
	local unit = self._unit

	if #actor_list == 0 and not Mover.collides_down(Unit.mover(unit)) then
		self:_abort_shield_bash_pose()
		self:anim_event("to_inair")
		self:change_state("inair")
	end
end

function PlayerShieldBashing:_update_shield_bash(dt, t)
	local internal = self._internal
	local controller = self._controller
	local shield_bash_pose_input = controller and controller:get("shield_bash_pose") > BUTTON_THRESHOLD
	local block_input = controller and controller:get("block") > BUTTON_THRESHOLD
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local gear_name = inventory:_gear(slot_name):name()
	local charge_time = Gear[gear_name].attacks.shield_bash.charge_time
	local attack_time = Gear[gear_name].attacks.shield_bash.attack_time

	if not shield_bash_pose_input and self:_can_swing_shield_bash(t, charge_time) then
		self:_swing_shield_bash(t, charge_time, attack_time)
	end
end

function PlayerShieldBashing:update_movement(dt, t)
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

	local move_multiplier

	if internal.swinging_shield_bash then
		local total_move_multiplier = math.auto_lerp(0.75, 1.25, 2.6, 3.1, math.clamp(self._charge_factor, 0.75, 1.25))
		local speed_t = (t - self._swing_time) / self._swing_length

		move_multiplier = math.lerp(total_move_multiplier * 1.8, total_move_multiplier * 0.2, speed_t)
	else
		move_multiplier = self._internal.posing_shield_bash and 2 or 1
	end

	local anim_delta = Vector3.flat(wanted_position - current_position) * move_multiplier
	local anim_delta_length = Vector3.length(anim_delta)
	local delta = anim_delta + Vector3(0, 0, fall_velocity) * dt

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	delta = final_position - current_position

	internal.velocity:store(delta / dt)
	self:set_local_position(final_position)
end

function PlayerShieldBashing:enter(old_state)
	PlayerShieldBashing.super.enter(self, old_state)

	local t = Managers.time:time("game")
	local internal = self._internal

	self:_align_to_camera()

	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local gear = inventory:_gear(slot_name)
	local attack = Gear[gear:name()].attacks.shield_bash

	self:anim_event_with_variable_float("shield_bash_pose_start", "shield_bash_pose_time", attack.charge_time)

	internal.shield_bash_pose_start_time = t
	internal.posing_shield_bash = true
	internal.max_rotation_speed = math.pi * 2
end

function PlayerShieldBashing:exit(new_state)
	PlayerShieldBashing.super.exit(self, new_state)

	local internal = self._internal

	internal.posing_shield_bash = false
	internal.max_rotation_speed = nil
end

function PlayerShieldBashing:update_rotation(dt, t)
	local internal = self._internal

	if internal.posing_shield_bash or internal.swinging_shield_bash then
		self:_align_to_camera()
	end

	self:update_aim_rotation(dt, t)

	if internal.swinging_shield_bash or internal.posing_shield_bash then
		self:update_lerped_rotation(dt, t)
	end
end

function PlayerShieldBashing:_swing_shield_bash(t, charge_anim_time, attack_time)
	local internal = self._internal

	internal.swinging_shield_bash = true
	internal.posing_shield_bash = false

	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local gear = inventory:_gear(slot_name)
	local attack = Gear[gear:name()].attacks.shield_bash
	local charge_time = t - internal.shield_bash_pose_start_time

	self._charge_factor = charge_time / charge_anim_time
	self._swing_time = t
	self._swing_length = attack_time

	inventory:start_melee_attack(slot_name, charge_time, "shield_bash", callback(self, "gear_cb_abort_shield_bash_swing"), 1)
	self:anim_event_with_variable_float("shield_bash_start", "shield_bash_time", attack.attack_time)
end

function PlayerShieldBashing:anim_cb_shield_bash_damage_finished()
	local internal = self._internal

	internal.swinging_shield_bash = false

	self:shield_bash_swing_finished()
end

function PlayerShieldBashing:anim_cb_shield_bash_finished()
	self:anim_event("shield_bash_finished")
	self:change_state("onground")
end

function PlayerShieldBashing:_can_swing_shield_bash(t, charge_time)
	local internal = self._internal

	return internal.posing_shield_bash and not internal.swinging_shield_bash and t - internal.shield_bash_pose_start_time > charge_time * 0.75
end

function PlayerShieldBashing:_abort_shield_bash_pose()
	local internal = self._internal

	internal.posing_shield_bash = false

	self:_damp_velocity()
	self:anim_event("shield_bash_finished")
	self:change_state("onground")
end

function PlayerShieldBashing:_damp_velocity()
	local internal = self._internal
	local velocity = internal.velocity:unbox()
	local horizontal_velocity = Vector3.flat(velocity)

	horizontal_velocity = math.min(Vector3.length(horizontal_velocity), PlayerUnitMovementSettings.move_speed * PlayerUnitMovementSettings.double_time.move_speed) * Vector3.normalize(horizontal_velocity)

	internal.velocity:store(Vector3(horizontal_velocity.x, horizontal_velocity.y, velocity.z))
end

function PlayerShieldBashing:_align_to_camera()
	local internal = self._internal

	self:update_aim_rotation()

	local rot = Quaternion.look(Vector3.flat(self._aim_vector), Vector3.up())

	self:set_target_world_rotation(rot)
end
