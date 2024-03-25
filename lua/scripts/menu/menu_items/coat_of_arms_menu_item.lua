-- chunkname: @scripts/menu/menu_items/coat_of_arms_menu_item.lua

CoatOfArmsMenuItem = class(CoatOfArmsMenuItem, MenuItem)

function CoatOfArmsMenuItem:init(config, world)
	CoatOfArmsMenuItem.super.init(self, config, world)
	self:set_selected(false)
end

function CoatOfArmsMenuItem:set_selected(selected)
	self._selected = selected
end

function CoatOfArmsMenuItem:selected()
	return self._selected
end

function CoatOfArmsMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_background_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_background_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function CoatOfArmsMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function CoatOfArmsMenuItem:render(dt, t, gui, layout_settings)
	local offset_x = self._highlighted and layout_settings.texture_background_width / 2 or 0
	local offset_y = self._highlighted and layout_settings.texture_background_height / 2 or 0
	local offset_z = self._highlighted and 3 or 0
	local center_x = self._x + layout_settings.padding_left + layout_settings.texture_background_width / 2 - offset_x
	local center_y = self._y + layout_settings.padding_bottom + layout_settings.texture_background_height / 2 - offset_y
	local w, h = Gui.resolution()

	Gui.bitmap(gui, "clear_mask", Vector3(0, 0, 0), Vector2(w, h))

	if self._selected then
		Gui.bitmap(gui, layout_settings.texture_selected_background, Vector3(math.floor(center_x - layout_settings.texture_selected_background_width / 2), math.floor(center_y - layout_settings.texture_selected_background_height / 2), self._z + offset_z), Vector2(math.floor(layout_settings.texture_selected_background_width) + offset_x * 2, math.floor(layout_settings.texture_selected_background_height) + offset_y * 2))
	else
		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(center_x - layout_settings.texture_background_width / 2), math.floor(center_y - layout_settings.texture_background_height / 2), self._z + offset_z), Vector2(math.floor(layout_settings.texture_background_width) + offset_x * 2, math.floor(layout_settings.texture_background_height) + offset_y * 2))
	end

	Gui.bitmap(gui, layout_settings.texture_mask, Vector3(math.floor(center_x - layout_settings.texture_background_width / 2) - 1, math.floor(center_y - layout_settings.texture_background_height / 2) - 1, self._z + offset_z), Vector2(math.floor(layout_settings.texture_background_width) + offset_x * 2 + 2, math.floor(layout_settings.texture_background_height) + offset_y * 2 + 2))

	local position = Vector3(center_x - layout_settings.texture_width / 2, center_y - layout_settings.texture_height / 2, self._z + 2 + offset_z)
	local uv00 = Vector2(layout_settings.texture_atlas_settings.uv00[1], layout_settings.texture_atlas_settings.uv00[2])
	local uv11 = Vector2(layout_settings.texture_atlas_settings.uv11[1], layout_settings.texture_atlas_settings.uv11[2])
	local size = Vector2(layout_settings.texture_width, layout_settings.texture_width)
	local color = self.config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color or self.config.color or {
		255,
		255,
		255,
		255
	}

	Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, position, size + Vector2(offset_x * 2, offset_y * 2), Color(color[1], color[2], color[3], color[4]))

	if layout_settings.display_name then
		local font_size = self._highlighted and 28 or 16
		local font = self._highlighted and MenuSettings.fonts.hell_shark_28 or MenuSettings.fonts.hell_shark_16
		local min, max = Gui.text_extents(gui, layout_settings.display_name, font.font, font_size)
		local extents = {
			max[1] - min[1],
			max[3] - min[3]
		}

		Gui.text(gui, layout_settings.display_name, font.font, font_size, font.material, Vector3(center_x - extents[1] * 0.5 + offset_x, center_y - extents[2] * 0.4 + offset_y, self._z + 2 + offset_z), Color(255, 255, 255, 255))
	end
end

function CoatOfArmsMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "coat_of_arms",
		page = config.page,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		texture = config.texture,
		color = config.color,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.coat_of_arms
	}

	return CoatOfArmsMenuItem:new(config, compiler_data.world)
end
