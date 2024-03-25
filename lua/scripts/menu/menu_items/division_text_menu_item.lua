-- chunkname: @scripts/menu/menu_items/division_text_menu_item.lua

require("scripts/menu/menu_items/menu_item")

DivisionTextMenuItem = class(DivisionTextMenuItem, TextMenuItem)

function DivisionTextMenuItem:render(dt, t, gui, layout_settings)
	self.super.render(self, dt, t, gui, layout_settings)

	if layout_settings.color_highlighted and self._highlighted then
		local x, y

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

		local z = self._z + (layout_settings.offset_z or 0)

		self._alpha = 0.75 + math.sin(t * 7) * 0.25

		self:_render_background(gui, {
			x,
			y,
			layout_settings.division_rect[1],
			layout_settings.division_rect[2]
		}, 3, Color(255 * self._alpha, 128, 128, 150), z, layout_settings)

		local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
		local x = math.floor(self._x + layout_settings.padding_left - self._min_x)
		local y = self._y + layout_settings.padding_bottom

		if not self.config.not_pixel_perfect_y then
			y = math.floor(y)
		end

		Gui.text(gui, self.config.text, font, layout_settings.font_size, font_material, Vector3(x + 1, y - 1, z), Color(0, 0, 0))
	end
end

function DivisionTextMenuItem:_render_background(gui, rect, thickness, color, layer, layout_settings)
	Gui.bitmap(gui, "division", Vector3(rect[1], rect[2], layer), Vector2(rect[3], -rect[4]), color)
end

function DivisionTextMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "division",
		division_index = config.division_index,
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

	return DivisionTextMenuItem:new(config, compiler_data.world)
end
