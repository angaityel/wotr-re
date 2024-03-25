-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_node.lua

BTNode = class(BTNode)

function BTNode:init(name, parent, data, input, output)
	self._name = name
	self._parent = parent
	self._data = data
	self._input = input
	self._output = output
end

function BTNode:setup(unit, blackboard, profile)
	return
end

function BTNode:run(unit, blackboard, t, dt)
	ferror("This function should've been overridden in derived class")
end
