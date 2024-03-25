-- chunkname: @scripts/managers/hud/hud_damage_numbers/hud_damage_number.lua

HUDDamageNumber = class(HUDDamageNumber)

function HUDDamageNumber:init(config)
	self.config = config
	self.font_settings = MenuSettings.fonts.hell_shark_36
end

function HUDDamageNumber:width()
	return 0
end

function HUDDamageNumber:height()
	return 0
end

function HUDDamageNumber:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local progression = (t - config.start_time) / 2
	local time_to_large = 0.08
	local damage_based_size = config.damage / 2000

	damage_based_size = damage_based_size > 0.1 and 0.1 or damage_based_size

	local min_font_size = (damage_based_size + 0.11) * config.ranged_size_multiplier
	local max_font_size = (damage_based_size + min_font_size * 2) * config.ranged_size_multiplier
	local font_size_difference = max_font_size - min_font_size

	if progression <= time_to_large then
		config.font_size = progression / time_to_large * font_size_difference + min_font_size
	else
		config.font_size = max_font_size - (progression - time_to_large) / (1 - time_to_large) * font_size_difference
	end
end

function HUDDamageNumber:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local progression = (t - config.start_time) / 2
end

function HUDDamageNumber:render(dt, t, gui, layout_settings)
	local config = self.config
	local progression = (t - config.start_time) / 2
	local c = config.colour
	local colour = Color(c[1], c[2], c[3], c[4])
	local shadow_colour = Color(c[1], 0, 0, 0)

	if progression >= 1 then
		config.ended_function(config.id)

		colour = Color(0, c[2], c[3], c[4])
		shadow_colour = Color(0, 0, 0, 0)
	else
		local alpha = (1 - progression) * 255

		colour = Color(alpha, c[2], c[3], c[4])
		shadow_colour = Color(alpha, 0, 0, 0)
	end

	local camera_rotation = Managers.state.camera:camera_rotation(config.viewport_name)
	local pos = config.position:unbox()
	local transform_matrix = Matrix4x4.from_quaternion_position(camera_rotation, pos)
	local damage = math.floor(config.damage)
	local font_size = config.font_size
	local ranged_size_multiplier = config.ranged_size_multiplier
	local font_settings = self.font_settings
	local font_name = font_settings.font
	local font_material = font_settings.material
	local text_extent_min, text_extent_max = Gui.text_extents(gui, damage, font_name, font_size)
	local text_width = text_extent_max[1] - text_extent_min[1]
	local text_height = text_extent_max[3] - text_extent_min[3]
	local text_offset = Vector3(-text_width / 2, -text_height / 2, 0)
	local total_text_offset = Vector3.add(Vector3(0, progression * ranged_size_multiplier, 0), text_offset)
	local shield_width = font_size
	local shield_height = font_size
	local shield_offset = Vector3(-shield_width / 2, -shield_height / 2, 0)
	local total_shield_offset = Vector3.add(Vector3(0, progression * ranged_size_multiplier, 0), shield_offset)

	if damage > 0 then
		Gui.text_3d(gui, damage, font_name, font_size, font_material, transform_matrix, total_text_offset, 1, colour)
		Gui.text_3d(gui, damage, font_name, font_size, font_material, transform_matrix, Vector3(total_text_offset.x + 0.005 * ranged_size_multiplier, total_text_offset.y - 0.007 * ranged_size_multiplier, total_text_offset.z), 0, shadow_colour)
	else
		Gui.bitmap_3d(gui, "hud_damage_number_shield", transform_matrix, total_shield_offset, 10, Vector2(shield_width, shield_height), colour)
	end
end

function HUDDamageNumber.create_from_config(config)
	return HUDDamageNumber:new(config)
end
