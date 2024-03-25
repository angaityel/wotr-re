-- chunkname: @scripts/unit_extensions/horse/horse_locomotion.lua

HorseLocomotion = class(HorseLocomotion)

require("scripts/settings/horse_movement_settings")
require("scripts/unit_extensions/horse/states/horse_movement_state_base")
require("scripts/unit_extensions/horse/states/horse_onground")
require("scripts/unit_extensions/horse/states/horse_jumping")
require("scripts/unit_extensions/horse/states/horse_landing")
require("scripts/unit_extensions/horse/states/horse_inair")
require("scripts/unit_extensions/horse/states/horse_husk")
require("scripts/unit_extensions/horse/states/horse_onground_ai")
require("scripts/unit_extensions/horse/states/horse_dead")
require("scripts/unit_extensions/horse/states/horse_brake")
require("scripts/unit_extensions/horse/states/horse_onground_mounted_ai")
require("scripts/helpers/player_mechanics_helper")

HorseLocomotion.SYSTEM = "locomotion_system"

function HorseLocomotion:init(world, unit, id, game, ghost_mode, spawner_unit_id)
	self.world = world
	self.game = game
	self.id = id
	self.unit = unit
	self.spawner_unit_id = spawner_unit_id
	self.debug_drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "HORSE_DEBUG"
	})
	self._steering = AISteering:new(unit, self)
	self._states = {}

	self:create_state("onground", HorseOnground)
	self:create_state("onground_ai", HorseOngroundAi)
	self:create_state("onground_mounted_ai", HorseOngroundMountedAi)
	self:create_state("jumping", HorseJumping)
	self:create_state("landing", HorseLanding)
	self:create_state("inair", HorseInair)
	self:create_state("husk", HorseHusk)
	self:create_state("dead", HorseDead)
	self:create_state("brake", HorseBrake)

	if id then
		self:switch_to_husk()

		self.spawner_unit_id = GameSession.game_object_field(game, id, "spawner_unit_id")
	else
		self:switch_to_local()
	end

	Unit.set_data(unit, "game_object_migrated_away_cb", function(object_id, new_peer_id)
		self:switch_to_husk()
	end)
	Unit.set_data(unit, "game_object_migrated_to_me_cb", function(object_id, old_peer_id)
		self:switch_to_local()
	end)

	if ghost_mode then
		self:_enter_ghost_mode()
	end

	Unit.set_data(unit, "game_session_disconnect_callback", callback(self, "cb_game_session_disconnect"))

	if not self._husk and Managers.state.network:game() then
		self:_create_game_object()
	end

	self:_setup_mount_profile()
	self:_init_state_values()
	Unit.set_material_variation(unit, self._mount_profile.material_variation)
	self:_set_spawn_position(unit)

	local level_settings = LevelHelper:current_level_settings()
	local flow_event = level_settings.on_spawn_flow_event

	if flow_event then
		Unit.flow_event(unit, flow_event)
	end
end

function HorseLocomotion:fall_height()
	if self.current_state.fall_height then
		return self.current_state:fall_height()
	end
end

function HorseLocomotion:_setup_mount_profile()
	local unit = self.unit
	local mount_profile

	if not self._husk then
		mount_profile = MountProfiles[Unit.get_data(unit, "mount_profile")]
	elseif self.game then
		local mount_profile_name = NetworkLookup.mount_profiles[GameSession.game_object_field(self.game, self.id, "mount_profile")]

		Unit.set_data(unit, "mount_profile", mount_profile_name)

		mount_profile = MountProfiles[mount_profile_name]
	end

	self._mount_profile = mount_profile
end

function HorseLocomotion:_create_game_object()
	local unit = self.unit
	local mover = Unit.mover(unit)
	local data_table = {
		idle_rotation_speed = 0,
		rotation_speed = 0,
		move_speed = 0,
		husk_unit = NetworkLookup.husks[Unit.get_data(unit, "husk_unit")],
		position = Mover.position(mover),
		rotation = Unit.local_rotation(unit, 0),
		game_object_created_func = NetworkLookup.game_object_functions.cb_spawn_unit,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		object_destroy_func = NetworkLookup.game_object_functions.cb_destroy_unit,
		mount_profile = NetworkLookup.mount_profiles[Unit.get_data(unit, "mount_profile")],
		ghost_mode = self.ghost_mode,
		spawner_unit_id = self.spawner_unit_id
	}
	local callback = Unit.get_data(unit, "game_session_disconnect_callback")

	self.id = Managers.state.network:create_game_object("horse_unit", data_table, callback, "cb_local_unit_spawned", unit)
	self.game = Managers.state.network:game()
