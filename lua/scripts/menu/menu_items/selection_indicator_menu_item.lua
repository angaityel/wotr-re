-- chunkname: @scripts/menu/menu_items/selection_indicator_menu_item.lua

require("scripts/menu/menu_items/menu_item")

SelectionIndicatorMenuItem = class(SelectionIndicatorMenuItem, MenuItem)

function SelectionIndicatorMenuItem:init(config, world)
	SelectionIndicatorMenuItem.super.init(self, config, world)

	self._selection_count = 5
	self._selected_index = 3
end

function SelectionIndicatorMenuItem:on_select(ignore_sound)
	local delta_x = self._mouse_x - self._x

	if delta_x > 0 and delta_x < self._width then
		local selected_index = math.ceil(delta_x / self._width * self._selection_count)

		if self.config.on_select_new_index then
			self:_try_callback(self.config.callback_object, self.config.on_select_new_index, selected_index)
		end
	end

	SelectionIndicatorMenuItem.super.on_select(self, ignore_sound)
end

function SelectionIndicatorMenuItem:update(dt, t)
	if self:visible() and self.config.on_update_selection then
		self._selection_count, self._selected_index = self:_try_callback(self.config.callback_object, self.config.on_update_selection, unpack(self.config.on_update_selection_args or {}))
	end
end

function SelectionIndicatorMenuItem:update_size(dt, t, gui, layout_settings)
	self:update(dt, t)

	self._width = (layout_settings.texture_width + layout_settings.texture_spacing) * self._selection_count
	self._height = layout_settings.texture_height

	SelectionIndicatorMenuItem.super.update_size(self, dt, t, gui)
end

function SelectionIndicatorMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	SelectionIndicatorMenuItem.super.update_position(self, dt, t)
end

function SelectionIndicatorMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	return
end

function SelectionIndicatorMenuItem:render(dt, t, gui, layout_settings)
	if self.config.no_render_outside_screen and MenuHelper.is_outside_screen(self._x, self._y, self._width, self._height, 10) then
		return
	end

	local z = self._z + (layout_settings.offset_z or 0)
	local selected_texture_c = layout_settings.selected_texture_color or {
		255,
		255,
		255,
		255
	}
	local unselected_texture_c = layout_settings.unselected_texture_color or {
		255,
		255,
		255,
		255
	}
	local selected_texture_color = Color(selected_texture_c[1], selected_texture_c[2], selected_texture_c[3], selected_texture_c[4])
	local unselected_texture_color = Color(unselected_texture_c[1], unselected_texture_c[2], unselected_texture_c[3], unselected_texture_c[4])
	local x, y

	y = self._y

	for i = 0, self._selection_count - 1 do
		x = self._x + (layout_settings.texture_spacing + layout_settings.texture_width) * i

		if i == self._selected_index - 1 then
			local uv00 = Vector2(layout_settings.selected_texture_settings.uv00[1], layout_settings.selected_texture_settings.uv00[2])
			local uv11 = Vector2(layout_settings.selected_texture_settings.uv11[1], layout_settings.selected_texture_settings.uv11[2])

			Gui.bitmap_uv(gui, layout_settings.selected_texture, uv00, uv11, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_width, layout_settings.texture_height), selected_texture_color)
		else
			local uv00 = Vector2(layout_settings.unselected_texture_settings.uv00[1], layout_settings.unselected_texture_settings.uv00[2])
			local uv11 = Vector2(layout_settings.unselected_texture_settings.uv11[1], layout_settings.unselected_texture_settings.uv11[2])

			Gui.bitmap_uv(gui, layout_settings.unselected_texture, uv00, uv11, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_width, layout_settings.texture_height), unselected_texture_color)
		end
	end

	SelectionIndicatorMenuItem.super.render(self, dt, t, gui)
end

function SelectionIndicatorMenuItem:on_page_enter()
	SelectionIndicatorMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_text then
		self.config.text = self:_try_callback(self.config.callback_object, self.config.on_enter_text, unpack(self.config.on_enter_text_args or {}))
	end
end

function SelectionIndicatorMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "selection_index",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_select_new_index = config.on_select_new_index,
		on_update_selection = config.on_update_selection,
		on_update_selection_args = config.on_update_selection_args or {},
		color = config.color,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		no_render_outside_screen = config.no_render_outside_screen,
		sounds = config.parent_page.config.sounds.items.text
	}

	return SelectionIndicatorMenuItem:new(config, compiler_data.world)
end
