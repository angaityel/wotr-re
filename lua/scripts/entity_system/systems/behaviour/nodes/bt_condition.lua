-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTCondition = class(BTCondition, BTNode)

function BTCondition:init(...)
	BTCondition.super.init(self, ...)
end

function BTCondition:setup(unit, blackboard, profile)
	fassert(self._child, "No child node found for node %q", self._name)
	self._child:setup(unit, blackboard, profile)

	self._negate = self._data and self._data.negate or false
end

function BTCondition:accept(unit, blackboard, t, dt)
	ferror("This function should've been overridden in derived class")
end

function BTCondition:run(unit, blackboard, t, dt)
	local result

	if self._negate then
		result = not self:accept(unit, blackboard, t, dt)
	else
		result = self:accept(unit, blackboard, t, dt)
	end

	if result then
		local child_result = self._child:run(unit, blackboard, t, dt)

		if self._child.accept then
			result = result and child_result
		end
	end

	return result
end

function BTCondition:add_child(child_node)
	self._child = child_node
end
