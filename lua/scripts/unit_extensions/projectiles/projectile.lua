-- chunkname: @scripts/unit_extensions/projectiles/projectile.lua

require("scripts/helpers/weapon_helper")

Projectile = class(Projectile)
Projectile.SYSTEM = "projectile_system"

function Projectile:init(world, unit, owning_player_index, user_unit, weapon_unit, is_husk, game, projectile_name, firing_gear_name, exit_velocity, gravity_multiplier, damage_multiplier, properties_id)
	self._world = world
	self._unit = unit
	self._is_husk = is_husk
	self._game = game
	self._projectile_name = projectile_name
	self._firing_gear_name = firing_gear_name
	self._exit_velocity = Vector3Box(exit_velocity)
	self._velocity = Vector3Box(exit_velocity)
	self._exit_position = Vector3Box(Unit.world_position(unit, 0))
	self._damage = nil
	self._settings = WeaponHelper:attachment_settings(firing_gear_name, "projectile_head", projectile_name)
	self._time = 0
	self._properties = self:_translate_properties_id(properties_id)
	self._destroyed = false

	Unit.set_data(unit, "extension", self)
	self:set_active(true)

	self._gravity_multiplier = gravity_multiplier
	self._damage_multiplier = damage_multiplier

	Unit.set_data(unit, "user_unit", user_unit)

	if not self._is_husk then
		self._user_unit = user_unit
		self._weapon_unit = weapon_unit

		self:_init_raycast()
	end

	Managers.player:assign_unit_ownership(unit, owning_player_index)

	self._owner_id = owning_player_index

	self:_spawn_arrow_trail()
end

function Projectile:_spawn_arrow_trail(params)
	local unit = self._unit
	local owner = Managers.player:owner(unit)
	local particle

	if owner and not owner.remote then
		particle = self._settings.local_arrow_trail_particle
	else
		particle = self._settings.remote_arrow_trail_particle
	end

	local position_offset = Vector3(0, 0, 0)
	local rotation_offset = Quaternion.look(Vector3.up(), Vector3.up())

	self._arrow_trail_id = ScriptWorld.create_particles_linked(self._world, particle, unit, 0, "stop", Matrix4x4.from_quaternion_position(rotation_offset, position_offset))
end

function Projectile:_translate_properties_id(properties_id)
	local properties = {}
	local i = 1

	while properties_id > 0 do
		local result = properties_id % 2

		properties_id = (properties_id - result) / 2

		if result ~= 0 then
			properties[#properties + 1] = NetworkLookup.weapon_properties[i]
		end

		i = i + 1
	end

	return properties
end

function Projectile:user_unit()
	return self._user_unit
end

function Projectile:set_active(active)
	self._active = active
end

function Projectile:_init_raycast()
	local function raycast_result(hits)
		if hits and self._active then
			for _, hit in ipairs(hits) do
				if self:_raycast_result(unpack(hit)) then
					break
				end
			end
		end
	end

	local physics_world = World.physics_world(self._world)

	self._raycast = PhysicsWorld.make_raycast(physics_world, raycast_result, "all", "collision_filter", "ray_projectile")
end

function Projectile:update(unit, input, dt, context)
	self._time = self._time + dt

	if not self._active then
		return
	end

	self:_update_movement(unit, self._time, dt)
end

function Projectile:_update_movement(unit, t, dt)
	local p0 = Unit.world_position(unit, 0)
	local p1 = self:_position(t)
	local p2 = self:_position(t + Managers.time:mean_dt())

	self._velocity:store(p1 - p0)

	if not self._is_husk then
		self._raycast:cast(p0, Vector3.normalize(p2 - p0), Vector3.length(p2 - p0))

		if script_data.projectile_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "script_data.projectile_debug"
			})

			drawer:sphere(p0, 0.05, Color(125, 125, 125))
			drawer:vector(p0, p2 - p0)
			drawer:sphere(p2, 0.025, Color(255, 255, 255))
			drawer:sphere(p1, 0.0125, Color(0, 0, 0))
		end
	end

	Unit.set_local_position(unit, 0, p1)
	Unit.set_local_rotation(unit, 0, Quaternion.look(p1 - p0, Vector3.up()))
end

function Projectile:_position(t)
	local exit_position = self._exit_position:unbox()
	local exit_velocity = self._exit_velocity:unbox()
	local gravity = Vector3.z(ProjectileSettings.gravity:unbox()) * self._gravity_multiplier
	local x = Vector3.x(exit_position) + Vector3.x(exit_velocity) * t
	local y = Vector3.y(exit_position) + Vector3.y(exit_velocity) * t
	local z = Vector3.z(exit_position) + Vector3.z(exit_velocity) * t + gravity * t * t / 2

	return Vector3(x, y, z)
end

