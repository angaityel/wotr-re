-- chunkname: @scripts/menu/menu_items/objective_marker_menu_item.lua

require("scripts/menu/menu_items/menu_item")

ObjectiveMarkerMenuItem = class(ObjectiveMarkerMenuItem, MenuItem)

function ObjectiveMarkerMenuItem:init(config, world)
	ObjectiveMarkerMenuItem.super.init(self, config, world)

	self._objective_unit = config.objective_unit
	self._blackboard = config.blackboard
	self._local_player = config.local_player
end

function ObjectiveMarkerMenuItem:update_size(dt, t, gui, layout_settings, layout_settings_2)
	local w, h = self:_update_size(dt, t, gui, layout_settings)

	self._width = w
	self._height = h

	if layout_settings_2 then
		local w, h = self:_update_size(dt, t, gui, layout_settings_2)

		self._width_2 = w
		self._height_2 = h
	end
end

function ObjectiveMarkerMenuItem:_update_size(dt, t, gui, layout_settings)
	local blackboard = self._blackboard
	local settings = layout_settings.spawn_map
	local texture = settings.texture_func and settings.texture_func(blackboard, self._local_player)

	if not texture then
		return 0, 0
	end

	local uv00 = Vector2(texture.uv00[1], texture.uv00[2])
	local uv11 = Vector2(texture.uv11[1], texture.uv11[2])
	local texture_width = texture.size[1] * settings.scale
	local texture_height = texture.size[2] * settings.scale

	return texture_width, texture_height
end

function ObjectiveMarkerMenuItem:update_position(dt, t, layout_settings, layout_settings_2, x, y, z, minimap_props)
	local unit = self._objective_unit
	local pos = Unit.world_position(unit, 0)
	local map_x, map_y = MenuHelper.calculate_minimap_position(pos, minimap_props)

	self._x = x + map_x
	self._y = y + map_y
	self._z = z
end

function ObjectiveMarkerMenuItem:render(dt, t, gui, layout_settings, layout_settings_2, minimap_props)
	self:_render_texture(dt, t, gui, layout_settings, minimap_props, self._width, self._height)

	if layout_settings_2 then
		self:_render_texture(dt, t, gui, layout_settings_2, minimap_props, self._width_2, self._height_2)
	end
end

function ObjectiveMarkerMenuItem:_render_texture(dt, t, gui, layout_settings, minimap_props, w, h)
	local blackboard = self._blackboard
	local local_player = self._local_player
	local settings = layout_settings.spawn_map
	local texture = settings.texture_func and settings.texture_func(blackboard, local_player)

	if not texture then
		return
	end

	local color = HUDHelper.floating_hud_icon_color(local_player, settings, blackboard, dt, t)
	local uv00 = Vector2(texture.uv00[1], texture.uv00[2])
	local uv11 = Vector2(texture.uv11[1], texture.uv11[2])
	local x = self._x - w / 2
	local y = self._y - h / 2

	Gui.bitmap_uv(gui, settings.texture_atlas, uv00, uv11, Vector3(math.floor(x), math.floor(y), self._z), Vector2(w, h), color)
end

function ObjectiveMarkerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "objective_marker",
		name = config.name,
		disabled = config.disabled,
		objective_unit = config.objective_unit,
		blackboard = config.blackboard,
		local_player = config.local_player,
		layout_settings = config.layout_settings,
		layout_settings_2 = config.layout_settings_2
	}

	return ObjectiveMarkerMenuItem:new(config, compiler_data.world)
end
