-- chunkname: @scripts/menu/menu_items/tab_menu_item.lua

require("scripts/menu/menu_items/menu_item")

TabMenuItem = class(TabMenuItem, MenuItem)

function TabMenuItem:init(config, world)
	TabMenuItem.super.init(self, config, world)
	self:set_selected(false)
end

function TabMenuItem:on_select(ignore_sound)
	self:set_selected(true)
	TabMenuItem.super.on_select(self, ignore_sound)
end

function TabMenuItem:on_deselect()
	self:set_selected(false)
end

function TabMenuItem:set_selected(selected)
	self._selected = selected
end

function TabMenuItem:selected()
	return self._selected
end

function TabMenuItem:set_text(text)
	self.config.text = text
end

function TabMenuItem:start_pulse(speed, alpha_min, alpha_max)
	self._pulse = {
		speed = speed,
		alpha_min = alpha_min,
		alpha_max = alpha_max
	}
end

function TabMenuItem:stop_pulse(speed, alpha_min, alpha_max)
	self._pulse = nil
end

function TabMenuItem:pulse()
	return self._pulse
end

function TabMenuItem:update_size(dt, t, gui, layout_settings)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, self.config.text, font, layout_settings.font_size)

	self._text_width = max[1] - min[1]

	local width = layout_settings.text_padding_left + self._text_width + layout_settings.text_padding_right

	self._width = math.max(width, layout_settings.min_width)
	self._height = layout_settings.height
end

function TabMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function TabMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	self:render(dt, t, gui, layout_settings)
end

function TabMenuItem:render(dt, t, gui, layout_settings)
	local config = self.config
	local texture_x, texture_y

	if layout_settings.texture_align == "left" then
		texture_x = math.floor(self._x)
		texture_y = math.floor(self._y)
	elseif layout_settings.texture_align == "right" then
		texture_x = math.floor(self._x + self._width - layout_settings.texture_width)
		texture_y = math.floor(self._y)
	end

	local texture = self._highlighted and layout_settings.texture_highlighted or layout_settings.texture
	local texture_c = config.disabled and layout_settings.texture_color_disabled or self._selected and layout_settings.texture_color_selected or self._highlighted and layout_settings.texture_color_highlighted or layout_settings.texture_color
	local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])

	Gui.bitmap(gui, texture, Vector3(texture_x, texture_y, self._z), Vector2(layout_settings.texture_width, layout_settings.texture_height), texture_color)

	local text_x, text_y

	if layout_settings.text_align == "left" then
		text_x = math.floor(self._x + layout_settings.text_padding_left)
		text_y = math.floor(self._y + layout_settings.text_offset_y)
	elseif layout_settings.text_align == "right" then
		text_x = math.floor(self._x + self._width - self._text_width - layout_settings.text_padding_right)
		text_y = math.floor(self._y + layout_settings.text_offset_y)
	end

	local text_c = config.disabled and layout_settings.text_color_disabled or self._selected and layout_settings.text_color_selected or self._highlighted and layout_settings.text_color_highlighted or layout_settings.text_color
	local text_color = Color(text_c[1], text_c[2], text_c[3], text_c[4])
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local shadow_color_table = self.config.disabled and layout_settings.drop_shadow_color_disabled or layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])

	ScriptGUI.text(gui, config.text, font, layout_settings.font_size, font_material, Vector3(text_x, text_y, self._z + 2), text_color, shadow_color, shadow_offset)

	if self._pulse and not self._highlighted then
		local texture = layout_settings.texture_pulse
		local amp = (self._pulse.alpha_max - self._pulse.alpha_min) / 2
		local off = self._pulse.alpha_min + amp
		local alpha = amp * math.cos(t * self._pulse.speed) + off

		Gui.bitmap(gui, texture, Vector3(texture_x, texture_y, self._z + 1), Vector2(layout_settings.texture_width, layout_settings.texture_height), Color(alpha, 255, 255, 255))
	end
end

function TabMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "tab",
		name = config.name,
		page = config.page,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		text = L(config.text),
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.tab
	}

	return TabMenuItem:new(config, compiler_data.world)
end
