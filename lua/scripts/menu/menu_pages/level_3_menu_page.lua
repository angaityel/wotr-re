-- chunkname: @scripts/menu/menu_pages/level_3_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")

Level3MenuPage = class(Level3MenuPage, MainMenuPage)
Level3MenuPage.menu_level = 3

function Level3MenuPage:init(config, item_groups, world)
	Level3MenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_texture = TextureMenuContainer.create_from_config()
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
end

function Level3MenuPage:_update_container_size(dt, t)
	Level3MenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	layout_settings.background_texture.stretch_height = self._item_list:height()

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
end

function Level3MenuPage:_update_container_position(dt, t)
	Level3MenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 15)

	local x = self._item_list:x() + self._item_list:width() - self._background_texture:width()
	local y = self._item_list:y()

	self._background_texture:update_position(dt, t, layout_settings.background_texture, x, y, self.config.z + 10)
end

function Level3MenuPage:render_from_child_page(dt, t, leef)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local page_type = self:_highlighted_item() and self:_highlighted_item().config.page and self:_highlighted_item().config.page.config.type

	if page_type == "drop_down_list" or page_type == "popup" then
		self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
		self._item_list:render(dt, t, self._gui, layout_settings.item_list)
	else
		self._item_list:render_from_child_page(dt, t, self._gui, layout_settings.item_list)
	end

	self.config.parent_page:render_from_child_page(dt, t, leef or self)
end

function Level3MenuPage:render(dt, t)
	Level3MenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
end

function Level3MenuPage:cb_controller_help_func()
	local pad_active = Managers.input:pad_active(1)

	if pad_active then
		return "\n\n\n\n" .. L("menu_switch_to_mouse_input_help")
	else
		return "\n\n\n\n" .. L("menu_switch_to_pad_input_help")
	end
end

function Level3MenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "level_3",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		show_revision = page_config.show_revision,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera(),
		static_tooltip_callback = page_config.static_tooltip_callback
	}

	return Level3MenuPage:new(config, item_groups, compiler_data.world)
end
