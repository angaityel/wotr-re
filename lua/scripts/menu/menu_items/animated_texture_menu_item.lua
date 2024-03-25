-- chunkname: @scripts/menu/menu_items/animated_texture_menu_item.lua

AnimatedTextureMenuItem = class(AnimatedTextureMenuItem, MenuItem)

function AnimatedTextureMenuItem:init(config, world)
	AnimatedTextureMenuItem.super.init(self, config, world)

	self._frame = 0
end

function AnimatedTextureMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function AnimatedTextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function AnimatedTextureMenuItem:render(dt, t, gui, layout_settings)
	self._frame = (self._frame + dt * layout_settings.animation_speed) % #layout_settings.frames

	local texture_index = math.floor(self._frame) + 1
	local texture_x = self._x + layout_settings.padding_left
	local texture_y = self._y + layout_settings.padding_bottom
	local texture
	local atlas = layout_settings.texture_atlas

	if atlas then
		local atlas_settings = layout_settings.texture_atlas_settings
		local texture_settings = atlas_settings[layout_settings.frames[texture_index]]
		local texture_width = texture_settings.size[1] * layout_settings.scale
		local texture_height = texture_settings.size[2] * layout_settings.scale

		Gui.bitmap_uv(gui, atlas, Vector2(texture_settings.uv00[1], texture_settings.uv00[2]), Vector2(texture_settings.uv11[1], texture_settings.uv11[2]), Vector3(texture_x, texture_y, self._z), Vector2(math.floor(texture_width), math.floor(texture_height)))
	else
		Gui.bitmap(gui, layout_settings.frames[texture_index], Vector3(texture_x, texture_y, self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)))
	end
end

function AnimatedTextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "loading_texture",
		page = config.page,
		name = config.name,
		callback_object = callback_object,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.loading_texture
	}

	return AnimatedTextureMenuItem:new(config, compiler_data.world)
end
