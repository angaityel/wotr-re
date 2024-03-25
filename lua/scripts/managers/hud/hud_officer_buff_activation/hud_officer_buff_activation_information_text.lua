-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_information_text.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDOfficerBuffActivationText = class(HUDOfficerBuffActivationText, HUDTextElement)

function HUDOfficerBuffActivationText:init(config)
	HUDOfficerBuffActivationText.super.init(self, config)
end

function HUDOfficerBuffActivationText:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local level = blackboard.level

	if blackboard.buff_type then
		local pad_active = Managers.input:pad_active(1)
		local controller_settings = pad_active and "pad360" or "keyboard_mouse"

		if config.name == "level_text" then
			blackboard.text = string.format("%.0f", level)
		elseif config.key_name == "shift_function" then
			if pad_active then
				local key = ActivePlayerControllerSettings[controller_settings].shift_function.key

				blackboard.text = L("pad360_" .. key)
			else
				return
			end
		else
			local key = ActivePlayerControllerSettings[controller_settings][blackboard.buff_name].key
			local key_locale_name = pad_active and L("pad360_" .. key) or ActivePlayerControllerSettings[controller_settings][blackboard.buff_name].key

			blackboard.text = key_locale_name
		end

		if Managers.input:pad_active(1) then
			self._x = self._x + (layout_settings.pad_offset_x or 0)
			self._y = self._y + (layout_settings.pad_offset_y or 0)
		end

		HUDOfficerBuffActivationText.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDOfficerBuffActivationText.create_from_config(config)
	return HUDOfficerBuffActivationText:new(config)
end
