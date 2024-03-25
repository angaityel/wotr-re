-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_text_element.lua

HUDTextElement = class(HUDTextElement)

function HUDTextElement:init(config)
	self._width = nil
	self._height = nil
	self.config = config
end

function HUDTextElement:width()
	return self._width
end

function HUDTextElement:height()
	return self._height
end

function HUDTextElement:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local text = config.blackboard and config.blackboard.text or self.config.text

	if type(text) ~= "string" then
		text = tostring(text)
	end

	local font = layout_settings.font or MenuSettings.fonts.menu_font

	if layout_settings.text_max_length then
		text = HUDHelper:trunkate_text(text, layout_settings.text_max_length, "...", true)
	end

	local min, max = Gui.text_extents(gui, text, font.font, layout_settings.font_size)

	self._width = max[1] - min[1]
	self._height = max[3] - min[3]
	self._min_x = min[1]
	self._text = text
end

function HUDTextElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x - self._min_x
	self._y = y
	self._z = z
end

function HUDTextElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local color_table = config.blackboard and config.blackboard.color or layout_settings.text_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])
	local shadow_color = layout_settings.shadow_color and Color(layout_settings.shadow_color[1], layout_settings.shadow_color[2], layout_settings.shadow_color[3], layout_settings.shadow_color[4])
	local shadow_offset = layout_settings.shadow_offset and Vector2(layout_settings.shadow_offset[1], layout_settings.shadow_offset[2])
	local text = self.config.blackboard and self.config.blackboard.text or self._text

	if type(text) ~= "string" then
		text = tostring(text)
	end

	local font = layout_settings.font or MenuSettings.fonts.menu_font

	ScriptGUI.text(gui, text, font.font, layout_settings.font_size, font.material, Vector3(math.floor(self._x), math.floor(self._y), self._z), color, shadow_color, shadow_offset)
end

function HUDTextElement.create_from_config(config)
	return HUDTextElement:new(config)
end
