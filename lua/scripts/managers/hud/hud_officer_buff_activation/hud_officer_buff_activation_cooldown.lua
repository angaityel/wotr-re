-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_cooldown.lua

require("scripts/managers/hud/shared_hud_elements/hud_circle_cooldown")

HUDOfficerBuffActivationCooldown = class(HUDOfficerBuffActivationCooldown, HUDCircleCooldown)

function HUDOfficerBuffActivationCooldown:init(config)
	HUDOfficerBuffActivationCooldown.super.init(self, config)
end

function HUDOfficerBuffActivationCooldown:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local buff_type = blackboard.buff_type

	if not buff_type then
		return
	end

	if t < blackboard.cooldown then
		config.cooldown_shader_value = (blackboard.cooldown - t) / Buffs[buff_type].cooldown_time

		local id = config.container_id

		layout_settings.texture = id == 1 and layout_settings.texture_buff_1 or layout_settings.texture_buff_2

		HUDOfficerBuffActivationCooldown.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDOfficerBuffActivationCooldown.create_from_config(config)
	return HUDOfficerBuffActivationCooldown:new(config)
end
