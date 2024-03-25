-- chunkname: @scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDTaggingActivationTimer = class(HUDTaggingActivationTimer, HUDCircleTimer)

function HUDTaggingActivationTimer:init(config)
	HUDTaggingActivationTimer.super.init(self, config)
end

function HUDTaggingActivationTimer:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard
	local player = blackboard.player
	local player_unit = player.player_unit
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

	if locomotion.tagging and locomotion.time_to_tag > 0 then
		HUDTaggingActivationTimer.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDTaggingActivationTimer.create_from_config(config)
	return HUDTaggingActivationTimer:new(config)
end