function Projectile:_raycast_result(position, distance, normal, actor)
	if not actor or self._destroyed then
		return
	end

	local hit_unit = Actor.unit(actor)

	if not Unit.alive(hit_unit) then
		return
	end

	hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

	if not Unit.alive(hit_unit) then
		return
	end

	if hit_unit == self._user_unit or hit_unit == self._weapon_unit or Unit.get_data(hit_unit, "user_unit") == self._user_unit then
		if script_data.projectile_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "script_data.projectile_debug"
			})

			drawer:sphere(position, 0.025, Color(0, 0, 125))
		end

		return false
	end

	self:set_active(false)

	local damage, damage_range_type, penetrated, target_type
	local impact_direction = Vector3.normalize(self._velocity:unbox())

	if Unit.get_data(hit_unit, "health") then
		damage, damage_range_type, penetrated = self:_calculate_damage(hit_unit, position, actor, normal, impact_direction)
	end

	local hit_archery_target = false
	local unit = self._unit
	local owner = Managers.player:owner(unit)

	if Unit.has_data(hit_unit, "archery_target") and owner then
		ScriptUnit.extension(hit_unit, "objective_system"):projectile_impact(owner, actor, position, normal)

		hit_archery_target = true
	end

	if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
		target_type = "character"
	elseif Unit.has_data(hit_unit, "gear_name") then
		local gear_settings = Gear[Unit.get_data(hit_unit, "gear_name")]
		local gear_user = Unit.get_data(hit_unit, "user_unit")

		if not Unit.alive(gear_user) then
			return
		end

		local gear_user_locomotion = ScriptUnit.extension(gear_user, "locomotion_system")

		if gear_user_locomotion.blocking and gear_user_locomotion.block_unit == hit_unit then
			target_type = "blocking_gear"
		else
			target_type = "gear"
		end
	else
		target_type = "prop"
	end

	local hit_zone = WeaponHelper:hit_zone(hit_unit, actor)

	self:_hit(hit_unit, position, actor, damage, penetrated, target_type, hit_zone, impact_direction, normal)

	if script_data.projectile_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "script_data.projectile_debug"
		})

		drawer:sphere(position, 0.025, Color(255, 0, 0))
		drawer:vector(position, normal * 0.2, Color(255, 0, 0))
	end

	if damage then
		self:_apply_damage(hit_unit, position, normal, actor, self._settings.damage_type, damage, damage_range_type, hit_zone, impact_direction)
	elseif owner and not hit_archery_target then
		Managers.state.stats_collector:weapon_missed(owner, self._firing_gear_name)
	end

	return true
end

function Projectile:_calculate_damage(victim_unit, position, actor, normal, impact_direction)
	Profiler.start("Projectile:_add_damage")

	local damage, damage_range_type, penetrated

	if Unit.get_data(victim_unit, "health") then
		local weapon_rotation = Unit.world_rotation(self._unit, 0)
		local weapon_velocity = Quaternion.forward(weapon_rotation) * Vector3.length(self._exit_velocity:unbox())
		local attacker_velocity = Vector3(0, 0, 0)
		local victim_velocity = WeaponHelper:locomotion_velocity(victim_unit)

		damage, damage_range_type, penetrated = WeaponHelper:calculate_projectile_damage(attacker_velocity, weapon_velocity, victim_velocity, self._firing_gear_name, self._unit, victim_unit, self._projectile_name, actor, position, normal, impact_direction, self._properties, self._damage_multiplier)
	end

	Profiler.stop()

	return damage, damage_range_type, penetrated
end

function Projectile:_apply_damage(victim_unit, position, normal, actor, damage_type, damage, damage_range_type, hit_zone, impact_direction)
	local range = Vector3.length(position - self._exit_position:unbox())
	local victim_position = Unit.world_position(victim_unit, 0)
	local player_manager = Managers.player
	local player_index = self._owner_id
	local player = player_manager:player_exists(player_index) and player_manager:player(player_index)

	WeaponHelper:add_damage(self._world, victim_unit, player, self._user_unit, damage_type, damage, position, normal, actor, damage_range_type, self._firing_gear_name, hit_zone, impact_direction, nil, true, range)

	for _, property in ipairs(self._properties) do
		if WeaponHelper:damage_over_time_property(property) and damage > 0 then
			WeaponHelper:add_damage_over_time(self._world, victim_unit, player, property, range)
		end
	end
end

