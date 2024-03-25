-- chunkname: @scripts/menu/menu_items/text_menu_item.lua

require("scripts/menu/menu_items/menu_item")

TextMenuItem = class(TextMenuItem, MenuItem)

function TextMenuItem:init(config, world)
	TextMenuItem.super.init(self, config, world)
	self:set_selected(false)
end

function TextMenuItem:on_select(ignore_sound)
	if self.config.toggle_selection then
		self:set_selected(not self._selected)
	else
		self:set_selected(true)
	end

	TextMenuItem.super.on_select(self, ignore_sound)
end

function TextMenuItem:on_deselect()
	self:set_selected(false)
end

function TextMenuItem:set_selected(selected)
	self._selected = selected
end

function TextMenuItem:selected()
	return self._selected
end

function TextMenuItem:set_text(text)
	self.config.text = text
end

function TextMenuItem:update(dt, t)
	if self:visible() and self.config.on_update_text then
		self.config.text = self:_try_callback(self.config.callback_object, self.config.on_update_text, unpack(self.config.on_update_text_args or {}))
	end
end

function TextMenuItem:update_size(dt, t, gui, layout_settings)
	self:update(dt, t)

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, self.config.text, font, layout_settings.font_size)

	self._width = max[1] - min[1] + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.line_height + layout_settings.padding_top + layout_settings.padding_bottom
	self._min_x = min[1]

	TextMenuItem.super.update_size(self, dt, t, gui)
end

function TextMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	TextMenuItem.super.update_position(self, dt, t)
end

function TextMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	local z = self._z + (layout_settings.offset_z or 0)

	if layout_settings.texture_disabled and self.config.disabled then
		local x, y

		if layout_settings.texture_alignment == "left" then
			x = self._x + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_disabled_width / 2 + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_disabled_width + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		end

		local c = layout_settings.texture_color_render_from_child_page
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.bitmap(gui, layout_settings.texture_disabled, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_disabled_width, layout_settings.texture_disabled_height), color)
	end

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = self.config.color or layout_settings.color_render_from_child_page
	local color = Color(c[1], c[2], c[3], c[4])

	ScriptGUI.text(gui, self.config.text, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + layout_settings.padding_left - self._min_x), math.floor(self._y + layout_settings.padding_bottom), z + 1), color)
end

function TextMenuItem:render(dt, t, gui, layout_settings)
	if self.config.no_render_outside_screen and MenuHelper.is_outside_screen(self._x, self._y, self._width, self._height, 10) then
		return
	end

	local z = self._z + (layout_settings.offset_z or 0)
	local pulse_alpha

	if layout_settings.pulse_speed then
		local amp = (layout_settings.pulse_alpha_max - layout_settings.pulse_alpha_min) / 2
		local off = layout_settings.pulse_alpha_min + amp

		pulse_alpha = amp * math.cos(t * layout_settings.pulse_speed) + off
	end

	local x, y

	if layout_settings.texture_highlighted and self._highlighted then
		if layout_settings.texture_alignment == "left" then
			x = self._x + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_highlighted_width / 2 + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_highlighted_width + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2 + (layout_settings.texture_offset_y or 0)
		end

		local texture_c = layout_settings.texture_highlighted_color or {
			255,
			255,
			255,
			255
		}
		local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])

		Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_highlighted_width, layout_settings.texture_highlighted_height), texture_color)
	elseif layout_settings.texture_disabled and self.config.disabled then
		if layout_settings.texture_alignment == "left" then
			x = self._x + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_disabled_width / 2 + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_disabled_width + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		end

		local texture_c = layout_settings.texture_disabled_color or {
			255,
			255,
			255,
			255
		}
		local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])

		x = math.floor(x)
		y = self.config.not_pixel_perfect_y and y or math.floor(y)

		Gui.bitmap(gui, layout_settings.texture_disabled, Vector3(x, y, z), Vector2(layout_settings.texture_disabled_width, layout_settings.texture_disabled_height), texture_color)
	elseif layout_settings.texture then
		if layout_settings.texture_alignment == "left" then
			x = self._x + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_width / 2 + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_height / 2 + (layout_settings.texture_offset_y or 0)
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_width + (layout_settings.texture_offset_x or 0)
			y = self._y + self._height / 2 - layout_settings.texture_height / 2 + (layout_settings.texture_offset_y or 0)
		end

		local texture_c = layout_settings.texture_color or {
			255,
			255,
			255,
			255
		}
		local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])

		Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_width, layout_settings.texture_height), texture_color)
	end

	if IS_DEMO and self.config.demo_icon then
		local w, h = Gui.resolution()
		local pos = Vector3(math.floor(self._x) + self._width, math.floor(self._y), self._z)
		local demo_color = Color(255, layout_settings.demo_color[1], layout_settings.demo_color[2], layout_settings.demo_color[3])

		Gui.bitmap(gui, layout_settings.texture_unavalible_demo, pos, Vector2(layout_settings.texture_unavalible_width, layout_settings.texture_unavalible_height))
		Gui.text(gui, L("menu_demo_text"), layout_settings.demo_font.font, layout_settings.demo_font_size, layout_settings.demo_font.material, pos + Vector3(layout_settings.texture_unavalible_width * 0.8, layout_settings.texture_unavalible_height * 0.5, 1), demo_color)
		Gui.text(gui, L("menu_demo_text"), layout_settings.demo_font.font, layout_settings.demo_font_size, layout_settings.demo_font.material, pos + Vector3(layout_settings.texture_unavalible_width * 0.8 + 2, layout_settings.texture_unavalible_height * 0.5 - 2, 0), Color(15, 15, 15))
	end

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = self.config.color or self.config.disabled and layout_settings.color_disabled or self._selected and layout_settings.color_selected or self._highlighted and layout_settings.color_highlighted or layout_settings.color
	local color = Color(pulse_alpha or c[1], c[2], c[3], c[4])
	local shadow_color_table = self.config.disabled and layout_settings.drop_shadow_color_disabled or layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local x = math.floor(self._x + layout_settings.padding_left - self._min_x)
	local y = self._y + layout_settings.padding_bottom

	if not self.config.not_pixel_perfect_y then
		y = math.floor(y)
	end

	ScriptGUI.text(gui, self.config.text, font, layout_settings.font_size, font_material, Vector3(x, y, z + 1), color, shadow_color, shadow_offset)
	TextMenuItem.super.render(self, dt, t, gui)
end

function TextMenuItem:on_page_enter()
	TextMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_text then
		self.config.text = self:_try_callback(self.config.callback_object, self.config.on_enter_text, unpack(self.config.on_enter_text_args or {}))
	end
end

function TextMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "text",
		page = config.page,
		name = config.name,
		demo_icon = config.demo_icon,
		disabled = config.disabled,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_enter_text = config.on_enter_text,
		on_enter_text_args = config.on_enter_text_args or {},
		on_update_text = config.on_update_text,
		on_update_text_args = config.on_update_text_args or {},
		toggle_selection = config.toggle_selection,
		text = config.no_localization and config.text or L(config.text),
		color = config.color,
		tooltip_text = config.tooltip_text,
		tooltip_text_2 = config.tooltip_text_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		floating_tooltip = config.floating_tooltip,
		not_pixel_perfect_y = config.not_pixel_perfect_y,
		no_render_outside_screen = config.no_render_outside_screen,
		sounds = config.parent_page.config.sounds.items.text
	}

	return TextMenuItem:new(config, compiler_data.world)
end
