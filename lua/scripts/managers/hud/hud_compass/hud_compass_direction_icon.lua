-- chunkname: @scripts/managers/hud/hud_compass/hud_compass_direction_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDCompassDirectionIcon = class(HUDCompassDirectionIcon, HUDTextElement)

function HUDCompassDirectionIcon:init(config)
	HUDCompassDirectionIcon.super.init(self, config)
end

function HUDCompassDirectionIcon:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local cam_rotation = Camera.world_rotation(config.camera)
	local cam_forward = Quaternion.forward(cam_rotation)

	Vector3.set_z(cam_forward, 0)

	local angle = (math.atan2(config.world_direction[1], config.world_direction[2]) - math.atan2(cam_forward.x, cam_forward.y)) / (math.pi / 180)

	angle = angle + 180
	angle = angle % 360
	angle = angle - 180
	self._x = x + angle * (layout_settings.compass_width / layout_settings.degrees)
	self._y = y
	self._z = z
	self._angle = angle
end

function HUDCompassDirectionIcon:render(dt, t, gui, layout_settings)
	if math.abs(self._angle) < layout_settings.degrees / 2 then
		HUDCompassDirectionIcon.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDCompassDirectionIcon.create_from_config(config)
	return HUDCompassDirectionIcon:new(config)
end
