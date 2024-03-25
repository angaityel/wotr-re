-- chunkname: @scripts/menu/menu_pages/expandable_popup_menu_page.lua

ExpandablePopupMenuPage = class(ExpandablePopupMenuPage, MenuPage)

function ExpandablePopupMenuPage:init(config, item_groups, world)
	ExpandablePopupMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self.config.on_enter_options_args.popup_page = self
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
	self._background_rect = RectMenuContainer.create_from_config()
	self._background_texture = TextureMenuContainer.create_from_config()
end

function ExpandablePopupMenuPage:on_enter()
	ExpandablePopupMenuPage.super.on_enter(self)
	self:_try_callback(self.config.callback_object, self.config.on_enter_options, self.config.on_enter_options_args)
end

function ExpandablePopupMenuPage:update(dt, t)
	ExpandablePopupMenuPage.super.update(self, dt, t)
	self:_update_container_size(dt, t)
	self:_update_container_position(dt, t)
end

function ExpandablePopupMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)

	layout_settings.background_rect.absolute_height = self._item_list:height()

	self._background_rect:update_size(dt, t, self._gui, layout_settings.background_rect)
end

function ExpandablePopupMenuPage:_update_container_position(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 2)

	local x = self._item_list:x() + self._item_list:width() - self._background_texture:width()
	local y = self._item_list:y()

	self._background_texture:update_position(dt, t, layout_settings.background_texture, x, y, self.config.z + 1)

	local x, y = MenuHelper:container_position(self._background_rect, layout_settings.background_rect)

	self._background_rect:update_position(dt, t, layout_settings.background_rect, x, y, self.config.z)
end

function ExpandablePopupMenuPage:render(dt, t)
	ExpandablePopupMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)
	self._background_rect:render(dt, t, self._gui, layout_settings.background_rect)
end

function ExpandablePopupMenuPage:cb_item_selected(popup_action, parent_page_action)
	local parent_page_args = {
		action = parent_page_action,
		popup_page = self
	}

	self:_try_callback(self.config.callback_object, self.config.on_item_selected, parent_page_args)

	if popup_action == "close" then
		self._menu_logic:change_page(self.config.parent_page)
	end
end

function ExpandablePopupMenuPage:cb_item_disabled(disabled_func)
	local parent_page_args = {
		popup_page = self
	}

	return self:_try_callback(self.config.callback_object, disabled_func, parent_page_args)
end

function ExpandablePopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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

	return ExpandablePopupMenuPage:new(config, item_groups, compiler_data.world)
end
