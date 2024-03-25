-- chunkname: @scripts/helpers/hud_helper.lua

HUDHelper = HUDHelper or {}
HUDHelper.STANDARD_ASPECT_RATIO = 1.7777777777777777

function HUDHelper:layout_settings(settings_table)
	local res_width, res_height = Gui.resolution()
	local selected_width = 0
	local selected_height = 0
	local lowest_available_width = math.huge
	local lowest_available_height = math.huge

	for width, setting in pairs(settings_table) do
		if width <= res_width and selected_width < width then
			selected_width = width
		end

		if width < lowest_available_width then
			lowest_available_width = width
		end
	end

	if selected_width == 0 then
		selected_width = lowest_available_width
	end

	for height, setting in pairs(settings_table[selected_width]) do
		if height <= res_height and selected_height < height then
			selected_height = height
		end

		if height < lowest_available_height then
			lowest_available_height = height
		end
	end

	if selected_height == 0 then
		selected_height = lowest_available_height
	end

	return settings_table[selected_width][selected_height]
end

function HUDHelper:element_position(parent_element, element, layout_settings)
	local parent_width, parent_height

	if parent_element then
		parent_width = parent_element:width()
		parent_height = parent_element:height()
	else
		parent_width, parent_height = Gui.resolution()
	end

	local screen_x, screen_y, pivot_x, pivot_y

	if layout_settings.screen_align_x == "left" then
		screen_x = 0
	elseif layout_settings.screen_align_x == "center" then
		screen_x = parent_width / 2
	elseif layout_settings.screen_align_x == "right" then
		screen_x = parent_width
	end

	if layout_settings.screen_align_y == "bottom" then
		screen_y = 0
	elseif layout_settings.screen_align_y == "center" then
		screen_y = parent_height / 2
	elseif layout_settings.screen_align_y == "top" then
		screen_y = parent_height
	end

	screen_x = screen_x + layout_settings.screen_offset_x * parent_width
	screen_y = screen_y + layout_settings.screen_offset_y * parent_height

	if layout_settings.pivot_align_x == "left" then
		pivot_x = 0
	elseif layout_settings.pivot_align_x == "center" then
		pivot_x = -element:width() / 2
	elseif layout_settings.pivot_align_x == "right" then
		pivot_x = -element:width()
	end

	if layout_settings.pivot_align_y == "bottom" then
		pivot_y = 0
	elseif layout_settings.pivot_align_y == "center" then
		pivot_y = -element:height() / 2
	elseif layout_settings.pivot_align_y == "top" then
		pivot_y = -element:height()
	end

	pivot_x = pivot_x + layout_settings.pivot_offset_x
	pivot_y = pivot_y + layout_settings.pivot_offset_y

	local x = screen_x + pivot_x
	local y = screen_y + pivot_y

	return x, y
end

function HUDHelper:floating_icon_size(screen_z, texture_width, texture_height, min_scale, max_scale, min_scale_distance, max_scale_distance)
	local k = (max_scale - min_scale) / (max_scale_distance - min_scale_distance)
	local scale = k * (screen_z - max_scale_distance) + max_scale

	scale = math.clamp(scale, min_scale, max_scale)

	local width = texture_width * scale
	local height = texture_height * scale

	return width, height
end

function HUDHelper:floating_text_icon_size(screen_z, font_size, min_scale, max_scale, min_scale_distance, max_scale_distance)
	local k = (max_scale - min_scale) / (max_scale_distance - min_scale_distance)
	local scale = k * (screen_z - max_scale_distance) + max_scale

	scale = math.clamp(scale, min_scale, max_scale)

	local scaled_font_size = font_size * scale

	return scaled_font_size
end

function HUDHelper:clamped_icon_position(x, y, z)
	local res_width, res_height = Gui.resolution()
	local margin_x = res_height * self.STANDARD_ASPECT_RATIO * (1 - HUDSettings.default_zone.x_radius)
	local margin_y = res_height * (1 - HUDSettings.default_zone.y_radius)

	if z < 0 then
		x = res_width - x
	end

	if x < margin_x then
		x = margin_x
	elseif x > res_width - margin_x then
		x = res_width - margin_x
	end

	if y < margin_y or z < 6 then
		y = margin_y
	elseif y > res_height - margin_y then
		y = res_height - margin_y
	end

	return x, y
end

function HUDHelper:inside_attention_screen_zone(x, y, z)
	if z > 0 then
		local res_width, res_height = Gui.resolution()
		local width = res_height * self.STANDARD_ASPECT_RATIO
		local height = res_height

		x = x * (width / res_width)

		local center_x = width / 2
		local center_y = height / 2
		local radius_ratio = HUDSettings.attention_zone.y_radius / HUDSettings.attention_zone.x_radius
		local scaled_x = (x - center_x) / center_x * radius_ratio
		local scaled_y = (y - center_y) / center_y
		local distance = Vector3.length(Vector3(scaled_x, scaled_y, 0))

		return distance < HUDSettings.attention_zone.y_radius
	end
end

function HUDHelper:inside_default_screen_zone(x, y, z)
	if z > 0 then
		local res_width, res_height = Gui.resolution()
		local margin_x = res_height * self.STANDARD_ASPECT_RATIO * (1 - HUDSettings.default_zone.x_radius)
		local margin_y = res_height * (1 - HUDSettings.default_zone.y_radius)

		if margin_x < x and x < res_width - margin_x and margin_y < y and y < res_height - margin_y then
			return true
		end
	end
