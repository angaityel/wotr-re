-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_bar_element.lua

HUDBarElement = class(HUDBarElement)

function HUDBarElement:init(config)
	self._width = nil
	self._height = nil
	self.config = config
	self._progress = 0
end

function HUDBarElement:width()
	return self._width
end

function HUDBarElement:height()
	return self._height
end

function HUDBarElement:set_progress(progress)
	self._progress = progress
end

function HUDBarElement:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.bar_width
	self._height = layout_settings.bar_height
end

function HUDBarElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function HUDBarElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local progress = config.blackboard and config.blackboard.progress or self.config.progress or 0

	self._progress = math.lerp(self._progress, progress, dt * 2)

	local bgr_c = config.blackboard and config.blackboard.background_texture_color or self.config.background_texture_color or layout_settings.background_texture_color or {
		255,
		255,
		255,
		255
	}
	local bgr_color = Color(bgr_c[1], bgr_c[2], bgr_c[3], bgr_c[4])

	Gui.bitmap(gui, layout_settings.background_texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(layout_settings.bar_width, layout_settings.bar_height), bgr_color)

	local c = config.blackboard and config.blackboard.texture_color or self.config.texture_color or layout_settings.texture_color or {
		255,
		255,
		255,
		255
	}
	local color = Color(c[1], c[2], c[3], c[4])
	local texture_x = math.floor(self._x + (layout_settings.texture_offset_x or 0))
	local texture_y = math.floor(self._y + (layout_settings.texture_offset_y or 0))
	local texture_w = (layout_settings.bar_width - (layout_settings.texture_offset_x and layout_settings.texture_offset_x * 2 or 0)) * self._progress
	local texture_h = layout_settings.bar_height - (layout_settings.texture_offset_y and layout_settings.texture_offset_x * 2) or 0

	Gui.bitmap(gui, layout_settings.texture, Vector3(texture_x, texture_y, self._z + 1), Vector2(texture_w, texture_h), color)

	if layout_settings.texture_2 then
		local c_2 = config.blackboard and config.blackboard.texture_2_color or self.config.texture_2_color or layout_settings.texture_2_color or {
			255,
			255,
			255,
			255
		}
		local color_2 = Color(c_2[1], c_2[2], c_2[3], c_2[4])
		local texture_2_x = texture_x + texture_w
		local texture_2_y = texture_y
		local texture_2_w = layout_settings.bar_width - texture_w - (layout_settings.texture_offset_x and layout_settings.texture_offset_x * 2 or 0)
		local texture_2_h = texture_h

		Gui.bitmap(gui, layout_settings.texture_2, Vector3(texture_2_x, texture_2_y, self._z + 2), Vector2(texture_2_w, texture_2_h), color_2)
	end
end

function HUDBarElement.create_from_config(config)
	return HUDBarElement:new(config)
end
