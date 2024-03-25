-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_text_element_alt.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDTextElementAlt = class(HUDTextElementAlt, HUDTextElement)

function HUDTextElementAlt:init(config)
	HUDTextElementAlt.super.init(self, config)
end

function HUDTextElementAlt:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard

	if not blackboard then
		return
	end

	local pad_active = Managers.input:pad_active(1)
	local controller_settings = pad_active and "pad360" or "keyboard_mouse"

	if pad_active then
		local key = ActivePlayerControllerSettings[controller_settings][config.key_name].key
		local key_locale_name = L("pad360_" .. key)

		blackboard.text = key_locale_name
	else
		local controller = ActivePlayerControllerSettings[controller_settings][config.key_name]

		blackboard.text = controller.key
	end

	if Managers.input:pad_active(1) then
		self._x = self._x + (layout_settings.pad_offset_x or 0)
		self._y = self._y + (layout_settings.pad_offset_y or 0)
	end

	HUDTextElementAlt.super.render(self, dt, t, gui, layout_settings)
end

function HUDTextElementAlt.create_from_config(config)
	return HUDTextElementAlt:new(config)
end
