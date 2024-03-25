-- chunkname: @scripts/managers/hud/hud_call_horse/hud_call_horse_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDCallHorseTimer = class(HUDCallHorseTimer, HUDCircleTimer)

function HUDCallHorseTimer:init(config)
	HUDCallHorseTimer.super.init(self, config)
end

function HUDCallHorseTimer:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard
	local player_unit = blackboard.player_unit
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

	if locomotion.calling_horse then
		HUDCallHorseTimer.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDCallHorseTimer.create_from_config(config)
	return HUDCallHorseTimer:new(config)
end
