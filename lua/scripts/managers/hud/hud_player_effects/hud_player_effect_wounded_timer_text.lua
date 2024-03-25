-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_wounded_timer_text.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPlayerEffectWoundedTimerText = class(HUDPlayerEffectWoundedTimerText, HUDTextElement)

function HUDPlayerEffectWoundedTimerText:init(config)
	HUDPlayerEffectWoundedTimerText.super.init(self, config)
end

function HUDPlayerEffectWoundedTimerText:render(dt, t, gui, layout_settings)
	local config = self.config
	local effect_type = config.effect_type
	local blackboard = config.blackboard[effect_type]
	local level = blackboard.level

	if effect_type and level > 0 then
		local round_t = Managers.time:time("round")
		local time_left = math.abs(math.max(math.ceil(blackboard.end_time - round_t), 0))

		config.text = string.format("%.0f", time_left)

		HUDPlayerEffectWoundedTimerText.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDPlayerEffectWoundedTimerText.create_from_config(config)
	return HUDPlayerEffectWoundedTimerText:new(config)
end
