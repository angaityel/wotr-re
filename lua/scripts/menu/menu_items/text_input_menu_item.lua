-- chunkname: @scripts/menu/menu_items/text_input_menu_item.lua

TextInputMenuItem = class(TextInputMenuItem, MenuItem)

function TextInputMenuItem:init(config, world)
	TextInputMenuItem.super.init(self, config, world)

	self._text = ""
	self._input_index = nil
	self._input_mode = nil
end

function TextInputMenuItem:set_text(text)
	self._text = text

	local utf8chars = self:_utf8chars(text)

	self._input_index = utf8chars + 1
end

function TextInputMenuItem:_utf8chars(text)
	local length = string.len(text)
	local index = 1
	local utf8chars = 0
	local _

	while index <= length do
		_, index = Utf8.location(text, index)
		utf8chars = utf8chars + 1
	end

	return utf8chars
end

function TextInputMenuItem:text()
	return self._text
end

function TextInputMenuItem:validate_text_length()
	return self:_utf8chars(self._text) >= self.config.min_text_length
end

function TextInputMenuItem:_update_input_text()
	local text = self._text
	local index = self._input_index
	local mode = self._input_mode or "insert"
	local keystrokes = Keyboard.keystrokes()
	local new_text, new_index, new_mode = KeystrokeHelper.parse_strokes(text, index, mode, keystrokes)

	if self:_utf8chars(new_text) > self.config.max_text_length then
		return
	end

	self._text = new_text
	self._input_index = new_index
	self._input_mode = new_mode
end

function TextInputMenuItem:update_size(dt, t, gui, layout_settings)
	self:_update_input_text()

	local text = self._text
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)

	self._text_width = max[1] - min[1]

	local char_from
	local char_to = 1
	local length = 0

	for i = 1, self._input_index - 1 do
		char_from, char_to = Utf8.location(text, char_to)
		length = length + (char_to - char_from)
	end

	local marker_text = string.sub(text, 1, length)
	local min, max = Gui.text_extents(gui, marker_text, font, layout_settings.font_size)

	self._marker_offset_x = max[1] - min[1]
	self._width = layout_settings.width
	self._height = layout_settings.height
end

function TextInputMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function TextInputMenuItem:render(dt, t, gui, layout_settings)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local text_x = self._x + self._width / 2 - self._text_width / 2
	local text_y = self._y + (layout_settings.text_offset_y or 0)

	ScriptGUI.text(gui, self._text, font, layout_settings.font_size, font_material, Vector3(math.floor(text_x), math.floor(text_y), self._z + 1), color)

	local marker_x = text_x + self._marker_offset_x - layout_settings.marker_width / 2
	local marker_y = self._y + (layout_settings.marker_offset_y or 0)
	local marker_alpha = 100 * math.cos(t * 8) + 155
	local marker_color = Color(marker_alpha, 255, 255, 255)

	Gui.rect(gui, Vector3(math.floor(marker_x), math.floor(marker_y), self._z + 1), Vector2(math.floor(layout_settings.marker_width), math.floor(layout_settings.marker_height)), marker_color)

	if layout_settings.texture_background then
		local x = self._x + self._width / 2 - layout_settings.texture_background_width / 2
		local y = self._y + (layout_settings.texture_offset_y or 0)

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(x), math.floor(y), self._z), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height))
	end
end

function TextInputMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "text_input",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_enter_text = config.on_enter_text,
		on_enter_text_args = config.on_enter_text_args or {},
		min_text_length = config.min_text_length or 0,
		max_text_length = config.max_text_length or math.huge,
		toggle_selection = config.toggle_selection,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.text_input
	}

	return TextInputMenuItem:new(config, compiler_data.world)
end
