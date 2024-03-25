-- chunkname: @scripts/menu/menu_containers/drop_down_list_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

DropDownListMenuContainer = class(DropDownListMenuContainer, MenuContainer)

function DropDownListMenuContainer:init(items)
	DropDownListMenuContainer.super.init(self)

	self._items = items
end

function DropDownListMenuContainer:update_size(dt, t, gui, layout_settings)
	local width = 0
	local height = 0

	for i, item in ipairs(self._items) do
		item:update_size(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))

		height = height + item:height()

		if i < #self._items then
			-- block empty
		end

		if width < item:width() then
			width = item:width()
		end
	end

	self._width = width
	self._height = height
end

function DropDownListMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	local offset_x = layout_settings.offset_x
	local offset_y = self._height + layout_settings.offset_y

	for i, item in ipairs(self._items) do
		offset_y = offset_y - item:height()

		local item_x = x + offset_x
		local item_y = y + offset_y
		local item_z = z + 1

		item:update_position(dt, t, MenuHelper:layout_settings(item.config.layout_settings), item_x, item_y, item_z)
	end

	self._x = x + layout_settings.offset_x
	self._y = y + layout_settings.offset_y
	self._z = z
end

function DropDownListMenuContainer:render(dt, t, gui, layout_settings)
	local background_color = Color(layout_settings.background_color[1], layout_settings.background_color[2], layout_settings.background_color[3], layout_settings.background_color[4])

	Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(self._width), math.floor(self._height)), background_color)

	for i, item in ipairs(self._items) do
		item:render(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))
	end
end

function DropDownListMenuContainer.create_from_config(items)
	return DropDownListMenuContainer:new(items)
end
