-- chunkname: @scripts/menu/menu_pages/popup_menu_page.lua

require("scripts/utils/big_picture_input_handler")

PopupMenuPage = class(PopupMenuPage, MenuPage)

function PopupMenuPage:init(config, item_groups, world)
	PopupMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self.config.on_enter_options_args.popup_page = self
	self._header_list = ItemListMenuContainer.create_from_config(item_groups.header_list)
	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
	self._button_list = ItemListMenuContainer.create_from_config(item_groups.button_list)
	self._background_rect = RectMenuContainer.create_from_config()

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.overlay_texture then
		self._overlay_texture = FrameTextureMenuContainer.create_from_config()
	end

	if self.config.try_big_picture_input then
		self._big_picture_input_handler = BigPictureInputHandler:new()
	end
end

function PopupMenuPage:on_enter()
	PopupMenuPage.super.on_enter(self)
	self:_try_callback(self.config.callback_object, self.config.on_enter_options, self.config.on_enter_options_args)

	if Managers.input:pad_active(1) and self.config.try_big_picture_input then
		local abort_big_picture = not self._big_picture_input_handler:show_text_input(L(self.config.big_picture_input_params.description), self.config.big_picture_input_params.min_text_length, self.config.big_picture_input_params.max_text_length, self.config.big_picture_input_params.password)

		if abort_big_picture then
			self._big_picture_input_handler_active = false
		else
			self._big_picture_input_handler_active = true
		end
	else
		self._big_picture_input_handler_active = false
	end
end

function PopupMenuPage:update(dt, t)
	PopupMenuPage.super.update(self, dt, t)
	self:_update_container_size(dt, t)
	self:_update_container_position(dt, t)

	if self._big_picture_input_handler_active then
		local text, done, submitted = self._big_picture_input_handler:poll_text_input_done()

		if done then
			self._mouse = false

			self:_try_cancel()

			if submitted then
				local bp_callback_object = self.config[self.config.big_picture_input_params.bp_callback_object]
				local bp_callback = callback(bp_callback_object, self.config.big_picture_input_params.bp_callback_name)

				bp_callback(text)
			end
		end
	end
end

function PopupMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._header_list:update_size(dt, t, self._gui, layout_settings.header_list)
	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
	self._button_list:update_size(dt, t, self._gui, layout_settings.button_list)
	self._background_rect:update_size(dt, t, self._gui, layout_settings.background_rect)

	if self._overlay_texture then
		self._overlay_texture:update_size(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function PopupMenuPage:_update_container_position(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._header_list, layout_settings.header_list)

	self._header_list:update_position(dt, t, layout_settings.header_list, x, y, self.config.z + 1)

	x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 1)

	x, y = MenuHelper:container_position(self._button_list, layout_settings.button_list)

	self._button_list:update_position(dt, t, layout_settings.button_list, x, y, self.config.z + 1)

	x, y = MenuHelper:container_position(self._background_rect, layout_settings.background_rect)

	self._background_rect:update_position(dt, t, layout_settings.background_rect, x, y, self.config.z)

	if self._overlay_texture then
		local x, y = MenuHelper:container_position(self._overlay_texture, layout_settings.overlay_texture)

		self._overlay_texture:update_position(dt, t, layout_settings.overlay_texture, x, y, self.config.z + 40)
	end
end

function PopupMenuPage:_update_input(input)
	if not self._big_picture_input_handler_active then
		PopupMenuPage.super._update_input(self, input)
	end
end

function PopupMenuPage:render(dt, t)
	PopupMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if not self._big_picture_input_handler_active then
		self._header_list:render(dt, t, self._gui, layout_settings.header_list)
		self._item_list:render(dt, t, self._gui, layout_settings.item_list)
		self._button_list:render(dt, t, self._gui, layout_settings.button_list)
		self._background_rect:render(dt, t, self._gui, layout_settings.background_rect)
	end

	local parent_page_type = self.config.parent_page and self.config.parent_page.config.type

	if self._overlay_texture and parent_page_type ~= "drop_down_list" then
		self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function PopupMenuPage:cb_item_selected(popup_action, parent_page_action)
	local parent_page_args = {
		action = parent_page_action,
		popup_page = self
	}

	self:_try_callback(self.config.callback_object, self.config.on_item_selected, parent_page_args)

	if popup_action and popup_action == "close" then
		self._menu_logic:change_page(self.config.parent_page)
	end
end

function PopupMenuPage:cb_item_disabled(disabled_func)
	local parent_page_args = {
		popup_page = self
	}

	return self:_try_callback(self.config.callback_object, disabled_func, parent_page_args)
end

function PopupMenuPage:move_left()
	PopupMenuPage.super.move_down(self)
end

function PopupMenuPage:move_right()
	PopupMenuPage.super.move_up(self)
end

function PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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
		in_splash_screen = page_config.in_splash_screen,
		try_big_picture_input = page_config.try_big_picture_input,
		big_picture_input_params = page_config.big_picture_input_params
	}

	return PopupMenuPage:new(config, item_groups, compiler_data.world)
end
