-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_pushing.lua

PlayerPushing = class(PlayerPushing, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5

function PlayerPushing:update(dt, t)
	PlayerPushing.super.update(self, dt, t)
	self:update_movement(dt, t)
	self:update_rotation(dt, t)
end

function PlayerPushing:update_movement(dt)
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
	local delta = anim_delta + Vector3(0, 0, fall_velocity) * dt

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	delta = final_position - current_position

	internal.velocity:store(delta / dt)
	self:set_local_position(final_position)
end

function PlayerPushing:enter(old_state)
	PlayerPushing.super.enter(self, old_state)
	self:_align_to_camera()

	local internal = self._internal
	local inventory = internal:inventory()

	self:_swing_push()
	self:_play_voice("chr_vce_push")
end

function PlayerPushing:exit(new_state)
	PlayerPushing.super.exit(self, new_state)

	local internal = self._internal

	internal.swinging_push = false

	self:_play_voice("stop_chr_vce_push")
end

function PlayerPushing:update_rotation(dt, t)
	self:update_aim_rotation(dt, t)
	self:update_lerped_rotation(dt, t)
end

function PlayerPushing:_swing_push(t)
	local internal = self._internal

	internal.swinging_push = true

	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local gear = inventory:_gear(slot_name)
	local attack = Gear[gear:name()].attacks.push

	inventory:start_melee_attack(slot_name, 0, "push", callback(self, "gear_cb_abort_push_swing"), 1)
	self:anim_event_with_variable_float("push_start", "push_time", attack.attack_time)
end

function PlayerPushing:anim_cb_push_damage_finished()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local gear = inventory:_gear(slot_name)

	self:push_swing_finished()
end

function PlayerPushing:anim_cb_push_finished()
	self:anim_event("push_finished")
	self:change_state("onground")
end

function PlayerPushing:_align_to_camera()
	local internal = self._internal

	self:update_aim_rotation()

	local rot = Quaternion.look(Vector3.flat(self._aim_vector), Vector3.up())

	self:set_target_world_rotation(rot)
end

PlayerRushing = class(PlayerRushing, PlayerPushing)

function PlayerRushing:update_movement(dt, t)
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

	local anim_delta

	if self._end_t then
		anim_delta = Vector3.normalize(Vector3.flat(Quaternion.forward(Unit.local_rotation(unit, 0)))) * self:_speed(self._end_t - t) * dt
	else
		anim_delta = Vector3.flat(wanted_position - current_position)
	end

	local delta = anim_delta + Vector3(0, 0, fall_velocity) * dt

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	delta = final_position - current_position

	internal.velocity:store(delta / dt)
	self:set_local_position(final_position)
end

local DURATION = 0.45
local MAX_SPEED = 12
local MAX_AT = 0.7

function PlayerRushing:_speed(time_left)
	if time_left > MAX_AT * DURATION then
		local t = (time_left - MAX_AT * DURATION) / ((1 - MAX_AT) * DURATION)
		local lerp_t = 0.5 * (math.cos(t * math.pi) + 1)

		return MAX_SPEED * lerp_t + self._start_speed * (1 - lerp_t)
	else
		return MAX_SPEED
	end
end

function PlayerRushing:enter(old_state)
	PlayerRushing.super.enter(self, old_state)

	self._end_t = Managers.time:time("game") + DURATION

	local internal = self._internal

	internal.rush_stamina = 0
	self._start_speed = Vector3.dot(internal.velocity:unbox(), Quaternion.forward(Unit.local_rotation(self._unit, 0)))
end

function PlayerRushing:update(dt, t)
	PlayerRushing.super.update(self, dt, t)

	if self._internal.current_state_name == "rushing" and self._end_t then
		if t > self._end_t then
			self:anim_event("charge_finished")
			self:change_state("onground")
		else
			self:_update_sweep(dt, t)
		end
	end
end

local SWEEP_EPSILON = 0.001

function PlayerRushing:_update_sweep(dt, t)
	local old_pos = self._last_sweep_position:unbox()
	local new_pos = self:_sweep_position()
	local sweep_vector = new_pos - old_pos

	if Vector3.length(sweep_vector) < SWEEP_EPSILON then
		return
	end

	local physics_world = World.physics_world(self._internal.world)
	local hits = PhysicsWorld.linear_sphere_sweep(physics_world, old_pos, new_pos, 0.5, 10, "types", "both", "collision_filter", "melee_trigger")

	if script_data.rush_sweep_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})

		drawer:capsule(old_pos, new_pos, 0.5)
	end

	if not hits then
		return
	end

	local hard_hit = false
	local impact_direction = Vector3.normalize(sweep_vector)
	local hit_units = {}
	local unit = self._unit

	for _, hit in ipairs(hits) do
		local hit_unit = Actor.unit(hit.actor)
		local actor = hit.actor
		local normal = hit.normal
		local position = hit.position

		hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

		if hit_units[hit_unit] then
			break
		end

		hit_units[hit_unit] = true

		if hit_unit ~= unit and Unit.get_data(hit_unit, "user_unit") ~= unit and self:_rush_hit(hit_unit, actor, normal, position, impact_direction) then
			break
		end
	end

	self._last_sweep_position:store(new_pos)
