-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_texture_element.lua

HUDTextureElement = class(HUDTextureElement)

function HUDTextureElement:init(config)
	self._width = nil
	self._height = nil
	self.config = config
end

function HUDTextureElement:width()
	return self._width
end

function HUDTextureElement:height()
	return self._height
end

function HUDTextureElement:update_size(dt, t, gui, layout_settings)
	local atlas_settings = self:_texture_atlas_settings(layout_settings)

	self._width = (layout_settings.texture_width or atlas_settings.size[1]) * (layout_settings.scale or 1)
	self._height = (layout_settings.texture_height or atlas_settings.size[2]) * (layout_settings.scale or 1)
end

function HUDTextureElement:_texture_atlas_settings(layout_settings)
	return layout_settings.texture_atlas_settings_func and layout_settings.texture_atlas_settings_func(self.config.blackboard) or layout_settings.texture_atlas_settings
end

function HUDTextureElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

local WHITE = {
	255,
	255,
	255,
	255
}

function HUDTextureElement:_color(dt, t, gui, layout_settings, config)
	local color_table = config.blackboard and config.blackboard.color or layout_settings.color or WHITE

	if color_table[4] and color_table[1] <= 0 then
		return
	end

	return Color(color_table[1], color_table[2], color_table[3], color_table[4])
end

function HUDTextureElement:_texture(dt, t, gui, layout_settings, config)
	return config.blackboard and config.blackboard.texture or layout_settings.texture
end

function HUDTextureElement:_size()
	return Vector2(self._width, self._height)
end

function HUDTextureElement:_position()
	return Vector3(math.floor(self._x), math.floor(self._y), self._z)
end

function HUDTextureElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local color = self:_color(dt, t, gui, layout_settings, config)

	if not color then
		return
	end

	local position = self:_position(dt, t, gui, layout_settings, config)
	local size = self:_size(dt, t, gui, layout_settings, config)

	if config.gradient_shader_value then
		local material = Gui.material(gui, config.blackboard and config.blackboard.texture or layout_settings.texture)

		if material then
			Material.set_scalar(material, "gradient_threshold", config.gradient_shader_value)
		end
	end

	if layout_settings.texture_atlas then
		local texture_atlas_settings = self:_texture_atlas_settings(layout_settings)
		local uv00 = Vector2(texture_atlas_settings.uv00[1], texture_atlas_settings.uv00[2])
		local uv11 = Vector2(texture_atlas_settings.uv11[1], texture_atlas_settings.uv11[2])

		Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, position, size, color)
	else
		local texture = self:_texture(dt, t, gui, layout_settings, config)

		if config.transform_matrix then
			Gui.bitmap_3d(gui, texture, config.transform_matrix, Vector3(0, 0, 0), self._z, size, color)
		else
			Gui.bitmap(gui, texture, position, size, color)
		end
	end
end

function HUDTextureElement.create_from_config(config)
	return HUDTextureElement:new(config)
end
