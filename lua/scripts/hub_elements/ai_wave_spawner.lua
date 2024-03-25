-- chunkname: @scripts/hub_elements/ai_wave_spawner.lua

AIWaveSpawner = class(AIWaveSpawner)
AIWaveSpawner.SYSTEM = "spawner_system"

require("scripts/settings/wave_configs")

function AIWaveSpawner:init(world, unit)
	self._world = world
	self._level = LevelHelper:current_level(world)
	self._nav_mesh = Level.navigation_mesh(self._level)
	self._unit = unit
	self._spawned_units = {}

	Managers.state.event:register(self, "event_round_started", "flow_cb_round_started")
	Managers.state.event:register(self, "ai_unit_died", "cb_unit_died")
end

function AIWaveSpawner:flow_cb_round_started()
	self:_parse_config()
end

function AIWaveSpawner:cb_unit_died(unit)
	if self._spawned_units[unit] then
		self._spawned_units[unit] = nil

		Level.trigger_event(self._level, self._on_kill_event_name)
	end
end

function AIWaveSpawner:on_activate()
	local t = Managers.time:time("game")

	self._wave_index = 0
	self._wave_stack = {}

	self:next_wave(t)
end

function AIWaveSpawner:next_wave(t)
	if script_data.wave_spawn_debug then
		print("[AIWaveSpawner] next_wave")
	end

	self._wave_index = self._wave_index % #self._wave_config + 1

	local wave_data = {
		current_node_index = 0,
		finished = false,
		index = self._wave_index,
		start_time = t
	}

	table.insert(self._wave_stack, wave_data)
	self:_next_wave_node(t, wave_data)
end

function AIWaveSpawner:_next_wave_node(t, wave_data)
	if script_data.wave_spawn_debug then
		print("[AIWaveSpawner] next_node")
	end

	local next_node = wave_data.current_node_index + 1
	local wave_index = wave_data.index
	local wave_node = self._wave_config[wave_index][next_node]

	if wave_node then
		wave_data.current_node_index = next_node
		wave_data.current_node_start = t

		self["_enter_node_" .. wave_node.type](self, t, wave_node, wave_data)
	else
		if script_data.wave_spawn_debug then
			print("[AIWaveSpawner] wave_finished")
		end

		wave_data.finished = true
	end
end

function AIWaveSpawner:update(unit, input, dt, context, t)
	local wave_stack = self._wave_stack

	for i = #wave_stack, 1, -1 do
		local wave_data = wave_stack[i]
		local wave = self._wave_config[wave_data.index]

		if not wave_data.finished then
			local node = wave[wave_data.current_node_index]

			self:_update_node(t, node, wave_data)
		end

		local next_wave = t - wave_data.start_time > wave.auto_next_wave

		if next_wave and wave_data.index == self._wave_index then
			self:next_wave(t)
		end

		if next_wave and wave_data.finished then
			table.remove(self._wave_stack, i)
		end
	end
end

function AIWaveSpawner:_update_node(t, node, wave_data)
	local node_type = node.type

	if node_type == "delay" then
		-- block empty
	elseif node_type == "spawn" then
		self:_update_spawn_node(t, node, wave_data)
	end

	if t > wave_data.current_node_start + node.duration then
		self:_next_wave_node(wave_data.current_node_start + node.duration, wave_data)
	end
end

function AIWaveSpawner:_enter_node_delay(t, node, wave_data)
	return
end

function AIWaveSpawner:_enter_node_spawn(t, node, wave_data)
	wave_data.node_data = {
		spawns = 0
	}
end

function AIWaveSpawner:_update_spawn_node(t, node, wave_data)
	local node_data = wave_data.node_data
	local lapsed_time = t - wave_data.current_node_start
	local expected_spawns = math.min(math.floor(node.amount * (lapsed_time / node.duration)), node.amount)
	local spawns_left = expected_spawns - node_data.spawns

	for i = 1, spawns_left do
		self:_spawn_unit(node.ai_profile)

		if script_data.wave_spawn_debug then
			print("[AIWaveSpawner] spawn", node_data.spawns + i, "/", node.amount)
		end
	end

	node_data.spawns = expected_spawns
end

function AIWaveSpawner:on_deactivate()
	return
end

function AIWaveSpawner:_parse_config()
	local player_name = Unit.get_data(self._unit, "player_name")

	fassert(player_name:len() > 0, "No 'player name' specified")

	self._player_name = player_name

	local spawn_area = Unit.get_data(self._unit, "spawn_area")

	fassert(spawn_area:len() > 0, "No spawn area specified")

	self._spawn_area = spawn_area
	self._wave_config = WaveConfigs[Unit.get_data(self._unit, "wave_config")]

	fassert(self._wave_config)

	self._on_spawn_event_name = Unit.get_data(self._unit, "on_spawn_event_name")
	self._on_kill_event_name = Unit.get_data(self._unit, "on_kill_event_name")
end

function AIWaveSpawner:_spawn_unit(profile_name)
	local profile = AIProfiles[profile_name]
	local unit_name = Armours[profile.armour].ai_unit
	local spawn_pos

	for i = 1, 50 do
		local spawn_point = Level.random_point_inside_volume(self._level, self._spawn_area)
		local poly = NavigationMesh.find_polygon(self._nav_mesh, spawn_point)

		if poly then
			spawn_pos = NavigationMesh.project_to_polygon(self._nav_mesh, spawn_point, poly)

			break
		end
	end

	if spawn_pos == nil then
		print("[AIWaveSpawner] No valid spawn point found for area %q", self._spawn_area)

		return
	end

	local spawn_rot = Unit.world_rotation(self._unit, 0)
	local player_unit = World.spawn_unit(self._world, unit_name, spawn_pos, spawn_rot)

	Unit.set_data(player_unit, "player_profile", profile_name)
	Managers.state.entity:register_unit(self._world, player_unit, self._player_name)

	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
	local pose = Matrix4x4.from_quaternion_position(spawn_rot, spawn_pos)

	locomotion:set_pose(pose)

	if profile.mount then
		local unit_name = MountProfiles[profile.mount].unit
		local mount_unit = World.spawn_unit(self._world, unit_name, spawn_pos, spawn_rot)

		Unit.set_data(mount_unit, "mount_profile", profile.mount)
		Managers.state.entity:register_unit(self._world, mount_unit)

		local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

		locomotion:mount(mount_unit)
	end

	self._spawned_units[player_unit] = true

	Level.set_flow_variable(self._level, self._on_spawn_event_name .. "_unit", player_unit)
	Level.trigger_event(self._level, self._on_spawn_event_name)
end

function AIWaveSpawner:despawn()
	for unit, _ in pairs(self._spawned_units) do
		if Unit.alive(unit) then
			Managers.state.entity:unregister_unit(unit)
			World.destroy_unit(self._world, unit)
		end

		self._spawned_units[unit] = nil
	end
end

function AIWaveSpawner:destroy()
	return
end
