-- chunkname: @scripts/menu/menu_items/loading_texture_menu_item.lua

LoadingTextureMenuItem = class(LoadingTextureMenuItem, MenuItem)

function LoadingTextureMenuItem:init(config, world)
	LoadingTextureMenuItem.super.init(self, config, world)

	self._rotation = 0
end

function LoadingTextureMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function LoadingTextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function LoadingTextureMenuItem:render(dt, t, gui, layout_settings)
	self._rotation = self._rotation + dt * (layout_settings.texture_rotation_angle * math.pi / 180)

	local texture_rotation = self._rotation % (2 * math.pi)
	local texture_x = self._x + layout_settings.padding_left
	local texture_y = self._y + layout_settings.padding_bottom
	local texture_pivot_x = texture_x + layout_settings.texture_width / 2
	local texture_pivot_y = texture_y + layout_settings.texture_height / 2
	local transform_matrix = Rotation2D(Vector2(math.floor(texture_x), math.floor(texture_y)), texture_rotation, Vector2(math.floor(texture_pivot_x), math.floor(texture_pivot_y)))

	Gui.bitmap_3d(gui, layout_settings.texture, transform_matrix, Vector3(0, 0, 0), self._z, Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)))
end

function LoadingTextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "loading_texture",
		page = config.page,
		name = config.name,
		callback_object = callback_object,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.loading_texture
	}

	return LoadingTextureMenuItem:new(config, compiler_data.world)
end
