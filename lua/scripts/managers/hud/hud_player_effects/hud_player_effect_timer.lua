-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPlayerEffectTimer = class(HUDPlayerEffectTimer, HUDTextureElement)

function HUDPlayerEffectTimer:init(config)
	HUDPlayerEffectTimer.super.init(self, config)
end

function HUDPlayerEffectTimer:render(dt, t, gui, layout_settings)
	local config = self.config
	local effect_type = config.effect_type
	local blackboard = config.blackboard[effect_type]
	local level = blackboard.level

	if effect_type and level > 0 and effect_type ~= "wounded" then
		local round_t = Managers.time:time("round")
		local buff_settings = Buffs[effect_type]
		local debuff_settings = Debuffs[effect_type]
		local render = false

		if buff_settings and blackboard.end_time >= round_t + AreaBuffSettings.FADE_TIME then
			config.gradient_shader_value = 1 - (blackboard.end_time - AreaBuffSettings.FADE_TIME - round_t) / buff_settings.duration
			layout_settings.texture = buff_settings.hud_timer_material
			render = true
		elseif debuff_settings and round_t <= blackboard.end_time then
			config.gradient_shader_value = 1 - (blackboard.end_time - round_t) / debuff_settings.duration
			layout_settings.texture = debuff_settings.hud_timer_material
			render = true
		end

		if render then
			HUDPlayerEffectTimer.super.render(self, dt, t, gui, layout_settings)
		end
	end
end

function HUDPlayerEffectTimer.create_from_config(config)
	return HUDPlayerEffectTimer:new(config)
end
