-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_onground.lua

require("scripts/unit_extensions/human/base/states/human_onground")

PlayerOnground = class(PlayerOnground, HumanOnground)

local BUTTON_THRESHOLD = 0.5
local PARRY_ATTEMPT_THRESHOLD = 0.001
local POSE_ATTEMPT_THRESHOLD = 0.001

function PlayerOnground:update(dt, t)
	PlayerOnground.super.update(self, dt, t)
	self:update_aim_rotation(dt, t)
	self:_update_rotation(dt, t)
	self:_update_weapons(dt, t)
	self:_update_crouch(dt, t)
	self:_update_officer_buff_activation(dt, t)
	self:_update_tagging(dt, t)
	self:_update_animation(dt, t)
	self:_update_movement(dt, t)
	self:_update_stamina(dt, t)
	self:_update_transition(dt, t)

	self._transition = nil
end

function PlayerOnground:_calculate_speed(dt, current_speed, target_speed, encumbrance)
	local x = current_speed.x
	local y = current_speed.y
	local internal = self._internal
	local acceleration_multiplier = internal:has_perk("fleet_footed") and Perks.fleet_footed.acceleration_multiplier or 1
	local encumbrance_factor = PlayerUnitMovementSettings.encumbrance.functions.movement_acceleration(encumbrance)
	local new_x = PlayerUnitMovementSettings.movement_acceleration(dt, current_speed.x, target_speed.x, encumbrance_factor, acceleration_multiplier)
	local new_y = PlayerUnitMovementSettings.movement_acceleration(dt, current_speed.y, target_speed.y, encumbrance_factor, acceleration_multiplier)
	local ret = Vector3(new_x, new_y, 0)

	return ret
end

function PlayerOnground:enter(old_state, movement_type)
	PlayerOnground.super.enter(self, old_state)

	self._movement_type = movement_type

	if old_state ~= "inair" and old_state ~= "jumping" and old_state ~= "landing" then
		self._internal.double_time_timer = Managers.time:time("game") + PlayerUnitMovementSettings.double_time.timer_time
	end
end

function PlayerOnground:exit(new_state)
	PlayerOnground.super.exit(self, new_state)

	local internal = self._internal

	internal.double_time_recovery = false
	self._inair_timer = nil
	self._transition = nil
	self._movement_type = nil
	self._movement_dir = nil

	self:safe_action_interrupt("state_" .. new_state)
end

function PlayerOnground:_check_jump(dt, t)
	local internal = self._internal
	local height_multiplier = internal:has_perk("field_warden") and Perks.field_warden.height_multiplier or 1

	if self._controller and self._controller:get("jump") and not self._transition and self:can_jump(t) then
		local wanted_animation_event

		if self._movement_type == "running_fwd" or self._movement_type == "running_bwd" then
			wanted_animation_event = "jump_fwd"
			self._transition = "jumping"

			local velocity = internal.velocity:unbox()

			Vector3.set_z(velocity, 0)

			local fwd_move_vector = Quaternion.forward(internal.move_rot:unbox())
			local fwd_length = Vector3.dot(fwd_move_vector, velocity)

			if fwd_length < PlayerUnitMovementSettings.jump.forward_jump.minimum_horizontal_velocity then
				velocity = velocity + (PlayerUnitMovementSettings.jump.forward_jump.minimum_horizontal_velocity - fwd_length) * fwd_move_vector
			end

			Vector3.set_z(velocity, PlayerUnitMovementSettings.jump.forward_jump.initial_vertical_velocity * height_multiplier)
			internal.velocity:store(velocity)
		elseif self._movement_type == "idle" then
			wanted_animation_event = "jump_idle"
			self._transition = "jumping"

			internal.velocity:store(internal.velocity:unbox() + Vector3(0, 0, PlayerUnitMovementSettings.jump.stationary_jump.initial_vertical_velocity * height_multiplier))
		end

		self:anim_event(wanted_animation_event)
	end
end

