-- chunkname: @scripts/menu/menu_items/drop_down_list_menu_item.lua

DropDownListMenuItem = class(DropDownListMenuItem, MenuItem)

function DropDownListMenuItem:init(config, world)
	DropDownListMenuItem.super.init(self, config, world)

	self._description_text = ""
	self._value_text = ""
end

function DropDownListMenuItem:update_size(dt, t, gui, layout_settings)
	local text = self._description_text .. self._value_text
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)

	self._width = max[1] - min[1] + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.line_height + layout_settings.padding_top + layout_settings.padding_bottom

	local min, max = Gui.text_extents(gui, self._description_text, font, layout_settings.font_size)

	self._description_text_width = max[1] - min[1] + layout_settings.padding_left
	self._description_text_height = layout_settings.line_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function DropDownListMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function DropDownListMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	self:render(dt, t, gui, layout_settings, true)
end

function DropDownListMenuItem:render(dt, t, gui, layout_settings, rendered_from_child)
	if layout_settings.texture_background then
		local x = self._x
		local y = self._y + self._height / 2 - layout_settings.texture_background_height / 2
		local color_table = self._highlighted and layout_settings.color_highlighted or layout_settings.color
		local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(x), math.floor(y), self._z), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height), color)
	end

	if layout_settings.texture_highlighted and self._highlighted then
		local x, y

		if layout_settings.texture_alignment == "left" then
			x = self._x
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_highlighted_width / 2
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_highlighted_width
			y = self._y + self._height / 2 - layout_settings.texture_highlighted_height / 2
		end

		Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(x), math.floor(y), self._z + 1), Vector2(layout_settings.texture_highlighted_width, layout_settings.texture_highlighted_height))
	end

	if layout_settings.texture_arrow and not layout_settings.hide_arrow_when_unselected or layout_settings.texture_arrow and self._highlighted then
		local x, y

		if layout_settings.texture_alignment == "left" then
			x = self._x + layout_settings.texture_arrow_offset_x
			y = self._y + layout_settings.texture_arrow_offset_y + layout_settings.padding_bottom
		elseif layout_settings.texture_alignment == "center" then
			x = self._x + self._width / 2 - layout_settings.texture_arrow_width / 2 + layout_settings.texture_arrow_offset_x
			y = self._y + layout_settings.texture_arrow_offset_y
		elseif layout_settings.texture_alignment == "right" then
			x = self._x + self._width - layout_settings.texture_arrow_width + layout_settings.texture_arrow_offset_x
			y = self._y + layout_settings.texture_arrow_offset_y
		end

		Gui.bitmap(gui, layout_settings.texture_arrow, Vector3(math.floor(x), math.floor(y), self._z + 2), Vector2(layout_settings.texture_arrow_width, layout_settings.texture_arrow_height))
	end

	local color = self.config.disabled and layout_settings.color_disabled or rendered_from_child and layout_settings.color_render_from_child_page or self._highlighted and layout_settings.color_highlighted or layout_settings.color
	local text = self._description_text .. self._value_text
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local shadow_color, shadow_offset

	if not rendered_from_child then
		local shadow_color_table = self.config.disabled and layout_settings.drop_shadow_color_disabled or layout_settings.drop_shadow_color

		shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
		shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	end

	ScriptGUI.text(gui, text, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z + 3), Color(color[1], color[2], color[3], color[4]), shadow_color, shadow_offset)
end

function DropDownListMenuItem:description_text_width()
	return self._description_text_width
end

function DropDownListMenuItem:description_text_height()
	return self._description_text_height
end

function DropDownListMenuItem:on_page_enter()
	DropDownListMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_text then
		self._description_text, self._value_text = self:_try_callback(self.config.callback_object, self.config.on_enter_text, unpack(self.config.on_enter_text_args or {}))
	end
end

function DropDownListMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "drop_down_list",
		name = config.name,
		page = config.page,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_enter_text = config.on_enter_text,
		on_enter_text_args = config.on_enter_text_args or {},
		tooltip_text = config.tooltip_text,
		tooltip_text_2 = config.tooltip_text_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.drop_down_list
	}

	return DropDownListMenuItem:new(config, compiler_data.world)
end
