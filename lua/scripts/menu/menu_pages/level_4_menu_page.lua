-- chunkname: @scripts/menu/menu_pages/level_4_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")

Level4MenuPage = class(Level4MenuPage, MainMenuPage)
Level4MenuPage.menu_level = 4

function Level4MenuPage:init(config, item_groups, world)
	Level4MenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self:_create_scroll_items()

	self._background_texture = TextureMenuContainer.create_from_config()
	self._background_texture_top_line = RectMenuContainer.create_from_config()
	self._background_texture_bottom_shadow = TextureMenuContainer.create_from_config()
	self._item_list_header = ItemListMenuContainer.create_from_config(item_groups.item_list_header)
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list, item_groups.item_list_scroll)
end

function Level4MenuPage:_create_scroll_items()
	local scroll_up_config = {
		on_select = "cb_scroll_up_item_list",
		callback_object = "page",
		parent_page = self,
		z = self.config.z + 1,
		layout_settings = MainMenuSettings.items.scroll_up_left_aligned,
		sounds = self.config.sounds.items.texture
	}
	local scroll_up_item = TextureMenuItem.create_from_config({
		world = self._world
	}, scroll_up_config, self)

	self:add_item(scroll_up_item, "item_list_scroll")

	local scroll_down_config = {
		on_select = "cb_scroll_down_item_list",
		callback_object = "page",
		parent_page = self,
		z = self.config.z + 1,
		layout_settings = MainMenuSettings.items.scroll_down_left_aligned,
		sounds = self.config.sounds.items.texture
	}
	local scroll_down_item = TextureMenuItem.create_from_config({
		world = self._world
	}, scroll_down_config, self)

	self:add_item(scroll_down_item, "item_list_scroll")

	local scroll_text_config = {
		text = "",
		no_localization = true,
		disabled = true,
		parent_page = self,
		z = self.config.z + 1,
		layout_settings = MainMenuSettings.items.scroll_text_left_aligned
	}
	local scroll_text_item = TextMenuItem.create_from_config({
		world = self._world
	}, scroll_text_config, self)

	self:add_item(scroll_text_item, "item_list_scroll")
end

function Level4MenuPage:cb_scroll_up_item_list()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:scroll_up(layout_settings.item_list)
end

function Level4MenuPage:cb_scroll_down_item_list()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:scroll_down(layout_settings.item_list)
end

function Level4MenuPage:_update_container_size(dt, t)
	Level4MenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local num_items = #self:items_in_group("item_list")

	if num_items > layout_settings.item_list.max_visible_rows then
		layout_settings.item_list.number_of_columns = 2
		layout_settings.item_list.number_of_visible_rows = layout_settings.item_list.max_visible_rows
		layout_settings.item_list.scroll_number_of_rows = layout_settings.item_list.max_visible_rows
	else
		layout_settings.item_list.number_of_columns = 1
		layout_settings.item_list.number_of_visible_rows = num_items
		layout_settings.item_list.scroll_number_of_rows = num_items
	end

	self._item_list_header:update_size(dt, t, self._gui, layout_settings.item_list)
	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)

	layout_settings.background_texture.stretch_height = self._item_list:height() + self._item_list_header:height() + (self._back_list and self._back_list:height() or 0)

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
	self._background_texture_top_line:update_size(dt, t, self._gui, layout_settings.background_texture_top_line)
	self._background_texture_bottom_shadow:update_size(dt, t, self._gui, layout_settings.background_texture_bottom_shadow)
end

