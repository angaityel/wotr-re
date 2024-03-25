-- chunkname: @scripts/managers/hud/hud_call_horse/hud_call_horse_cooldown.lua

require("scripts/managers/hud/shared_hud_elements/hud_circle_cooldown")

HUDCallHorseCooldown = class(HUDCallHorseCooldown, HUDCircleCooldown)

function HUDCallHorseCooldown:init(config)
	HUDCallHorseCooldown.super.init(self, config)
end

function HUDCallHorseCooldown:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard

	if blackboard.cooldown_time - t > 0 then
		HUDCallHorseCooldown.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDCallHorseCooldown.create_from_config(config)
	return HUDCallHorseCooldown:new(config)
end
