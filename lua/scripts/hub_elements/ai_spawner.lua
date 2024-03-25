-- chunkname: @scripts/hub_elements/ai_spawner.lua

AISpawner = class(AISpawner)
AISpawner.SYSTEM = "spawner_system"

function AISpawner:init(world, unit)
	self._world = world
	self._unit = unit
	self._spawned_units = {}
	self._num_spawned_units = 0

	Managers.state.event:register(self, "event_round_started", "flow_cb_round_started")
	Managers.state.event:register(self, "ai_unit_died", "cb_unit_died")
end

function AISpawner:flow_cb_round_started()
	self:_parse_config()
end

function AISpawner:cb_unit_died(victim_unit, attacking_player)
	if self._spawned_units[victim_unit] then
		self._spawned_units[victim_unit] = nil
		self._num_spawned_units = self._num_spawned_units - 1

		local profile_name = Unit.get_data(victim_unit, "player_profile")

		self._spawned_profiles[profile_name] = self._spawned_profiles[profile_name] - 1

		Unit.set_flow_variable(self._unit, "lua_ai_unit", victim_unit)
		Unit.flow_event(self._unit, "lua_on_kill")

		if attacking_player.index == 1 then
			Unit.flow_event(self._unit, "lua_on_player_kill")
		end
	end
end

function AISpawner:on_activate()
	self._spawn_timer = Managers.state.entity_system.t
end

function AISpawner:on_deactivate()
	return
end

function AISpawner:_parse_config()
	self._level = LevelHelper:current_level(self._world)
	self._nav_mesh = Level.navigation_mesh(self._level)

	local player_name = Unit.get_data(self._unit, "player_name")

	fassert(player_name:len() > 0, "No 'player name' specified")

	self._player_name = player_name

	local spawn_area = Unit.get_data(self._unit, "spawn_area")

	fassert(spawn_area:len() > 0, "No spawn area specified")

	self._spawn_area = spawn_area

	local movement_area = Unit.get_data(self._unit, "movement_area")

	self._movement_area = movement_area:len() > 0 and movement_area or nil

	local profiles = Unit.get_data(self._unit, "ai_profiles")

	self._profiles = {}
	self._spawned_profiles = {}
	self._desired_amount = 0

	local MAX_PROFILES = 3

	for i = 1, MAX_PROFILES do
		local index = "ai_profile_" .. i
		local profile_string = Unit.get_data(self._unit, index)
		local profile_name, amount = string.match(profile_string, "([%S]+) (%d+)")

		if profile_name and amount then
			self._profiles[profile_name] = tonumber(amount)
			self._spawned_profiles[profile_name] = 0
			self._desired_amount = self._desired_amount + tonumber(amount)
		end
	end

	self._next_spawn_profile = next(self._profiles)

	local pool_size = tonumber(Unit.get_data(self._unit, "pool_size"))

	fassert(pool_size >= 0, "Pool size can't be negative")

	self._pool_size = pool_size == 0 and math.huge or pool_size

	local spawn_rate = tonumber(Unit.get_data(self._unit, "spawn_rate"))

	fassert(spawn_rate >= 0, "Spawn rate can't be negative")

	self._spawn_rate = spawn_rate
end

function AISpawner:_spawn_unit()
	while true do
		if self._spawned_profiles[self._next_spawn_profile] < self._profiles[self._next_spawn_profile] then
			break
		else
			self._next_spawn_profile = next(self._profiles, self._next_spawn_profile) or next(self._profiles)
		end
	end

	local profile_name = self._next_spawn_profile

	fassert(AIProfiles[profile_name], "AI profile %q doesn't exist", profile_name)

	local profile = table.clone(AIProfiles[profile_name])

	profile.properties.spawn_area = self._spawn_area
	profile.properties.movement_area = self._movement_area

	local spawn_pos

	for i = 1, 50 do
		local spawn_point

		if self._deterministic then
			self._seed, spawn_point = Level.next_random_point_inside_volume(self._level, self._spawn_area, self._seed)
		else
			spawn_point = Level.random_point_inside_volume(self._level, self._spawn_area)
		end

		local poly = NavigationMesh.find_polygon(self._nav_mesh, spawn_point)

		if poly then
			spawn_pos = NavigationMesh.project_to_polygon(self._nav_mesh, spawn_point, poly)

			break
		end
	end

	if spawn_pos == nil then
		print("[AISpawner] No valid spawn point found for area %q", self._spawn_area)

		return
	end

	local unit_name = Armours[profile.armour].ai_unit
	local spawn_rot = Unit.world_rotation(self._unit, 0)
	local ai_unit = World.spawn_unit(self._world, unit_name, spawn_pos, spawn_rot)

	Unit.set_data(ai_unit, "player_profile", profile_name)
	Managers.state.entity:register_unit(self._world, ai_unit, self._player_name, profile, self._unit)

	local locomotion = ScriptUnit.extension(ai_unit, "locomotion_system")
	local pose = Matrix4x4.from_quaternion_position(spawn_rot, spawn_pos)

	locomotion:set_pose(pose)

	if profile.mount then
		local unit_name = MountProfiles[profile.mount].unit
		local mount_unit = World.spawn_unit(self._world, unit_name, spawn_pos, spawn_rot)

		Unit.set_data(mount_unit, "mount_profile", profile.mount)
		Managers.state.entity:register_unit(self._world, mount_unit)
		locomotion:mount(mount_unit)
	end

	self._spawned_units[ai_unit] = true
	self._spawned_profiles[profile_name] = self._spawned_profiles[profile_name] + 1
	self._num_spawned_units = self._num_spawned_units + 1
	self._pool_size = self._pool_size - 1
	self._next_spawn_profile = next(self._profiles, self._next_spawn_profile) or next(self._profiles)

	Unit.set_flow_variable(self._unit, "lua_ai_unit", ai_unit)
	Unit.flow_event(self._unit, "lua_on_spawn")
end

function AISpawner:update(unit, input, dt, context, t)
	if t >= self._spawn_timer + self._spawn_rate then
		self._spawn_timer = t

		if self._pool_size > 0 and self._num_spawned_units < self._desired_amount then
			self:_spawn_unit()
		end
	end
end

function AISpawner:despawn()
	for unit, _ in pairs(self._spawned_units) do
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")
		local mounted_unit = locomotion.mounted_unit

		if Managers.state.network:game() then
			locomotion:destroy_game_objects()
		else
			Managers.state.entity:unregister_unit(unit)
			World.destroy_unit(self._world, unit)
		end

		self._spawned_units[unit] = nil

		if mounted_unit then
			Managers.state.entity:unregister_unit(mounted_unit)
			World.destroy_unit(self._world, mounted_unit)
		end
	end

	for profile_name, _ in pairs(self._spawned_profiles) do
		self._spawned_profiles[profile_name] = 0
	end

	self._num_spawned_units = 0
end

function AISpawner:kill()
	for unit, _ in pairs(self._spawned_units) do
		local damage = ScriptUnit.extension(unit, "damage_system")

		damage:die(unit)
	end

	for profile_name, _ in pairs(self._spawned_profiles) do
		self._spawned_profiles[profile_name] = 0
	end

	self._num_spawned_units = 0
end

function AISpawner:spawned_units()
	return self._spawned_units
end

function AISpawner:set_deterministic(deterministic, seed)
	self._deterministic = deterministic
	self._seed = seed
end

function AISpawner:destroy()
	return
end
