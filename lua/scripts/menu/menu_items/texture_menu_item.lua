-- chunkname: @scripts/menu/menu_items/texture_menu_item.lua

TextureMenuItem = class(TextureMenuItem, MenuItem)

function TextureMenuItem:init(config, world)
	TextureMenuItem.super.init(self, config, world)
	self:set_selected(false)
end

function TextureMenuItem:on_page_enter()
	TextureMenuItem.super.on_page_enter(self)

	if self:visible() and self.config.on_enter_texture then
		self.config.texture = self:_try_callback(self.config.callback_object, self.config.on_enter_texture, unpack(self.config.on_enter_texture_args or {}))
	end
end

function TextureMenuItem:set_selected(selected)
	self._selected = selected
end

function TextureMenuItem:selected()
	return self._selected
end

function TextureMenuItem:removed()
	return self.config.removed
end

function TextureMenuItem:update(dt, t)
	TextureMenuItem.super.update(self, dt, t)

	if self:visible() and self.config.on_update_texture then
		self.config.texture = self:_try_callback(self.config.callback_object, self.config.on_update_texture, unpack(self.config.on_update_texture_args or {}))
	end
end

function TextureMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.texture_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function TextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function TextureMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	local color = layout_settings.color_render_from_child_page or {
		255,
		255,
		255,
		255
	}

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), Color(color[1], color[2], color[3], color[4]))
end

function TextureMenuItem:render(dt, t, gui, layout_settings)
	if self.config.no_render_outside_screen and MenuHelper.is_outside_screen(self._x, self._y, self._width, self._height, 10) then
		return
	end

	local color = self.config.disabled and layout_settings.color_disabled or self._highlighted and layout_settings.color_highlighted or layout_settings.color or self.config.color or {
		255,
		255,
		255,
		255
	}
	local texture = layout_settings.texture or self.config.texture
	local texture_x = math.floor(self._x + layout_settings.padding_left)
	local texture_y = self._y + layout_settings.padding_bottom

	if not self.config.not_pixel_perfect_y then
		texture_y = math.floor(texture_y)
	end

	if not self.config.hide then
		Gui.bitmap(gui, texture, Vector3(texture_x, texture_y, self._z + 1), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)), Color(color[1], color[2], color[3], color[4]))

		if layout_settings.texture_background then
			local x, y, z

			if layout_settings.texture_background_alignment == "left" then
				x = self._x + (layout_settings.texture_background_offset_x or 0)
				y = self._y + (layout_settings.texture_background_offset_y or 0)
				z = self._z + (layout_settings.texture_background_offset_z or 1)
			elseif layout_settings.texture_background_alignment == "center" then
				x = self._x + self._width / 2 - layout_settings.texture_background_width / 2 + (layout_settings.texture_background_offset_x or 0)
				y = self._y + self._height / 2 - layout_settings.texture_background_height / 2 + (layout_settings.texture_background_offset_y or 0)
				z = self._z + (layout_settings.texture_background_offset_z or 1)
			elseif layout_settings.texture_background_alignment == "right" then
				x = self._x + self._width - layout_settings.texture_background_width + (layout_settings.texture_background_offset_x or 0)
				y = self._y + self._height / 2 - layout_settings.texture_background_height / 2 + (layout_settings.texture_background_offset_y or 0)
				z = self._z + (layout_settings.texture_background_offset_z or 1)
			end

			local c = layout_settings.texture_background_color or {
				255,
				255,
				255,
				255
			}
			local color = Color(c[1], c[2], c[3], c[4])

			Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_background_width, layout_settings.texture_background_height), color)
		end

		if self._highlighted and layout_settings.texture_highlighted then
			Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(self._x + layout_settings.padding_left + (layout_settings.texture_highlighted_offset_x or 0)), math.floor(self._y + layout_settings.padding_bottom + (layout_settings.texture_highlighted_offset_y or 0)), self._z + (layout_settings.texture_highlighted_offset_z or 1)), Vector2(math.floor(layout_settings.texture_highlighted_width), math.floor(layout_settings.texture_highlighted_height)))
		end

		if self.config.disabled and layout_settings.texture_disabled then
			Gui.bitmap(gui, layout_settings.texture_disabled, Vector3(math.floor(self._x + layout_settings.padding_left + (layout_settings.texture_disabled_offset_x or 0)), math.floor(self._y + layout_settings.padding_bottom + (layout_settings.texture_disabled_offset_y or 0)), self._z + (layout_settings.texture_disabled_offset_z or 1)), Vector2(math.floor(layout_settings.texture_disabled_width), math.floor(layout_settings.texture_disabled_height)))
		end
	end
end

function TextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "texture",
		page = config.page,
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
		not_pixel_perfect_y = config.not_pixel_perfect_y,
		no_render_outside_screen = config.no_render_outside_screen,
		color = config.color,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture
	}

	return TextureMenuItem:new(config, compiler_data.world)
end
