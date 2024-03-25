-- chunkname: @scripts/managers/hud/hud_pose_charge/hud_pose_charge_circle_segment.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPoseChargeCircleSegment = class(HUDPoseChargeCircleSegment, HUDTextureElement)

function HUDPoseChargeCircleSegment:init(config)
	HUDPoseChargeCircleSegment.super.init(self, config)

	self._circle_radius = config.circle_radius
end

function HUDPoseChargeCircleSegment:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local rot_angle = blackboard.direction_offset_angle
	local circle_radius = self._circle_radius
	local pos_x = x + self._width / 2 + circle_radius * math.cos(-rot_angle + math.pi * 0.5)
	local pos_y = y + self._height / 2 + circle_radius * math.sin(-rot_angle + math.pi * 0.5)
	local trans_pos_x = pos_x - self._width / 2
	local trans_pos_y = pos_y - self._height / 2

	layout_settings.color = {
		255 * config.alpha_multiplier,
		layout_settings.color[2],
		layout_settings.color[3],
		layout_settings.color[4]
	}
	config.transform_matrix = Rotation2D(Vector2(trans_pos_x, trans_pos_y), rot_angle, Vector2(pos_x, pos_y))

	HUDPoseChargeCircleSegment.super.update_position(self, dt, t, layout_settings, x, y, z)
end

function HUDPoseChargeCircleSegment.create_from_config(config)
	return HUDPoseChargeCircleSegment:new(config)
end
