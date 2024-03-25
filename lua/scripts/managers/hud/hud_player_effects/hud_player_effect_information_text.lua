-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_information_text.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDPlayerEffectInformationText = class(HUDPlayerEffectInformationText, HUDTextElement)

function HUDPlayerEffectInformationText:init(config)
	HUDPlayerEffectInformationText.super.init(self, config)
end

function HUDPlayerEffectInformationText:render(dt, t, gui, layout_settings)
	local config = self.config
	local effect_type = config.effect_type
	local blackboard = config.blackboard[effect_type]
	local buff_settings = Buffs[effect_type]
	local debuff_settings = Debuffs[effect_type]
	local level = blackboard.level

	config.text = string.format("%.0f", level)

	if buff_settings and level > 0 or not buff_settings and level > 1 then
		HUDPlayerEffectInformationText.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDPlayerEffectInformationText.create_from_config(config)
	return HUDPlayerEffectInformationText:new(config)
end
