-- chunkname: @scripts/managers/hud/hud_sp_tutorial/hud_sp_tutorial_element.lua

HUDSPTutorialtElement = class(HUDSPTutorialtElement)

function HUDSPTutorialtElement:init(config)
	self._width = nil
	self._height = nil
	self.config = config
end

function HUDSPTutorialtElement:width()
	return self._width
end

function HUDSPTutorialtElement:height()
	return self._height
end

function HUDSPTutorialtElement:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local text = config.blackboard and config.blackboard.text or self.config.text
	local formatted_text = MenuHelper:format_text(text, gui, layout_settings.font.font, layout_settings.font_size, layout_settings.text_width)

	self._text = {}

	for i, text in ipairs(formatted_text) do
		self._text[i] = {
			text = text
		}
	end

	self._width = layout_settings.text_padding_left + layout_settings.text_width
	self._height = layout_settings.text_padding_bottom + #self._text * layout_settings.line_height + layout_settings.text_padding_top
end

function HUDSPTutorialtElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function HUDSPTutorialtElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local color_table = config.blackboard and config.blackboard.color or layout_settings.text_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])
	local shadow_color = layout_settings.text_shadow_color and Color(layout_settings.text_shadow_color[1], layout_settings.text_shadow_color[2], layout_settings.text_shadow_color[3], layout_settings.text_shadow_color[4])
	local shadow_offset = layout_settings.text_shadow_offset and Vector2(layout_settings.text_shadow_offset[1], layout_settings.text_shadow_offset[2])
	local text_x_offset = layout_settings.text_padding_left
	local text_y_offset = layout_settings.text_padding_bottom

	for i = #self._text, 1, -1 do
		ScriptGUI.text(gui, self._text[i].text, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, Vector3(math.floor(self._x + text_x_offset), math.floor(self._y + text_y_offset), self._z + 2), color, shadow_color, shadow_offset)

		text_y_offset = text_y_offset + layout_settings.line_height
	end

	local color_table = config.blackboard and config.blackboard.color or layout_settings.header_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])
	local shadow_color = layout_settings.header_shadow_color and Color(layout_settings.header_shadow_color[1], layout_settings.header_shadow_color[2], layout_settings.header_shadow_color[3], layout_settings.header_shadow_color[4])
	local shadow_offset = layout_settings.header_shadow_offset and Vector2(layout_settings.header_shadow_offset[1], layout_settings.header_shadow_offset[2])
	local header_x_offset = layout_settings.text_padding_left
	local header_y_offset = text_y_offset + layout_settings.header_padding_bottom
	local header_text = config.blackboard and config.blackboard.header_text or self.config.header_text

	ScriptGUI.text(gui, header_text, layout_settings.header_font.font, layout_settings.header_font_size, layout_settings.header_font.material, Vector3(math.floor(self._x + header_x_offset), math.floor(self._y + header_y_offset), self._z + 2), color, shadow_color, shadow_offset)

	local atlas_settings = table.clone(layout_settings.header_texture_atlas_settings)

	atlas_settings.uv00[2] = atlas_settings.uv00[2] + 0.002
	atlas_settings.uv11[2] = atlas_settings.uv11[2] - 0.002

	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local size = Vector2(atlas_settings.size[1], layout_settings.header_texture_height)
	local color_table = layout_settings.header_texture_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])
	local header_text_y = self._y + header_y_offset + layout_settings.header_texture_offset_y

	Gui.bitmap_uv(gui, layout_settings.header_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(header_text_y), self._z + 1), size, color)

	local atlas_settings = layout_settings.bottom_line_texture_atlas_settings
	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local bottom_line_size = Vector2(atlas_settings.size[1], atlas_settings.size[2])

	Gui.bitmap_uv(gui, layout_settings.bottom_line_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(header_text_y), self._z + 3), bottom_line_size)

	local atlas_settings = layout_settings.top_line_texture_atlas_settings
	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local top_line_size = Vector2(atlas_settings.size[1], atlas_settings.size[2])

	Gui.bitmap_uv(gui, layout_settings.top_line_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(header_text_y + layout_settings.header_texture_height - top_line_size[2]), self._z + 3), top_line_size)

	local atlas_settings = layout_settings.bottom_line_texture_atlas_settings
	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local bottom_line_size = Vector2(atlas_settings.size[1], atlas_settings.size[2])

	Gui.bitmap_uv(gui, layout_settings.bottom_line_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(self._y), self._z + 2), bottom_line_size)

	local atlas_settings = layout_settings.top_line_texture_atlas_settings
	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local top_line_size = Vector2(atlas_settings.size[1], atlas_settings.size[2])

	Gui.bitmap_uv(gui, layout_settings.top_line_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(self._y + self._height - top_line_size[2]), self._z + 2), top_line_size)

	local atlas_settings = table.clone(layout_settings.gradient_texture_atlas_settings)

	atlas_settings.uv00[2] = atlas_settings.uv00[2] + 0.002
	atlas_settings.uv11[2] = atlas_settings.uv11[2] - 0.002

	local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
	local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])
	local size = Vector2(atlas_settings.size[1], self._height)
	local color_table = layout_settings.gradient_texture_color
	local color = Color(color_table[1], color_table[2], color_table[3], color_table[4])

	Gui.bitmap_uv(gui, layout_settings.gradient_texture_atlas, uv00, uv11, Vector3(math.floor(self._x), math.floor(self._y), math.floor(self._z)), size, color)
end

function HUDSPTutorialtElement.create_from_config(config)
	return HUDSPTutorialtElement:new(config)
end
