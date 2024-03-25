-- chunkname: @scripts/menu/menu_containers/floating_tooltip_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

FloatingTooltipMenuContainer = class(FloatingTooltipMenuContainer, MenuContainer)

function FloatingTooltipMenuContainer:init(header, text, parent_item)
	FloatingTooltipMenuContainer.super.init(self)

	self._header = header
	self._text = text
	self._parent_item = parent_item
	self._force_x = nil
	self._force_y = nil
	self._active = false
	self._animations = {}
end

function FloatingTooltipMenuContainer:is_playing()
	return self._playing
end

function FloatingTooltipMenuContainer:play()
	self._playing = true

	self:_reset_animations()

	self._animations[self._anim_fade_in_delay] = true
end

function FloatingTooltipMenuContainer:stop()
	self._playing = false

	if self._animations[self._anim_fade_in_delay] == true then
		self._animations[self._anim_fade_in_delay] = false
	else
		self._animations[self._anim_fade_in] = false
		self._animations[self._anim_fade_out_delay] = true
	end
end

function FloatingTooltipMenuContainer:_anim_fade_in_delay(dt, t, gui, layout_settings)
	self._fade_in_delay = self._fade_in_delay + dt

	if self._fade_in_delay >= layout_settings.fade_in_delay then
		self._anim_x = self._x
		self._anim_y = self._y
		self._animations[self._anim_fade_in_delay] = false
		self._animations[self._anim_fade_in] = true
	end
end

function FloatingTooltipMenuContainer:_anim_fade_in(dt, t, gui, layout_settings)
	self._alpha_multiplier = math.lerp(self._alpha_multiplier, 1, dt * layout_settings.fade_in_speed)
end

function FloatingTooltipMenuContainer:_anim_fade_out_delay(dt, t, gui, layout_settings)
	self._fade_out_delay = self._fade_out_delay + dt

	if self._fade_out_delay >= layout_settings.fade_out_delay then
		self._animations[self._anim_fade_out_delay] = false
		self._animations[self._anim_fade_out] = true
	end
end

function FloatingTooltipMenuContainer:_anim_fade_out(dt, t, gui, layout_settings)
	self._alpha_multiplier = math.lerp(self._alpha_multiplier, 0, dt * layout_settings.fade_out_speed)
end

function FloatingTooltipMenuContainer:_reset_animations()
	self._fade_in_delay = 0
	self._fade_out_delay = 0
	self._alpha_multiplier = 0
	self._animations[self._anim_fade_in_delay] = nil
	self._animations[self._anim_fade_in] = nil
	self._animations[self._anim_fade_out_delay] = nil
	self._animations[self._anim_fade_out] = nil
end

function FloatingTooltipMenuContainer:update_size(dt, t, gui, layout_settings)
	local header_width = 0
	local header_height = 0

	if self._header then
		local header_font = layout_settings.header_font.font
		local header_font_size = layout_settings.header_font_size
		local header = layout_settings.header_no_localization and self._header or L(self._header)
		local min, max = Gui.text_extents(gui, header, header_font, header_font_size)

		header_width = max[1] - min[1]
		header_height = max[3] - min[3]
	end

	self._center_width = math.max(layout_settings.min_center_width, header_width)
	self._header_height = header_height
	self._width = self._center_width + layout_settings.texture_width * 2

	local text_height = 0

	if self._text then
		local text = layout_settings.text_no_localization and self._text or L(self._text)

		self:_update_text_table(text, gui, layout_settings, self._center_width)

		text_height = #self._text_table * layout_settings.text_line_height
	end

	local text_padding_top = 0

	if self._header and self._text then
		text_padding_top = layout_settings.text_padding_top
	end

	self._text_padding_top = text_padding_top
	self._center_height = header_height + text_height + text_padding_top
	self._height = self._center_height + layout_settings.texture_height * 2
end

function FloatingTooltipMenuContainer:_update_text_table(text, gui, layout_settings, width)
	local font = layout_settings.text_font.font
	local font_size = layout_settings.text_font_size
	local formatted_text = MenuHelper:format_text(text, gui, font, font_size, width)

	self._text_table = {}

	for i, text in ipairs(formatted_text) do
		local min, max = Gui.text_extents(gui, text, font, layout_settings.text_font_size)

		self._text_table[i] = {
			width = max[1] - min[1],
			text = text
		}
	end
end

function FloatingTooltipMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function FloatingTooltipMenuContainer:render(dt, t, gui, layout_settings)
	if table.size(self._animations) == 0 then
		return
	end

	for anim, update in pairs(self._animations) do
		if update then
			anim(self, dt, t, gui, layout_settings)
		end
	end

	self:_render_gui(dt, t, gui, layout_settings)
end

