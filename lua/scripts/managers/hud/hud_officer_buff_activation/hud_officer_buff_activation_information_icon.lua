-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_information_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDOfficerBuffActivationInformationIcon = class(HUDOfficerBuffActivationInformationIcon, HUDTextureElement)

function HUDOfficerBuffActivationInformationIcon:init(config)
	HUDOfficerBuffActivationInformationIcon.super.init(self, config)
end

function HUDOfficerBuffActivationInformationIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard

	if blackboard.buff_type then
		if config.name == "key_circle2" then
			local pad_active = Managers.input:pad_active(1)

			if not pad_active then
				return
			end
		end

		HUDOfficerBuffActivationInformationIcon.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDOfficerBuffActivationInformationIcon.create_from_config(config)
	return HUDOfficerBuffActivationInformationIcon:new(config)
end
