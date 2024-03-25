-- chunkname: @scripts/unit_extensions/objectives/archery_target_objective.lua

ArcheryTargetObjective = class(ArcheryTargetObjective)
ArcheryTargetObjective.SYSTEM = "objective_system"

function ArcheryTargetObjective:init(world, unit)
	self._world = world
	self._unit = unit
	self._active = {}
	self._blackboard = {
		owner_team_side = "neutral",
		active_team_sides = {}
	}

	local current_level = LevelHelper:current_level(self._world)
	local level_unit_index = Level.unit_index(current_level, unit)

	Unit.set_data(unit, "level_unit_index", level_unit_index)
	Managers.state.event:register(self, "event_start_round", "event_start_round")

	self._target_actor = Unit.actor(unit, Unit.get_data(unit, "archery_target", "actor"))
	self._target_bullseye_node = Unit.node(unit, Unit.get_data(unit, "archery_target", "bullseye"))

	local areas = {}
	local position = Unit.world_position(unit, self._target_bullseye_node)
	local index = 1

	while Unit.has_data(unit, "archery_target", "score_areas", index) do
		local locator = Unit.get_data(unit, "archery_target", "score_areas", index, "locator")
		local node = Unit.node(unit, locator)
		local radius = Vector3.length(position - Unit.world_position(unit, node))
		local score = Unit.get_data(unit, "archery_target", "score_areas", index, "score")

		areas[index] = {
			radius = radius,
			score = score
		}
		index = index + 1
	end

	self._target_areas = areas
end

function ArcheryTargetObjective:objective(side)
	return "", -math.huge
end

function ArcheryTargetObjective:projectile_impact(player, actor, position, normal)
	local unit = self._unit
	local bullseye_node = self._target_bullseye_node
	local bullseye_rotation = Unit.world_rotation(unit, bullseye_node)
	local player_side = player and player.team and player.team.side

	if script_data.archery_target_debug then
		print(player_side)
		print(not self._active[player_side], self._target_actor ~= actor, Vector3.dot(normal, Quaternion.forward(bullseye_rotation)) < 0)
		table.dump(self._active)
	end

	if not self._active[player_side] or self._target_actor ~= actor or Vector3.dot(normal, Quaternion.forward(bullseye_rotation)) < 0 then
		return
	end

	if script_data.archery_target_debug then
		print("hit")
	end

	local up_vector = Quaternion.up(bullseye_rotation)
	local right_vector = Quaternion.right(bullseye_rotation)
	local bullseye_position = Unit.world_position(unit, bullseye_node)
	local diff_vector = position - bullseye_position
	local distance = math.sqrt(Vector3.dot(up_vector, diff_vector)^2 + Vector3.dot(right_vector, diff_vector)^2)

	for _, area in ipairs(self._target_areas) do
		if distance < area.radius then
			local score = area.score
			local unit = self._unit

			Unit.set_flow_variable(unit, "lua_side_name", player_side)
			Unit.set_flow_variable(unit, "lua_score", score)
			Unit.flow_event(unit, "lua_hit")

			return
		end
	end
end

function ArcheryTargetObjective:update(unit, input, dt, context)
	return
end

function ArcheryTargetObjective:event_start_round(params)
	self:_init_teams()
end

function ArcheryTargetObjective:destroy()
	return
end

function ArcheryTargetObjective:_init_teams()
	local teams = Managers.state.team:sides()

	for _, team in pairs(teams) do
		self._active[team] = false
	end
end

function ArcheryTargetObjective:active(team)
	return self._active[team]
end

function ArcheryTargetObjective:flow_cb_set_active(team_side, active)
	local no_active_before = true
	local no_active_after = true

	self._blackboard.active_team_sides[team_side] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if self._blackboard.active_team_sides[team_side] then
			no_active_after = false
		end

		if self._active[team_side] then
			no_active_before = false
		end
	end

	if active and no_active_before then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end

	self._active[team_side] = active
end
