-- chunkname: @scripts/menu/menu_pages/level_2_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")

Level2MenuPage = class(Level2MenuPage, MainMenuPage)
Level2MenuPage.menu_level = 2

function Level2MenuPage:init(config, item_groups, world)
	Level2MenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_texture = TextureMenuContainer.create_from_config()
	self._horizontal_line_top_texture = TextureMenuContainer.create_from_config()
	self._horizontal_line_bottom_texture = TextureMenuContainer.create_from_config()
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
end

function Level2MenuPage:_update_container_size(dt, t)
	Level2MenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	layout_settings.background_texture.stretch_height = self._item_list:height()

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
	self._horizontal_line_top_texture:update_size(dt, t, self._gui, layout_settings.horizontal_line_top_texture)
	self._horizontal_line_bottom_texture:update_size(dt, t, self._gui, layout_settings.horizontal_line_bottom_texture)
	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
end

function Level2MenuPage:_update_container_position(dt, t)
	Level2MenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x = 0
	local y = self._parent_item:y() + self._parent_item:height() - self._background_texture:height()

	self._background_texture:update_position(dt, t, layout_settings, x, y, self.config.z + 15)

	x = self._background_texture:width() / 2 - self._horizontal_line_top_texture:width() / 2
	y = self._background_texture:y() + self._background_texture:height()

	self._horizontal_line_top_texture:update_position(dt, t, layout_settings, x, y, self.config.z + 15)

	x = self._background_texture:width() / 2 - self._horizontal_line_bottom_texture:width() / 2
	y = self._background_texture:y() - self._horizontal_line_bottom_texture:height()

	self._horizontal_line_bottom_texture:update_position(dt, t, layout_settings, x, y, self.config.z + 15)

	x = self._parent_item:x() + self._parent_item:width() - self._item_list:width()
	y = self._parent_item:y() + self._parent_item:height() - self._item_list:height()

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 20)
end

function Level2MenuPage:render_from_child_page(dt, t, leef)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local page_type = self:_highlighted_item() and self:_highlighted_item().config.page and self:_highlighted_item().config.page.config.type

	if page_type == "drop_down_list" then
		self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
		self._item_list:render(dt, t, self._gui, layout_settings.item_list)
	end

	self.config.parent_page:render_from_child_page(dt, t, leef or self)
end

function Level2MenuPage:render(dt, t)
	Level2MenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
	self._horizontal_line_top_texture:render(dt, t, self._gui, layout_settings.horizontal_line_top_texture)
	self._horizontal_line_bottom_texture:render(dt, t, self._gui, layout_settings.horizontal_line_bottom_texture)
	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
end

function Level2MenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "level_2",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		show_revision = page_config.show_revision,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return Level2MenuPage:new(config, item_groups, compiler_data.world)
end
