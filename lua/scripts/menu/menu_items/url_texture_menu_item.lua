-- chunkname: @scripts/menu/menu_items/url_texture_menu_item.lua

URLTextureMenuItem = class(URLTextureMenuItem, MenuItem)

function URLTextureMenuItem:init(config, world)
	URLTextureMenuItem.super.init(self, config, world)
end

function URLTextureMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function URLTextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function URLTextureMenuItem:render(dt, t, gui, layout_settings)
	local x = self._x + layout_settings.padding_left
	local y = self._y + layout_settings.padding_bottom
	local z = self._z + 1
	local w = layout_settings.texture_width
	local h = layout_settings.texture_height

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(x), math.floor(y), z), Vector2(math.floor(w), math.floor(h)))
end

function URLTextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "url_texture",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		url = config.url,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture
	}

	return URLTextureMenuItem:new(config, compiler_data.world)
end