end

function PlayerRushing:exit(new_state)
	PlayerRushing.super.exit(self, new_state)

	local internal = self._internal
	local aim_vector = self._aim_vector
	local aim_vector_flat = Vector3.normalize(Vector3.flat(aim_vector))
	local aim_rot_flat = Quaternion.look(aim_vector_flat, Vector3.up())
	local velocity = internal.velocity:unbox()

	internal.speed:store(Vector3(Vector3.dot(Quaternion.right(aim_rot_flat), velocity), Vector3.dot(Quaternion.forward(aim_rot_flat), velocity), 0) / self:_move_speed())
end

function PlayerRushing:_rush_hit(hit_unit, actor, normal, position, impact_direction)
	if not hit_unit or not Unit.alive(hit_unit) then
		return
	end

	local hard

	if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
		local victim_locomotion = ScriptUnit.extension(hit_unit, "locomotion_system")

		if victim_locomotion.parrying and self:_check_parry(victim_locomotion) then
			hard = true
		elseif victim_locomotion.blocking and self:_check_blocking(victim_locomotion) then
			hard = true
		else
			self:_rush_impact_character(hit_unit, position, normal, actor, impact_direction)

			hard = false
		end
	elseif Unit.has_data(hit_unit, "gear_name") then
		local gear_settings = Gear[Unit.get_data(hit_unit, "gear_name")]
		local gear_user = Unit.get_data(hit_unit, "user_unit")

		if not Unit.alive(gear_user) then
			return
		end

		local gear_user_locomotion = ScriptUnit.extension(gear_user, "locomotion_system")

		if gear_user_locomotion.parrying and gear_user_locomotion.block_unit == hit_unit and self:_check_parry(gear_user_locomotion) then
			hard = true
		elseif gear_user_locomotion.blocking and gear_user_locomotion.block_unit == hit_unit and self:_check_blocking(gear_user_locomotion) then
			hard = true
		else
			return
		end
	else
		hard = (not Unit.get_data(hit_unit, "soft_target") or false) and true
	end

	if hard then
		self:anim_event_with_variable_float("charge_hit_hard", "charge_hit_hard_penalty_time", 1)
	else
		self:anim_event("charge_finished")
		self:change_state("onground")
	end

	self._end_t = nil

	return true
end

function PlayerRushing:_check_parry(victim_locomotion)
	if victim_locomotion.block_direction ~= "down" or not Unit.alive(victim_locomotion.block_unit) then
		return false
	end

	local attacker_aim = self._internal:aim_direction()
	local victim_aim = victim_locomotion:aim_direction()
	local attacker_aim_flat = Vector3(attacker_aim.x, attacker_aim.y, 0)
	local victim_aim_flat = Vector3(victim_aim.x, victim_aim.y, 0)
	local dot = Vector3.dot(attacker_aim_flat, victim_aim_flat)

	return dot < 0
end

function PlayerRushing:_check_blocking(victim_locomotion)
	if not Unit.alive(victim_locomotion.block_unit) then
		return false
	end

	local attacker_aim = self._internal:aim_direction()
	local victim_aim = victim_locomotion:aim_direction()
	local attacker_aim_flat = Vector3.flat(attacker_aim)
	local victim_aim_flat = Vector3.flat(victim_aim)
	local dot = Vector3.dot(attacker_aim_flat, victim_aim_flat)

	return dot < 0
end

function PlayerRushing:_rush_impact_character(hit_unit, position, normal, actor, impact_direction)
	local network_manager = Managers.state.network
	local internal = self._internal
	local world = self._world
	local unit = self._unit
	local user_unit = self._user_unit

	WeaponHelper:rush_impact_character(hit_unit, position, normal, world, impact_direction)
	internal.velocity:store(Vector3(0, 0, 0))

	if internal.game and internal.id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_rush_impact_character", internal.id, network_manager:game_object_id(hit_unit), position, normal, impact_direction)
		else
			network_manager:send_rpc_server("rpc_rush_impact_character", internal.id, network_manager:game_object_id(hit_unit), position, normal, impact_direction)
		end
	end
end

function PlayerRushing:anim_cb_charge_finished()
	self:anim_event("charge_finished")
	self:change_state("onground")
end

function PlayerRushing:_swing_push(t)
	local internal = self._internal

	self._last_sweep_position = Vector3Box(self:_sweep_position())

	self:anim_event("charge_start")
end

function PlayerRushing:_sweep_position()
	local unit = self._unit

	return Unit.local_position(unit, 0) + Quaternion.forward(Unit.local_rotation(unit, 0)) * 0.125 + Vector3(0, 0, 1)
end
