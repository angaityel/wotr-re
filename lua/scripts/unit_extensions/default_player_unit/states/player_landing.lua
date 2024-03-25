-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_landing.lua

PlayerLanding = class(PlayerLanding, PlayerMovementStateBase)

function PlayerLanding:update(dt, t)
	PlayerLanding.super.update(self, dt, t)
	self:update_aim_rotation(dt, t)
	self:_update_movement(dt, t)

	if self._movement_type == "moving" then
		self:update_rotation(dt, t)
	end

	self:update_transition(dt, t)

	self._transition = nil
	self._movement_type = nil
end

local STILL_LANDING_CHECK = 0.1
local DIRECTION_EPSILON = 0.1

function PlayerLanding:enter(old_state, landing_type)
	local internal = self._internal
	local unit = internal.unit
	local speed = internal.speed:unbox()
	local t = Managers.time:time("game")
	local camera_manager = Managers.state.camera
	local network_manager = Managers.state.network

	if landing_type == "knocked_down" then
		self:anim_event("land_knocked_down")

		if network_manager:game() then
			network_manager:send_rpc_server("rpc_self_knock_down", internal.id)
		elseif not Managers.lobby.lobby then
			ScriptUnit.extension(unit, "damage_system"):self_knock_down()
		end

		self:_halting_landing()

		internal.land_type = "knocked_down"
	elseif landing_type == "heavy" then
		camera_manager:camera_effect_sequence_event("landed_hard", t)
		camera_manager:camera_effect_shake_event("landed_hard", t)

		if true or Vector3.length(speed) < STILL_LANDING_CHECK then
			self:anim_event("land_heavy_still")

			self._movement_type = "still"
			self._onground_movement_type = "idle"
		elseif speed.y < -DIRECTION_EPSILON then
			self:anim_event("land_heavy_moving_bwd")

			self._movement_type = "moving"
			self._onground_movement_type = "running_bwd"
		else
			self:anim_event("land_heavy_moving_fwd")

			self._movement_type = "moving"
			self._onground_movement_type = "running_fwd"
		end

		self:_halting_landing()

		internal.land_type = "heavy"
	else
		camera_manager:camera_effect_sequence_event("landed_soft", t)
		camera_manager:camera_effect_shake_event("landed_soft", t)

		if Vector3.length(speed) < STILL_LANDING_CHECK then
			self:anim_event("land_still")

			self._movement_type = "still"
			self._onground_movement_type = "idle"
		elseif speed.y < -DIRECTION_EPSILON then
			self:anim_event("land_moving_bwd")

			self._movement_type = "moving"
			self._onground_movement_type = "running_bwd"
		else
			self:anim_event("land_moving_fwd")

			self._movement_type = "moving"
			self._onground_movement_type = "running_fwd"
		end

		internal.land_type = "light"
	end

	internal.landing = true
end

function PlayerLanding:_halting_landing()
	local internal = self._internal
	local unit = self._unit

	internal.speed:store(Vector3(0, 0, 0))

	internal.move_speed = 0
end

function PlayerLanding:exit(new_state)
	PlayerLanding.super.exit(self, new_state)

	self._transition = nil
	self._movement_type = nil

	local internal = self._internal

	internal.landing = false
	internal.land_type = nil
	internal.anim_forced_upper_body_block = Managers.time:time("game") + PlayerUnitMovementSettings.landing.anim_forced_upper_body_block
end

function PlayerLanding:update_transition(dt)
	if self._transition then
		self:anim_event("to_" .. self._transition)
		self:change_state(self._transition, self._onground_movement_type)

		return
	end

	local mover = Unit.mover(self._unit)

	local function callback(actors)
		self:cb_evaluate_inair_transition(actors)
	end

	local physics_world = World.physics_world(self._internal.world)

	PhysicsWorld.overlap(physics_world, callback, "shape", "sphere", "position", Mover.position(mover), "size", Vector3(0.5, 0.5, 1), "types", "both", "collision_filter", "landing_overlap")
end

function PlayerLanding:cb_evaluate_inair_transition(actor_list)
	if self._internal.current_state_name ~= "landing" then
		return
	end

	if #actor_list == 0 then
		self:anim_event("to_inair")
		self:change_state("inair")
	end
end

function PlayerLanding:anim_cb_landing_to_onground()
	self._transition = "onground"
end

function PlayerLanding:_update_movement(dt, t)
	local final_position = PlayerMechanicsHelper:script_driven_camera_relative_update_movement(self._unit, self._internal, dt, false)

	self:set_local_position(final_position)
end

function PlayerLanding:update_rotation(dt, t)
	local internal = self._internal
	local move = internal.speed:unbox()
	local move_length = Vector3.length(move)

	internal.move_rotation_local:store(Quaternion(Vector3.up(), math.atan2(-move.x, move.y)))
	internal.target_rotation:store(Quaternion(Vector3.up(), math.atan2(-math.sign(move.y + 0.1) * move.x, math.abs(move.y))))
	self:_update_current_rotation(dt, t)
end
