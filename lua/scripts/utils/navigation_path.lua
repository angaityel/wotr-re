-- chunkname: @scripts/utils/navigation_path.lua

NavigationPath = class(NavigationPath)

function NavigationPath:init(name, path, callback)
	self._name = name
	self._path = {}
	self._current_index = 1
	self._callback = callback

	for i = 1, #path do
		self._path[i] = Vector3Box(path[i])
	end
end

function NavigationPath:name()
	return self._name
end

function NavigationPath:current()
	return self._path[self._current_index]:unbox()
end

function NavigationPath:last()
	return self._path[#self._path]:unbox()
end

function NavigationPath:advance()
	self._current_index = self._current_index + 1
end

function NavigationPath:is_last()
	return self._current_index == #self._path
end

function NavigationPath:reset()
	self._current_index = 1
end

function NavigationPath:reverse()
	table.reverse(self._path)
end

function NavigationPath:callback()
	return self._callback
end

function NavigationPath:draw()
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "nav_path"
	})

	drawer:reset()

	for _, node in ipairs(self._path) do
		drawer:sphere(node:unbox(), 0.25)
	end
end
