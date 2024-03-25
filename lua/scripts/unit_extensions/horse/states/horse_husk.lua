-- chunkname: @scripts/unit_extensions/horse/states/horse_husk.lua

HorseHusk = class(HorseHusk, HorseMovementStateBase)

function HorseHusk:init(unit, internal)
	HorseMovementStateBase.init(self, unit, internal)
	Unit.set_animation_merge_options(unit)

	self._unit = unit
	self._internal = internal
	self._anim_move_var_index = Unit.animation_find_variable(unit, "horse_move_speed")
	self._rotation_speed_anim_var = Unit.animation_find_variable(unit, "horse_rotation_speed")
	self._anim_driven_rotation_speed_var = Unit.animation_find_variable(unit, "horse_idle_rotation_speed")
	self._physics_culled = false
end

local ROT_LERP = 5
local POS_LERP = 5
local VELOCITY_LERP = 5
local ANIM_LERP = 5
local POS_EPSILON = 0.01
local POS_LERP_TIME = 0.3

function HorseHusk:enter(old_state)
	HorseHusk.super.enter(self, old_state)

	self._internal.cruise_control = false
end

function HorseHusk:update(unit, internal, controller, dt, context)
	HorseMovementStateBase.update(self, unit, internal, controller, dt, context)

	local internal = self._internal
	local old_pos = Unit.local_position(unit, 0)
	local new_pos = GameSession.game_object_field(internal.game, internal.id, "position")
	local new_rot = GameSession.game_object_field(internal.game, internal.id, "rotation")

	if script_data.extrapolation_debug then
		local old_rot = Unit.local_rotation(unit, 0)
		local velocity = GameSession.game_object_field(internal.game, internal.id, "velocity")

		Unit.set_local_rotation(unit, 0, Quaternion.lerp(old_rot, new_rot, math.min(dt * ROT_LERP, 1)))

		local last_pos = Unit.get_data(unit, "last_lerp_position") or old_pos
		local last_pos_offset = Unit.get_data(unit, "last_lerp_position_offset") or Vector3(0, 0, 0)
		local accumulated_movement = Unit.get_data(unit, "accumulated_movement") or Vector3(0, 0, 0)

		self._pos_lerp_time = (self._pos_lerp_time or 0) + dt

		local lerp_t = self._pos_lerp_time / POS_LERP_TIME
		local move_delta = velocity * dt

		accumulated_movement = accumulated_movement + move_delta

		local lerp_pos = Vector3.lerp(Vector3(0, 0, 0), last_pos_offset, math.min(lerp_t, 1))
		local pos = last_pos + accumulated_movement + lerp_pos

		Unit.set_data(unit, "accumulated_movement", accumulated_movement)

		if Vector3.length(new_pos - last_pos) > POS_EPSILON then
			self._pos_lerp_time = 0

			Unit.set_data(unit, "last_lerp_position", pos)
			Unit.set_data(unit, "last_lerp_position_offset", new_pos - pos)
			Unit.set_data(unit, "accumulated_movement", Vector3(0, 0, 0))
		end

		Unit.set_local_position(unit, 0, pos)
		Mover.set_position(Unit.mover(unit), pos)

		local lerp_val = math.min(dt * ANIM_LERP, 1)
		local old_move_speed = Unit.animation_get_variable(unit, self._anim_move_var_index)
		local new_move_speed = GameSession.game_object_field(internal.game, internal.id, "move_speed")
		local old_rot_speed = Unit.animation_get_variable(unit, self._rotation_speed_anim_var)
		local new_rot_speed = GameSession.game_object_field(internal.game, internal.id, "rotation_speed")
		local old_idle_rot_speed = Unit.animation_get_variable(unit, self._anim_driven_rotation_speed_var)
		local new_idle_rot_speed = GameSession.game_object_field(internal.game, internal.id, "idle_rotation_speed")
		local lerped_move_speed = math.lerp(old_move_speed, new_move_speed, lerp_val)
		local lerped_rot_speed = math.lerp(old_rot_speed, new_rot_speed, lerp_val)
		local lerped_idle_rot_speed = math.lerp(old_idle_rot_speed, new_idle_rot_speed, lerp_val)

		Unit.animation_set_variable(unit, self._anim_move_var_index, lerped_move_speed)
		Unit.animation_set_variable(unit, self._rotation_speed_anim_var, lerped_rot_speed)
		Unit.animation_set_variable(unit, self._anim_driven_rotation_speed_var, lerped_idle_rot_speed)

		local rider = Unit.get_data(unit, "user_unit")

		if Unit.alive(rider) then
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_move_speed"), lerped_move_speed)
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_rotation_speed"), lerped_rot_speed)
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_idle_rotation_speed"), lerped_idle_rot_speed)
		elseif rider then
			print("[QF] We have a rider unit assigned but it isn't alive...")
		end

		internal.velocity:store(velocity)
	elseif script_data.lerp_debug then
		local old_rot = Unit.local_rotation(unit, 0)

		if script_data.lerp_pos_only then
			Unit.set_local_rotation(unit, 0, new_rot)
		else
			Unit.set_local_rotation(unit, 0, Quaternion.lerp(old_rot, new_rot, math.min(dt * ROT_LERP, 1)))
		end

		local lerped_pos = Vector3.lerp(old_pos, new_pos, math.min(dt * POS_LERP, 1))

		Unit.set_local_position(unit, 0, lerped_pos)

		local old_var = Unit.animation_get_variable(unit, self._anim_move_var_index)
		local new_var = GameSession.game_object_field(internal.game, internal.id, "move_speed")

		Unit.animation_set_variable(unit, self._anim_move_var_index, math.lerp(old_var, new_var, math.min(dt * ANIM_LERP, 1)))
		Mover.set_position(Unit.mover(unit), lerped_pos)
		internal.velocity:store(math.lerp(internal.velocity:unbox(), (lerped_pos - old_pos) / dt, math.min(dt * VELOCITY_LERP, 1)))
	else
		Unit.set_local_rotation(unit, 0, new_rot)
		Unit.set_local_position(unit, 0, new_pos)

		local move_speed = GameSession.game_object_field(internal.game, internal.id, "move_speed")
		local rotation_speed = GameSession.game_object_field(internal.game, internal.id, "rotation_speed")
		local idle_rotation_speed = GameSession.game_object_field(internal.game, internal.id, "idle_rotation_speed")

		Unit.animation_set_variable(unit, self._anim_move_var_index, move_speed)
		Unit.animation_set_variable(unit, self._rotation_speed_anim_var, rotation_speed)
		Unit.animation_set_variable(unit, self._anim_driven_rotation_speed_var, idle_rotation_speed)

		local rider = Unit.get_data(unit, "user_unit")

		if Unit.alive(rider) then
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_move_speed"), move_speed)
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_rotation_speed"), rotation_speed)
			Unit.animation_set_variable(rider, Unit.animation_find_variable(rider, "horse_idle_rotation_speed"), idle_rotation_speed)
		elseif rider then
			print("[QF] We have a rider unit assigned but it isn't alive...")
		end

		Mover.set_position(Unit.mover(unit), new_pos)
		internal.velocity:store(math.lerp(internal.velocity:unbox(), (new_pos - old_pos) / dt, math.min(dt * VELOCITY_LERP, 1)))
	end

	if not Managers.lobby.server then
		self:_update_culling(dt)
	end
