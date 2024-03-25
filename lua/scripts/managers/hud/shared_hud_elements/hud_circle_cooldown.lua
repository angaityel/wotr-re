-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_circle_cooldown.lua

HUDCircleCooldown = class(HUDCircleCooldown, HUDTextureElement)

function HUDCircleCooldown:init(config)
	HUDCircleCooldown.super.init(self, config)
end

function HUDCircleCooldown:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local cooldown_shader_value = blackboard.cooldown_shader_value or config.cooldown_shader_value

	if cooldown_shader_value then
		config.gradient_shader_value = cooldown_shader_value
	else
		local remaining_time = blackboard.cooldown_time - t
		local duration = blackboard.cooldown_duration

		config.gradient_shader_value = remaining_time / duration
	end

	HUDCircleCooldown.super.render(self, dt, t, gui, layout_settings)
end

function HUDCircleCooldown.create_from_config(config)
	return HUDCircleCooldown:new(config)
end
