-- chunkname: @scripts/menu/menu_items/progress_bar_menu_item.lua

ProgressBarMenuItem = class(ProgressBarMenuItem, MenuItem)

function ProgressBarMenuItem:init(config, world)
	ProgressBarMenuItem.super.init(self, config, world)

	self._bar_value = 0
	self._bar_value_max = 0
end

function ProgressBarMenuItem:set_bar_data(data)
	self._bar_data = data
end

function ProgressBarMenuItem:update_size(dt, t, gui, layout_settings)
	local bar_data = self._bar_data

	self._offset_x = 0
	self._extra_width = 0

	if layout_settings.left_aligned and bar_data then
		local font = layout_settings.text_bar_font and layout_settings.text_bar_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.text_bar_font and layout_settings.text_bar_font.material or MenuSettings.fonts.menu_font.material

		if bar_data.left_text then
			local min, max = Gui.text_extents(gui, bar_data.left_text, font, layout_settings.text_sides_font_size)
			local width = max[1] - min[1]

			self._offset_x = width
			self._extra_width = self._extra_width + width
		end

		if bar_data.right_text then
			local min, max = Gui.text_extents(gui, bar_data.right_text, font, layout_settings.text_sides_font_size)
			local width = max[1] - min[1]

			self._extra_width = self._extra_width + width
		end
	end

	self._width = layout_settings.bar_width + (layout_settings.border_size * 2 or 0) + self._extra_width
	self._height = layout_settings.bar_height + (layout_settings.border_size * 2 or 0)
end

function ProgressBarMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x + self._offset_x
	self._y = y
	self._z = z
end

function ProgressBarMenuItem:render(dt, t, gui, layout_settings)
	local width = layout_settings.bar_width + (layout_settings.border_size * 2 or 0)

	if layout_settings.border_size then
		local c = layout_settings.border_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(width), math.floor(self._height)), color)
	end

	local c = layout_settings.texture_bar_bgr_color or {
		255,
		255,
		255,
		255
	}
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.bitmap(gui, layout_settings.texture_bar_bgr, Vector3(math.floor(self._x + (layout_settings.border_size or 0)), math.floor(self._y + (layout_settings.border_size or 0)), self._z + 1), Vector2(math.floor(layout_settings.bar_width), math.floor(layout_settings.bar_height)), color)

	local bar_data = self._bar_data

	if bar_data and bar_data.value and bar_data.value_max then
		local c = layout_settings.texture_bar_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])
		local bar_width = (bar_data.value - bar_data.value_min) / (bar_data.value_max - bar_data.value_min) * layout_settings.bar_width

		Gui.bitmap(gui, layout_settings.texture_bar, Vector3(math.floor(self._x + (layout_settings.border_size or 0)), math.floor(self._y + (layout_settings.border_size or 0)), self._z + 2), Vector2(math.floor(bar_width), math.floor(layout_settings.bar_height)), color)
	end

	if bar_data and bar_data.value then
		local font = layout_settings.text_bar_font and layout_settings.text_bar_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.text_bar_font and layout_settings.text_bar_font.material or MenuSettings.fonts.menu_font.material
		local c = layout_settings.text_bar_font_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])
		local progress_text = bar_data.value .. (bar_data.value_max and " / " .. bar_data.value_max or "") .. (self.config.text and " " .. L(self.config.text) or "")
		local min, max = Gui.text_extents(gui, progress_text, font, layout_settings.text_bar_font_size)
		local progress_text_width = max[1] - min[1]
		local progress_text_height = max[3] - min[3]
		local shadow_color = Color(layout_settings.text_bar_drop_shadow_color[1], layout_settings.text_bar_drop_shadow_color[2], layout_settings.text_bar_drop_shadow_color[3], layout_settings.text_bar_drop_shadow_color[4])
		local shadow_offset = layout_settings.text_bar_drop_shadow_offset and Vector2(layout_settings.text_bar_drop_shadow_offset[1], layout_settings.text_bar_drop_shadow_offset[2])

		ScriptGUI.text(gui, progress_text, font, layout_settings.text_bar_font_size, font_material, Vector3(math.floor(self._x + width / 2 - progress_text_width / 2), math.floor(self._y + layout_settings.text_bar_offset_y), self._z + 3), color, shadow_color, shadow_offset)
	end

	if bar_data and bar_data.left_text then
		local font = layout_settings.text_sides_font and layout_settings.text_sides_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.text_sides_font and layout_settings.text_sides_font.material or MenuSettings.fonts.menu_font.material
		local c = layout_settings.text_sides_font_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])
		local min, max = Gui.text_extents(gui, bar_data.left_text, font, layout_settings.text_sides_font_size)
		local text_width = max[1] - min[1]
		local text_height = max[3] - min[3]
		local shadow_color = Color(layout_settings.text_sides_drop_shadow_color[1], layout_settings.text_sides_drop_shadow_color[2], layout_settings.text_sides_drop_shadow_color[3], layout_settings.text_sides_drop_shadow_color[4])
		local shadow_offset = layout_settings.text_sides_drop_shadow_offset and Vector2(layout_settings.text_sides_drop_shadow_offset[1], layout_settings.text_sides_drop_shadow_offset[2])

		ScriptGUI.text(gui, bar_data.left_text, font, layout_settings.text_sides_font_size, font_material, Vector3(math.floor(self._x - text_width - layout_settings.text_sides_padding), math.floor(self._y + layout_settings.text_sides_offset_y), self._z + 3), color, shadow_color, shadow_offset)
	end

	if bar_data and bar_data.right_text then
		local font = layout_settings.text_sides_font and layout_settings.text_sides_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.text_sides_font and layout_settings.text_sides_font.material or MenuSettings.fonts.menu_font.material
		local c = layout_settings.text_sides_font_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])
		local min, max = Gui.text_extents(gui, bar_data.right_text, font, layout_settings.text_sides_font_size)
		local text_width = max[1] - min[1]
		local text_height = max[3] - min[3]
		local shadow_color = Color(layout_settings.text_sides_drop_shadow_color[1], layout_settings.text_sides_drop_shadow_color[2], layout_settings.text_sides_drop_shadow_color[3], layout_settings.text_sides_drop_shadow_color[4])
		local shadow_offset = layout_settings.text_sides_drop_shadow_offset and Vector2(layout_settings.text_sides_drop_shadow_offset[1], layout_settings.text_sides_drop_shadow_offset[2])

		ScriptGUI.text(gui, bar_data.right_text, font, layout_settings.text_sides_font_size, font_material, Vector3(math.floor(self._x + width + layout_settings.text_sides_padding), math.floor(self._y + layout_settings.text_sides_offset_y), self._z + 3), color, shadow_color, shadow_offset)
	end
end

function ProgressBarMenuItem:on_page_enter()
	ProgressBarMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_value then
		self._bar_data = self:_try_callback(self.config.callback_object, self.config.on_enter_value, unpack(self.config.on_enter_value_args or {}))
	end
end

function ProgressBarMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "progress_bar",
		page = config.page,
		name = config.name,
		text = config.text,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		callback_object = callback_object,
		on_enter_value = config.on_enter_value,
		on_enter_value_args = config.on_enter_value_args or {},
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.progress_bar
	}

	return ProgressBarMenuItem:new(config, compiler_data.world)
end