end

function HUDHelper:inside_screen(x, y, z)
	if z > 0 then
		local res_width, res_height = Gui.resolution()

		if x > 0 and x < res_width and y > 0 and y < res_height then
			return true
		end
	end
end

function HUDHelper:crop_text(gui, text, font, font_size, max_width, crop_suffix)
	local suffix = ""
	local index = string.len(text)

	while index > 0 do
		local min, max = Gui.text_extents(gui, text .. suffix, font, font_size)
		local width = max[1] - min[1]

		if width <= max_width then
			return text .. suffix
		end

		local char_begin, char_end = Utf8.location(text, index)

		index = char_begin - 1
		text = string.sub(text, 1, index)
		suffix = crop_suffix or ""
	end

	return ""
end

function HUDHelper:trunkate_text(text, max_length, trunkate_suffix, replace_all_with_suffix)
	local length = string.len(text)
	local index = 1
	local num_chars = 0
	local _

	while index <= length do
		_, index = Utf8.location(text, index)
		num_chars = num_chars + 1

		if num_chars == max_length then
			break
		end
	end

	local new_text = string.sub(text, 1, index - 1)

	if index - 1 ~= length and trunkate_suffix then
		if replace_all_with_suffix then
			new_text = trunkate_suffix
		else
			new_text = new_text .. trunkate_suffix
		end
	end

	return new_text
end

function HUDHelper:player_color(local_player, other_player)
	local color_table

	if local_player.team and local_player.team == other_player.team then
		if local_player.squad_index and local_player.squad_index == other_player.squad_index then
			color_table = HUDSettings.player_colors.squad_member
		else
			color_table = HUDSettings.player_colors.team_member
		end
	else
		color_table = HUDSettings.player_colors.enemy
	end

	return color_table
end

function HUDHelper:render_version_info(gui)
	local res_width, res_height = Gui.resolution()
	local text_size = 18
	local build = script_data.build_identifier or "???"
	local revision = script_data.settings.content_revision or "???"
	local text = "Content revision: " .. revision .. " Build version: " .. build

	if rawget(_G, "Steam") then
		local appid = Steam.app_id()

		text = text .. " Appid: " .. appid
	end

	local min, max = Gui.text_extents(gui, text, MenuSettings.fonts.menu_font.font, text_size)
	local width = max[1] - min[1]
	local height = max[3] - min[3]
	local x = res_width - width - 8
	local y = height

	Gui.text(gui, text, MenuSettings.fonts.menu_font.font, text_size, MenuSettings.fonts.menu_font.material, Vector3(x, y, 102), Color(255, 255, 255, 255))
	Gui.text(gui, text, MenuSettings.fonts.menu_font.font, text_size, MenuSettings.fonts.menu_font.material, Vector3(x + 2, y - 2, 101), Color(255, 0, 0, 0))
end

function HUDHelper:render_fps(gui, dt)
	local fps

	fps = dt < 1e-07 and 0 or 1 / dt

	local text = string.format("%i FPS", fps)
	local color

	if fps < 30 then
		color = Color(255, 255, 80, 80)
	else
		color = Color(255, 255, 255, 255)
	end

	local res_width, res_height = Gui.resolution()
	local text_size = 24
	local min, max = Gui.text_extents(gui, text, MenuSettings.fonts.menu_font.font, text_size)
	local width = max[1] - min[1]
	local height = max[3] - min[3]
	local x = res_width - width - 8
	local y = height + 16

	Gui.text(gui, text, MenuSettings.fonts.menu_font.font, text_size, MenuSettings.fonts.menu_font.material, Vector3(x, y, 102), color)
	Gui.text(gui, text, MenuSettings.fonts.menu_font.font, text_size, MenuSettings.fonts.menu_font.material, Vector3(x + 2, y - 2, 101), Color(255, 0, 0, 0))
end

function HUDHelper.floating_hud_icon_color(player, settings, blackboard, dt, t)
	local color_table = {
		255,
		255,
		255,
		255
	}
	local alpha_mul = 1

	if blackboard then
		if blackboard.owner_team_side and player.team then
			if blackboard.owner_team_side == "neutral" then
				color_table = HUDSettings.player_colors.neutral_team
			elseif blackboard.owner_team_side == player.team.side then
				color_table = HUDSettings.player_colors.team_member
			else
				color_table = HUDSettings.player_colors.enemy
			end

			if blackboard.being_captured then
				alpha_mul = math.abs(t % 1 - 0.5) * 2
			end
		elseif blackboard.color then
			color_table = blackboard.color
		elseif settings.color then
			color_table = settings.color
		end
	end

	return Color(alpha_mul * color_table[1], color_table[2], color_table[3], color_table[4])
end

function HUDHelper.atlas_material(atlas_name, material_name, masked)
	local real_atlas = rawget(_G, atlas_name)

	fassert(real_atlas, "[HUDHelper.atlas_material] There is no such atlas(%q)", tostring(atlas_name))

	local material_table = real_atlas[material_name]

	fassert(material_table, "[HUDHelper.atlas_material] There is no material name (%q) in atlas (%q)", tostring(material_name), tostring(atlas_name))

	local material = masked and atlas_name .. "_masked" or atlas_name
	local uv00 = Vector2(material_table.uv00[1], material_table.uv00[2])
	local uv11 = Vector2(material_table.uv11[1], material_table.uv11[2])
	local size = Vector2(material_table.size[1], material_table.size[2])

	return material, uv00, uv11, size
end
