-- chunkname: @scripts/menu/menu_items/scoreboard_player_menu_item.lua

ScoreboardPlayerMenuItem = class(ScoreboardPlayerMenuItem, MenuItem)

function ScoreboardPlayerMenuItem:init(config, world)
	ScoreboardPlayerMenuItem.super.init(self, config, world)

	self._local_player = config.local_player
	self._player = config.player
	self._network_id = config.player:network_id()
	self._stats = Managers.state.stats_collection
end

function ScoreboardPlayerMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function ScoreboardPlayerMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function ScoreboardPlayerMenuItem:render(dt, t, gui, layout_settings)
	local player = self._player
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local column_offset_x = 0

	Gui.bitmap(gui, layout_settings.texture_coat_of_arms_dummy, Vector3(math.floor(self._x + column_offset_x + layout_settings.texture_coat_of_arms_dummy_offset_x), math.floor(self._y + layout_settings.texture_coat_of_arms_dummy_offset_y), self._z + 20), Vector2(layout_settings.texture_coat_of_arms_dummy_width, layout_settings.texture_coat_of_arms_dummy_height))

	column_offset_x = column_offset_x + layout_settings.column_width[1]

	local player_name = self:player_name()
	local player_name_truncated = HUDHelper:crop_text(gui, player_name, font, layout_settings.font_size, layout_settings.column_width[2] - 10, "...")

	ScriptGUI.text(gui, player_name_truncated, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[2]

	local rank = self._stats:get(self._network_id, "rank")

	ScriptGUI.text(gui, rank, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[3]

	local status_texture
	local local_team = self._local_player.team
	local player_team = player.team
	local allow_ghost_talking = Managers.state.game_mode:allow_ghost_talking()
	local show_enemy_info = allow_ghost_talking or player_team == local_team

	if show_enemy_info then
		if Unit.alive(player.player_unit) then
			local damage_ext = ScriptUnit.extension(player.player_unit, "damage_system")

			if damage_ext._dead then
				status_texture = layout_settings.texture_status_dead
			elseif damage_ext._knocked_down then
				status_texture = layout_settings.texture_status_knocked_down
			elseif damage_ext._wounded then
				status_texture = layout_settings.texture_status_wounded
			end
		else
			status_texture = layout_settings.texture_status_dead
		end
	end

	if status_texture then
		Gui.bitmap(gui, status_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.texture_status_offset_x), math.floor(self._y + layout_settings.texture_status_offset_y), self._z + 20), Vector2(layout_settings.texture_status_width, layout_settings.texture_status_height))
	end

	column_offset_x = column_offset_x + layout_settings.column_width[4]

	if show_enemy_info then
		ScriptGUI.text(gui, self:score(), font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)
	end

	column_offset_x = column_offset_x + layout_settings.column_width[5]

	local ping = "?"
	local game = Managers.state.network:game()
	local game_object_id = player.game_object_id

	if game and game_object_id then
		if GameSession.game_object_exists(game, game_object_id) then
			ping = GameSession.game_object_field(game, game_object_id, "ping")
		else
			print("[ScoreboardPlayerMenuItem] Game object does not exist! game_object_id:", game_object_id)
		end
	end

	ScriptGUI.text(gui, ping, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 20), color, shadow_color, shadow_offset)

	if self._highlighted then
		local x

		if layout_settings.texture_highlighted_align == "left" then
			x = self._x
		elseif layout_settings.texture_highlighted_align == "right" then
			x = self._x + self._width - layout_settings.texture_highlighted_width
		end

		local c = layout_settings.texture_highlighted_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(x), math.floor(self._y), self._z + 19), Vector2(layout_settings.texture_highlighted_width, layout_settings.texture_highlighted_height), color)
	end
end

function ScoreboardPlayerMenuItem:score()
	return self._stats:get(self._network_id, "experience_round")
end

function ScoreboardPlayerMenuItem:player_name()
	return self._player:name()
end

function ScoreboardPlayerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "scoreboard_player",
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
		sounds = config.parent_page.config.sounds.items.text,
		z = config.z,
		player = config.player,
		local_player = config.local_player
	}

	return ScoreboardPlayerMenuItem:new(config, compiler_data.world)
end
