-- chunkname: @scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_cross.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDCrossbowMinigameCross = class(HUDCrossbowMinigameCross, HUDTextureElement)

function HUDCrossbowMinigameCross:init(config)
	HUDCrossbowMinigameCross.super.init(self, config)

	self._circle_radius = 93
end

function HUDCrossbowMinigameCross:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local rot_angle = blackboard.hook_rot_angle
	local offset_angle = rot_angle - math.pi / 2 - 0.05555555555555555 * math.pi
	local swing_angle = 0.1111111111111111 * math.pi

	if blackboard.hitting then
		offset_angle = offset_angle + swing_angle
	elseif blackboard.missing then
		offset_angle = rot_angle
	else
		offset_angle = offset_angle - swing_angle
	end

	local circle_radius = self._circle_radius
	local cross_pos_x = blackboard.circle_pos_x + (circle_radius - 25) * math.cos(-rot_angle + math.pi * 0.5)
	local cross_pos_y = blackboard.circle_pos_y + (circle_radius - 25) * math.sin(-rot_angle + math.pi * 0.5)
	local trans_pos_x = cross_pos_x - self._width / 2
	local trans_pos_y = cross_pos_y - self._height / 2

	config.transform_matrix = Rotation2D(Vector2(trans_pos_x, trans_pos_y), offset_angle, Vector2(cross_pos_x, cross_pos_y))

	HUDCrossbowMinigameCross.super.update_position(self, dt, t, layout_settings, trans_pos_x, trans_pos_y, z)
end

function HUDCrossbowMinigameCross:render(dt, t, gui, layout_settings)
	local blackboard = self.config.blackboard

	if blackboard.attempts == 0 and not blackboard.missing and not blackboard.hitting then
		return
	end

	layout_settings.color[1] = blackboard.cross_alpha or 255

	HUDCrossbowMinigameCross.super.render(self, dt, t, gui, layout_settings)
end

function HUDCrossbowMinigameCross.create_from_config(config)
	return HUDCrossbowMinigameCross:new(config)
end
