-- chunkname: @scripts/menu/menu_pages/level_1_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")
require("scripts/menu/menu_containers/news_ticker_menu_container")
require("scripts/menu/menu_pages/main_menu_page")

Level1MenuPage = class(Level1MenuPage, MainMenuPage)
Level1MenuPage.menu_level = 1

function Level1MenuPage:init(config, item_groups, world)
	Level1MenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
	self._news_ticker = NewsTickerMenuContainer:new()

	self._news_ticker:load(self._gui)
end

function Level1MenuPage:_update_container_size(dt, t)
	Level1MenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
	self._news_ticker:update_size(dt, t, self._gui, layout_settings.news_ticker)
end

function Level1MenuPage:_update_container_position(dt, t)
	Level1MenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 15)

	local x, y = MenuHelper:container_position(self._news_ticker, layout_settings.news_ticker)

	self._news_ticker:update_position(dt, t, layout_settings.news_ticker, x, y, 800)
end

function Level1MenuPage:render_from_child_page(dt, t, leef)
	if script_data.hide_title_screen then
		return
	end

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._gradient_texture:render(dt, t, self._gui, layout_settings.gradient_texture)
	self._vertical_line_texture:render(dt, t, self._gui, layout_settings.vertical_line_texture)
	self._corner_top_texture:render(dt, t, self._gui, layout_settings.corner_top_texture)
	self._corner_bottom_texture:render(dt, t, self._gui, layout_settings.corner_bottom_texture)

	if leef.menu_level == 2 or leef.config.type == "drop_down_list" and leef.config.parent_page and leef.config.parent_page.menu_level == 2 then
		self._item_list:render_from_child_page(dt, t, self._gui, layout_settings.item_list)
	end
end

function Level1MenuPage:render(dt, t)
	if script_data.hide_title_screen then
		return
	end

	Level1MenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
	self._news_ticker:render(dt, t, self._gui, layout_settings.news_ticker)
end

function Level1MenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "level_1",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		on_enter_highlight_item = page_config.on_enter_highlight_item,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		on_cancel_input = page_config.on_cancel_input,
		on_cancel_input_args = page_config.on_cancel_input_args,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return Level1MenuPage:new(config, item_groups, compiler_data.world)
end
