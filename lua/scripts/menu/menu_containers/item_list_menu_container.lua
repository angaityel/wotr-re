-- chunkname: @scripts/menu/menu_containers/item_list_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

ItemListMenuContainer = class(ItemListMenuContainer, MenuContainer)

function ItemListMenuContainer:init(items, scroll_items)
	ItemListMenuContainer.super.init(self)

	self._items = items
	self._scroll_items = scroll_items
	self._top_visible_row = 1
end

function ItemListMenuContainer:set_top_visible_row(row_num)
	self._top_visible_row = row_num
end

function ItemListMenuContainer:can_scroll_up(layout_settings)
	return self._top_visible_row > layout_settings.scroll_number_of_rows
end

function ItemListMenuContainer:can_scroll_down(layout_settings)
	local num_visible_items = self:num_visible_items()
	local total_number_of_rows = math.ceil(num_visible_items / layout_settings.number_of_columns)

	return total_number_of_rows > self._top_visible_row + layout_settings.scroll_number_of_rows - 1
end

function ItemListMenuContainer:scroll_up(layout_settings)
	if self:can_scroll_up(layout_settings) then
		self._top_visible_row = self._top_visible_row - layout_settings.scroll_number_of_rows
	else
		self._top_visible_row = 1
	end
end

function ItemListMenuContainer:scroll_down(layout_settings)
	if self:can_scroll_down(layout_settings) then
		self._top_visible_row = self._top_visible_row + layout_settings.scroll_number_of_rows
	end
end

