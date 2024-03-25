-- chunkname: @scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_background_circle.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDCrossbowMinigameBackgroundCircle = class(HUDCrossbowMinigameBackgroundCircle, HUDTextureElement)

function HUDCrossbowMinigameBackgroundCircle:init(config)
	HUDCrossbowMinigameBackgroundCircle.super.init(self, config)
end

function HUDCrossbowMinigameBackgroundCircle:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local trans_pos_x = blackboard.circle_pos_x - self._width / 2
	local trans_pos_y = blackboard.circle_pos_y - self._height / 2

	HUDCrossbowMinigameBackgroundCircle.super.update_position(self, dt, t, layout_settings, trans_pos_x, trans_pos_y, z)
end

function HUDCrossbowMinigameBackgroundCircle.create_from_config(config)
	return HUDCrossbowMinigameBackgroundCircle:new(config)
end
