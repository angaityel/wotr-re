-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDOfficerBuffActivationIcon = class(HUDOfficerBuffActivationIcon, HUDTextureElement)

function HUDOfficerBuffActivationIcon:init(config)
	HUDOfficerBuffActivationIcon.super.init(self, config)
end

function HUDOfficerBuffActivationIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local level = blackboard.level
	local buff_type = blackboard.buff_type

	if buff_type then
		local icon_texture = Perks[buff_type].hud_activation_icon

		if t >= blackboard.cooldown then
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

		layout_settings.texture_atlas_settings = HUDAtlas[icon_texture]

		HUDOfficerBuffActivationIcon.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDOfficerBuffActivationIcon.create_from_config(config)
	return HUDOfficerBuffActivationIcon:new(config)
end
