-- chunkname: @scripts/menu/menu_containers/text_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

TextMenuContainer = class(TextMenuContainer, MenuContainer)

function TextMenuContainer:init(text)
	TextMenuContainer.super.init(self)

	self._text = text
	self._rendering = true
end

function TextMenuContainer:set_text(text)
	self._text = text
end

function TextMenuContainer:set_rendering(rendering)
	self._rendering = rendering
end

function TextMenuContainer:update_size(dt, t, gui, layout_settings)
	local text = layout_settings.no_localization and self._text or L(self._text)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)
	local text_width = max[1] - min[1]
	local text_height = max[3] - min[3]
	local width, height

	if layout_settings.texture_background_width and text_width < layout_settings.texture_background_width then
		width = layout_settings.texture_background_width
	else
		width = text_width
	end

	if layout_settings.texture_background_height and text_height < layout_settings.texture_background_height then
		height = layout_settings.texture_background_height
	else
		height = text_height
	end

	self._text_width = text_width
	self._text_height = text_height
	self._width = width
	self._height = height
end

function TextMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function TextMenuContainer:render(dt, t, gui, layout_settings)
	if not self._rendering then
		return
	end

	if layout_settings.texture_background then
		local texture_x, texture_y

		if layout_settings.texture_background_alignment == "left" then
			texture_x = self._x
			texture_y = self._y
		elseif layout_settings.texture_background_alignment == "center" then
			texture_x = self._x + self._width / 2 - layout_settings.texture_background_width / 2
			texture_y = self._y + self._height / 2 - layout_settings.texture_background_height / 2
		elseif layout_settings.texture_background_alignment == "right" then
			texture_x = self._x + self._width - layout_settings.texture_background_width
			texture_y = self._y + self._height / 2 - layout_settings.texture_background_height / 2
		end

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(texture_x), math.floor(texture_y), self._z), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height))
	end

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local text_color = Color(layout_settings.text_color[1], layout_settings.text_color[2], layout_settings.text_color[3], layout_settings.text_color[4])
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local text = layout_settings.no_localization and self._text or L(self._text)
	local text_x = self._x + self._width / 2 - self._text_width / 2
	local text_y = self._y + layout_settings.text_offset_y

	ScriptGUI.text(gui, text, font, layout_settings.font_size, font_material, Vector3(math.floor(text_x), math.floor(text_y), self._z + 1), text_color, shadow_color, shadow_offset)
end

function TextMenuContainer.create_from_config(text)
	return TextMenuContainer:new(text)
end
