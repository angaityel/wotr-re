-- chunkname: @scripts/menu/menu_items/enum_menu_item.lua

EnumMenuItem = class(EnumMenuItem, MenuItem)

function EnumMenuItem:init(config, world)
	EnumMenuItem.super.init(self, config, world)

	if self:visible() and self.config.on_init_options then
		local entries, selection = self:_try_callback(self.config.callback_object, self.config.on_init_options)

		self._selection = selection
		self.config.entries = entries
		self.config.selected_entry = self.config.entries[self._selection]
	end
end

function EnumMenuItem:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, config.text .. tostring(config.selected_entry.value), font, layout_settings.font_size)

	self._width = max[1] - min[1] + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.line_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function EnumMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function EnumMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	local config = self.config
	local c = layout_settings.color_render_from_child_page
	local color = Color(c[1], c[2], c[3], c[4])
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material

	ScriptGUI.text(gui, config.text .. tostring(config.selected_entry.value), font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z + 1), color)
end

function EnumMenuItem:render(dt, t, gui, layout_settings)
	local config = self.config

	if layout_settings.texture_highlighted and self._highlighted then
		local x, y

		if layout_settings.texture_alignment == "left" then
			x = self._x
			y = self._y + self._height / 2 - layout_settings.texture_disabled_height / 2
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_highlighted_width / 2
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_highlighted_width
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2
		end

		Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(x), math.floor(y), self._z), Vector2(layout_settings.texture_highlighted_width, layout_settings.texture_highlighted_height))
	end

	local color = config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local shadow_color_table = self.config.disabled and layout_settings.drop_shadow_color_disabled or layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])

	ScriptGUI.text(gui, config.text .. tostring(config.selected_entry.value), font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z + 1), Color(color[1], color[2], color[3], color[4]), shadow_color, shadow_offset)
end

function EnumMenuItem:select_entry_by_key(entry_key)
	local selection

	for key, value in ipairs(self.config.entries) do
		if entry_key == value.key then
			selection = key

			break
		end
	end

	self._selection = selection

	local new_entry = self.config.entries[selection]

	self:_update_and_notify_value(new_entry)
end

function EnumMenuItem:on_left_click(ignore_sound)
	self:on_move_right()

	if not ignore_sound then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, self.config.sounds.select)
	end
end

function EnumMenuItem:on_right_click(ignore_sound)
	self:on_move_left()

	if not ignore_sound then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, self.config.sounds.select)
	end
end

function EnumMenuItem:on_move_left()
	self._selection = self._selection - 1

	if self._selection == 0 then
		self._selection = #self.config.entries
	end

	local new_entry = self.config.entries[self._selection]

	self:_update_and_notify_value(new_entry)
end

function EnumMenuItem:on_move_right()
	self._selection = self._selection + 1

	if self._selection > #self.config.entries then
		self._selection = 1
	end

	local new_entry = self.config.entries[self._selection]

	self:_update_and_notify_value(new_entry)
end

function EnumMenuItem:on_page_enter()
	EnumMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_options then
		local entries, selection = self:_try_callback(self.config.callback_object, self.config.on_enter_options)

		self._selection = selection
		self.config.entries = entries
		self.config.selected_entry = self.config.entries[self._selection]
	end
end

function EnumMenuItem:_update_and_notify_value(new_entry)
	if self.config.selected_entry ~= new_entry then
		self:_try_callback(self.config.callback_object, self.config.on_option_changed, new_entry)
	end

	self.config.selected_entry = new_entry
end

function EnumMenuItem:notify_value(...)
	self:_try_callback(self.config.callback_object, self.config.on_option_changed, self.config.selected_entry, ...)
end

function EnumMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "enum",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_init_options = config.on_init_options,
		on_enter_options = config.on_enter_options,
		on_option_changed = config.on_option_changed,
		values = config.values,
		text = config.no_localization and config.text or L(config.text) .. ": ",
		tooltip_text = config.tooltip_text,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.enum,
		remove_func = config.remove_func and callback(callback_object, config.remove_func)
	}

	return EnumMenuItem:new(config, compiler_data.world)
end