function ItemListMenuContainer:_visible_items(number_of_columns, number_of_visible_rows)
	local visible_items = {}
	local num_active_items = self:num_visible_items()
	local active_items = self:active_items()
	local start_index = (self._top_visible_row - 1) * number_of_columns + 1
	local num_visible_items = number_of_columns * number_of_visible_rows
	local end_index = start_index + num_visible_items - 1

	for i = start_index, end_index do
		if i > #active_items then
			break
		else
			visible_items[#visible_items + 1] = active_items[i]
		end
	end

	return visible_items
end

function ItemListMenuContainer:num_visible_items()
	local cnt = 0

	for _, item in ipairs(self._items) do
		if not item:removed() then
			cnt = cnt + 1
		end
	end

	return cnt
end

function ItemListMenuContainer:active_items()
	local items = {}

	for _, item in ipairs(self._items) do
		if not item:removed() then
			items[#items + 1] = item
		end
	end

	return items
end

function ItemListMenuContainer:update_size(dt, t, gui, layout_settings)
	if #self._items == 0 then
		self._width = 0
		self._height = 0

		return
	end

	for i, item in ipairs(self._items) do
		item:set_hidden(true)
	end

	local widest_item_in_column = {}
	local highest_item = 0
	local row_offsets = {}
	local num_visible_items = self:num_visible_items()
	local number_of_columns = layout_settings.number_of_columns or 1
	local number_of_rows = math.ceil(num_visible_items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
	local visible_items = self:_visible_items(number_of_columns, number_of_visible_rows)

	for i, item in ipairs(visible_items) do
		local current_column = (i - 1) % number_of_columns + 1

		item:set_hidden(false)
		item:set_column(current_column)

		local item_layout_settings = MenuHelper:layout_settings(item.config.layout_settings)

		item:update_size(dt, t, gui, item_layout_settings)

		if not widest_item_in_column[current_column] then
			widest_item_in_column[current_column] = item:width()
		else
			widest_item_in_column[current_column] = math.max(widest_item_in_column[current_column], item:width())
		end

		highest_item = math.max(highest_item, item:height())

		if i % number_of_columns == 0 or i == #visible_items then
			local current_row = math.ceil(i / number_of_columns)

			if current_row > 1 then
				row_offsets[current_row] = row_offsets[current_row - 1] + highest_item
			else
				row_offsets[current_row] = highest_item
			end

			highest_item = 0
		end
	end

	self._row_offsets = row_offsets

	local number_of_columns = layout_settings.number_of_columns or 1

	if layout_settings.column_width then
		local total_column_width = 0

		for _, col_width in ipairs(layout_settings.column_width) do
			total_column_width = total_column_width + col_width
		end

		self._width = total_column_width
	else
		local width = 0

		for i, w in ipairs(widest_item_in_column) do
			width = width + w
		end

		self._width = width
	end

	local height = row_offsets[#row_offsets]

	if not self._scroll_items or height > self._height then
		self._height = height
	end

	if self._scroll_items then
		local item_up = self._scroll_items[1]

		item_up:update_size(dt, t, gui, MenuHelper:layout_settings(item_up.config.layout_settings))

		local item_down = self._scroll_items[2]

		item_down:update_size(dt, t, gui, MenuHelper:layout_settings(item_down.config.layout_settings))

		local item_text = self._scroll_items[3]

		item_text:update_size(dt, t, gui, MenuHelper:layout_settings(item_text.config.layout_settings))
	end

	self._widest_item_in_column = widest_item_in_column
end

function ItemListMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	if #self._items == 0 then
		return
	end

	local num_visible_items = self:num_visible_items()
	local number_of_columns = layout_settings.number_of_columns or 1
	local number_of_rows = math.ceil(num_visible_items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
	local visible_items = self:_visible_items(number_of_columns, number_of_visible_rows)
	local column_offset_x = 0

	for i, item in ipairs(visible_items) do
		local current_column = (i - 1) % number_of_columns + 1

		if current_column - 1 == 0 then
			column_offset_x = 0
		end

		local column_width = layout_settings.column_width and layout_settings.column_width[current_column] or self._widest_item_in_column[current_column]
		local item_x = self._x + column_offset_x

		if layout_settings.column_alignment and layout_settings.column_alignment[current_column] == "center" then
			item_x = item_x + column_width / 2 - item:width() / 2
		elseif layout_settings.column_alignment and layout_settings.column_alignment[current_column] == "right" then
			item_x = item_x + column_width - item:width()
		end

		local current_row = math.ceil(i / number_of_columns)
		local item_y = self._y + self._height - self._row_offsets[current_row]

		column_offset_x = column_offset_x + column_width

		item:update_position(dt, t, MenuHelper:layout_settings(item.config.layout_settings), item_x, item_y, z + 1)
	end

	if self._scroll_items then
		local item_up = self._scroll_items[1]
		local item_up_layout_settings = MenuHelper:layout_settings(item_up.config.layout_settings)
		local item_up_x = self._x + (item_up_layout_settings.offset_x or self._width + item_up_layout_settings.padding_left)
		local item_up_y = self._y + self._height - item_up_layout_settings.texture_height - item_up_layout_settings.padding_top

		item_up:update_position(dt, t, item_up_layout_settings, item_up_x, item_up_y, z + 1)

		local item_down = self._scroll_items[2]
		local item_down_layout_settings = MenuHelper:layout_settings(item_down.config.layout_settings)
		local item_down_x = self._x + (item_down_layout_settings.offset_x or self._width + item_down_layout_settings.padding_left)
		local item_down_y = self._y + item_down_layout_settings.padding_bottom

		item_down:update_position(dt, t, item_down_layout_settings, item_down_x, item_down_y, z + 1)

		local item_text = self._scroll_items[3]
		local item_text_layout_settings = MenuHelper:layout_settings(item_text.config.layout_settings)
		local item_text_x = self._x + (item_text_layout_settings.offset_x or self._width + item_text_layout_settings.padding_left)
		local item_text_y = self._y + self._height / 2 - item_text:height() / 2

		item_text:update_position(dt, t, item_text_layout_settings, item_text_x, item_text_y, z + 1)
	end
end

function ItemListMenuContainer:render_from_child_page(dt, t, gui, layout_settings)
	if #self._items == 0 then
		return
	end

	local num_visible_items = self:num_visible_items()
	local number_of_columns = layout_settings.number_of_columns or 1
	local number_of_rows = math.ceil(num_visible_items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
	local visible_items = self:_visible_items(number_of_columns, number_of_visible_rows)

	for i, item in ipairs(visible_items) do
		if item:visible() then
			item:render_from_child_page(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))
		end
	end

	if self._scroll_items then
		-- block empty
	end
end

function ItemListMenuContainer:current_page(layout_settings)
	local current_page = 1

	if self._scroll_items then
		local num_visible_items = self:num_visible_items()
		local item_text = self._scroll_items[3]
		local total_number_of_rows = math.ceil(num_visible_items / layout_settings.number_of_columns)
		local total_number_of_pages = math.ceil(total_number_of_rows / layout_settings.scroll_number_of_rows)

		current_page = math.ceil(self._top_visible_row / total_number_of_rows * total_number_of_pages)
	end

	return current_page
end

function ItemListMenuContainer:num_pages(layout_settings)
	local total_number_of_pages = 1

	if self._scroll_items then
		local num_visible_items = self:num_visible_items()
		local item_text = self._scroll_items[3]
		local total_number_of_rows = math.ceil(num_visible_items / layout_settings.number_of_columns)

		total_number_of_pages = math.ceil(total_number_of_rows / layout_settings.scroll_number_of_rows)
	end

	return total_number_of_pages
end

function ItemListMenuContainer:render(dt, t, gui, layout_settings)
	if #self._items == 0 then
		return
	end

	local num_visible_items = self:num_visible_items()
	local number_of_columns = layout_settings.number_of_columns or 1
	local number_of_rows = math.ceil(num_visible_items / number_of_columns)
	local number_of_visible_rows = layout_settings.number_of_visible_rows or number_of_rows
	local visible_items = self:_visible_items(number_of_columns, number_of_visible_rows)

	for i, item in ipairs(visible_items) do
		if item:visible() then
			item:render(dt, t, gui, MenuHelper:layout_settings(item.config.layout_settings))
		end
	end

	if self._scroll_items then
		local item_up = self._scroll_items[1]

		item_up.config.disabled = not self:can_scroll_up(layout_settings)

		local item_down = self._scroll_items[2]

		item_down.config.disabled = not self:can_scroll_down(layout_settings)

		local item_text = self._scroll_items[3]
		local num_visible_items = self:num_visible_items()
		local total_number_of_rows = math.ceil(num_visible_items / layout_settings.number_of_columns)
		local total_number_of_pages = math.ceil(total_number_of_rows / layout_settings.scroll_number_of_rows)
		local current_page = math.ceil(self._top_visible_row / total_number_of_rows * total_number_of_pages)

		item_text.config.text = current_page .. "/" .. total_number_of_pages

		if not item_up.config.disabled or not item_down.config.disabled then
			if not item_up:removed() then
				item_up:render(dt, t, gui, MenuHelper:layout_settings(item_up.config.layout_settings))
			end

			if not item_down:removed() then
				item_down:render(dt, t, gui, MenuHelper:layout_settings(item_down.config.layout_settings))
			end

			if not item_text:removed() then
				item_text:render(dt, t, gui, MenuHelper:layout_settings(item_text.config.layout_settings))
			end
		end
	end

	if layout_settings.background_color then
		local c = layout_settings.background_color
		local color = Color(c[1], c[2], c[3], c[4])
		local height = math.max(layout_settings.background_min_height or 0, self._height)

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y + self._height - height), self._z), Vector2(math.floor(self._width), math.floor(height)), color)
	end

	if layout_settings.texture_background then
		local c = layout_settings.texture_background_color or {
			255,
			255,
			255,
			255
		}
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.bitmap(gui, layout_settings.texture_background, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(self._width), math.floor(self._height)), color)
	end
end

function ItemListMenuContainer.create_from_config(items, scroll_items)
	return ItemListMenuContainer:new(items, scroll_items)
end