end

function HorseLocomotion:cb_game_session_disconnect()
	self._frozen = true
	self.id = nil
	self.game = nil
end

function HorseLocomotion:_init_state_values()
	self.rot_speed = 0
	self.anim_rot_speed = 0

	local rot = Unit.local_rotation(self.unit, 0)
	local dir = Quaternion.forward(rot)
	local flat_dir = Vector3.flat(dir)

	self.yaw = -math.atan2(flat_dir.x, flat_dir.y)
	self.pitch = 0
	self.new_pitch = 0
	self.gait_index = 2
	self.gait_anim_rotation_state = nil
	self.charging = false
	self.charge_stamina = self._mount_profile.max_charge_stamina
	self.charge_acceleration_timer = 0
	self.charge_cooldown = 0
	self.speed = 0
	self.acceleration = 0
	self.acceleration_change = self._mount_profile.acceleration_change
	self.velocity = Vector3Box(0, 0, 0)
end

function HorseLocomotion:switch_to_local()
	self._husk = false

	if self.current_state then
		self:change_state("onground_ai")
	else
		self:set_init_state("onground_ai")
	end
end

function HorseLocomotion:switch_to_husk()
	self._husk = true

	if self.current_state then
		self:change_state("husk")
	else
		self:set_init_state("husk")
	end
end

function HorseLocomotion:_set_spawn_position(unit)
	local mover = Unit.mover(unit)
	local position = Mover.position(mover)

	Mover.move(mover, Vector3(0, 0, -0.4), World.delta_time(self.world))

	local final_pos = Mover.position(mover)

	Unit.set_local_position(unit, 0, final_pos)
end

function HorseLocomotion:update(unit, input, dt, context, t)
	if self._frozen then
		return
	end

	Profiler.start("HorseLocomotion:update")

	local controller = input.controller
	local owning_player = Managers.player:owner(self.unit)

	if owning_player and owning_player.ai_player and self.current_state_name == "onground_ai" then
		self:change_state("onground_mounted_ai")
	elseif not controller and self.current_state_name == "onground" then
		print("SWITCH TO ONGROUND_AI", self.unit, self.id, controller)
		self:change_state("onground_ai")
	elseif controller and self.current_state_name == "onground_ai" then
		print("SWITCH TO ONGROUND", self.unit, self.id, controller)
		self:change_state("onground")
	end

	if Managers.lobby.server then
		self:_update_despawn_timer(dt, t)
	end

	self.current_state:update(unit, self, controller, dt, context, t)
	self.current_state:post_update(unit, self, controller, dt, context, t)

	if self._husk then
		local ghost_mode = GameSession.game_object_field(self.game, self.id, "ghost_mode")
		local player_manager = Managers.player
		local local_player = player_manager:player_exists(1) and player_manager:player(1)

		ghost_mode = ghost_mode and (not local_player or not owning_player or local_player.team ~= owning_player.team or local_player.spawn_data.state ~= "ghost_mode")

		if not ghost_mode and self.ghost_mode then
			self:exit_ghost_mode()
		elseif ghost_mode and not self.ghost_mode then
			self:_enter_ghost_mode()
		end
	end

	if not self.ghost_mode and (Managers.lobby.server or not Managers.lobby.lobby) then
		self:_update_collision_sweep(dt, t)
	end

	Profiler.stop()

	input.controller = nil
end

local MOUNT_MASS = 250
local PLAYER_UNIT_MASS = 120
local IMPACT_ENERGY_LOSS_RATIO = 0.9

