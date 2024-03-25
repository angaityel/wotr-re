-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_container_element.lua

HUDOfficerBuffActivationContainerElement = class(HUDOfficerBuffActivationContainerElement, HUDContainerElement)

function HUDOfficerBuffActivationContainerElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	local config = self.config
	local amount_of_active_buffs = 0

	for id, element in pairs(self._elements) do
		local blackboard = element.config.blackboard

		if blackboard and blackboard.buff_type then
			local element_layout_settings = HUDHelper:layout_settings(element.config.layout_settings)

			element_layout_settings.pivot_offset_x = amount_of_active_buffs * layout_settings.container_element_spacing_x

			local offset_x, offset_y = HUDHelper:element_position(self, element, element_layout_settings)
			local element_x = offset_x + x
			local element_y = offset_y + y
			local element_z = (element.config.z or 1) + z

			element:update_position(dt, t, element_layout_settings, element_x, element_y, element_z)

			amount_of_active_buffs = amount_of_active_buffs + 1
		end
	end
end

function HUDOfficerBuffActivationContainerElement.create_from_config(config)
	return HUDOfficerBuffActivationContainerElement:new(config)
end
