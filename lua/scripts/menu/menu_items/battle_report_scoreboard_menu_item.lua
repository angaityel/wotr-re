-- chunkname: @scripts/menu/menu_items/battle_report_scoreboard_menu_item.lua

BattleReportScoreboardMenuItem = class(BattleReportScoreboardMenuItem, MenuItem)

function BattleReportScoreboardMenuItem:init(config, world)
	BattleReportScoreboardMenuItem.super.init(self, config, world)

	self._player_index = config.player_index
	self._player_name = config.player_name
	self._team_name = config.team_name
	self._stats = config.stats
	self._player_id = config.player_id
	self._network_id = config.network_id
	self._local_player_index = config.local_player_index
end

function BattleReportScoreboardMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function BattleReportScoreboardMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function BattleReportScoreboardMenuItem:render(dt, t, gui, layout_settings)
	local stats = self._stats
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local column_offset_x = layout_settings.text_offset_x
	local rank = stats:get(self._network_id, "rank")

	ScriptGUI.text(gui, rank, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[1]

	Gui.bitmap(gui, layout_settings.texture_coat_of_arms_dummy, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.texture_coat_of_arms_dummy_offset_y), self._z + 20), Vector2(layout_settings.texture_coat_of_arms_dummy_width, layout_settings.texture_coat_of_arms_dummy_height))

	column_offset_x = column_offset_x + layout_settings.column_width[2]

	local team_texture

	if self._team_name == "red" then
		team_texture = layout_settings.texture_team_rose_red
	elseif self._team_name == "white" then
		team_texture = layout_settings.texture_team_rose_white
	end

	if team_texture then
		Gui.bitmap(gui, team_texture, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.texture_team_rose_offset_y), self._z + 20), Vector2(layout_settings.texture_team_rose_width, layout_settings.texture_team_rose_height))
	end

	column_offset_x = column_offset_x + layout_settings.column_width[3]

	local player_name = self._player_name or "?"

	ScriptGUI.text(gui, player_name, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[4]

	local score = stats:get(self._network_id, "experience_round") or "?"

	ScriptGUI.text(gui, score, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[5]

	local kills = stats:get(self._network_id, "enemy_kills") or "?"

	ScriptGUI.text(gui, kills, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[6]

	local deaths = stats:get(self._network_id, "deaths") or "?"

	ScriptGUI.text(gui, deaths, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[7]

	local captures = stats:get(self._network_id, "objectives_captured") or L("menu_n_a")

	ScriptGUI.text(gui, captures, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[8]

	local capture_assists = stats:get(self._network_id, "objectives_captured_assist") or L("menu_n_a")

	ScriptGUI.text(gui, capture_assists, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[9]

	if self._highlighted then
		local c = layout_settings.background_color_highlighted
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z + 15), Vector2(self._width, self._height), color)
	elseif self._local_player_index == self._player_index then
		-- block empty
	end
end

function BattleReportScoreboardMenuItem:score()
	return self._stats:get(self._network_id, "experience_round")
end

function BattleReportScoreboardMenuItem:stats(name)
	return self._stats:get(self._network_id, name)
end

function BattleReportScoreboardMenuItem:player_name()
	return self._player_name
end

function BattleReportScoreboardMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "battle_report_scoreboard",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.battle_report_scoreboard,
		z = config.z,
		player_index = config.player_index,
		player_id = config.player_id,
		network_id = config.network_id,
		player_name = config.player_name,
		team_name = config.team_name,
		stats = config.stats,
		local_player_index = config.local_player_index
	}

	return BattleReportScoreboardMenuItem:new(config, compiler_data.world)
end