function HorseLocomotion:_update_collision_sweep(dt, t)
	local world = self.world
	local physics_world = World.physics_world(world)
	local velocity = self.velocity:unbox()
	local speed = Vector3.length(velocity)

	if speed < 4.2 then
		return
	end

	local unit = self.unit

	if not Unit.alive(unit) then
		return
	end

	local cast_offset = velocity * dt
	local node = Unit.node(unit, "Neck")
	local unit_rot = Unit.world_rotation(unit, 0)
	local cast_from = Unit.world_position(unit, node) - Quaternion.up(unit_rot) * 0.5
	local forward_dir = Quaternion.forward(unit_rot)
	local cast_to = cast_from + cast_offset
	local cast_radius = 0.25
	local impact_direction = Vector3.normalize(cast_to - cast_from)
	local hits = PhysicsWorld.linear_sphere_sweep(physics_world, cast_from, cast_to, cast_radius, 1, "types", "dynamics", "collision_filter", "horse_collision_sweep")

	if script_data.horse_collision_debug then
		self.debug_drawer:capsule(cast_from, cast_to, cast_radius)
	end

	self._pushed_units = self._pushed_units or {}

	local side_dir = Quaternion.right(unit_rot)
	local mount_energy = MOUNT_MASS * speed
	local impact = false
	local damage = 0

	if hits then
		for _, hit in ipairs(hits) do
			local actor = hit.actor
			local hit_unit = Actor.unit(actor)

			hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

			local pushed_time = self._pushed_units[hit_unit]

			if (not pushed_time or t > pushed_time + 2) and Managers.player:owner(unit) ~= Managers.player:owner(hit_unit) and (not ScriptUnit.has_extension(hit_unit, "locomotion_system") or ScriptUnit.extension(hit_unit, "locomotion_system").mounted and not ScriptUnit.extension(hit_unit, "locomotion_system"):mounted()) then
				self._pushed_units[hit_unit] = t

				local normal = hit.normal
				local position = hit.position
				local right = Vector3.dot(position - cast_from, side_dir) > 0
				local transfered_energy = mount_energy * HorseUnitMovementSettings.obstacle_impact.energy_transfer_rate

				mount_energy = mount_energy - transfered_energy

				local single_player = not Managers.lobby.lobby
				local min, max

				if single_player then
					min = -math.huge
					max = math.huge
				else
					min = -NetworkConstants.velocity.max
					max = NetworkConstants.velocity.max
				end

				local impact_velocity = math.clamp(transfered_energy * IMPACT_ENERGY_LOSS_RATIO / PLAYER_UNIT_MASS, min, max)

				impact = true

				local impulse = impact_velocity * Vector3.normalize(Vector3.flat(forward_dir + (right and side_dir * 0.25 or -side_dir * 0.25)))

				self:impact_obstacle()
				WeaponHelper:mount_impact_character(hit_unit, damage, position, normal, world, "mount_impact", impulse)

				local network_manager = Managers.state.network

				if self.game and self.id then
					network_manager:send_rpc_clients("rpc_mount_impact_character", self.id, network_manager:game_object_id(hit_unit), damage, position, normal, impulse)
				end
			end
		end
	end
end

function HorseLocomotion:impact_obstacle()
	if self.current_state.impact_obstacle then
		self.current_state:impact_obstacle()
	end
end

function HorseLocomotion:_update_despawn_timer(dt, t)
	local unit = self.unit

	if not Unit.alive(unit) then
		return
	end

	local network_manager = Managers.state.network
	local spawner_unit = network_manager:game_object_unit(self.spawner_unit_id)
	local rider = Unit.get_data(unit, "user_unit")
	local spawner_alive = spawner_unit and Unit.alive(spawner_unit)
	local spawner_in_range = spawner_alive and self:_spawner_in_range(spawner_unit)

	if not rider and (not spawner_alive or not spawner_in_range) and not self._spawner_out_of_range then
		self._spawner_out_of_range = true
		self._despawn_timer = t + HorseUnitMovementSettings.despawn_settings.time_before_despawn
	end

	local damage_ext = ScriptUnit.extension(unit, "damage_system")

	if rider or spawner_in_range then
		self._spawner_out_of_range = false
	elseif t >= self._despawn_timer and not damage_ext:is_dead() then
		damage_ext:die()
	end
end

function HorseLocomotion:_spawner_in_range(spawner_unit)
	local spawner_pos = Unit.world_position(spawner_unit, 0)
	local mount_pos = Unit.world_position(self.unit, 0)
	local flat = Vector3.flat(spawner_pos - mount_pos)
	local distance = Vector3.length(flat)

	return distance <= HorseUnitMovementSettings.despawn_settings.range_before_despawn
end