function PlayerOnground:_check_perks(dt, t)
	local internal = self._internal
	local controller = self._controller

	if controller and not self._transition then
		if controller:get("call_horse_released") then
			internal.call_horse_release_button = false
		end

		if controller:has("shield_bash_initiate") and controller:get("shield_bash_initiate") and self:can_shield_bash(t) then
			self._transition = "shield_bashing"
		elseif controller:has("push") and controller:get("push") and self:can_push(t) then
			self._transition = "pushing"
		elseif controller:has("call_horse") and controller:get("call_horse") > BUTTON_THRESHOLD and self:can_call_horse(self._unit, t) then
			self._transition = "calling_horse"
		elseif controller:has("rush_pressed") and controller:get("rush_pressed") and self:can_rush(t) then
			self._transition = "rushing"
		end
	end
end

function PlayerOnground:_check_interact(dt, t)
	local interact = self._controller and self._controller:get("interact")
	local internal = self._internal

	if interact and not self._transition then
		local interaction = ScriptUnit.extension(self._unit, "interaction_system")
		local target, interact_type = interaction:get_interaction_target()

		if not target then
			return
		end

		if interact_type == "mount" and self:can_mount(t) then
			self._transition = "mounted"
			internal.mounted_unit = target
		elseif interact_type == "revive" and self:can_revive(t) then
			self:change_state("reviving_teammate", target, t)
		elseif interact_type == "flag_spawn" and self:can_pickup_flag() then
			if Managers.lobby.lobby then
				local level = LevelHelper:current_level(self._internal.world)
				local capture_point_index = Level.unit_index(level, target)

				internal.picking_flag = true

				Managers.state.network:send_rpc_server("rpc_request_flag_spawn", internal.id, capture_point_index)
			else
				local objective_ext = ScriptUnit.extension(target, "objective_system")
				local unit = self._unit

				if objective_ext:can_spawn_flag(unit) then
					local flag = objective_ext:spawn_flag(unit)
					local flag_ext = ScriptUnit.extension(flag, "flag_system")

					flag_ext:pickup(unit)

					internal.carried_flag = flag
				end
			end
		elseif interact_type == "flag_plant" and self:can_plant_flag() then
			self:change_state("planting_flag", target, t)
		elseif interact_type == "flag_pickup" and self:can_pickup_flag() then
			if Managers.lobby.lobby then
				local flag_id = Unit.get_data(target, "game_object_id")

				internal.picking_flag = true

				Managers.state.network:send_rpc_server("rpc_request_flag_pickup", internal.id, flag_id)
			else
				local unit = self._unit
				local flag_ext = ScriptUnit.extension(target, "flag_system")

				if flag_ext:can_be_picked_up(unit) then
					flag_ext:pickup(unit)

					internal.carried_flag = target
				end
			end
		elseif interact_type == "flag_drop" and self:can_drop_flag() then
			assert(target == internal.carried_flag, "Trying to drop other flag than carried flag")
			self:_drop_flag()
		elseif interact_type == "execute" and self:can_execute(t) then
			self:change_state("executing", target, t)
		elseif interact_type == "climb" and self:can_climb(t) then
			self:change_state("climbing", target)
		elseif interact_type == "bandage" and self:can_bandage(t) then
			self:change_state("bandaging_teammate", target, t)
		elseif interact_type == "trigger" and self:can_trigger(t) then
			self:change_state("triggering", target, t)
		end
	end
end

function PlayerOnground:_check_bandage(dt, t)
	local bandage = self._controller and self._controller:get("bandage_start")
	local damage_ext = ScriptUnit.extension(self._unit, "damage_system")

	if not self._transition and bandage and self:can_bandage(t) then
		self:change_state("bandaging_self", self._unit, t)

		return true
	end
end

function PlayerOnground:_update_transition(dt, t)
	if Application.platform() == "ps3" then
		return
	end

	self:_check_jump(dt, t)
	self:_check_perks(dt, t)

	if not self:_check_bandage(dt, t) then
		self:_check_interact(dt, t)
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

	PhysicsWorld.overlap(physics_world, callback, "shape", "sphere", "position", Mover.position(mover), "size", 0.4, "types", "both", "collision_filter", "landing_overlap")
