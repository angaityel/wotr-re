-- chunkname: @scripts/managers/hud/hud_cruise_control/hud_cruise_control_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDCruiseControlIcon = class(HUDCruiseControlIcon, HUDTextureElement)

function HUDCruiseControlIcon:init(config)
	HUDCruiseControlIcon.super.init(self, config)
end

function HUDCruiseControlIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local mount_locomotion = blackboard.mount_locomotion

	if not mount_locomotion then
		return
	end

	local gear = mount_locomotion.cruise_control_gear or 2
	local gear_name = HorseUnitMovementSettings.cruise_control.gears[gear].name
	local texture = layout_settings.gear_textures[gear_name]

	layout_settings.texture_atlas_settings = HUDAtlas[texture]

	HUDCruiseControlIcon.super.render(self, dt, t, gui, layout_settings)
end

function HUDCruiseControlIcon.create_from_config(config)
	return HUDCruiseControlIcon:new(config)
end
