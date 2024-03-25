-- chunkname: @scripts/menu/menu_items/column_header_texture_menu_item.lua

ColumnHeaderTextureMenuItem = class(ColumnHeaderTextureMenuItem, TextureMenuItem)

function ColumnHeaderTextureMenuItem:init(config, world)
	ColumnHeaderTextureMenuItem.super.init(self, config, world)

	self._sort_order = self._default_sort_order
end

function ColumnHeaderTextureMenuItem:on_select(ignore_sound)
	if self._selected then
		if self._sort_order == "asc" then
			self._sort_order = "desc"
		else
			self._sort_order = "asc"
		end
	else
		self._sort_order = self.config.default_sort_order
	end

	self:set_selected(true)

	self.config.on_select_args = {
		self.config.sort_column,
		self._sort_order
	}

	ColumnHeaderTextureMenuItem.super.on_select(self, ignore_sound)
end

function ColumnHeaderTextureMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function ColumnHeaderTextureMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function ColumnHeaderTextureMenuItem:render(dt, t, gui, layout_settings)
	if self._selected and self._width > 0 then
		local texture

		if self._sort_order == "asc" then
			texture = layout_settings.texture_sort_asc
		else
			texture = layout_settings.texture_sort_desc
		end

		local x = self._x + self._width + layout_settings.texture_sort_offset_x
		local y = self._y + layout_settings.texture_sort_offset_y
		local z = self._z + layout_settings.texture_sort_offset_z

		Gui.bitmap(gui, texture, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.texture_sort_width, layout_settings.texture_sort_height))
	end

	local x = self._x + layout_settings.rect_delimiter_offset_x
	local y = self._y + layout_settings.rect_delimiter_offset_y
	local z = self._z + layout_settings.rect_delimiter_offset_z
	local color = Color(layout_settings.rect_delimiter_color[1], layout_settings.rect_delimiter_color[2], layout_settings.rect_delimiter_color[3], layout_settings.rect_delimiter_color[4])

	Gui.rect(gui, Vector3(math.floor(x), math.floor(y), z), Vector2(layout_settings.rect_delimiter_width, layout_settings.rect_delimiter_height), color)

	local x = self._x + layout_settings.texture_offset_x
	local y = self._y + layout_settings.texture_offset_y
	local z = self._z + layout_settings.texture_offset_z

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(x), math.floor(y), z), Vector2(math.floor(layout_settings.texture_width), math.floor(layout_settings.texture_height)))

	if layout_settings.rect_background_color then
		local color = Color(layout_settings.rect_background_color[1], layout_settings.rect_background_color[2], layout_settings.rect_background_color[3], layout_settings.rect_background_color[4])

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(self._width, self._height), color)
	end
end

function ColumnHeaderTextureMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "column_header_texture",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		texture = config.texture,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture,
		sort_column = config.sort_column,
		default_sort_order = config.default_sort_order
	}

	return ColumnHeaderTextureMenuItem:new(config, compiler_data.world)
end
