-- chunkname: @scripts/menu/menu_items/atlas_texture_menu_item.lua

AtlasTextureMenuItem = class(AtlasTExtureMenuItem, MenuItem)

function AtlasTextureMenuItem:init(config, world)
	AtlasTextureMenuItem.super.init(self, config, world)
end

function AtlasTextureMenuItem:on_page_enter()
	AtlasTextureMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_texture then
		local texture, atlas = self:_try_callback(self.config.callback_object, self.config.on_enter_texture, unpack(self.config.on_enter_texture_args or {}))

		self.config.texture = texture
		self.config.atlas_settings = atlas
	end
end

function AtlasTextureMenuItem:update(dt, t)
	if self:visible() and self.config.on_update_texture then
		local texture, atlas = self:_try_callback(self.config.callback_object, self.config.on_update_texture, unpack(self.config.on_update_texture_args or {}))

		self.config.texture = texture
		self.config.atlas_settings = atlas
	end
end

function AtlasTextureMenuItem:update_size(dt, t, gui, layout_settings)
	self:update(dt, t)

	local atlas_settings = layout_settings.atlas_settings or self.config.atlas_settings

	if atlas_settings then
		self._width = (layout_settings.texture_width or atlas_settings.size[1] or self.config.width) + layout_settings.padding_left + layout_settings.padding_right
		self._height = (layout_settings.texture_height or atlas_settings.size[2] or self.config.height) + layout_settings.padding_top + layout_settings.padding_bottom
	else
		self._width = (layout_settings.texture_width or self.config.width) + layout_settings.padding_left + layout_settings.padding_right
		self._height = (layout_settings.texture_height or self.config.height) + layout_settings.padding_top + layout_settings.padding_bottom
	end
end

function AtlasTextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function AtlasTextureMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	if not self.config.hide then
		local color = self.config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color or self.config.color or {
			255,
			255,
			255,
			255
		}
		local texture = layout_settings.texture or self.config.texture
		local atlas_settings = layout_settings.atlas_settings or self.config.atlas_settings
		local texture_x = math.floor(self._x + layout_settings.padding_left)
		local texture_y = self._y + layout_settings.padding_bottom
		local texture_width = layout_settings.texture_width or self.config.width or atlas_settings.size[1]
		local texture_height = layout_settings.texture_height or self.config.height or atlas_settings.size[2]
		local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
		local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])

		Gui.bitmap_uv(gui, texture, uv00, uv11, Vector3(texture_x, texture_y, self._z), Vector2(math.floor(texture_width), math.floor(texture_height)), Color(color[1], color[2], color[3], color[4]))
	end
end

function AtlasTextureMenuItem:render(dt, t, gui, layout_settings)
	if not self.config.hide and (layout_settings.texture or self.config.texture) then
		local color = self.config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color or self.config.color or {
			255,
			255,
			255,
			255
		}
		local texture = layout_settings.texture or self.config.texture
		local atlas_settings = layout_settings.atlas_settings or self.config.atlas_settings
		local texture_x = math.floor(self._x + layout_settings.padding_left)
		local texture_y = self._y + layout_settings.padding_bottom

		if atlas_settings then
			local texture_width = layout_settings.texture_width or atlas_settings.size[1] or self.config.width
			local texture_height = layout_settings.texture_height or atlas_settings.size[2] or self.config.height
			local uv00 = Vector2(atlas_settings.uv00[1], atlas_settings.uv00[2])
			local uv11 = Vector2(atlas_settings.uv11[1], atlas_settings.uv11[2])

			Gui.bitmap_uv(gui, texture, uv00, uv11, Vector3(texture_x, texture_y, self._z), Vector2(math.floor(texture_width), math.floor(texture_height)), Color(color[1], color[2], color[3], color[4]))
		else
			local texture_width = layout_settings.texture_width or self.config.width
			local texture_height = layout_settings.texture_height or self.config.height

			Gui.bitmap(gui, texture, Vector3(texture_x, texture_y, self._z), Vector2(math.floor(texture_width), math.floor(texture_height)), Color(color[1], color[2], color[3], color[4]))
		end
	end
end

function AtlasTextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "atlas_texture",
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_enter_texture = config.on_enter_texture,
		on_enter_texture_args = config.on_enter_texture_args or {},
		on_update_texture = config.on_update_texture,
		on_update_texture_args = config.on_update_texture_args or {},
		texture = config.texture,
		atlas_settings = config.atlas_settings,
		color = config.color,
		layout_settings = config.layout_settings,
		width = config.width,
		height = config.height,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture
	}

	return AtlasTextureMenuItem:new(config, compiler_data.world)
end
