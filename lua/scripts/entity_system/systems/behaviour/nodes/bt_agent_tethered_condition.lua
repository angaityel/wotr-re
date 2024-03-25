-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_agent_tethered_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTAgentTetheredCondition = class(BTAgentTetheredCondition, BTCondition)

function BTAgentTetheredCondition:init(...)
	BTAgentTetheredCondition.super.init(self, ...)
end

function BTAgentTetheredCondition:setup(unit, blackboard, profile)
	BTAgentTetheredCondition.super.setup(self, unit, blackboard, profile)

	self._ai_props = profile.properties
end

function BTAgentTetheredCondition:accept(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	return self._ai_props.tethered and not locomotion.in_movement_area and locomotion.tether_timer <= 0
end
