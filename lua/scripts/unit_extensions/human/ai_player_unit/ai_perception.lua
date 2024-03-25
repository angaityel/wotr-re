-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_perception.lua

AIPerception = class(AIPerception)

function AIPerception:init(world, unit, blackboard, config)
	self._physics_world = World.physics_world(world)
	self._unit = unit
	self._blackboard = blackboard
	self._blackboard.players = {}
	self._config = config
	self._scan_callback = callback(self, "_scan")
	self._overlap_callback = callback(self, "cb_overlap_result")
end

function AIPerception:set_config(params)
	if params.radius then
		self._config.radius = params.radius
	end

	if params.filter then
		self._config.filter = params.filter
	end
end

function AIPerception:update(t, dt)
	Profiler.start("AIPerception")
	Managers.state.ai_resource:add_job(self._scan_callback)

	for player_unit, _ in pairs(self._blackboard.players) do
		self._blackboard.players[player_unit] = Unit.alive(player_unit) == true or nil
	end

	Profiler.stop()
end

function AIPerception:_scan()
	if Unit.alive(self._unit) then
		local unit_pos = Unit.local_position(self._unit, 0)

		PhysicsWorld.overlap(self._physics_world, self._overlap_callback, "position", unit_pos, "size", self._config.radius, "types", "dynamics", "collision_filter", self._config.filter)
	end
end

function AIPerception:cb_overlap_result(actors)
	if not Unit.alive(self._unit) then
		return
	end

	local unit_pos = Unit.world_position(self._unit, Unit.node(self._unit, "Head"))

	for _, actor in ipairs(actors) do
		local player_unit = Actor.unit(actor)

		if player_unit ~= self._unit and ScriptUnit.has_extension(player_unit, "damage_system") then
			local player_unit_pos = Unit.world_position(player_unit, Unit.node(self._unit, "Head"))
			local offset = player_unit_pos - unit_pos
			local raycast_dir = Vector3.normalize(offset)
			local raycast_length = Vector3.length(offset)
			local callback = callback(self, "cb_raycast_result", player_unit)
			local raycast = self._physics_world:make_raycast(callback, "any", "types", "statics", "collision_filter", "ai_line_of_sight_check")

			Raycast.cast(raycast, unit_pos, raycast_dir, raycast_length)
		end
	end
end

function AIPerception:cb_raycast_result(player_unit, hit)
	self._blackboard.players[player_unit] = hit == false or nil
end
