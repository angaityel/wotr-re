-- chunkname: @scripts/menu/menu_pages/demo_popup_menu_page.lua

DemoPopupMenuPage = class(DemoPopupMenuPage, PopupMenuPage)

function DemoPopupMenuPage:init(config, item_groups, world)
	DemoPopupMenuPage.super.super.init(self, config, item_groups, world)

	self._world = world
	self.config.on_enter_options_args.popup_page = self
	self._header_list = ItemListMenuContainer.create_from_config(item_groups.header_list)
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
	self._button_list = ItemListMenuContainer.create_from_config(item_groups.button_list)
	self._background_texture = TextureMenuContainer.create_from_config()

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.overlay_texture then
		self._overlay_texture = FrameTextureMenuContainer.create_from_config()
	end
end

function DemoPopupMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._header_list:update_size(dt, t, self._gui, layout_settings.header_list)
	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
	self._button_list:update_size(dt, t, self._gui, layout_settings.button_list)
	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)

	if self._overlay_texture then
		self._overlay_texture:update_size(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function DemoPopupMenuPage:_update_container_position(dt, t)
	local w, h = Gui.resolution()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._header_list, layout_settings.header_list)

	self._header_list:update_position(dt, t, layout_settings.header_list, x, y, self.config.z + 1)

	x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 1)

	local x = w * 0.5 - self._background_texture:width() * 0.5
	local y = h * 0.5 - self._background_texture:height() * 0.5

	self._background_texture:update_position(dt, t, layout_settings.background_texture, x, y, self.config.z + 1)
	self._button_list:update_position(dt, t, layout_settings.button_list, x, y, self.config.z + 1)

	if self._overlay_texture then
		local x, y = MenuHelper:container_position(self._overlay_texture, layout_settings.overlay_texture)

		self._overlay_texture:update_position(dt, t, layout_settings.overlay_texture, x, y, self.config.z + 40)
	end
end

function DemoPopupMenuPage:render(dt, t)
	DemoPopupMenuPage.super.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._button_list:render(dt, t, self._gui, layout_settings.button_list)
	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)

	local parent_page_type = self.config.parent_page and self.config.parent_page.config.type

	if self._overlay_texture and parent_page_type ~= "drop_down_list" then
		self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function DemoPopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "popup",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_options = page_config.on_enter_options,
		on_enter_options_args = page_config.on_enter_options_args or {},
		on_item_selected = page_config.on_item_selected,
		on_cancel_exit = page_config.on_cancel_exit,
		show_revision = page_config.show_revision,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		in_splash_screen = page_config.in_splash_screen
	}

	return DemoPopupMenuPage:new(config, item_groups, compiler_data.world)
end
