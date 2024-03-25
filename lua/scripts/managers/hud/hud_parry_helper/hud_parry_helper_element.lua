-- chunkname: @scripts/managers/hud/hud_parry_helper/hud_parry_helper_element.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDParryHelperElement = class(HUDParryHelperElement, HUDTextureElement)

function HUDParryHelperElement:init(config)
	HUDParryHelperElement.super.init(self, config)

	self._circle_radius = config.circle_radius
	self._element_texture = nil
	self._element_color = nil
end

function HUDParryHelperElement:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local rot_angle = blackboard and blackboard[config.name]

	if rot_angle then
		local circle_radius = self._circle_radius
		local pos_x = x + self._width / 2 + circle_radius * math.cos(-rot_angle + math.pi * 0.5)
		local pos_y = y + self._height / 2 + circle_radius * math.sin(-rot_angle + math.pi * 0.5)
		local trans_pos_x = pos_x - self._width / 2
		local trans_pos_y = pos_y - self._height / 2

		config.transform_matrix = Rotation2D(Vector2(trans_pos_x, trans_pos_y), rot_angle, Vector2(pos_x, pos_y))

		HUDParryHelperElement.super.update_position(self, dt, t, layout_settings, x, y, z)
	end
end

function HUDParryHelperElement:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local rot_angle = blackboard and blackboard[config.name]

	if rot_angle then
		local delay_time = blackboard[config.name .. "_delay_time"]

		if delay_time then
			if t - delay_time > 0 then
				self._element_color = layout_settings.color
				self._element_texture = layout_settings.texture
			else
				self._element_color = layout_settings.color_2
				self._element_texture = layout_settings.texture_2
			end
		else
			self._element_color = layout_settings.color
			self._element_texture = layout_settings.texture
		end

		HUDParryHelperElement.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDParryHelperElement:_color()
	local color_table = self._element_color

	return Color(color_table[1], color_table[2], color_table[3], color_table[4])
end

function HUDParryHelperElement:_texture()
	return self._element_texture
end

function HUDParryHelperElement.create_from_config(config)
	return HUDParryHelperElement:new(config)
end
