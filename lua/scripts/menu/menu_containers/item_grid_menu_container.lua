-- chunkname: @scripts/menu/menu_containers/item_grid_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

ItemGridMenuContainer = class(ItemGridMenuContainer, MenuContainer)

function ItemGridMenuContainer:init(items, header_items, scroll_bar_items)
	ItemGridMenuContainer.super.init(self)

	self._items = items
	self._header_items = header_items
	self._scroll_bar_items = scroll_bar_items
	self._top_visible_row = 1
	self._visible_items = nil
	self._header_columns_width = nil
	self._header_rows_height = nil
	self._item_columns_width = nil
	self._item_rows_height = nil
	self._header_rows_offset = nil
	self._item_rows_offset = nil
	self._items_total_width = nil
	self._items_total_height = nil
	self._headers_total_height = nil
end

function ItemGridMenuContainer:is_mouse_inside(mouse_x, mouse_y)
	local x1, y1, x2, y2 = self._x, self._y, self._x + self._width, self._y + self._height

	return x1 <= mouse_x and mouse_x <= x2 and y1 <= mouse_y and mouse_y <= y2
end

function ItemGridMenuContainer:can_scroll(layout_settings)
	if self._scroll_bar_items then
		local column_settings = layout_settings.items.columns
		local number_of_columns = #column_settings
		local number_of_rows = math.ceil(#self._items / number_of_columns)
		local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
		local num_scrollable_rows = number_of_rows - number_of_visible_rows

		if num_scrollable_rows > 0 then
			return true
		end
	end
end

function ItemGridMenuContainer:top_visible_row()
	return self._top_visible_row
end

function ItemGridMenuContainer:set_top_visible_row(row)
	if row > 1 or row < #self._items then
		self._top_visible_row = row
	end
end

function ItemGridMenuContainer:scroll_up()
	if self._top_visible_row > 1 then
		self._top_visible_row = self._top_visible_row - 1
	end
end

function ItemGridMenuContainer:scroll_down(layout_settings)
	local column_settings = layout_settings.items.columns
	local number_of_columns = #column_settings
	local number_of_rows = math.ceil(#self._items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows

	if self._top_visible_row < #self._items - number_of_visible_rows + 1 then
		self._top_visible_row = self._top_visible_row + 1
	end
end

function ItemGridMenuContainer:items()
	return self._items
end

function ItemGridMenuContainer:update_size(dt, t, gui, layout_settings)
	if self._header_items then
		self._header_columns_width, self._header_rows_height, self._headers_total_height = self:_update_items_size(dt, t, gui, layout_settings, self._header_items, layout_settings.headers)
	end

	local column_settings = layout_settings.items.columns
	local number_of_columns = #column_settings
	local number_of_rows = math.ceil(#self._items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows

	self._visible_items = self:_visible_items_table(number_of_columns, number_of_visible_rows)
	self._item_columns_width, self._item_rows_height, self._items_total_height = self:_update_items_size(dt, t, gui, layout_settings, self._visible_items, layout_settings.items)

	local width = 0

	for i = 1, #self._item_columns_width do
		width = width + self._item_columns_width[i]
	end

	self._items_total_width = width
	self._width = width + (self._scroll_bar_items and self._scroll_bar_items[1]:width() or 0)
	self._height = (self._headers_total_height or 0) + math.max(layout_settings.background_min_height or 0, self._items_total_height)

	for i, item in ipairs(self._items) do
		item:set_hidden(true)
	end

	for i, item in ipairs(self._visible_items) do
		item:set_hidden(false)
	end

	if self._scroll_bar_items then
		local top_scrollable_row = math.max(number_of_rows - number_of_visible_rows + 1, 1)

		if top_scrollable_row < self._top_visible_row then
			self._top_visible_row = top_scrollable_row
		end

		self._scroll_bar_items[1]:set_grid_properties(self._top_visible_row, number_of_visible_rows, number_of_rows)

		local scroll_bar_layout_settings = MenuHelper:layout_settings(self._scroll_bar_items[1].config.layout_settings)
		local scroll_bar_height = math.max(layout_settings.background_min_height or 0, self._items_total_height)

		self._scroll_bar_items[1]:update_size(dt, t, gui, layout_settings.scroll_bar, scroll_bar_layout_settings.width, self._height, scroll_bar_height)
	end

	self._gui = gui
end

function ItemGridMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	local column_offset = 0
	local row_offset = 0

	if self._header_items then
		self._header_rows_offset = self:_update_items_position(dt, t, layout_settings, x, y, z, self._header_items, row_offset, layout_settings.headers, self._header_columns_width)
		row_offset = self._headers_total_height
	end

	self._item_rows_offset = self:_update_items_position(dt, t, layout_settings, x, y, z, self._visible_items, row_offset, layout_settings.items, self._item_columns_width)

	if self._scroll_bar_items then
		if layout_settings.scroll_bar.align == "left" then
			self._scroll_bar_items[1]:update_position(dt, t, MenuHelper:layout_settings(self._scroll_bar_items[1].config.layout_settings), self._x, self._y, z + layout_settings.scroll_bar.offset_z)
		elseif layout_settings.scroll_bar.align == "right" then
			self._scroll_bar_items[1]:update_position(dt, t, MenuHelper:layout_settings(self._scroll_bar_items[1].config.layout_settings), self._x + self._width - self._scroll_bar_items[1]:width(), self._y, z + layout_settings.scroll_bar.offset_z)
		end
	end
end

function ItemGridMenuContainer:render(dt, t, gui, layout_settings)
	if layout_settings.rect_background_color then
		local c = layout_settings.rect_background_color
		local color = Color(c[1], c[2], c[3], c[4])
		local bgr_height = math.max(layout_settings.background_min_height or 0, self._items_total_height)
		local x = self._x

		if self._scroll_bar_items and layout_settings.scroll_bar.align == "left" then
			x = x + self._scroll_bar_items[1]:width()
		end

		local y = self._y + (layout_settings.background_offset_y or 0)

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(y), self._z), Vector2(math.floor(self._items_total_width), math.floor(bgr_height)), color)
	end

	if layout_settings.texture_background then
		local bgr_width = layout_settings.texture_background_width or self._items_total_width
		local bgr_height = math.max(layout_settings.background_min_height or 0, self._items_total_height)
		local x

		if layout_settings.texture_background_align == "left" then
			x = self._x

			if self._scroll_bar_items and layout_settings.scroll_bar.align == "left" then
				x = x + self._scroll_bar_items[1]:width()
			end
		elseif layout_settings.texture_background_align == "right" then
			x = self._x + self._width - bgr_width
		end

		local y = self._y + (layout_settings.background_offset_y or 0)
		local c = layout_settings.texture_background_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(x), math.floor(y), self._z), Vector2(math.floor(bgr_width), math.floor(bgr_height)), color)
	end

	if layout_settings.atlas_texture_background and layout_settings.atlas_texture_background_settings then
		local bgr_width = layout_settings.texture_background_width or layout_settings.atlas_texture_background_settings.size[1] or self._items_total_width
		local bgr_height = math.max(layout_settings.background_min_height or 0, self._items_total_height)
		local x

		if layout_settings.texture_background_align == "left" then
			x = self._x

			if self._scroll_bar_items and layout_settings.scroll_bar.align == "left" then
				x = x + self._scroll_bar_items[1]:width()
			end
		elseif layout_settings.texture_background_align == "right" then
			x = self._x + self._width - bgr_width
		end

		local y = self._y + (layout_settings.background_offset_y or 0)
		local c = layout_settings.texture_background_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])
		local uv00 = Vector2(layout_settings.atlas_texture_background_settings.uv00[1], layout_settings.atlas_texture_background_settings.uv00[2])
		local uv11 = Vector2(layout_settings.atlas_texture_background_settings.uv11[1], layout_settings.atlas_texture_background_settings.uv11[2])

		Gui.bitmap_uv(gui, layout_settings.atlas_texture_background, uv00, uv11, Vector3(math.floor(x), math.floor(y), self._z), Vector2(math.floor(bgr_width), math.floor(bgr_height)), color)
	end

	if self._header_items then
		for i, item in ipairs(self._header_items) do
			item:render(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))
			self:_row_background_color(gui, layout_settings, i, layout_settings.headers, self._header_rows_height, self._header_rows_offset)
		end
	end

	for i, item in ipairs(self._visible_items) do
		if item:visible() then
			item:render(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))
			self:_row_background_color(gui, layout_settings, i, layout_settings.items, self._item_rows_height, self._item_rows_offset)
		end
	end

	if self._scroll_bar_items then
		self._scroll_bar_items[1]:render(dt, t, gui, MenuHelper:layout_settings(self._scroll_bar_items[1].config.layout_settings))

		if self._debug then
			local color = Color(255, 255, 0, 0)
			local gui = self._gui
			local x = self._scroll_bar_items[1]:x()
			local y = self._scroll_bar_items[1]:y()
			local w = self._scroll_bar_items[1]:width()
			local h = self._scroll_bar_items[1]:height()

			Gui.rect(gui, Vector3(x, y, 500), Vector2(w, 1), color)
			Gui.rect(gui, Vector3(x + w, y, 500), Vector2(1, h), color)
			Gui.rect(gui, Vector3(x, y + h, 500), Vector2(w, 1), color)
			Gui.rect(gui, Vector3(x, y, 500), Vector2(1, h), color)
		end
	end
