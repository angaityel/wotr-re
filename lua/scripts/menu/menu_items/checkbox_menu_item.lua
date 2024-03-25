-- chunkname: @scripts/menu/menu_items/checkbox_menu_item.lua

CheckboxMenuItem = class(CheckboxMenuItem, TextMenuItem)

function CheckboxMenuItem:init(config, world)
	CheckboxMenuItem.super.init(self, config, world)
end

function CheckboxMenuItem:on_page_enter()
	CheckboxMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_select then
		self._selected = self:_try_callback(self.config.callback_object, self.config.on_enter_select, unpack(self.config.on_enter_select_args or {}))
	end
end

function CheckboxMenuItem:render(dt, t, gui, layout_settings)
	CheckboxMenuItem.super.render(self, dt, t, gui, layout_settings)

	local c = self.config.color or self.config.disabled and layout_settings.texture_disabled_color or {
		255,
		255,
		255,
		255
	}
	local color = Color(c[1], c[2], c[3], c[4])

	if self._selected then
		Gui.bitmap(gui, layout_settings.texture_selected, Vector3(math.floor(self._x + layout_settings.texture_selected_offset_x), math.floor(self._y + self._height / 2 - layout_settings.texture_selected_height / 2), self._z + 1), Vector2(layout_settings.texture_selected_width, layout_settings.texture_selected_height), color)
	else
		Gui.bitmap(gui, layout_settings.texture_deselected, Vector3(math.floor(self._x + layout_settings.texture_deselected_offset_x), math.floor(self._y + self._height / 2 - layout_settings.texture_deselected_height / 2), self._z + 1), Vector2(layout_settings.texture_deselected_width, layout_settings.texture_deselected_height), color)
	end
end

function CheckboxMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		toggle_selection = true,
		type = "checkbox",
		name = config.name,
		page = config.page,
		disabled = config.disabled,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		callback_object = callback_object,
		on_enter_select = config.on_enter_select,
		on_enter_select_args = config.on_enter_select_args,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		text = config.no_localization and config.text or L(config.text),
		tooltip_text = config.tooltip_text,
		tooltip_text_2 = config.tooltip_text_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.checkbox
	}

	return CheckboxMenuItem:new(config, compiler_data.world)
end
