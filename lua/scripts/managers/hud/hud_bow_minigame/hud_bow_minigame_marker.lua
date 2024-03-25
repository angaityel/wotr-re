-- chunkname: @scripts/managers/hud/hud_bow_minigame/hud_bow_minigame_marker.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDBowMinigameMarker = class(HUDBowMinigameMarker, HUDTextureElement)

function HUDBowMinigameMarker:init(config)
	HUDBowMinigameMarker.super.init(self, config)

	self._circle_radius = 76
	self._rot_angle = nil
end

function HUDBowMinigameMarker:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local rot_angle = blackboard.marker_rotations[config.name]
	local circle_radius = self._circle_radius
	local pos_x = x + self._width / 2 + circle_radius * math.cos(-rot_angle + math.pi * 0.5)
	local pos_y = y + self._height / 2 + circle_radius * math.sin(-rot_angle + math.pi * 0.5)
	local trans_pos_x = pos_x - self._width / 2
	local trans_pos_y = pos_y - self._height / 2

	config.transform_matrix = Rotation2D(Vector2(trans_pos_x, trans_pos_y), rot_angle, Vector2(pos_x, pos_y))

	HUDBowMinigameMarker.super.update_position(self, dt, t, layout_settings, trans_pos_x, trans_pos_y, z)
end

function HUDBowMinigameMarker.create_from_config(config)
	return HUDBowMinigameMarker:new(config)
end