end

function ItemGridMenuContainer:_update_items_size(dt, t, gui, layout_settings, items, settings)
	local column_settings = settings.columns
	local row_settings = settings.rows
	local column_width_table = self:_columns_width(items, column_settings)
	local row_height_table = {}
	local number_of_columns = #settings.columns
	local total_height = 0

	for i, item in ipairs(items) do
		local current_row = math.ceil(i / number_of_columns)
		local current_column = (i - 1) % number_of_columns + 1
		local column_width = column_width_table[current_column]
		local row_settings = settings.rows[current_row] or settings.rows[#settings.rows]
		local row_height = row_settings.height
		local item_layout_settings = MenuHelper:layout_settings(item.config.layout_settings)

		item:update_size(dt, t, gui, item_layout_settings, column_width, row_height)

		row_height_table[current_row] = row_height

		if current_column == 1 then
			total_height = total_height + row_height
		end
	end

	return column_width_table, row_height_table, total_height
end

function ItemGridMenuContainer:_update_items_position(dt, t, layout_settings, x, y, z, items, row_offset, settings, column_width_table)
	local column_settings = settings.columns
	local number_of_columns = #column_settings
	local number_of_rows = math.ceil(#self._items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
	local visible_items = self:_visible_items_table(number_of_columns, number_of_visible_rows)
	local row_offset_table = {}
	local column_offset = 0
	local scroll_bar_offset = 0

	if self._scroll_bar_items and layout_settings.scroll_bar.align == "left" then
		scroll_bar_offset = self._scroll_bar_items[1]:width()
	end

	for i, item in ipairs(items) do
		local current_column = (i - 1) % number_of_columns + 1
		local current_row = math.ceil(i / number_of_columns)
		local column_width = column_width_table[current_column]
		local column_align = column_settings[current_column].align
		local row_settings = settings.rows[current_row] or settings.rows[#settings.rows]
		local row_height = row_settings.height
		local row_align = row_settings.align

		if current_column - 1 == 0 then
			column_offset = scroll_bar_offset
		else
			column_offset = column_offset + column_width_table[current_column - 1]
		end

		local item_x

		if column_align == "left" then
			item_x = self._x + column_offset
		elseif column_align == "center" then
			item_x = self._x + column_offset + column_width / 2 - item:width() / 2
		elseif column_align == "right" then
			item_x = self._x + column_offset + column_width - item:width()
		end

		if current_column == 1 then
			row_offset = row_offset + row_height
			row_offset_table[#row_offset_table + 1] = row_offset
		end

		local item_y

		if row_align == "bottom" then
			item_y = self._y + self._height - row_offset
		elseif row_align == "center" then
			item_y = self._y + self._height - row_offset + row_height / 2 - item:height() / 2
		elseif row_align == "top" then
			item_y = self._y + self._height - row_offset + row_height - item:height()
		end

		item:update_position(dt, t, MenuHelper:layout_settings(item.config.layout_settings), item_x, item_y, z + 1)

		if self._debug then
			local color = Color(255, 0, 0, 255)
			local gui = self._gui
			local x = self._x + column_offset
			local y = self._y + self._height - row_offset
			local w = column_width
			local h = row_height

			Gui.rect(gui, Vector3(x, y, 500), Vector2(w, 1), color)
			Gui.rect(gui, Vector3(x + w, y, 500), Vector2(1, h), color)
			Gui.rect(gui, Vector3(x, y + h, 500), Vector2(w, 1), color)
			Gui.rect(gui, Vector3(x, y, 500), Vector2(1, h), color)
		end
	end

	return row_offset_table
end

function ItemGridMenuContainer:_visible_items_table(number_of_columns, number_of_visible_rows)
	local visible_items = {}
	local start_index = (self._top_visible_row - 1) * number_of_columns + 1
	local num_visible_items = number_of_columns * number_of_visible_rows
	local end_index = start_index + num_visible_items - 1

	self._start_index = start_index

	for i = start_index, end_index do
		if i > #self._items then
			self._end_index = i - 1

			return visible_items
		elseif not self._items[i]:removed() then
			visible_items[#visible_items + 1] = self._items[i]
		end
	end

	self._end_index = end_index

	return visible_items
end

function ItemGridMenuContainer:row_info()
	return self._start_index, self._end_index
end

function ItemGridMenuContainer:_columns_width(items, column_settings)
	local num_columns = #column_settings
	local width = {}

	for column_num = 1, num_columns do
		if column_settings[column_num].width then
			width[column_num] = column_settings[column_num].width
		else
			local column_items = self:_items_in_column(items, column_num, num_columns)

			for i, item in ipairs(column_items) do
				if not width[column_num] or item:width() > width[column_num] then
					width[column_num] = item:width()
				end
			end
		end
	end

	return width
end

function ItemGridMenuContainer:_items_in_column(items, column_num, num_columns)
	local items_in_column = {}

	for i, item in ipairs(items) do
		local c_num = (i - 1) % num_columns + 1

		if c_num == column_num then
			items_in_column[#items_in_column + 1] = item
		end
	end

	return items_in_column
end

function ItemGridMenuContainer:_row_background_color(gui, layout_settings, i, settings, rows_height, rows_offset)
	local number_of_columns = #settings.columns
	local current_row = math.ceil(i / number_of_columns)
	local row_settings = settings.rows[current_row] or settings.rows[#settings.rows]
	local c

	if current_row % 2 == 0 and row_settings.even_color then
		c = row_settings.even_color
	elseif current_row % 2 == 1 and row_settings.odd_color then
		c = row_settings.odd_color
	elseif row_settings.color then
		c = row_settings.color
	end

	if c then
		local color = Color(c[1], c[2], c[3], c[4])
		local x = self._x + (row_settings.color_padding_left or 0)
		local y = self._y + self._height - rows_offset[current_row]
		local w = self._items_total_width - (row_settings.color_padding_left or 0) - (row_settings.color_padding_right or 0)
		local h = rows_height[current_row]

		Gui.rect(gui, Vector3(math.floor(x), math.floor(y), self._z), Vector2(math.floor(w), math.floor(h)), color)
	end
end

function ItemGridMenuContainer.create_from_config(items, header_items, scroll_bar_items)
	return ItemGridMenuContainer:new(items, header_items, scroll_bar_items)
end
