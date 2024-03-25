-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_calling_horse.lua

PlayerCallingHorse = class(PlayerCallingHorse, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5

function PlayerCallingHorse:init(unit, internal, world)
	PlayerCallingHorse.super.init(self, unit, internal, world)

	self._unit = unit
	self._world = world
	self._internal = internal
	self._display_overlap_fail_area = false
	self._display_overlap_fail_area_timer = 0
end

function PlayerCallingHorse:update(dt, t)
	PlayerCallingHorse.super.update(self, dt, t)

	local internal = self._internal
	local controller = self._controller
	local call_horse_input = controller and controller:get("call_horse") > BUTTON_THRESHOLD

	self:_spawn_overlap_check(dt, t)

	local owned_mount = internal.owned_mount_unit
	local rider = owned_mount and Unit.alive(owned_mount) and Unit.get_data(owned_mount, "user_unit")

	if call_horse_input and not rider then
		if self._call_overlap_check_passed then
			if t >= internal.call_horse_timer then
				self:finish_calling_horse("successful")

				return
			end
		else
			self:finish_calling_horse("overlap_failed")
		end
	else
		self:finish_calling_horse("input_released")
	end

	self:update_movement(dt, t)
	self:update_rotation(dt, t)

	if t >= self._next_whistle then
		TimpaniWorld.trigger_event(World.timpani_world(self._world), "perc_cavalry_call")

		self._next_whistle = t + 1
	end
end

function PlayerCallingHorse:update_movement(dt)
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

function PlayerCallingHorse:enter(old_state)
	PlayerCallingHorse.super.enter(self, old_state)
	self:_align_to_camera()

	local internal = self._internal

	internal.calling_horse = true
	internal.call_horse_timer = Managers.time:time("game") + Perks.cavalry.duration
	self._call_overlap_check_passed = true

	local position = Unit.world_position(self._unit, 0)

	self._feet_projector = World.spawn_unit(self._world, "units/beings/chr_wotr_man/chr_wotr_man_feet_projector", position)

	self:anim_event("cavalry_whistle_start")

	self._next_whistle = Managers.time:time("game") + 1

	local blackboard = internal.call_horse_blackboard

	blackboard.max_time = Perks.cavalry.duration
	blackboard.timer = Managers.time:time("game") + Perks.cavalry.duration
end

function PlayerCallingHorse:exit(new_state)
	PlayerCallingHorse.super.exit(self, new_state)

	local internal = self._internal

	internal.calling_horse = false
	self._call_overlap_check_passed = true

	if Unit.alive(self._feet_projector) then
		World.destroy_unit(self._world, self._feet_projector)
	end
end

function PlayerCallingHorse:finish_calling_horse(reason)
	self:anim_event("cavalry_whistle_end")

	local internal = self._internal
	local unit = self._unit
	local t = Managers.time:time("game")

	if reason == "successful" then
		self:_play_voice("perc_cavalry_spawn")

		local owned_mount = internal.owned_mount_unit

		if owned_mount and Unit.alive(owned_mount) then
			local network_manager = Managers.state.network

			if network_manager:game() then
				local horse_object_id = network_manager:unit_game_object_id(owned_mount)

				network_manager:send_rpc_server("rpc_try_kill_owned_horse", horse_object_id)
			elseif not Managers.lobby.lobby then
				local mount_damage_ext = ScriptUnit.extension(owned_mount, "damage_system")

				mount_damage_ext:die()
			end
		end

		internal:spawn_new_mount(internal.player, internal._player_profile.mount, self._unit, false, true)
	elseif reason == "input_released" or reason == "interupted" then
		self:change_state("onground")
	elseif reason == "overlap_failed" then
		if self._call_overlap_check_passed == false then
			internal.call_horse_release_button = true
		end

		local position = Unit.world_position(unit, 0)
		local world = self._world

		if internal.call_horse_top_projector then
			World.destroy_unit(world, internal.call_horse_top_projector)
		end

		internal.call_horse_top_projector = World.spawn_unit(self._world, "units/beings/chr_wotr_man/chr_wotr_man_top_projector", position)
		internal.display_call_horse_overlap_fail = true
		internal.call_horse_overlap_fail_timer = t + 3

		self:change_state("onground")
	end
end

function PlayerCallingHorse:update_rotation(dt, t)
	self:update_aim_rotation(dt, t)
end

function PlayerCallingHorse:_spawn_overlap_check(dt, t)
	local physics_world = World.physics_world(self._internal.world)
	local callback = callback(self, "cb_cancel_call_horse")
	local mover = Unit.mover(self._unit)
	local position = Mover.position(mover)
	local capsule_pos = Vector3(position.x, position.y, position.z + 1.5)

	if script_data.call_horse_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "call_horse_debug_drawer"
		})

		drawer:sphere(capsule_pos, 1.2, Color(0, 255, 0))
	end

	PhysicsWorld.overlap(physics_world, callback, "position", capsule_pos, "size", 1.2, "collision_filter", "horse_call_overlap")
end

function PlayerCallingHorse:cb_cancel_call_horse(actors)
	self._call_overlap_check_passed = #actors == 0
end

function PlayerCallingHorse:_align_to_camera()
	local internal = self._internal
	local viewport_name = Unit.get_data(self._unit, "viewport_name")
	local camera_manager = Managers.state.camera
	local current_cam_rot = camera_manager:camera_rotation(viewport_name)
	local dir = Quaternion.forward(current_cam_rot)
	local norm_flat_dir = Vector3.normalize(Vector3.flat(dir))
	local yaw = -math.atan2(norm_flat_dir.x, norm_flat_dir.y)
	local rot = Quaternion(Vector3.up(), yaw)

	self:_set_rotation(rot)
end
