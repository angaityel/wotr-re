-- chunkname: @scripts/menu/menu_items/player_info_menu_item.lua

PlayerInfoMenuItem = class(PlayerInfoMenuItem, MenuItem)

function PlayerInfoMenuItem:init(config, world)
	PlayerInfoMenuItem.super.init(self, config, world)
	self:set_selected(false)

	self._player = config.player
end

function PlayerInfoMenuItem:on_select(ignore_sound)
	self:set_selected(true)
	PlayerInfoMenuItem.super.on_select(self, ignore_sound)
end

function PlayerInfoMenuItem:on_deselect()
	self:set_selected(false)
end

function PlayerInfoMenuItem:set_selected(selected)
	self._selected = selected
end

function PlayerInfoMenuItem:selected()
	return self._selected
end

function PlayerInfoMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function PlayerInfoMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function PlayerInfoMenuItem:render(dt, t, gui, layout_settings)
	local player = self._player
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local column_offset_x = 0
	local friend = false

	if friend then
		Gui.bitmap(gui, layout_settings.friend_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.friend_texture_offset_x), math.floor(self._y + layout_settings.friend_texture_offset_y), self._z + 2), Vector2(math.floor(layout_settings.friend_texture_width), math.floor(layout_settings.friend_texture_height)))
	end

	column_offset_x = column_offset_x + layout_settings.column_width[1]

	local player_name = player.name or "?"
	local player_name_truncated = HUDHelper:crop_text(gui, player_name, font, layout_settings.font_size, layout_settings.column_width[2] - 4, "...")

	ScriptGUI.text(gui, player_name_truncated, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[2]

	local score = player.score or "?"

	ScriptGUI.text(gui, score, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[3]

	local rank = player.rank or "?"
	local min, max = Gui.text_extents(gui, rank, font, layout_settings.font_size)
	local width = max[1] - min[1]

	ScriptGUI.text(gui, rank, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x - width), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)
end

function PlayerInfoMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "player_info",
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
		player = config.player
	}

	return PlayerInfoMenuItem:new(config, compiler_data.world)
end
