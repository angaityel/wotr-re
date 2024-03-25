-- chunkname: @scripts/menu/menu_pages/menu_page.lua

require("scripts/helpers/menu_helper")
require("scripts/hud/hud_elements_buttons_x360")

MenuPage = class(MenuPage)

function MenuPage:init(config, item_groups, world)
	self.config = config
	self._current_highlight = nil
	self._parent_item = nil
	self._gui = World.get_data(world, "menu_gui")
	self._items = {}
	self._item_groups = item_groups
	self._width = config.width
	self._height = config.height
	self._played_music_events = {}

	self:_try_play_music_events("on_page_init")
	self:_setup_button_gui(self._gui)
end

function MenuPage:_try_play_music_events(page_event)
	local music_events = self.config.music_events

	if music_events and music_events[page_event] then
		for i, config in ipairs(music_events[page_event]) do
			if not config.play_once or not self._played_music_events[config.event] then
				Managers.music:trigger_event(config.event)

				self._played_music_events[config.event] = true
			end
		end
	end
end

function MenuPage:_setup_button_gui(gui)
	self._button_gui = gui
end

function MenuPage:update(dt, t)
	for index, item in ipairs(self._items) do
		item:update_disabled()
		item:update_visible()
		item:update_remove()

		local disabled = not IS_DEMO and item.config.disabled or false
		local invisible = item.config.visible == false
		local removed = item:removed()

		if item == self:_highlighted_item() and (disabled or invisible or removed) then
			self:_highlight_item(nil, true)
		end
	end

	if self.config.render_parent_page then
		self:parent_page():update_from_child_page(dt, t)
	end
end

function MenuPage:update_from_child_page(dt, t)
	self:update(dt, t)
end

function MenuPage:set_input(input)
	self:_update_input(input)
	self:_update_mouse_hover(input)
end

function MenuPage:_update_input(input)
	if not input then
		return
	end

	if input:has("select") and input:get("select") then
		self:_select_item()

		self._mouse = false
	elseif input:has("move_up") and input:get("move_up") then
		self:move_up()

		self._mouse = false
	elseif input:has("move_down") and input:get("move_down") then
		self:move_down()

		self._mouse = false
	elseif input:has("move_left") and input:get("move_left") and input:has("move_up_button") and not (input:get("move_up_button") > 0) and input:has("move_down_button") and not (input:get("move_down_button") > 0) then
		self:move_left()

		self._mouse = false
	elseif input:has("move_right") and input:get("move_right") and input:has("move_up_button") and not (input:get("move_up_button") > 0) and input:has("move_down_button") and not (input:get("move_down_button") > 0) then
		self:move_right()

		self._mouse = false
	elseif input:has("cancel") and input:get("cancel") then
		self._mouse = false
		self._mouse_highlight = nil

		self:_try_cancel()
	end
end

function MenuPage:_try_cancel()
	if self.config.on_cancel_input then
		local callback_object = self.config.callback_object

		if self.config.on_cancel_input_callback_object == "page" then
			callback_object = self
		end

		self:_try_callback(callback_object, self.config.on_cancel_input, self.config.on_cancel_input_args)
	end

	if not self.config.no_cancel_to_parent_page then
		self:_cancel()
	end
end

function MenuPage:_auto_highlight_first_item()
	for index, item in ipairs(self._items) do
		if item:visible() and item:highlightable() and not item:disabled() and not item.config.hidden and not item:removed() then
			self:_highlight_item(index)

			break
		end
	end
end

function MenuPage:_update_mouse_hover(input)
	if not input then
		self:_set_item_mouse_position(nil, nil)

		return
	end

	local mouse_pos = input:has("cursor") and input:get("cursor")

	if not mouse_pos then
		if Window.show_cursor() or not self._current_highlight then
			self:_auto_highlight_first_item()
		end

		Window.set_show_cursor(false)

		return
	elseif not Window.show_cursor() then
		Window.set_show_cursor(true)
	end

	local highlight_index

	self:_set_item_mouse_position(mouse_pos.x, mouse_pos.y)

	for index, item in pairs(self._items) do
		if item:is_mouse_inside(mouse_pos.x, mouse_pos.y) and item:visible() and (item:visible_in_demo() or not item:disabled() and not item.config.hidden and not item:removed()) then
			highlight_index = index

			break
		end
	end

	if not self._mouse and highlight_index ~= self._mouse_highlight then
		self._mouse = true
	end

	self._mouse_highlight = highlight_index

	if not self._mouse then
		return
	end

	if highlight_index then
		self:_highlight_item(highlight_index)

		if input:get("select_left_click") then
			self:_on_left_click()
		end

		if input:get("select_right_click") then
			self:_on_right_click()
		end

		if input:get("select_down") == 1 then
			self:_select_item_down(mouse_pos)
		end
	else
		self:_highlight_item(nil)
	end
