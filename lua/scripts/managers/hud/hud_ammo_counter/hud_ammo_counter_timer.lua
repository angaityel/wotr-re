-- chunkname: @scripts/managers/hud/hud_ammo_counter/hud_ammo_counter_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDAmmoCounterTimer = class(HUDAmmoCounterTimer, HUDTextureElement)

function HUDAmmoCounterTimer:init(config)
	HUDAmmoCounterTimer.super.init(self, config)
end

function HUDAmmoCounterTimer:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard

	config.gradient_shader_value = blackboard.text == blackboard.maximum_ammo and 1 or blackboard.timer

	HUDAmmoCounterTimer.super.render(self, dt, t, gui, layout_settings)
end

function HUDAmmoCounterTimer.create_from_config(config)
	return HUDAmmoCounterTimer:new(config)
end
