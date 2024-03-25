-- chunkname: @scripts/managers/hud/hud_deserting/hud_deserting_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDDesertingTimer = class(HUDDesertingTimer, HUDTextElement)

function HUDDesertingTimer:init(config)
	HUDDesertingTimer.super.init(self, config)
end

function HUDDesertingTimer:render(dt, t, gui, layout_settings)
	local config = self.config
	local deserter_timer = config.deserter_timer
	local timer = math.ceil(deserter_timer - t)

	config.text = string.format("%.0f", timer)

	HUDDesertingTimer.super.render(self, dt, t, gui, layout_settings)
end

function HUDDesertingTimer.create_from_config(config)
	return HUDDesertingTimer:new(config)
end