end

function MenuPage:_set_item_mouse_position(x, y)
	for _, item in pairs(self._items) do
		if x and y and item:is_mouse_inside(x, y) then
			item:set_mouse_position(x, y)
		else
			item:set_mouse_position(nil, nil)
		end
	end
end

function MenuPage:render(dt, t)
	if self.config.render_parent_page then
		self:parent_page():render_from_child_page(dt, t, self)
	end

	local layout_settings

	if self.config.layout_settings then
		layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	end

	local controller_active = Managers.input:pad_active(1)
	local layout = not layout_settings or not layout_settings.do_not_render_buttons
	local type = not self.config.type == "empty"

	if controller_active and (not layout_settings or not layout_settings.do_not_render_buttons) and self.config.type ~= "empty" then
		local button_info

		if layout_settings and layout_settings.button_info then
			button_info = layout_settings.button_info
		else
			button_info = MenuHelper:layout_settings(MainMenuSettings.default_button_info)
		end

		self:_render_button_info(button_info, self.config.button_info_name)
	end
end

function MenuPage:_render_button_info(layout_settings, button_info_name)
	local button_config = layout_settings[button_info_name] or layout_settings.default_buttons
	local text_data = layout_settings.text_data
	local w, h = Gui.resolution()
	local x = text_data.offset_x or 0
	local y = text_data.offset_y or 0
	local offset_x = 0
	local standard_button_size = {
		56,
		56
	}

	for _, button in ipairs(button_config) do
		local material, uv00, uv11, size = self:get_button_bitmap(button.button_name)
		local button_offset = {
			type(button.button_name) == "table" and #button.button_name * standard_button_size[1] or standard_button_size[1],
			size[2] == standard_button_size[2] and standard_button_size[2] or size[2] * 1.3
		}

		if type(button.button_name) == "table" then
			for i, button_name in ipairs(button.button_name) do
				local material, uv00, uv11, size = self:get_button_bitmap(button_name)
				local inner_button_offset = {
					type(button.button_name) == "table" and #button.button_name * standard_button_size[1] or standard_button_size[1],
					size[2] == standard_button_size[2] and standard_button_size[2] or size[2] * 1.3
				}

				Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x + (i - 1) * standard_button_size[1], y - inner_button_offset[2], 999), size)
			end
		else
			Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x, y - button_offset[2], 999), size)
		end

		local text = string.upper(L(button.text))

		Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + button_offset[1] + offset_x, y - standard_button_size[2] * 0.62, 999))

		if text_data.drop_shadow then
			local drop_x, drop_y = unpack(text_data.drop_shadow)

			Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + button_offset[1] + offset_x + drop_x, y - standard_button_size[2] * 0.62 + drop_y, 998), Color(0, 0, 0))
		end

		local min, max = Gui.text_extents(self._button_gui, text, text_data.font.font, text_data.font_size)

		offset_x = offset_x + (max[1] - min[1]) + button_offset[1]
	end
end

function MenuPage:render_from_child_page(dt, t)
	self:render(dt, t, true)
end

function MenuPage:_try_callback(callback_object, callback_name, ...)
	if callback_object and callback_name and callback_object[callback_name] then
		return callback_object[callback_name](callback_object, ...)
	end
end

