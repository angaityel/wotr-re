-- chunkname: @scripts/menu/menu_items/coat_of_arms_color_picker_menu_item.lua

CoatOfArmsColorPickerMenuItem = class(CoatOfArmsColorPickerMenuItem, MenuItem)

function CoatOfArmsColorPickerMenuItem:init(config, world)
	CoatOfArmsColorPickerMenuItem.super.init(self, config, world)
	self:set_selected(false)
end

function CoatOfArmsColorPickerMenuItem:set_selected(selected)
	self._selected = selected
end

function CoatOfArmsColorPickerMenuItem:selected()
	return self._selected
end

function CoatOfArmsColorPickerMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function CoatOfArmsColorPickerMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function CoatOfArmsColorPickerMenuItem:render(dt, t, gui, layout_settings)
	local color = self.config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color or self.config.color or {
		255,
		255,
		255,
		255
	}
	local texture = layout_settings.texture or self.config.texture
	local offset_x = self._highlighted and math.floor(layout_settings.texture_width) or 0
	local offset_y = self._highlighted and math.floor(layout_settings.texture_height) or 0
	local width = math.floor(layout_settings.texture_width) + offset_x * 2
	local height = math.floor(layout_settings.texture_height) + offset_y * 2
	local x = math.floor(self._x + layout_settings.padding_left) - offset_x
	local y = math.floor(self._y + layout_settings.padding_bottom) - offset_y
	local z = self._z + (self._highlighted and 2 or 1)

	Gui.bitmap(gui, texture, Vector3(x, y, z), Vector2(width, height), Color(color[1], color[2], color[3], color[4]))

	if self.config.color_2 then
		local c = self.config.color_2
		local color = Color(c[1], c[2], c[3], c[4])
		local offset_x = self._highlighted and math.floor(layout_settings.texture_2_width) or 0
		local offset_y = self._highlighted and math.floor(layout_settings.texture_2_height) or 0
		local texture_2_width = math.floor(layout_settings.texture_2_width) + offset_x * 2
		local texture_2_height = math.floor(layout_settings.texture_2_height) + offset_y * 2
		local x = math.floor(self._x + layout_settings.padding_left) - offset_x
		local y = math.floor(self._y + layout_settings.padding_bottom) - offset_y
		local z = self._z + (self._highlighted and 3 or 2)

		Gui.bitmap(gui, layout_settings.texture_2, Vector3(x, y, z), Vector2(texture_2_width, texture_2_height), color)
	end

	if self._selected and layout_settings.texture_selected_background then
		Gui.bitmap(gui, layout_settings.texture_selected_background, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z), Vector2(math.floor(layout_settings.texture_selected_background_width), math.floor(layout_settings.texture_selected_background_height)))
	end
end

function CoatOfArmsColorPickerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "coat_of_arms_color_picker",
		page = config.page,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		texture = config.texture,
		texture_2 = config.texture_2,
		color = config.color,
		color_2 = config.color_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.coat_of_arms_color_picker
	}

	return CoatOfArmsColorPickerMenuItem:new(config, compiler_data.world)
end
