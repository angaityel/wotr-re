-- chunkname: @scripts/menu/menu_items/local_player_marker_menu_item.lua

require("scripts/menu/menu_items/menu_item")

LocalPlayerMarkerMenuItem = class(LocalPlayerMarkerMenuItem, MenuItem)

function LocalPlayerMarkerMenuItem:init(config, world)
	LocalPlayerMarkerMenuItem.super.init(self, config, world)

	self._player = config.player
end

function LocalPlayerMarkerMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width
	self._height = layout_settings.texture_height
end

function LocalPlayerMarkerMenuItem:update_position(dt, t, layout_settings, x, y, z, minimap_props)
	local unit = self._player.player_unit
	local pos = Unit.world_position(unit, 0)
	local map_x, map_y = MenuHelper.calculate_minimap_position(pos, minimap_props)

	self._x = x + map_x
	self._y = y + map_y
	self._z = z
end

function LocalPlayerMarkerMenuItem:render(dt, t, gui, layout_settings, minimap_props)
	local player = self._player
	local unit = player.player_unit
	local player = self._player
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local aim_direction = locomotion:aim_direction()
	local aim_direction_flat = Vector3(aim_direction.x, aim_direction.y, 0)

	aim_direction_flat = Vector3.normalize(aim_direction_flat)

	local aim_rot = Quaternion.look(aim_direction_flat, Vector3.right())
	local texture_rotation = math.atan2(Vector3.dot(aim_direction_flat, minimap_props.x_axis:unbox()), Vector3.dot(aim_direction_flat, minimap_props.y_axis:unbox()))
	local texture_pivot_x = self._x
	local texture_pivot_y = self._y
	local transform_matrix = Rotation2D(Vector2(math.floor(self._x), math.floor(self._y)), texture_rotation, Vector2(math.floor(texture_pivot_x), math.floor(texture_pivot_y)))

	Gui.bitmap_3d(gui, layout_settings.texture, transform_matrix, Vector3(-self._width / 2, -self._height / 2, 0), self._z + 3, Vector2(math.floor(self._width), math.floor(self._height)))
end

function LocalPlayerMarkerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "local_player_marker",
		name = config.name,
		callback_object = callback_object,
		disabled = config.disabled,
		player = config.player,
		layout_settings = config.layout_settings
	}

	return LocalPlayerMarkerMenuItem:new(config, compiler_data.world)
end
