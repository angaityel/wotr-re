-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_animated_text_element.lua

HUDAnimatedTextElement = class(HUDAnimatedTextElement)

function HUDAnimatedTextElement:init(config)
	self._width = nil
	self._height = nil
	self._t = 0
	self.config = config

	local layout_settings = HUDHelper:layout_settings(config.layout_settings)

	for name, func in pairs(layout_settings.animations) do
		self[name] = func(0)
	end
end

function HUDAnimatedTextElement:width()
	return self._width
end

function HUDAnimatedTextElement:height()
	return self._height
end

function HUDAnimatedTextElement:update_size(dt, t, gui, layout_settings)
	self._t = self._t + dt

	for name, func in pairs(layout_settings.animations) do
		self[name] = func(math.clamp(self._t / layout_settings.anim_length, 0, 1))
	end

	local config = self.config
	local res_width, _ = Gui.resolution()
	local text = config.blackboard and config.blackboard.text or self.config.text
	local font = layout_settings.font or MenuSettings.fonts.menu_font
	local font_size = layout_settings.font_size * (self.font_size_multiplier or 1)
	local formatted_text = MenuHelper:format_text(text, gui, font.font, font_size, layout_settings.width or res_width)
	local max_width = 0

	self._text = {}

	for i, text in ipairs(formatted_text) do
		local min, max = Gui.text_extents(gui, text, font.font, font_size)
		local width = max[1] - min[1]

		if max_width < width then
			max_width = width
		end

		self._text[i] = {
			width = width,
			height = max[3] - min[3],
			text = text
		}
	end

	self._formatted_text = formatted_text
	self._width = max_width

	local line_height = layout_settings.line_height or self._text[1] and self._text[1].height or 0

	self._height = #self._text * line_height
end

function HUDAnimatedTextElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x + (self.offset_x or 0)
	self._y = y + (self.offset_y or 0)
	self._z = z
end

function HUDAnimatedTextElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local font = layout_settings.font or MenuSettings.fonts.menu_font
	local font_size = layout_settings.font_size * (self.font_size_multiplier or 1)
	local line_height = layout_settings.line_height or self._text[1] and self._text[1].height or 0
	local color = config.blackboard and config.blackboard.color or layout_settings.text_color or {
		255,
		255,
		255,
		255
	}
	local y = self._y
	local y_offset = 0

	for i = #self._text, 1, -1 do
		local text = self._text[i]
		local x

		if layout_settings.text_align == "right" then
			x = self._x + self._width - text.width
		elseif layout_settings.text_align == "center" then
			x = self._x + self._width / 2 - text.width / 2
		else
			x = self._x
		end

		Gui.text(gui, text.text, font.font, font_size, font.material, Vector3(math.floor(x), math.floor(y + y_offset), self._z), Color(color[1] * (self.alpha_multiplier or 1), color[2], color[3], color[4]))

		if layout_settings.drop_shadow then
			local color = layout_settings.drop_shadow_color or {
				255,
				0,
				0,
				0
			}

			Gui.text(gui, text.text, font.font, font_size, font.material, Vector3(math.floor(x + layout_settings.drop_shadow[1]), math.floor(y + y_offset + layout_settings.drop_shadow[2]), self._z - 1), Color(color[1] * (self.alpha_multiplier and self.alpha_multiplier * self.alpha_multiplier or 1), color[2], color[3], color[4]))
		end

		y_offset = y_offset + line_height
	end
end

function HUDAnimatedTextElement.create_from_config(config)
	return HUDAnimatedTextElement:new(config)
end