function Level4MenuPage:_update_container_position(dt, t)
	Level4MenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_x, header_y

	if self.config.parent_page.menu_level == 4 then
		header_x = MenuHelper:container_position(self._item_list_header, layout_settings.item_list)
		header_y = self.config.parent_page:items_in_group("item_list_header")[1]:y() - self._item_list_header:height()

		self._item_list_header:update_position(dt, t, layout_settings.item_list, header_x, header_y, self.config.z + 20)
	else
		header_x = MenuHelper:container_position(self._item_list_header, layout_settings.item_list)
		header_y = self._parent_item:y() + self._parent_item:height() - self._item_list_header:height()

		self._item_list_header:update_position(dt, t, layout_settings.item_list, header_x, header_y, self.config.z + 20)
	end

	local list_x = MenuHelper:container_position(self._item_list, layout_settings.item_list)
	local list_y = header_y - self._item_list:height()

	self._item_list:update_position(dt, t, layout_settings.item_list, list_x, list_y, self.config.z + 20)

	local bgr_x = 0
	local bgr_y = header_y + self._item_list_header:height() - self._background_texture:height()

	self._background_texture:update_position(dt, t, layout_settings.background_texture, bgr_x, bgr_y, self.config.z + 15)
	self._background_texture_top_line:update_position(dt, t, layout_settings.background_texture_top_line, bgr_x, bgr_y + self._background_texture:height() + 1 - self._background_texture_top_line:height(), self.config.z + 16)
	self._background_texture_bottom_shadow:update_position(dt, t, layout_settings.background_texture_bottom_shadow, bgr_x, bgr_y - self._background_texture_bottom_shadow:height(), self.config.z + 16)

	if self._tooltip_text_box then
		local tooltip_x = MenuHelper:container_position(self._tooltip_text_box, layout_settings.tooltip_text_box)
		local tooltip_y = self._item_list_header:y() + self._item_list_header:height() - self._tooltip_text_box:height()

		self._tooltip_text_box:update_position(dt, t, layout_settings.tooltip_text_box, tooltip_x, tooltip_y, self.config.z + 20)

		if self._tooltip_text_box_2 then
			local tooltip_2_x = MenuHelper:container_position(self._tooltip_text_box_2, layout_settings.tooltip_text_box_2)
			local tooltip_2_y = tooltip_y - self._tooltip_text_box_2:height()

			self._tooltip_text_box_2:update_position(dt, t, layout_settings.tooltip_text_box_2, tooltip_2_x, tooltip_2_y, self.config.z + 20)
		end
	end
end

function Level4MenuPage:render_from_child_page(dt, t, leef)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local page_type = self:_highlighted_item() and self:_highlighted_item().config.page and self:_highlighted_item().config.page.config.type

	if page_type == "drop_down_list" or page_type == "popup" then
		self._item_list_header:render(dt, t, self._gui, layout_settings.item_list)
		self._item_list:render(dt, t, self._gui, layout_settings.item_list)

		local max_height = self._item_list:height() + self._item_list_header:height() + (self._back_list and self._back_list:height() or 0)

		if max_height < self._tooltip_text_box:height() + self._tooltip_text_box_2:height() then
			max_height = self._tooltip_text_box:height() + self._tooltip_text_box_2:height()
		end

		layout_settings.background_texture.stretch_height = max_height

		self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)

		if self.config.parent_page:items_in_group("item_list_header") then
			local bgr_x = 0
			local bgr_y = self.config.parent_page:items_in_group("item_list_header")[1]:y() - self._background_texture:height()

			self._background_texture:update_position(dt, t, layout_settings.background_texture, bgr_x, bgr_y, self.config.z + 15)
			self._background_texture_bottom_shadow:update_position(dt, t, layout_settings.background_texture_bottom_shadow, bgr_x, bgr_y - self._background_texture_bottom_shadow:height(), self.config.z + 16)
		end

		self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
		self._background_texture_top_line:render(dt, t, self._gui, layout_settings.background_texture_top_line)
		self._background_texture_bottom_shadow:render(dt, t, self._gui, layout_settings.background_texture_bottom_shadow)
	else
		self._item_list_header:render_from_child_page(dt, t, self._gui, layout_settings.item_list)
		self._item_list:render_from_child_page(dt, t, self._gui, layout_settings.item_list)
		self._background_texture:render_from_child_page(dt, t, self._gui, layout_settings.background_texture)
	end

	if self._tooltip_text_box then
		self._tooltip_text_box:render(dt, t, self._gui, layout_settings.tooltip_text_box)
	end

	if self._tooltip_text_box_2 then
		self._tooltip_text_box_2:render(dt, t, self._gui, layout_settings.tooltip_text_box_2)
	end

	self.config.parent_page:render_from_child_page(dt, t, leef or self)
end

function Level4MenuPage:render(dt, t)
	Level4MenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
	self._background_texture_top_line:render(dt, t, self._gui, layout_settings.background_texture_top_line)
	self._background_texture_bottom_shadow:render(dt, t, self._gui, layout_settings.background_texture_bottom_shadow)
	self._item_list_header:render(dt, t, self._gui, layout_settings.item_list)
	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
end

function Level4MenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "level_4",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return Level4MenuPage:new(config, item_groups, compiler_data.world)
end