function FloatingTooltipMenuContainer:_render_gui(dt, t, gui, layout_settings)
	local x = self._anim_x
	local y = self._anim_y

	if not x or not y then
		return
	end

	local res_width, res_height = Gui.resolution()

	if res_width < x + self._width then
		x = x - self._width
	end

	if y - self._height + layout_settings.cursor_offset_y >= 0 then
		y = y - self._height + layout_settings.cursor_offset_y
	end

	if self._header then
		local header_x = x + layout_settings.texture_width
		local header_y = y + self._height - layout_settings.texture_height - self._header_height
		local header_z = self._z + 1
		local header_position = Vector3(math.floor(header_x), math.floor(header_y), header_z)
		local header_color_table = layout_settings.header_color
		local header_color = Color(header_color_table[1] * self._alpha_multiplier, header_color_table[2], header_color_table[3], header_color_table[4])
		local header_shadow_color_table = layout_settings.header_shadow_color
		local header_shadow_color = header_shadow_color_table and Color(header_shadow_color_table[1] * self._alpha_multiplier, header_shadow_color_table[2], header_shadow_color_table[3], header_shadow_color_table[4])
		local header_shadow_offset_table = layout_settings.header_shadow_offset
		local header_shadow_offset = header_shadow_offset_table and Vector2(header_shadow_offset_table[1], header_shadow_offset_table[2])
		local header = layout_settings.header_no_localization and self._header or L(self._header)

		ScriptGUI.text(gui, header, layout_settings.header_font.font, layout_settings.header_font_size, layout_settings.header_font.material, header_position, header_color, header_shadow_color, header_shadow_offset)
	end

	if self._text_table then
		local text_x = x + layout_settings.texture_width
		local text_y = y + self._height - layout_settings.texture_height - self._header_height - layout_settings.text_padding_top
		local text_z = self._z + 1
		local text_color_table = layout_settings.text_color
		local text_color = Color(text_color_table[1] * self._alpha_multiplier, text_color_table[2], text_color_table[3], text_color_table[4])
		local text_shadow_color_table = layout_settings.text_shadow_color
		local text_shadow_color = text_shadow_color_table and Color(text_shadow_color_table[1] * self._alpha_multiplier, text_shadow_color_table[2], text_shadow_color_table[3], text_shadow_color_table[4])
		local text_shadow_offset_table = layout_settings.text_shadow_offset
		local text_shadow_offset = text_shadow_offset_table and Vector2(text_shadow_offset_table[1], text_shadow_offset_table[2])
		local text_offset_y = layout_settings.text_line_height

		for i = 1, #self._text_table do
			local text_position = Vector3(math.floor(text_x), math.floor(text_y - text_offset_y), text_z)

			ScriptGUI.text(gui, self._text_table[i].text, layout_settings.text_font.font, layout_settings.text_font_size, layout_settings.text_font.material, text_position, text_color, text_shadow_color, text_shadow_offset)

			text_offset_y = text_offset_y + layout_settings.text_line_height
		end
	end

	local texture_color = Color(255 * self._alpha_multiplier, 255, 255, 255)
	local texture_offset_x = 0
	local texture_offset_y = 0

	Gui.bitmap(gui, layout_settings.texture_down_left, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), texture_color)

	texture_offset_x = texture_offset_x + layout_settings.texture_width

	Gui.bitmap(gui, layout_settings.texture_down_middle, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(self._center_width), math.floor(layout_settings.texture_height)), texture_color)

	texture_offset_x = texture_offset_x + self._center_width

	Gui.bitmap(gui, layout_settings.texture_down_right, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), texture_color)

	texture_offset_x = 0
	texture_offset_y = texture_offset_y + layout_settings.texture_height

	Gui.bitmap(gui, layout_settings.texture_middle_left, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(self._center_height)), texture_color)

	texture_offset_x = texture_offset_x + layout_settings.texture_width

	Gui.bitmap(gui, layout_settings.texture_center, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(self._center_width), math.floor(self._center_height)), texture_color)

	texture_offset_x = texture_offset_x + self._center_width

	Gui.bitmap(gui, layout_settings.texture_middle_right, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(self._center_height)), texture_color)

	texture_offset_x = 0
	texture_offset_y = texture_offset_y + self._center_height

	Gui.bitmap(gui, layout_settings.texture_top_left, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), texture_color)

	texture_offset_x = texture_offset_x + layout_settings.texture_width

	Gui.bitmap(gui, layout_settings.texture_top_middle, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(self._center_width), math.floor(layout_settings.texture_height)), texture_color)

	texture_offset_x = texture_offset_x + self._center_width

	Gui.bitmap(gui, layout_settings.texture_top_right, Vector3(math.floor(x + texture_offset_x), math.floor(y + texture_offset_y), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), texture_color)
end

function FloatingTooltipMenuContainer.create_from_config(header, text, parent_item)
	return FloatingTooltipMenuContainer:new(header, text, parent_item)
end
