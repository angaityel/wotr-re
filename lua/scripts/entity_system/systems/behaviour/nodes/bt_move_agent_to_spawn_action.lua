-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_move_agent_to_spawn_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMoveAgentToSpawnAction = class(BTMoveAgentToSpawnAction, BTNode)

function BTMoveAgentToSpawnAction:init(...)
	BTMoveAgentToSpawnAction.super.init(self, ...)

	self._random_spawn_pos = Vector3Box()
end

function BTMoveAgentToSpawnAction:setup(unit, blackboard, profile)
	self._ai_props = profile.properties

	self:_randomize_spawn_pos(blackboard)
end

function BTMoveAgentToSpawnAction:_randomize_spawn_pos(blackboard)
	local level = LevelHelper:current_level(blackboard.world)
	local nav_mesh = Level.navigation_mesh(level)
	local spawn_area = self._ai_props.spawn_area
	local random_spawn_pos = Level.random_point_inside_volume(level, spawn_area)
	local poly = NavigationMesh.find_polygon(nav_mesh, random_spawn_pos)

	if poly then
		local projected_pos = NavigationMesh.project_to_polygon(nav_mesh, random_spawn_pos, poly)

		self._spawn_area = spawn_area

		self._random_spawn_pos:store(projected_pos)
	else
		printf("No navigation mesh found in spawn area %q position %s", spawn_area, tostring(random_spawn_pos))
	end
end

function BTMoveAgentToSpawnAction:run(unit, blackboard, t, dt)
	local spawn_area = self._ai_props.spawn_area

	if self._spawn_area ~= spawn_area then
		self:_randomize_spawn_pos(blackboard)
	end

	local ai_base = ScriptUnit.extension(unit, "ai_system")
	local random_spawn_pos = self._random_spawn_pos:unbox()

	ai_base:navigation():move_to(random_spawn_pos)
end