end

function PlayerOnground:cb_evaluate_inair_transition(actor_list)
	if self._internal.current_state_name ~= "onground" then
		return
	end

	local unit = self._unit

	if #actor_list == 0 and not Mover.collides_down(Unit.mover(unit)) then
		self:change_state("inair")
		self:anim_event("to_inair")
	end
end

function PlayerOnground:_update_crouch(dt, t)
	if self._controller and self._controller:get("crouch") then
		local internal = self._internal

		if internal.crouching then
			self:_abort_crouch()
		elseif self:can_crouch(t) then
			self:safe_action_interrupt("crouch")
			self:_crouch()
		end
	end
end

function PlayerOnground:_crouch()
	self:anim_event("to_crouch")

	self._internal.crouching = true

	if Managers.lobby.lobby and GameSettingsDevelopment.network_mode == "steam" and not Achievement.unlocked(22) then
		local cb = callback(self, "cb_teabag_overlap")
		local unit = self._unit
		local pos = Unit.world_position(unit, Unit.node(unit, "Hips"))

		PhysicsWorld.overlap(World.physics_world(self._internal.world), cb, "shape", "capsule", "position", pos, "size", Vector3(0.3, 0.5, 0.8), "types", "dynamics", "collision_filter", "melee_trigger")
	end
end

function PlayerOnground:cb_teabag_overlap(actors)
	local internal = self._internal

	if internal.__destroyed then
		return
	end

	for _, actor in pairs(actors) do
		local hit_unit = Actor.unit(actor)

		if Unit.alive(hit_unit) and hit_unit ~= self._unit then
			hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

			local owner = Managers.player:owner(hit_unit)

			if owner and owner.team ~= internal.player.team then
				local hit_zones = Unit.get_data(hit_unit, "hit_zone_lookup_table")
				local hit_zone_hit = hit_zones and hit_zones[actor] and hit_zones[actor].name

				if hit_zone_hit then
					local damage_ext = ScriptUnit.has_extension(hit_unit, "damage_system") and ScriptUnit.extension(hit_unit, "damage_system")
					local kd = damage_ext and damage_ext.is_knocked_down and damage_ext:is_knocked_down()

					if kd and hit_zone_hit == "head" then
						AchievementHelper:unlock(22)

						return
					end
				end
			end
		end
	end
end

local WALK_THRESHOLD = 0.97
local JOG_THRESHOLD = 3.23
local RUN_THRESHOLD = 6.14
local CROUCH_SPEED = 0.96

function PlayerOnground:_calculate_move_speed_var_from_mps(move_speed)
	local speed_var
	local speed_multiplier = 1

	if self._internal.crouching then
		speed_var = 1
		speed_multiplier = move_speed / CROUCH_SPEED
	elseif move_speed <= WALK_THRESHOLD then
		speed_var = 0
		speed_multiplier = move_speed / WALK_THRESHOLD
	elseif move_speed <= JOG_THRESHOLD then
		speed_var = (move_speed - WALK_THRESHOLD) / (JOG_THRESHOLD - WALK_THRESHOLD)
	elseif move_speed <= RUN_THRESHOLD then
		speed_var = 1 + (move_speed - JOG_THRESHOLD) / (RUN_THRESHOLD - JOG_THRESHOLD)
	else
		speed_var = 3
		speed_multiplier = move_speed / RUN_THRESHOLD
	end

	return speed_var, speed_multiplier
end

