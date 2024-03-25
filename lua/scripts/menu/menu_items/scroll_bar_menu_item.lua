-- chunkname: @scripts/menu/menu_items/scroll_bar_menu_item.lua

require("scripts/menu/menu_items/menu_item")

ScrollBarMenuItem = class(ScrollBarMenuItem, MenuItem)

function ScrollBarMenuItem:init(config, world)
	ScrollBarMenuItem.super.init(self, config, world)

	self._grid_top_visible_row = nil
	self._grid_num_visible_rows = nil
	self._grid_total_num_of_rows = nil
	self._min_handle_height = 4
end

function ScrollBarMenuItem:set_grid_properties(top_visible_row, num_visible_rows, total_num_of_rows)
	self._grid_top_visible_row = top_visible_row
	self._grid_num_visible_rows = num_visible_rows
	self._grid_total_num_of_rows = total_num_of_rows
end

function ScrollBarMenuItem:update_size(dt, t, gui, layout_settings, w, h, scroll_height)
	self._width = w
	self._height = h
	self._scroll_height = scroll_height
end

function ScrollBarMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function ScrollBarMenuItem:highlightable()
	return false
end

function ScrollBarMenuItem:render(dt, t, gui, layout_settings)
	if self._select_down then
		self._mouse_area_width = 200
		self._mouse_area_x = self._x - 100
	else
		self._mouse_area_width = nil
		self._mouse_area_x = nil
	end

	self._select_down = nil

	local c = layout_settings.background_color
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(self._width), math.floor(self._height)), color)

	if not self.config.disabled then
		local c = layout_settings.scroll_bar_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x + self._width / 2 - layout_settings.scroll_bar_width / 2), math.floor(self._y), self._z + 1), Vector2(math.floor(layout_settings.scroll_bar_width), math.floor(self._scroll_height)), color)

		local handle_height = math.max(self._grid_num_visible_rows / self._grid_total_num_of_rows * self._scroll_height, self._min_handle_height)
		local handle_x = self._x + self._width / 2 - layout_settings.scroll_bar_handle_width / 2
		local scrollable_rows = self._grid_total_num_of_rows - self._grid_num_visible_rows
		local handle_y = self._y + self._scroll_height - handle_height - (self._grid_top_visible_row - 1) / scrollable_rows * (self._scroll_height - handle_height)
		local c = layout_settings.scroll_bar_handle_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(handle_x), math.floor(handle_y), self._z + 2), Vector2(math.floor(layout_settings.scroll_bar_handle_width), math.floor(handle_height)), color)
	end
end

function ScrollBarMenuItem:on_select_down(mouse_pos)
	local handle_height = math.max(self._grid_num_visible_rows / self._grid_total_num_of_rows * self._scroll_height, self._min_handle_height)
	local mouse_y = math.clamp(mouse_pos.y, self._y + handle_height / 2, self._y + self._scroll_height - handle_height / 2)
	local offsey_y_percent = (self._y + self._scroll_height - handle_height / 2 - mouse_y) / (self._scroll_height - handle_height)
	local top_scrollable_row = self._grid_total_num_of_rows - self._grid_num_visible_rows + 1
	local top_row = math.clamp(math.ceil(offsey_y_percent * top_scrollable_row), 1, top_scrollable_row)
	local cb_select_down = callback(self.config.callback_object, self.config.on_select_down)

	cb_select_down(top_row)

	self._select_down = true
end

function ScrollBarMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "scroll_bar",
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		on_select_down = config.on_select_down,
		callback_object = callback_object,
		parent_page = config.parent_page,
		layout_settings = config.layout_settings,
		sounds = config.parent_page.config.sounds.items.scroll_bar
	}

	return ScrollBarMenuItem:new(config, compiler_data.world)
end
