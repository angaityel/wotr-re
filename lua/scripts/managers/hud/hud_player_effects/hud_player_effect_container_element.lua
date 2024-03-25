-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_container_element.lua

HUDPlayerEffectContainerElement = class(HUDPlayerEffectContainerElement, HUDContainerElement)

function HUDPlayerEffectContainerElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	local config = self.config
	local amount_of_active_effects = 0
	local is_buff_container = config.is_buff_container

	for id, element in pairs(self._elements) do
		local blackboard = element.config.blackboard

		if blackboard and blackboard[element.config.effect_type].level > 0 then
			local element_layout_settings = HUDHelper:layout_settings(element.config.layout_settings)

			element_layout_settings.screen_offset_x = amount_of_active_effects * 0.125

			local offset_x, offset_y = HUDHelper:element_position(self, element, element_layout_settings)
			local element_x = offset_x + x
			local element_y = offset_y + y
			local element_z = (element.config.z or 1) + z

			element:update_position(dt, t, element_layout_settings, element_x, element_y, element_z)

			amount_of_active_effects = amount_of_active_effects + 1
		end
	end

	local res_width, res_height = Gui.resolution()

	layout_settings.screen_offset_x = (amount_of_active_effects - 1) * (30 / res_width) * -1 + (is_buff_container and PlayerEffectHUDSettings.buffs.container_position_x or PlayerEffectHUDSettings.debuffs.container_position_x)
	layout_settings.screen_offset_y = is_buff_container and PlayerEffectHUDSettings.buffs.container_position_y or PlayerEffectHUDSettings.debuffs.container_position_y
end

function HUDPlayerEffectContainerElement.create_from_config(config)
	return HUDPlayerEffectContainerElement:new(config)
end
