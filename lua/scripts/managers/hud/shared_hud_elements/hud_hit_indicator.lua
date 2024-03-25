-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_hit_indicator.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDHitIndicator = class(HUDHitIndicator, HUDTextureElement)

function HUDHitIndicator:update_position(dt, t, layout_settings, x, y, z)
	HUDHitIndicator.super.update_position(self, dt, t, layout_settings, x, y, z)

	local config = self.config
	local camera_rotation = Managers.state.camera:camera_rotation(config.viewport_name)
	local flat_camera_dir = Vector3.normalize(Vector3.flat(Quaternion.forward(camera_rotation)))
	local impact_dir = config.impact_direction:unbox()
	local angle = math.atan2(impact_dir.x, impact_dir.y) - math.atan2(flat_camera_dir.x, flat_camera_dir.y)
	local pos = Vector2(x, y)
	local width, height = Application.resolution()
	local pivot = Vector2(width * 0.5, height * 0.5)

	layout_settings.scale = height / 1080
	self.config.transform_matrix = Rotation2D(pos, angle, pivot)
end

function HUDHitIndicator.create_from_config(config, viewport_name, impact_direction)
	config.impact_direction = Vector3Box(impact_direction)
	config.viewport_name = viewport_name

	return HUDHitIndicator:new(config)
end

function HUDHitIndicator:render(dt, t, gui, layout_settings)
	local config = self.config
	local color = config.blackboard and config.blackboard.color or layout_settings.color or {
		255,
		255,
		255,
		255
	}

	if config.gradient_shader_value then
		local material = Gui.material(gui, layout_settings.texture)

		if material then
			Material.set_scalar(material, "gradient_threshold", config.gradient_shader_value)
		end
	end

	if config.transform_matrix then
		Gui.bitmap_3d(gui, layout_settings.texture, config.transform_matrix, Vector3(0, 0, 0), self._z, Vector2(self._width, self._height), Color(color[1], color[2], color[3], color[4]))
	elseif layout_settings.texture_atlas then
		if layout_settings.texture_atlas_settings_func then
			local texture_atlas_settings = layout_settings.texture_atlas_settings_func(config.blackboard)
			local uv00 = Vector2(texture_atlas_settings.uv00[1], texture_atlas_settings.uv00[2])
			local uv11 = Vector2(texture_atlas_settings.uv11[1], texture_atlas_settings.uv11[2])
			local size = Vector2(texture_atlas_settings.size[1], texture_atlas_settings.size[2])

			Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, Vector3(self._x, self._y, self._z), size, Color(color[1], color[2], color[3], color[4]))
		else
			local uv00 = Vector2(layout_settings.texture_atlas_settings.uv00[1], layout_settings.texture_atlas_settings.uv00[2])
			local uv11 = Vector2(layout_settings.texture_atlas_settings.uv11[1], layout_settings.texture_atlas_settings.uv11[2])
			local size = Vector2(layout_settings.texture_width, layout_settings.texture_height)

			Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, Vector3(self._x, self._y, self._z), size, Color(color[1], color[2], color[3], color[4]))
		end
	else
		Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(self._width, self._height), Color(color[1], color[2], color[3], color[4]))
	end
end
