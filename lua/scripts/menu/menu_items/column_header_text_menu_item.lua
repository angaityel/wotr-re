-- chunkname: @scripts/menu/menu_items/column_header_text_menu_item.lua

ColumnHeaderTextMenuItem = class(ColumnHeaderTextMenuItem, TextMenuItem)

function ColumnHeaderTextMenuItem:init(config, world)
	ColumnHeaderTextMenuItem.super.init(self, config, world)
	self:set_selected(false)

	self._sort_order = self._default_sort_order
end

function ColumnHeaderTextMenuItem:on_select(ignore_sound)
	if self._selected then
		if self._sort_order == "asc" then
			self._sort_order = "desc"
		else
			self._sort_order = "asc"
		end
	else
		self._sort_order = self.config.default_sort_order
	end

	self.config.on_select_args = {
		self.config.sort_column,
		self._sort_order
	}

	ColumnHeaderTextMenuItem.super.on_select(self, ignore_sound)
end

function ColumnHeaderTextMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function ColumnHeaderTextMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function ColumnHeaderTextMenuItem:render(dt, t, gui, layout_settings)
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

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local color = Color(layout_settings.text_color[1], layout_settings.text_color[2], layout_settings.text_color[3], layout_settings.text_color[4])
	local text_x, text_y, text_z
	local text = self.config.text

	if layout_settings.text_max_width then
		text = HUDHelper:crop_text(gui, text, font, layout_settings.font_size, layout_settings.text_max_width, "...")
	end

	if layout_settings.text_align == "right" then
		local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)
		local text_width = max[1] - min[1]

		text_x = self._x + self._width - text_width + layout_settings.text_offset_x
		text_y = self._y + layout_settings.text_offset_y
		text_z = self._z + layout_settings.text_offset_z
	else
		text_x = self._x + layout_settings.text_offset_x
		text_y = self._y + layout_settings.text_offset_y
		text_z = self._z + layout_settings.text_offset_z
	end

	ScriptGUI.text(gui, text, font, layout_settings.font_size, font_material, Vector3(math.floor(text_x), math.floor(text_y), text_z), color)

	if layout_settings.rect_background_color then
		local color = Color(layout_settings.rect_background_color[1], layout_settings.rect_background_color[2], layout_settings.rect_background_color[3], layout_settings.rect_background_color[4])

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(self._width, self._height), color)
	end
end

function ColumnHeaderTextMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "column_header_text",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		text = config.no_localization and config.text or L(config.text),
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.text,
		sort_column = config.sort_column,
		default_sort_order = config.default_sort_order
	}

	return ColumnHeaderTextMenuItem:new(config, compiler_data.world)
end
