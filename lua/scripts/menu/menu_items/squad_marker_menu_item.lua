-- chunkname: @scripts/menu/menu_items/squad_marker_menu_item.lua

require("scripts/menu/menu_items/menu_item")

SquadMarkerMenuItem = class(SquadMarkerMenuItem, MenuItem)

function SquadMarkerMenuItem:init(config, world)
	SquadMarkerMenuItem.super.init(self, config, world)

	self._player = config.player
	self._local_player = config.local_player

	self:set_selected(false)
end

function SquadMarkerMenuItem:set_selected(selected)
	self._selected = selected
end

function SquadMarkerMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.squad_textures_width
	self._height = layout_settings.squad_textures_height
end

function SquadMarkerMenuItem:update_position(dt, t, layout_settings, x, y, z, minimap_props)
	local unit = self._player.player_unit
	local pos = Unit.world_position(unit, 0)
	local map_x, map_y = MenuHelper.calculate_minimap_position(pos, minimap_props)

	self._x = x + map_x
	self._y = y + map_y
	self._z = z
end

function SquadMarkerMenuItem:render(dt, t, gui, layout_settings)
	local squad_texture

	if self._player.is_corporal and self._player.squad_index == self._local_player.squad_index then
		squad_texture = self.config.disabled and layout_settings.squad_corporal.texture_disabled or self._highlighted and layout_settings.squad_corporal.texture_highlighted or layout_settings.squad_corporal.texture
	else
		squad_texture = self.config.disabled and layout_settings.squad_member.texture_disabled or self._highlighted and layout_settings.squad_member.texture_highlighted or layout_settings.squad_member.texture
	end

	local x = self._x + self._width / 2 - layout_settings.squad_textures_width / 2
	local y = self._y + self._height / 2 - layout_settings.squad_textures_height / 2
	local color = self.config.disabled and Color(80, 255, 255, 255) or self._highlighted and Color(255, 255, 255, 255) or Color(200, 255, 255, 255)

	Gui.bitmap(gui, squad_texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(self._width, self._height), color)

	local x = self._x + self._width / 2 - layout_settings.spawn_target_texture_width / 2
	local y = self._y + self._height / 2 - layout_settings.spawn_target_texture_height / 2
	local render_spawn_target_texture = false

	if self.config.selected_spawn_target then
		local anim_offset_y = math.abs(layout_settings.spawn_target_anim_amplitude * math.sin(t * math.pi * layout_settings.spawn_target_anim_speed))

		self._anim_offset_y = layout_settings.spawn_target_offset_y + anim_offset_y
		render_spawn_target_texture = true
	elseif not self.config.disabled then
		self._anim_offset_y = layout_settings.spawn_target_offset_y
		render_spawn_target_texture = true
	end

	if render_spawn_target_texture then
		Gui.bitmap(gui, layout_settings.spawn_target_texture, Vector3(math.floor(x), math.floor(y) + self._anim_offset_y, self._z + 1), Vector2(layout_settings.spawn_target_texture_width, layout_settings.spawn_target_texture_height), color)
	end
end

function SquadMarkerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		selected_spawn_target = false,
		type = "squad_marker",
		name = config.name,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args,
		player = config.player,
		local_player = config.local_player,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.squad_marker
	}

	return SquadMarkerMenuItem:new(config, compiler_data.world)
end
