-- chunkname: @scripts/menu/menu_containers/text_box_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

TextBoxMenuContainer = class(TextBoxMenuContainer, MenuContainer)

function TextBoxMenuContainer:init()
	TextBoxMenuContainer.super.init(self)

	self._text = nil
end

function TextBoxMenuContainer:set_text(text, layout_settings, gui)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local formatted_text = MenuHelper:format_text(text, gui, font, layout_settings.font_size, layout_settings.width)

	self._text = {}

	for i, text in ipairs(formatted_text) do
		local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)

		self._text[i] = {
			width = max[1] - min[1],
			text = text
		}
	end
end

function TextBoxMenuContainer:clear_text()
	self._text = nil
end

function TextBoxMenuContainer:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width + (layout_settings.padding_left or 0) + (layout_settings.padding_right or 0)

	if self._text then
		self._height = #self._text * layout_settings.line_height + (layout_settings.padding_top or 0) + (layout_settings.padding_bottom or 0)
	else
		self._height = 0
	end
end

function TextBoxMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function TextBoxMenuContainer:render(dt, t, gui, layout_settings)
	if self._text then
		local y = self._y + (layout_settings.padding_bottom or 0)
		local y_offset = 0
		local color = Color(layout_settings.color[1], layout_settings.color[2], layout_settings.color[3], layout_settings.color[4])
		local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
		local shadow_color_table = layout_settings.drop_shadow_color
		local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
		local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])

		for i = #self._text, 1, -1 do
			local x

			if layout_settings.text_align == "left" then
				x = self._x + (layout_settings.padding_left or 0)
			elseif layout_settings.text_align == "right" then
				x = self._x + self._width - self._text[i].width - (layout_settings.padding_right or 0)
			end

			ScriptGUI.text(gui, self._text[i].text, font, layout_settings.font_size, font_material, Vector3(math.floor(x), math.floor(y + y_offset), self._z), color, shadow_color, shadow_offset)

			y_offset = y_offset + layout_settings.line_height
		end
	end
end

function TextBoxMenuContainer.create_from_config()
	return TextBoxMenuContainer:new()
end
