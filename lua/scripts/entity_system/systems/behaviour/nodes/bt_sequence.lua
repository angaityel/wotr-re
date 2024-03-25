-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_sequence.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSequence = class(BTSequence, BTNode)

function BTSequence:init(...)
	BTSequence.super.init(self, ...)

	self._children = {}
end

function BTSequence:setup(unit, blackboard, profile)
	for _, child_node in ipairs(self._children) do
		child_node:setup(unit, blackboard, profile)
	end

	if self._data then
		self._ignore_child_result = self._data.ignore_child_result
	end
end

function BTSequence:run(unit, blackboard, t, dt)
	for _, child_node in ipairs(self._children) do
		local success = child_node:run(unit, blackboard, t, dt)

		if not self._ignore_child_result and success == false then
			return false
		end
	end

	return true
end

function BTSequence:add_child(node)
	self._children[#self._children + 1] = node
end
