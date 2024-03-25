-- chunkname: @scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_circle.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDCrossbowMinigameCircle = class(HUDCrossbowMinigameCircle, HUDTextureElement)

function HUDCrossbowMinigameCircle:init(config)
	HUDCrossbowMinigameCircle.super.init(self, config)
end

function HUDCrossbowMinigameCircle:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local shake_x = 0
	local shake_y = 0

	if blackboard.missing then
		shake_x, shake_y = self:_random_circle_shake()
	end

	local texture_offset = config.blackboard.texture_offset
	local rot_angle = config.blackboard.grab_area_rot_angle + texture_offset

	config.blackboard.circle_pos_x = x + self._width / 2 + shake_x
	config.blackboard.circle_pos_y = y + self._height / 2 + shake_y
	config.gradient_shader_value = texture_offset / math.pi
	config.transform_matrix = Rotation2D(Vector2(x, y), rot_angle, Vector2(config.blackboard.circle_pos_x, config.blackboard.circle_pos_y))

	HUDCrossbowMinigameCircle.super.update_position(self, dt, t, layout_settings, x, y, z)
end

function HUDCrossbowMinigameCircle:_random_circle_shake()
	local num = 0.75
	local shake_x = math.random() < 0.5 and -num or num
	local shake_y = math.random() < 0.5 and -num or num

	return shake_x, shake_y
end

function HUDCrossbowMinigameCircle.create_from_config(config)
	return HUDCrossbowMinigameCircle:new(config)
end
