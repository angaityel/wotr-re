-- chunkname: @scripts/menu/menu_items/texture_button_menu_item.lua

require("scripts/menu/menu_items/menu_item")

TextureButtonMenuItem = class(TextureButtonMenuItem, MenuItem)

function TextureButtonMenuItem:init(config, world)
	TextureButtonMenuItem.super.init(self, config, world)
end

function TextureButtonMenuItem:set_text(text)
	self.config.text = text
end

function TextureButtonMenuItem:start_pulse(speed)
	self._pulse = {
		speed = speed
	}
end

function TextureButtonMenuItem:stop_pulse()
	self._pulse = nil
end

function TextureButtonMenuItem:pulse()
	return self._pulse
end

function TextureButtonMenuItem:update_size(dt, t, gui, layout_settings)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, self.config.text, font, layout_settings.font_size)

	self._text_width = max[1] - min[1]
	self._width = layout_settings.padding_left + layout_settings.texture_left_width + (layout_settings.texture_forced_width or self._text_width) + layout_settings.text_padding * 2 + layout_settings.texture_right_width + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function TextureButtonMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x + (layout_settings.texture_offset_x or 0)
	self._y = y + (layout_settings.texture_offset_y or 0)
	self._z = z
end

function TextureButtonMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	self:render(dt, t, gui, layout_settings)
end

function TextureButtonMenuItem:render(dt, t, gui, layout_settings)
	local config = self.config
	local texture_c = config.disabled and layout_settings.texture_color_disabled or self._highlighted and layout_settings.texture_color_highlighted or layout_settings.texture_color
	local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])
	local texture_left_x = math.floor(self._x + layout_settings.padding_left)
	local texture_left_y = math.floor(self._y + layout_settings.padding_bottom)

	if self._highlighted and layout_settings.texture_left_highlighted then
		Gui.bitmap(gui, layout_settings.texture_left_highlighted, Vector3(texture_left_x, texture_left_y, self._z + 1), Vector2(layout_settings.texture_left_width, layout_settings.texture_height), texture_color)
	elseif layout_settings.texture_left then
		Gui.bitmap(gui, layout_settings.texture_left, Vector3(texture_left_x, texture_left_y, self._z + 1), Vector2(layout_settings.texture_left_width, layout_settings.texture_height), texture_color)
	end

	local texture_middle_x = math.floor(texture_left_x + layout_settings.texture_left_width)
	local texture_middle_y = math.floor(texture_left_y)
	local texture_middle_width = layout_settings.texture_forced_width or math.floor(self._text_width + layout_settings.text_padding * 2)

	if self._highlighted and layout_settings.texture_middle_highlighted then
		Gui.bitmap(gui, layout_settings.texture_middle_highlighted, Vector3(texture_middle_x, texture_middle_y, self._z + 1), Vector2(texture_middle_width, layout_settings.texture_height), texture_color)
	elseif not layout_settings.no_middle_texture then
		Gui.bitmap(gui, layout_settings.texture_middle, Vector3(texture_middle_x, texture_middle_y, self._z + 1), Vector2(texture_middle_width, layout_settings.texture_height), texture_color)
	end

	local texture_right_x = math.floor(texture_middle_x + texture_middle_width)
	local texture_right_y = math.floor(texture_middle_y)

	if self._highlighted and layout_settings.texture_right_highlighted then
		Gui.bitmap(gui, layout_settings.texture_right_highlighted, Vector3(texture_right_x, texture_right_y, self._z + 1), Vector2(layout_settings.texture_right_width, layout_settings.texture_height), texture_color)
	elseif layout_settings.texture_right then
		Gui.bitmap(gui, layout_settings.texture_right, Vector3(texture_right_x, texture_right_y, self._z + 1), Vector2(layout_settings.texture_right_width, layout_settings.texture_height), texture_color)
	end

	local pulse_color_multiplier = self._pulse and 0.5 * math.cos(t * self._pulse.speed) + 0.5 or 1
	local text_x = math.floor(texture_middle_x + texture_middle_width / 2 - self._text_width / 2 + (layout_settings.text_offset_x or 0))
	local text_y = math.floor(texture_middle_y + layout_settings.text_offset_y)
	local text_c = config.disabled and layout_settings.text_color_disabled or not (not self._pulse and not self._highlighted) and layout_settings.text_color_highlighted or layout_settings.text_color
	local text_color = Color(text_c[1], text_c[2] * pulse_color_multiplier, text_c[3] * pulse_color_multiplier, text_c[4] * pulse_color_multiplier)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local shadow_color_table = self.config.disabled and layout_settings.drop_shadow_color_disabled or self._highlighted and layout_settings.drop_shadow_color_highlighted or layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and not self._pulse and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])

	ScriptGUI.text(gui, config.text, font, layout_settings.font_size, font_material, Vector3(text_x, text_y, self._z + 2), text_color, shadow_color, shadow_offset)

	if layout_settings.texture_background then
		local texture_background_x = math.floor(self._x + layout_settings.texture_background_offset_x)
		local texture_background_y = math.floor(self._y + layout_settings.texture_background_offset_y)
		local texture_background_c = self.config.disabled and layout_settings.texture_background_color_disabled or layout_settings.texture_background_color or {
			255,
			255,
			255,
			255
		}
		local texture_background_color = Color(texture_background_c[1], texture_background_c[2], texture_background_c[3], texture_background_c[4])

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(texture_background_x, texture_background_y, self._z), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height), texture_background_color)
	end
end

function TextureButtonMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "texture_button",
		name = config.name,
		page = config.page,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		disabled = config.disabled,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		text = config.no_localization and config.text or L(config.text),
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture_button
	}

	return TextureButtonMenuItem:new(config, compiler_data.world)
end