function HorseLocomotion:_enter_ghost_mode()
	self.ghost_mode = true

	local unit = self.unit
	local num_actors = Unit.num_actors(unit)

	for i = 0, num_actors - 1 do
		local actor = Unit.actor(unit, i)

		if actor then
			Actor.set_collision_enabled(actor, false)
			Actor.set_scene_query_enabled(actor, false)
		end
	end

	if self._husk then
		Unit.set_unit_visibility(unit, false)
		Unit.flow_event(unit, "disable_vfx")
	end

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "ghost_mode_horse_mover")
end

function HorseLocomotion:exit_ghost_mode()
	self.ghost_mode = false

	local unit = self.unit

	if not self._husk and self.game and self.id then
		GameSession.set_game_object_field(self.game, self.id, "ghost_mode", self.ghost_mode)
	else
		Unit.set_unit_visibility(unit, true)
		Unit.flow_event(unit, "enable_vfx")
	end

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "horse_mover")

	local num_actors = Unit.num_actors(unit)

	for i = 0, num_actors - 1 do
		local actor = Unit.actor(unit, i)

		if actor then
			Actor.set_collision_enabled(actor, true)
			Actor.set_scene_query_enabled(actor, true)
		end
	end
end

function HorseLocomotion:destroy()
	local unit = self.unit

	if Managers.player:owner(unit) then
		Managers.player:relinquish_unit_ownership(unit)
	end

	Managers.state.event:trigger("horse_destroyed", unit)
	self.current_state:exit("none")

	for key, state in pairs(self._states) do
		state:destroy()
	end
end

function HorseLocomotion:create_state(state_name, new_state)
	self._states[state_name] = new_state:new(self.unit, self)
end

function HorseLocomotion:change_state(new_state)
	self.current_state:change_state(new_state)
end

function HorseLocomotion:set_init_state(new_state)
	self.current_state = self._states[new_state]
	self.current_state_name = new_state

	self.current_state:enter("none")
end

function HorseLocomotion:anim_cb(callback, unit, param)
	local cb = self.current_state[callback]

	if cb then
		self.current_state[callback](self.current_state, unit, param)
	elseif self.current_state_name ~= "husk" then
		if self[callback] then
			self[callback](self, unit, param)
		else
			print("[HorseLocomotion:anim_cb()] Unit has no animation callback with name " .. tostring(callback) .. " neither in global nor in " .. tostring(self.current_state_name))
		end
	end
end

function HorseLocomotion:anim_cb_landing_to_onground()
	return
end

function HorseLocomotion:rpc_set_dead(impact_direction)
	self:set_dead(impact_direction)
end

function HorseLocomotion:set_dead(impact_direction)
	if self.current_state_name ~= "husk" then
		local rider = Unit.get_data(self.unit, "user_unit")

		if Unit.alive(rider) and ScriptUnit.has_extension(rider, "locomotion_system") then
			local rider_locomotion = ScriptUnit.extension(rider, "locomotion_system")

			rider_locomotion:stun("torso", impact_direction, "mount_dead", Vector3.dot(self:get_velocity(), Quaternion.forward(Unit.local_rotation(self.unit, 0))))
		end

		self:change_state("dead")
	end
end

function HorseLocomotion:get_velocity()
	return self.velocity:unbox()
end

function HorseLocomotion:rpc_animation_event(event)
	local unit = self.unit

	Unit.animation_event(unit, event)

	local rider = Unit.get_data(unit, "user_unit")

	if rider then
		Unit.animation_event(rider, event)
	end
end

function HorseLocomotion:steering()
	return self._steering
end

function HorseLocomotion:stun()
	return
end

function HorseLocomotion:damage_interrupt()
	return
end

function HorseLocomotion:received_damage()
	return
end

function HorseLocomotion:hurt_sound_event()
	return nil
end

function HorseLocomotion:has_perk()
	return false
end

function HorseLocomotion:rpc_animation_set_variable(index, variable)
	Unit.animation_set_variable(self.unit, index, variable)
end

function HorseLocomotion:hot_join_synch(sender, player)
	local unit = self.unit

	RPC.rpc_synch_horse_anim_state(sender, self.id, Unit.animation_get_state(unit))
end

function HorseLocomotion:teleport(position, rotation)
	if self.current_state_name ~= "husk" and self.current_state_name ~= "dead" then
		self.current_state:set_local_position(position)
		self.current_state:set_local_rotation(rotation)
		Mover.set_position(Unit.mover(self.unit), position)
	end
end
