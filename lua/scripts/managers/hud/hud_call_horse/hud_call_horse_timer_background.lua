-- chunkname: @scripts/managers/hud/hud_call_horse/hud_call_horse_timer_background.lua

HUDCallHorseTimerBackground = class(HUDCallHorseTimerBackground, HUDTextureElement)

function HUDCallHorseTimerBackground:init(config)
	HUDCallHorseTimer.super.init(self, config)
end

function HUDCallHorseTimerBackground:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard
	local player_unit = blackboard.player_unit
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

	if locomotion.calling_horse then
		HUDCallHorseTimerBackground.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDCallHorseTimerBackground.create_from_config(config)
	return HUDCallHorseTimerBackground:new(config)
end
