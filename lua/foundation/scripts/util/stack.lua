-- chunkname: @foundation/scripts/util/stack.lua

Stack = class(Stack)

function Stack:init()
	self._stack = {}
end

function Stack:push(node)
	table.insert(self._stack, node)
end

function Stack:pop()
	return table.remove(self._stack)
end

function Stack:top()
	return self._stack[#self._stack]
end

function Stack:size()
	return #self._stack
end

function Stack:clear()
	self._stack = {}
end