end

function HorseHusk:_update_culling(dt)
	local unit = self._unit
	local position = Unit.world_position(unit, 0)
	local viewport_name = Managers.player:player(1).viewport_name
	local camera_position = Managers.state.camera:camera_position(viewport_name)
	local distance = Vector3.length(position - camera_position)

	if GameSettingsDevelopment.physics_cull_husks then
		self:_update_physics_culling(dt, unit, distance)
	end
end

function HorseHusk:_update_physics_culling(dt, unit, distance)
	if not self._physics_culled and distance > GameSettingsDevelopment.physics_cull_husks.cull_range then
		Unit.flow_event(unit, "lua_disable_hit_detection")

		self._physics_culled = true
	elseif self._physics_culled and distance < GameSettingsDevelopment.physics_cull_husks.uncull_range then
		Unit.flow_event(unit, "lua_enable_hit_detection")

		local damage_ext = ScriptUnit.extension(unit, "damage_system")
		local mount_profile = MountProfiles[Unit.get_data(unit, "mount_profile")]

		damage_ext:_setup_hit_zones(mount_profile.hit_zones)

		self._physics_culled = false
	end
end

function HorseHusk:exit()
	self.super.exit(self)

	local unit = self._unit

	if self._physics_culled and ScriptUnit.has_extension(unit, "damage_system") then
		Unit.flow_event(unit, "lua_enable_hit_detection")

		local damage_ext = ScriptUnit.extension(unit, "damage_system")
		local mount_profile = MountProfiles[Unit.get_data(unit, "mount_profile")]

		damage_ext:_setup_hit_zones(mount_profile.hit_zones)

		self._physics_culled = false
	end
end

function HorseHusk:destroy()
	return
end
