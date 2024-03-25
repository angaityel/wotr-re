-- chunkname: @scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_cooldown.lua

require("scripts/managers/hud/shared_hud_elements/hud_circle_cooldown")

HUDTaggingActivationCooldown = class(HUDTaggingActivationCooldown, HUDCircleCooldown)

function HUDTaggingActivationCooldown:init(config)
	HUDTaggingActivationCooldown.super.init(self, config)
end

function HUDTaggingActivationCooldown:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard

	if blackboard.cooldown_time - t > 0 then
		HUDTaggingActivationCooldown.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDTaggingActivationCooldown.create_from_config(config)
	return HUDTaggingActivationCooldown:new(config)
end
