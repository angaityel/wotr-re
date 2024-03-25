-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_text_input_element.lua

HUDTextInputElement = class(HUDTextInputElement)

function HUDTextInputElement:init(config)
	self._width = nil
	self._height = nil
	self._growth_offset = 0
	self._min_visible_index = 0
	self.config = config
end

function HUDTextInputElement:width()
	return self._width
end

function HUDTextInputElement:height()
	return self._height
end

function HUDTextInputElement:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local text = config.blackboard and config.blackboard.text or self.config.text
	local font = layout_settings.font or MenuSettings.fonts.menu_font
	local char_from
	local char_to = 1
	local length = 0

	for i = 1, config.blackboard.input_index - 1 do
		char_from, char_to = Utf8.location(text, char_to)
		length = length + (char_to - char_from)
	end

	local marker_sub_str = string.sub(text, 1, length)
	local min, max = Gui.text_extents(gui, marker_sub_str, font.font, layout_settings.font_size)

	self._marker_offset_x = max[1] - min[1]

	local min, max = Gui.text_extents(gui, text, font.font, layout_settings.font_size)
	local text_width = max[1] - min[1]

	if layout_settings.avoid_growth then
		self._growth_offset = math.max(text_width - layout_settings.width, 0)
		self._width = layout_settings.width
	else
		self._width = math.max(layout_settings.width, text_width)
	end

	self._height = layout_settings.height
end

function HUDTextInputElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function HUDTextInputElement:render(dt, t, gui, layout_settings)
	local x = self._x
	local y = self._y
	local z = self._z
	local w = self._width
	local h = self._height
	local bgr_w = w + layout_settings.text_offset_x * 2
	local config = self.config
	local color_table = config.blackboard and config.blackboard.color or layout_settings.text_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])
	local shadow_color = layout_settings.shadow_color and Color(layout_settings.shadow_color[1], layout_settings.shadow_color[2], layout_settings.shadow_color[3], layout_settings.shadow_color[4])
	local shadow_offset = layout_settings.shadow_offset and Vector2(layout_settings.shadow_offset[1], layout_settings.shadow_offset[2])
	local text = config.blackboard and config.blackboard.text or self.config.text
	local font = layout_settings.font or MenuSettings.fonts.menu_font

	ScriptGUI.text(gui, text, font.font, layout_settings.font_size, font.material, Vector3(math.floor(x + layout_settings.text_offset_x - self._growth_offset), math.floor(y + layout_settings.text_offset_y), z + 2), color, shadow_color, shadow_offset)

	if layout_settings.background_color then
		local color = Color(layout_settings.background_color[1], layout_settings.background_color[2], layout_settings.background_color[3], layout_settings.background_color[4])

		Gui.rect(gui, Vector3(x, y, z), Vector2(bgr_w, h), color)
	end

	if layout_settings.border_size then
		local color = Color(layout_settings.border_color[1], layout_settings.border_color[2], layout_settings.border_color[3], layout_settings.border_color[4])

		Gui.rect(gui, Vector3(x - layout_settings.border_size, y + h, z + 1), Vector2(bgr_w + layout_settings.border_size * 2, layout_settings.border_size), color)
		Gui.rect(gui, Vector3(x - layout_settings.border_size, y - layout_settings.border_size, z + 1), Vector2(bgr_w + layout_settings.border_size * 2, layout_settings.border_size), color)
		Gui.rect(gui, Vector3(x - layout_settings.border_size, y, z + 1), Vector2(layout_settings.border_size, h), color)
		Gui.rect(gui, Vector3(x + bgr_w, y, z + 1), Vector2(layout_settings.border_size, h), color)
	end

	local marker_x = x + layout_settings.text_offset_x + self._marker_offset_x - layout_settings.marker_width
	local marker_y = y + self._height / 2 - layout_settings.marker_height / 2
	local marker_alpha = 100 * math.cos(t * 8) + 155
	local marker_color = Color(marker_alpha, layout_settings.marker_color[1], layout_settings.marker_color[2], layout_settings.marker_color[3])

	Gui.rect(gui, Vector3(math.floor(marker_x - self._growth_offset), math.floor(marker_y), self._z + 3), Vector2(math.floor(layout_settings.marker_width), math.floor(layout_settings.marker_height)), marker_color)
end

function HUDTextInputElement.create_from_config(config)
	return HUDTextInputElement:new(config)
end
