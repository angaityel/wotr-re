-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_players_detected_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTPlayersDetectedCondition = class(BTPlayersDetectedCondition, BTCondition)

function BTPlayersDetectedCondition:init(...)
	BTPlayersDetectedCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTPlayersDetectedCondition:accept(unit, blackboard, t, dt)
	local players_detected = blackboard[self._input]
	local any_players_detected = players_detected ~= nil and table.size(players_detected) > 0 or false

	return any_players_detected
end
