-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_process_move_orders_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTProcessMoveOrdersAction = class(BTProcessMoveOrdersAction, BTNode)

function BTProcessMoveOrdersAction:init(...)
	BTProcessMoveOrdersAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTProcessMoveOrdersAction:run(unit, blackboard, t, dt)
	if blackboard.move_to then
		blackboard.move_to = nil
		self._current_goal = nil

		return
	end

	local move_orders = blackboard[self._input]
	local goal, command = next(move_orders)

	if goal ~= nil and goal ~= self._current_goal then
		local ai_base = ScriptUnit.extension(unit, "ai_system")
		local callback = callback(self, "_command_finished", unit, blackboard, goal, command)

		if command.name == "follow" then
			ai_base:navigation():follow_spline(goal, callback)
		elseif command.name == "patrol" then
			ai_base:navigation():patrol_spline(goal)
		elseif command.name == "move" then
			ai_base:navigation():move_to_unit(goal, callback)
		end

		self._current_goal = goal
	else
		return false
	end
end

function BTProcessMoveOrdersAction:_command_finished(unit, blackboard, goal, command)
	local move_orders = blackboard[self._input]

	move_orders[goal] = nil
	self._current_goal = nil

	local world = blackboard.world
	local level = LevelHelper:current_level(world)

	if command.finish_event then
		Level.set_flow_variable(level, command.finish_event .. "_unit", unit)
		Level.trigger_event(level, command.finish_event)
	end
end