function Projectile:_hit(hit_unit, position, actor, damage, penetrated, target_type, hit_zone, impact_direction, normal)
	local unit = self._unit
	local network_manager = Managers.state.network

	if (target_type == "character" or target_type == "gear" or target_type == "blocking_gear") and not penetrated then
		Managers.state.projectile:drop_projectile(hit_unit, position, Unit.world_rotation(self._unit, 0), damage or 0, penetrated or false, target_type, self._unit, true, hit_zone, impact_direction, normal)
	else
		local actor_node = Actor.node(actor)
		local hit_node_rot = Unit.world_rotation(hit_unit, actor_node)
		local hit_node_pos = Unit.world_position(hit_unit, actor_node)
		local projectile_pos = position + Vector3.normalize(self._velocity:unbox()) * 0.15
		local projectile_rot = Unit.local_rotation(self._unit, 0)
		local rel_pos = projectile_pos - hit_node_pos
		local local_pos = Vector3(Vector3.dot(Quaternion.right(hit_node_rot), rel_pos), Vector3.dot(Quaternion.forward(hit_node_rot), rel_pos), Vector3.dot(Quaternion.up(hit_node_rot), rel_pos))
		local local_rot = Quaternion.multiply(Quaternion.inverse(hit_node_rot), projectile_rot)
		local static = target_type ~= "character" and target_type ~= "gear" and target_type ~= "blocking_gear"
		local hit_pos = static and projectile_pos or local_pos
		local max_pos

		if Managers.state.network:game() then
			max_pos = NetworkConstants.position.max
		else
			max_pos = math.huge
		end

		if max_pos <= math.abs(hit_pos.x) or max_pos <= math.abs(hit_pos.y) or max_pos <= math.abs(hit_pos.z) then
			Managers.state.projectile:drop_projectile(hit_unit, position, Unit.world_rotation(self._unit, 0), damage or 0, penetrated or false, target_type, self._unit, true, hit_zone, impact_direction, normal)
		else
			Managers.state.projectile:link_projectile(hit_unit, actor_node, hit_pos, static and projectile_rot or local_rot, damage or 0, penetrated or false, target_type, self._unit, true, hit_zone, impact_direction, normal)
		end
	end
end

function Projectile:link_projectile(hit_unit, actor_node, local_pos, local_rot, damage, penetrated, target_type, hit_zone, impact_direction, normal)
	local unit = self._unit

	if target_type == "character" or target_type == "gear" or target_type == "blocking_gear" then
		World.link_unit(self._world, unit, 0, hit_unit, actor_node)
	end

	Unit.set_local_position(unit, 0, local_pos)
	Unit.set_local_rotation(unit, 0, local_rot)
	World.update_unit(self._world, unit)

	local collision_actor = Unit.actor(unit, "projectile_collision")

	Actor.set_scene_query_enabled(collision_actor, false)
	Actor.set_collision_enabled(collision_actor, false)
	Unit.flow_event(unit, "lua_projectile_linked")

	local position = Unit.world_position(unit, 0)
	local rotation = Unit.world_rotation(unit, 0)
	local player_index = Managers.state.network:temp_player_index(self._owner_id)
	local player = Managers.player:player(player_index)
	local stun = self:_stun(player, hit_unit)

	WeaponHelper:projectile_impact(self._world, hit_unit, self._unit, player, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal, stun)

	if self._settings.kill_effect then
		World.destroy_particles(self._world, self._arrow_trail_id)
	else
		World.stop_spawning_particles(self._world, self._arrow_trail_id)
	end
end

function Projectile:_stun(own_player, hit_unit)
	local hit_unit_owner = Managers.player:owner(hit_unit)
	local properties = self._settings.properties

	if own_player and hit_unit_owner and hit_unit_owner.team ~= own_player.team and properties and (properties.stun or table.contains(properties, "stun")) then
		return true
	else
		return false
	end
end

function Projectile:drop_projectile(hit_unit, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal)
	local unit = self._unit
	local projectile_table = Unit.get_data(hit_unit, "linked_dummy_projectiles") or {}

	projectile_table[#projectile_table + 1] = unit

	Unit.set_data(hit_unit, "linked_dummy_projectiles", projectile_table)

	local actor = Unit.actor(unit, "c_dynamic")
	local physics_world = World.physics_world(self._world)

	Actor.set_kinematic(actor, false)
	Actor.teleport_position(actor, position)
	Actor.teleport_rotation(actor, rotation)

	local collision_actor = Unit.actor(unit, "projectile_collision")

	Actor.set_scene_query_enabled(collision_actor, false)
	Actor.set_collision_enabled(collision_actor, false)

	local player_index = Managers.state.network:temp_player_index(self._owner_id)
	local player = Managers.player:player(player_index)
	local stun = self:_stun(player, hit_unit)

	WeaponHelper:projectile_impact(self._world, hit_unit, self._unit, player, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal, stun)

	if self._settings.kill_effect then
		World.destroy_particles(self._world, self._arrow_trail_id)
	else
		World.stop_spawning_particles(self._world, self._arrow_trail_id)
	end
end

function Projectile:destroy()
	local unit = self._unit

	if Managers.player:owner(unit) then
		Managers.player:relinquish_unit_ownership(unit)
	end

	local network_manager = Managers.state.network

	if not self._is_husk and network_manager:game() then
		local object_id = network_manager:game_object_id(unit)

		network_manager:destroy_game_object(object_id)
	end

	self._raycast = nil
	self._destroyed = true
end
