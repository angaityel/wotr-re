-- chunkname: @scripts/menu/menu_containers/attachment_info_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

AttachmentInfoMenuContainer = class(AttachmentInfoMenuContainer, MenuContainer)

function AttachmentInfoMenuContainer:init()
	AttachmentInfoMenuContainer.super.init(self)

	self._attachment_settings = {}
end

function AttachmentInfoMenuContainer:clear()
	self._attachment_settings = {}
end

function AttachmentInfoMenuContainer:load_gear_attachment(gear_name, attachment_category, attachment_name)
	if attachment_category and attachment_name then
		local attachment_settings = WeaponHelper:attachment_settings(gear_name, attachment_category, attachment_name)
		local multipliers

		if attachment_settings.multipliers then
			for multiplier_name, multiplier_value in pairs(attachment_settings.multipliers) do
				multipliers = multipliers or {}

				local gear_property_name, ui_invert = OutfitHelper.attachment_multiplier_to_gear_property(multiplier_name)
				local value = OutfitHelper.gear_property(gear_name, gear_property_name)
				local max_value = OutfitHelper.gear_property_max(gear_property_name)
				local modified_value

				if multiplier_name == "crossbow_hit_section" then
					modified_value = value + multiplier_value * 15
				else
					modified_value = value * multiplier_value
				end

				if ui_invert then
					local min_value = OutfitHelper.gear_property_min(gear_property_name)

					value = max_value + min_value - value
					modified_value = max_value + min_value - modified_value
				end

				multipliers[#multipliers + 1] = {
					name = L("attachment_multiplier_" .. multiplier_name),
					value = value,
					modified_value = modified_value,
					max_value = max_value
				}
			end
		end

		self._attachment_settings = {
			textures = attachment_settings.ui_textures_big,
			multipliers = multipliers
		}
	else
		self._attachment_settings = {}
	end
end

function AttachmentInfoMenuContainer:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width

	local height = layout_settings.padding_top + layout_settings.texture_background_height + layout_settings.padding_bottom

	if self._attachment_settings.multipliers then
		local num_multipliers = table.size(self._attachment_settings.multipliers)

		height = height + math.abs(layout_settings.text_start_offset_y)
		height = height + num_multipliers * math.abs(layout_settings.text_offset_y) + num_multipliers * math.abs(layout_settings.bar_offset_y)
	end

	self._height = height
end

function AttachmentInfoMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function AttachmentInfoMenuContainer:render(dt, t, gui, layout_settings)
	if self._attachment_settings.textures then
		local texture_x = math.floor(self._x + layout_settings.texture_offset_x)
		local texture_y = math.floor(self._y + self._height - layout_settings.texture_size - (layout_settings.padding_top or 0)) + layout_settings.texture_offset_y
		local texture_size = Vector2(layout_settings.texture_size, layout_settings.texture_size)
		local num_textures = #self._attachment_settings.textures

		for i, texture in ipairs(self._attachment_settings.textures) do
			local texture_settings = layout_settings.texture_atlas_settings[texture]
			local uv00 = Vector2(texture_settings.uv00[1], texture_settings.uv00[2])
			local uv11 = Vector2(texture_settings.uv11[1], texture_settings.uv11[2])
			local offset_z = num_textures - i + 2

			Gui.bitmap_uv(gui, layout_settings.texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + offset_z), texture_size)
		end

		if self._attachment_settings.multipliers then
			local stats_x = math.floor(self._x)
			local stats_y = math.floor(self._y + self._height - (layout_settings.padding_top or 0) - layout_settings.texture_background_height + layout_settings.text_start_offset_y)
			local stats_text_c = layout_settings.text_color
			local stats_text_color = Color(stats_text_c[1], stats_text_c[2], stats_text_c[3], stats_text_c[4])
			local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
			local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
			local shadow_color_table = layout_settings.drop_shadow_color
			local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
			local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])

			for _, multiplier_config in ipairs(self._attachment_settings.multipliers) do
				stats_y = stats_y + layout_settings.text_offset_y

				ScriptGUI.text(gui, multiplier_config.name, font, layout_settings.font_size, font_material, Vector3(math.floor(stats_x), math.floor(stats_y), self._z + 1), stats_text_color, shadow_color, shadow_offset)

				stats_y = stats_y + layout_settings.bar_offset_y

				Gui.bitmap(gui, layout_settings.bar_background_texture, Vector3(math.floor(stats_x), math.floor(stats_y), self._z + 1), Vector2(math.floor(layout_settings.bar_width), layout_settings.bar_background_texture_height))

				local bar_width, multiplied_bar_width

				if multiplier_config.value == math.huge then
					bar_width = math.ceil(layout_settings.bar_width)
					multiplied_bar_width = 0

					Gui.bitmap(gui, layout_settings.bar_infinite_texture, Vector3(math.floor(stats_x + bar_width), math.floor(stats_y + layout_settings.bar_background_texture_height / 2 - layout_settings.bar_infinite_texture_height / 2), self._z + 2), Vector2(layout_settings.bar_infinite_texture_width, layout_settings.bar_infinite_texture_height))
				else
					bar_width = math.ceil(layout_settings.bar_width * (multiplier_config.value / multiplier_config.max_value))
					multiplied_bar_width = math.ceil(layout_settings.bar_width * ((multiplier_config.modified_value - multiplier_config.value) / multiplier_config.max_value))
				end

				Gui.bitmap(gui, layout_settings.bar_filling_texture, Vector3(math.floor(stats_x), math.floor(stats_y), self._z + 2), Vector2(bar_width, layout_settings.bar_filling_texture_height))

				if multiplier_config.modified_value > multiplier_config.value then
					Gui.bitmap(gui, layout_settings.bar_filling_light_texture, Vector3(math.floor(stats_x + bar_width), math.floor(stats_y), self._z + 3), Vector2(multiplied_bar_width, layout_settings.bar_filling_light_texture_height))
				else
					Gui.bitmap(gui, layout_settings.bar_filling_dark_texture, Vector3(math.floor(stats_x + bar_width), math.floor(stats_y), self._z + 3), Vector2(multiplied_bar_width, layout_settings.bar_filling_dark_texture_height))
				end
			end
		end
	end

	local bgr_x = self._x
	local bgr_y = math.floor(self._y + self._height - layout_settings.texture_background_height - (layout_settings.padding_top or 0))

	Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(bgr_x), math.floor(bgr_y), self._z + 1), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height))
end

function AttachmentInfoMenuContainer.create_from_config()
	return AttachmentInfoMenuContainer:new()
end
