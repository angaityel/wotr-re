-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_change_behaviour_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTChangeBehaviourAction = class(BTChangeBehaviour, BTNode)

function BTChangeBehaviourAction:init(...)
	BTChangeBehaviourAction.super.init(self, ...)
	fassert(self._data.slot, "No 'slot' set for node %q", self._name)
	fassert(self._data.behaviour, "No 'behavior' set for node %q", self._name)
end

function BTChangeBehaviourAction:setup(unit, blackboard, profile)
	self._slot_name = self._data.slot
	self._behaviour_name = self._data.behaviour
end

function BTChangeBehaviourAction:run(unit, blackboard, t, dt)
	local ai_system = ScriptUnit.extension(unit, "ai_system")

	ai_system:brain():change_behaviour(self._slot_name, self._behaviour_name)
end
