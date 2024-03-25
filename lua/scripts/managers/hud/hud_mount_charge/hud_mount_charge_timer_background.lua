-- chunkname: @scripts/managers/hud/hud_mount_charge/hud_mount_charge_timer_background.lua

HUDMountChargeTimerBackground = class(HUDMountChargeTimerBackground, HUDTextureElement)

function HUDMountChargeTimerBackground:init(config)
	HUDMountChargeTimer.super.init(self, config)
end

function HUDMountChargeTimerBackground:render(dt, t, gui, layout_settings, x, y, z)
	local blackboard = self.config.blackboard
	local mount_locomotion = blackboard.mount_locomotion

	if mount_locomotion.charging then
		HUDMountChargeTimerBackground.super.render(self, dt, t, gui, layout_settings, x, y, z)
	end
end

function HUDMountChargeTimerBackground.create_from_config(config)
	return HUDMountChargeTimerBackground:new(config)
end
