-- chunkname: @scripts/menu/menu_containers/menu_container.lua

MenuContainer = class(MenuContainer)

function MenuContainer:init()
	self._width = 0
	self._height = 0
	self._x = 0
	self._y = 0
end

function MenuContainer:width()
	return self._width
end

function MenuContainer:height()
	return self._height
end

function MenuContainer:x()
	return self._x
end

function MenuContainer:y()
	return self._y
end

function MenuContainer:z()
	return self._z
end

function MenuContainer:destroy()
	return
end
