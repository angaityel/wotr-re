-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_alive_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitAliveCondition = class(BTUnitAliveCondition, BTCondition)

function BTUnitAliveCondition:init(...)
	BTUnitAliveCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitAliveCondition:accept(unit, blackboard, t, dt)
	local player = blackboard[self._input]
	local source_player = blackboard.players[player]

	return Unit.alive(player) and source_player == true
end
