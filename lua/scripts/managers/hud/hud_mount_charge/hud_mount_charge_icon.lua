-- chunkname: @scripts/managers/hud/hud_mount_charge/hud_mount_charge_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDMountChargeIcon = class(HUDMountChargeIcon, HUDTextureElement)

function HUDMountChargeIcon:init(config)
	HUDMountChargeIcon.super.init(self, config)
end

function HUDMountChargeIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local mount_locomotion = blackboard.mount_locomotion

	if mount_locomotion and mount_locomotion.current_state:can_charge(t) then
		layout_settings.color = {
			255,
			255,
			255,
			255
		}
	else
		layout_settings.color = {
			255,
			150,
			150,
			150
		}
	end

	layout_settings.texture_atlas_settings = HUDAtlas.sprint

	HUDMountChargeIcon.super.render(self, dt, t, gui, layout_settings)
end

function HUDMountChargeIcon.create_from_config(config)
	return HUDMountChargeIcon:new(config)
end
