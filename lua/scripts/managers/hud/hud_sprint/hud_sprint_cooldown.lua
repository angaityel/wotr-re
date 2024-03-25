-- chunkname: @scripts/managers/hud/hud_sprint/hud_sprint_cooldown.lua

require("scripts/managers/hud/shared_hud_elements/hud_circle_cooldown")

HUDSprintCooldown = class(HUDSprintCooldown, HUDCircleCooldown)

function HUDSprintCooldown:init(config)
	HUDSprintCooldown.super.init(self, config)
end

function HUDSprintCooldown:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard

	if blackboard.cooldown_shader_value > 0 then
		HUDSprintCooldown.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDSprintCooldown.create_from_config(config)
	return HUDSprintCooldown:new(config)
end
