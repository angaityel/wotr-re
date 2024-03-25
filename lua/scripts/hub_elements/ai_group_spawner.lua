-- chunkname: @scripts/hub_elements/ai_group_spawner.lua

AIGroupSpawner = class(AIGroupSpawner)
AIGroupSpawner.SYSTEM = "spawner_system"

function AIGroupSpawner:init(world, unit)
	self._world = world
	self._level = LevelHelper:current_level(world)
	self._unit = unit
	self._active = false

	self:_parse_config()
	Managers.state.event:register(self, "event_round_started", "flow_cb_round_started")
	Managers.state.event:register(self, "unit_in_group_died", "cb_unit_in_group_died")
end

function AIGroupSpawner:flow_cb_round_started()
	return
end

function AIGroupSpawner:cb_unit_in_group_died(unit)
	local group = Managers.state.group:group(self._player_name, self._group_name)

	if group:num_members() == 0 and self._respawn and self._active then
		self:_spawn_group()
	end
end

function AIGroupSpawner:on_activate()
	self._active = true

	self:_spawn_group()
end

function AIGroupSpawner:on_deactivate()
	self._active = false
end

function AIGroupSpawner:_parse_config()
	local spawn_area = Unit.get_data(self._unit, "spawn_area")

	fassert(spawn_area:len() > 0, "No spawn area specified")

	self._spawn_area = spawn_area

	local profile_name = Unit.get_data(self._unit, "ai_profile")
	local profile = AIProfiles[profile_name]

	fassert(profile, "AI profile %q does not exist", profile_name)

	self._profile_name = profile_name

	local num_members = tonumber(Unit.get_data(self._unit, "num_members"))

	fassert(num_members >= 1, "Number of group members must be >= 1")

	self._num_members = num_members

	local player_name = Unit.get_data(self._unit, "player_name")

	fassert(player_name:len() > 0, "No 'player name' specified")

	self._player_name = player_name

	local group_name = Unit.get_data(self._unit, "group_name")

	fassert(group_name:len() > 0, "No 'group name' specified")

	self._group_name = group_name

	local respawn = Unit.get_data(self._unit, "respawn")

	self._respawn = respawn

	local on_spawn_event_name = Unit.get_data(self._unit, "on_spawn_event_name")

	self._on_spawn_event_name = on_spawn_event_name:len() > 0 and on_spawn_event_name or nil
end

function AIGroupSpawner:_spawn_group()
	local profile = AIProfiles[self._profile_name]
	local unit_name = Armours[profile.armour].ai_unit
	local spawn_pos = Level.random_point_inside_volume(self._level, self._spawn_area)
	local spawn_rot = Unit.world_rotation(self._unit, 0)
	local spawn_pose = Matrix4x4.from_quaternion_position(spawn_rot, spawn_pos)
	local group = Managers.state.group:group(self._player_name, self._group_name)

	group:locomotion():set_pose(spawn_pose)

	for i = 1, self._num_members do
		local unit = group:spawn_in(self._world, unit_name)

		Unit.set_data(unit, "player_profile", self._profile_name)
		Unit.set_data(unit, "behaviour", self._behaviour)
		Managers.state.entity:register_unit(self._world, unit, self._player_name)
	end

	if self._on_spawn_event_name then
		Level.trigger_event(self._level, self._on_spawn_event_name)
	end
end

function AIGroupSpawner:update(unit, input, dt, context, t)
	return
end

function AIGroupSpawner:destroy()
	return
end