function PlayerOnground:_update_animation(dt, t)
	local internal = self._internal
	local inventory = internal:inventory()
	local unit = self._unit
	local move = self._controller and self._controller:get("move") or Vector3(0, 0, 0)
	local anim_rush_var_index = Unit.animation_find_variable(unit, "rush_speed")
	local anim_move_var_index = Unit.animation_find_variable(unit, "move_speed")
	local anim_move_multiplier_var_index = Unit.animation_find_variable(unit, "double_time_speed")
	local slot_name = inventory:wielded_ranged_weapon_slot()
	local reloading_crossbow = false
	local encumbrance = inventory:encumbrance()

	if slot_name then
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		reloading_crossbow = weapon_ext:category() == "crossbow" and (weapon_ext:reloading() or not weapon_ext:can_aim())
	end

	local target_speed = not (not internal.projectile_camera_active and not reloading_crossbow) and Vector3(0, 0, 0) or move

	target_speed = Vector3.normalize(target_speed)

	if target_speed.y < 0 then
		Vector3.set_y(target_speed, target_speed.y * PlayerUnitMovementSettings.backward_move_scale * PlayerUnitMovementSettings.encumbrance.functions.movement_speed_backwards(encumbrance))
	end

	Vector3.set_x(target_speed, target_speed.x * PlayerUnitMovementSettings.strafe_move_scale * PlayerUnitMovementSettings.encumbrance.functions.movement_speed_strafe(encumbrance))

	local wanted_animation_event

	if internal.blocking or internal.parrying then
		target_speed = target_speed * inventory:weapon_pose_movement_multiplier(internal.block_slot_name)
	elseif internal.posing then
		target_speed = target_speed * inventory:weapon_pose_movement_multiplier(internal.pose_slot_name)
	elseif internal.aiming then
		target_speed = target_speed * inventory:weapon_pose_movement_multiplier(internal.aim_slot_name)
	end

	local area_buff_ext = ScriptUnit.extension(unit, "area_buff_system")

	target_speed = target_speed * area_buff_ext:buff_multiplier("march_speed")

	local new_movement_state
	local stamina_recovery = false

	if move.y > 0.1 and self:can_double_time() and not stamina_recovery then
		local double_time_time = t - internal.double_time_timer
		local lerp_t

		if double_time_time > 0 then
			internal.double_time = true
		end

		if double_time_time > PlayerUnitMovementSettings.double_time.ramp_up_time then
			lerp_t = 1
		else
			local new_direction = Vector3.normalize(Vector3.flat(self._aim_vector))
			local old_direction = internal.double_time_direction:unbox()
			local old_angle = math.atan2(old_direction.x, old_direction.y)
			local new_angle = math.atan2(new_direction.x, new_direction.y)

			if double_time_time < 0 then
				local diff_angle = math.abs(((new_angle - old_angle) / math.pi + 1) % 2 - 1)

				double_time_time = double_time_time - PlayerUnitMovementSettings.double_time.ramp_up_time * PlayerUnitMovementSettings.encumbrance.functions.double_time_acceleration(encumbrance) * diff_angle * 2
				internal.double_time_timer = math.min(t - double_time_time, t + PlayerUnitMovementSettings.double_time.timer_time)
			end

			lerp_t = math.clamp(double_time_time / (PlayerUnitMovementSettings.double_time.ramp_up_time * PlayerUnitMovementSettings.encumbrance.functions.double_time_acceleration(encumbrance)), 0, 1)

			internal.double_time_direction:store(new_direction)
		end

		target_speed = math.lerp(target_speed, target_speed * self:_double_time_speed(), lerp_t)
	else
		if move.y < 0.1 then
			internal.double_time = false
			internal.double_time_recovery = false
		end

		if internal.double_time then
			internal.double_time = false
			internal.double_time_recovery = true
			internal.double_time_recovery_timer = math.min(2 * t - internal.double_time_timer, t + PlayerUnitMovementSettings.double_time.ramp_down_time * PlayerUnitMovementSettings.encumbrance.functions.double_time_acceleration(encumbrance))
		end

		if internal.double_time_recovery and t > internal.double_time_recovery_timer then
			internal.double_time_recovery = false
		elseif internal.double_time_recovery then
			local double_time_time = internal.double_time_recovery_timer - t
			local lerp_t = math.clamp(double_time_time / (PlayerUnitMovementSettings.double_time.ramp_up_time * PlayerUnitMovementSettings.encumbrance.functions.double_time_acceleration(encumbrance)), 0, 1)

			target_speed = math.lerp(target_speed, target_speed * self:_double_time_speed(), lerp_t)
		end

		internal.double_time_timer = t + PlayerUnitMovementSettings.double_time.timer_time

		internal.double_time_direction:store(Vector3.normalize(Vector3.flat(self._aim_vector)))
	end

	local speed = self:_calculate_speed(dt, internal.speed:unbox(), target_speed, encumbrance)
	local move_length = Vector3.length(speed)
	local move_speed = internal.crouching and move_length * PlayerUnitMovementSettings.crouch_move_speed or move_length * self:_move_speed()
	local moving = move_length > 0.1
	local moving_fwd, moving_bwd

	internal.speed:store(speed)

	if moving then
		moving_fwd = speed.y > 0 or math.abs(speed.x) > 0.1 and math.abs(speed.y) < 0.1
		moving_bwd = not moving_fwd
		internal.movement_state = "onground/moving"
		new_movement_state = NetworkLookup.movement_states["onground/moving"]
	else
		internal.movement_state = "onground/idle"
		new_movement_state = NetworkLookup.movement_states["onground/idle"]
	end

	if internal.game and internal.id and new_movement_state ~= GameSession.game_object_field(internal.game, internal.id, "movement_state") then
		GameSession.set_game_object_field(internal.game, internal.id, "movement_state", new_movement_state)
	end

	if moving_bwd and self._movement_type ~= "running_bwd" then
		wanted_animation_event = "move_bwd"
		self._movement_type = "running_bwd"
	elseif moving_fwd and self._movement_type ~= "running_fwd" then
		wanted_animation_event = "move_fwd"
		self._movement_type = "running_fwd"
	elseif not moving and self._movement_type ~= "idle" then
		wanted_animation_event = "idle"
		self._movement_type = "idle"
	end

	Unit.animation_set_variable(unit, anim_rush_var_index, move_speed)

	local move_speed_var_value, speed_multiplier = self:_calculate_move_speed_var_from_mps(move_speed)

	Unit.animation_set_variable(unit, anim_move_var_index, move_speed_var_value)
	Unit.animation_set_variable(unit, anim_move_multiplier_var_index, speed_multiplier)

	internal.move_speed = move_speed

	if wanted_animation_event then
		self:anim_event(wanted_animation_event)
	end
