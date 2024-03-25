-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_timer_background.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPlayerEffectTimerBackground = class(HUDPlayerEffectTimerBackground, HUDTextureElement)

function HUDPlayerEffectTimerBackground:init(config)
	HUDPlayerEffectTimerBackground.super.init(self, config)
end

function HUDPlayerEffectTimerBackground:render(dt, t, gui, layout_settings)
	local config = self.config
	local effect_type = config.effect_type
	local blackboard = config.blackboard[effect_type]
	local level = blackboard.level

	if effect_type and level > 0 and effect_type ~= "wounded" then
		local round_t = Managers.time:time("round")
		local buff_settings = Buffs[effect_type]
		local debuff_settings = Debuffs[effect_type]

		if buff_settings and blackboard.end_time >= round_t + AreaBuffSettings.FADE_TIME or debuff_settings and round_t <= blackboard.end_time then
			HUDPlayerEffectTimer.super.render(self, dt, t, gui, layout_settings)
		end
	end
end

function HUDPlayerEffectTimerBackground.create_from_config(config)
	return HUDPlayerEffectTimerBackground:new(config)
end