function MenuPage:_select_item(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if not highlighted_item then
		return
	end

	highlighted_item:on_select(ignore_sound)

	local child_page = highlighted_item:page()

	if child_page then
		self._menu_logic:change_page(child_page, change_page_delay)
	end
end

function MenuPage:cb_is_demo()
	return IS_DEMO
end

function MenuPage:cb_is_not_demo()
	return not IS_DEMO
end

function MenuPage:cb_buy_game(args)
	if args == "confirm" or args.action == "confirm" then
		Application.open_url_in_browser(GameSettingsDevelopment.buy_game_url)
		Window.minimize()
	end
end

function MenuPage:_on_left_click(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if not highlighted_item then
		return
	end

	if highlighted_item.on_left_click then
		highlighted_item:on_left_click(ignore_sound)

		local child_page = highlighted_item:page()

		if child_page then
			self._menu_logic:change_page(child_page, change_page_delay)
		end
	else
		self:_select_item(change_page_delay, ignore_sound)
	end
end

function MenuPage:_on_right_click(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if not highlighted_item then
		return
	end

	if highlighted_item.on_right_click then
		highlighted_item:on_right_click(ignore_sound)
	end
end

function MenuPage:_select_item_down(mouse_pos)
	local highlighted_item = self:_highlighted_item()

	if not highlighted_item then
		return
	end

	highlighted_item:on_select_down(mouse_pos)
end

function MenuPage:_cancel()
	self._menu_logic:cancel_to_parent()
end

function MenuPage:parent_page()
	return self.config.parent_page
end

function MenuPage:environment()
	return self.config.environment
end

function MenuPage:camera()
	return self.config.camera
end

function MenuPage:items()
	return self._items
end

function MenuPage:visible_items()
	return self._items
end

function MenuPage:items_in_group(group)
	return self._item_groups[group]
end

function MenuPage:add_item_group(group)
	self._item_groups[group] = {}
end

function MenuPage:add_item(item, group)
	fassert(self._item_groups[group], "Group %q does not exist", group)

	self._items[#self._items + 1] = item
	self._item_groups[group][#self._item_groups[group] + 1] = item
end

function MenuPage:is_in_group(item, group)
	for i, group_item in ipairs(self._item_groups[group]) do
		if item == group_item then
			return true
		end
	end
end

function MenuPage:remove_items(group)
	for group_index = #self._item_groups[group], 1, -1 do
		local item = self._item_groups[group][group_index]

		if item == self:_highlighted_item() then
			self:_highlight_item(nil, true)
		end

		local index = table.find(self._items, item)

		table.remove(self._items, index)

		self._item_groups[group][group_index] = nil
	end
end

function MenuPage:remove_item_from_group(group, item)
	for group_index, group_item in pairs(self._item_groups[group]) do
		if group_item == item then
			if self:_highlighted_item() == item then
				self:_highlight_item(nil, true)
			end

			local index = table.find(self._items, item)

			table.remove(self._items, index)
			table.remove(self._item_groups[group], group_index)

			return
		end
	end
end

function MenuPage:num_items()
	return #self._items
end

function MenuPage:set_parent_item(item)
	self._parent_item = item
end

function MenuPage:cb_controller_enabled()
	return Managers.input:pad_active(1)
end

function MenuPage:cb_controller_disabled()
	return Managers.input:active_mapping(1) == "keyboard_mouse"
end

function MenuPage:on_enter(on_cancel)
	local controller_active = Managers.input:pad_active(1)

	if controller_active and not self.config.do_not_select_first_index then
		local index = self:_first_highlightable_index()

		if index then
			self:_highlight_item(index)
		end
	elseif not self.config.do_not_select_first_index then
		self:_highlight_item(nil, true)
	end

	self._mouse_highlight = nil

	for index, item in ipairs(self._items) do
		item:on_page_enter(on_cancel)
	end

	if self.config.on_enter_highlight_item then
		self:_on_enter_highlight_item()
	end

	self:_try_play_music_events("on_page_enter")
	Managers.state.event:trigger("show_game_mode_status", false)
end

function MenuPage:_on_enter_highlight_item()
	local callback_object = self.config.callback_object

	if self.config.on_enter_highlight_item_callback_object == "page" then
		callback_object = self
	end

	local item_name = self:_try_callback(self.config.callback_object, self.config.on_enter_highlight_item, self.config.on_enter_highlight_item_args)
	local item = self:find_item_by_name(item_name)

	if item and item:highlightable() then
		local item_index = self:_item_index(item)

		self:_highlight_item(item_index, true)
	end
end

function MenuPage:on_exit(on_cancel)
	for index, item in ipairs(self._items) do
		item:on_page_exit(on_cancel)
	end

	if on_cancel and self.config.on_cancel_exit then
		local callback_object = self.config.callback_object

		if self.config.on_cancel_exit_callback_object == "page" then
			callback_object = self
		end

		self:_try_callback(callback_object, self.config.on_cancel_exit, self.config.on_cancel_exit_args)
	end

	Managers.state.event:trigger("show_game_mode_status", true)
end

function MenuPage:_first_highlightable_index()
	for index, item in ipairs(self._items) do
		if item:highlightable() then
			return index
		end
	end
end

function MenuPage:_last_highlightable_index()
	for index = #self._items, 1, -1 do
		local item = self._items[index]

		if item:highlightable() then
			return index
		end
	end
end

function MenuPage:_item_index(item)
	return table.find(self._items, item)
end

function MenuPage:_highlighted_item()
	return self._items[self._current_highlight]
end

function MenuPage:_highlight_item(index, ignore_sound)
	if self._current_highlight ~= index then
		if self:_highlighted_item() then
			self:_highlighted_item():on_lowlight()
		end

		self._current_highlight = index

		if self:_highlighted_item() then
			self:_highlighted_item():on_highlight(ignore_sound)
		end
	end
end

function MenuPage:destroy()
	if self.__destroyed then
		return
	end

	self.__destroyed = true

	for index, item in ipairs(self._items) do
		item:destroy()
	end
end

function MenuPage:move_up()
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			index = index - 1

			if index < 1 then
				index = self:num_items()
			end
		until self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function MenuPage:move_down()
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			index = index % self:num_items() + 1
		until self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function MenuPage:move_left()
	if self:_highlighted_item() then
		self:_highlighted_item():on_move_left()
	end
end

function MenuPage:move_right()
	if self:_highlighted_item() then
		self:_highlighted_item():on_move_right()
	end
end

function MenuPage:set_menu_logic(menu_logic)
	self._menu_logic = menu_logic
end

function MenuPage:cb_cancel()
	self:_cancel()
end

function MenuPage:find_item_by_name(name)
	for i, item in ipairs(self._items) do
		if item.config.name and item.config.name == name then
			return item
		end
	end
end

function MenuPage:find_item_by_name_in_group(group, name)
	for i, item in ipairs(self._item_groups[group]) do
		if item.config.name and item.config.name == name then
			return item
		end
	end
end

function MenuPage:find_items_by_type_in_group(group, type)
	local items = {}
	local item_group = self._item_groups[group]

	for i, item in ipairs(item_group) do
		if item.config.type and item.config.type == type then
			items[#items + 1] = item
		end
	end

	return items
end

function MenuPage:find_items_of_type(type)
	local items = {}

	for i, item in ipairs(self._items) do
		if item.config.type and item.config.type == type then
			items[#items + 1] = item
		end
	end

	return items
end

function MenuPage:menu_activated()
	for index, item in pairs(self._items) do
		if item.config.page and item.config.page == self then
			print("[MenuPage:menu_activated()] Item found with same page as parent page! Item type:", item.config.type, "Page type:", item.config.page.config.type)
		end

		item:menu_activated()
	end
end

function MenuPage:menu_deactivated(tab)
	tab = tab or {}

	if tab[self] then
		-- block empty
	end

	tab[self] = true

	for index, item in pairs(self._items) do
		if item.config.page and item.config.page == self then
			print("[MenuPage:menu_deactivated()] Item found with same page as parent page! Item type:", item.config.type, "Page type:", item.config.page.config.type)
		end

		item:menu_deactivated(tab)
	end
end

function MenuPage:get_button_bitmap(button_name)
	if button_name and X360Buttons[button_name] then
		local uv00 = X360Buttons[button_name].uv00
		local uv11 = X360Buttons[button_name].uv11
		local size = X360Buttons[button_name].size

		return "x360_buttons", Vector2(uv00[1], uv00[2]), Vector2(uv11[1], uv11[2]), Vector2(size[1], size[2])
	else
		local uv00 = X360Buttons.default.uv00
		local uv11 = X360Buttons.default.uv11
		local size = X360Buttons.default.size

		return "x360_buttons", Vector2(uv00[1], uv00[2]), Vector2(uv11[1], uv11[2]), Vector2(size[1], size[2])
	end
end

function MenuPage:open_sale_popup(sale_items)
	self._sale_popup = MenuHelper:create_sale_popup_page(self._world, self, self, self.config.z + 50, self.config.sounds, sale_items)

	self._menu_logic:change_page(self._sale_popup)
end