end

function PlayerOnground:_update_movement(dt, t)
	if not self._internal.leaving_ghost_mode then
		local final_position = PlayerMechanicsHelper:script_driven_camera_relative_update_movement(self._unit, self._internal, dt, false)

		self:set_local_position(final_position)
	end
end

function PlayerOnground:_update_stamina(dt, t)
	local internal = self._internal
	local inventory = internal:inventory()
	local enc = inventory:encumbrance()
	local stamina_regen_multiplier = (internal:has_perk("infantry") and Perks.infantry.stamina_regen_multiplier or 1) * PlayerUnitMovementSettings.encumbrance.functions.stamina_max(enc)
	local max_stamina = self:_max_stamina(internal, enc)

	internal.rush_stamina = internal.rush_stamina + dt

	if max_stamina < internal.rush_stamina then
		internal.rush_stamina = max_stamina
	end

	local bb = internal.sprint_hud_blackboard

	bb.cooldown_shader_value = 1 - internal.rush_stamina / max_stamina
end

function PlayerOnground:_update_rotation(dt)
	local unit = self._unit
	local internal = self._internal
	local move = internal.speed:unbox()

	internal.move_rotation_local:store(Quaternion(Vector3.up(), math.atan2(-move.x, move.y)))
	internal.target_rotation:store(Quaternion(Vector3.up(), math.atan2(-math.sign(move.y + 0.1) * move.x, math.abs(move.y))))
	self:_update_current_rotation(dt)
end
