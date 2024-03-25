-- chunkname: @scripts/managers/hud/hud_hit_marker/hud_hit_marker_marker.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDHitMarkerMarker = class(HUDHitMarkerMarker, HUDTextureElement)

function HUDHitMarkerMarker:init(config)
	HUDHitMarkerMarker.super.init(self, config)

	self._alpha_value = 255
	self._alpha_timer = 0
	self._active = false
end

function HUDHitMarkerMarker:update_size(dt, t, gui, layout_settings)
	local config = self.config

	if config.active then
		self._alpha_value = 255
		self._alpha_timer = t + 3
		self._active = true
		config.active = false

		if config.same_team then
			layout_settings.scale = 1
			config.diagonal = true
			layout_settings.color[3] = 0
			layout_settings.color[4] = 0
		else
			layout_settings.scale = 1
			config.diagonal = false
			layout_settings.color[3] = 255
			layout_settings.color[4] = 255
		end
	end

	HUDHitMarkerMarker.super.update_size(self, dt, t, gui, layout_settings)
end

function HUDHitMarkerMarker:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config

	if config.diagonal then
		config.transform_matrix = Rotation2D(Vector2(x, y), math.pi / 4, Vector2(x + self._width * 0.5, y + self._height * 0.5))
	else
		config.transform_matrix = Rotation2D(Vector2(x, y), 0, Vector2(0, 0))
	end

	if t <= self._alpha_timer then
		self._alpha_value = self:_calculate_alpha(t)
	elseif self._active then
		self._active = false

		Managers.state.event:trigger("event_hit_marker_deactivated")
	end

	layout_settings.color = {
		self._alpha_value,
		layout_settings.color[2],
		layout_settings.color[3],
		layout_settings.color[4]
	}

	HUDHitMarkerMarker.super.update_position(self, dt, t, layout_settings, x, y, z)
end

function HUDHitMarkerMarker:_calculate_alpha(t)
	local alpha_value = 255 * (self._alpha_timer - t) / 5

	return alpha_value
end

function HUDHitMarkerMarker.create_from_config(config)
	return HUDHitMarkerMarker:new(config)
end
