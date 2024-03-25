-- chunkname: @scripts/menu/menu_pages/drop_down_list_menu_page.lua

require("scripts/menu/menu_containers/drop_down_list_menu_container")

DropDownListMenuPage = class(DropDownListMenuPage, MainMenuPage)

function DropDownListMenuPage:init(config, item_groups, world)
	DropDownListMenuPage.super.init(self, config, item_groups, world)

	self._world = world

	self:add_item_group("items")

	self._drop_down_list = ItemGridMenuContainer.create_from_config(item_groups.items, nil, item_groups.scroll_bar)
end

function DropDownListMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	DropDownListMenuPage.super._highlight_item(self, index, ignore_sound)

	if self:_highlighted_item() ~= highlighted_item then
		self:_try_callback(self.config.callback_object, self.config.on_option_highlighted, self:_highlighted_item())
	end
end

function DropDownListMenuPage:on_enter()
	self:remove_items("items")

	local options, selection = self:_try_callback(self.config.callback_object, self.config.on_enter_options, unpack(self.config.on_enter_options_args or {}))
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	for _, option in pairs(options) do
		local item_config = {
			no_localization = true,
			on_select = self.config.on_option_changed,
			on_select_args = {
				option
			},
			text = option.value,
			tooltip_text = option.tooltip_text,
			tooltip_text_2 = option.tooltip_text_2,
			layout_settings = layout_settings.drop_down_list.item_config,
			parent_page = self,
			sounds = self.config.sounds.items.text
		}
		local item = TextMenuItem.create_from_config({
			world = self._world
		}, item_config, self.config.callback_object)

		self:add_item(item, "items")
	end

	DropDownListMenuPage.super.on_enter(self)

	local controller_active = Managers.input:pad_active(1)

	if controller_active and not self.config.do_not_select_first_index then
		self:_auto_highlight_first_item()
	end
end

function DropDownListMenuPage:_select_item(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if highlighted_item then
		highlighted_item:on_select()

		if self.config.parent_page and highlighted_item.config.type ~= "scroll_bar" then
			self._menu_logic:change_page(self.config.parent_page)
		end
	end
end

function DropDownListMenuPage:_update_container_size(dt, t)
	DropDownListMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._drop_down_list:update_size(dt, t, self._gui, layout_settings.drop_down_list)
end

function DropDownListMenuPage:_update_container_position(dt, t)
	DropDownListMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local list_x, list_y, list_z

	if layout_settings.drop_down_list.list_alignment == "right" then
		list_x = self._parent_item:x() + self._parent_item:width() - self._drop_down_list:width() + (layout_settings.drop_down_list.offset_x or 0)
		list_y = self._parent_item:y() - self._drop_down_list:height() + (layout_settings.drop_down_list.offset_y or 0)
		list_z = self.config.z + 1
	else
		list_x = self._parent_item:x() + (layout_settings.drop_down_list.offset_x or 0)
		list_y = self._parent_item:y() - self._drop_down_list:height() + (layout_settings.drop_down_list.offset_y or 0)
		list_z = self.config.z + 1
	end

	self._drop_down_list:update_position(dt, t, layout_settings.drop_down_list, list_x, list_y, list_z)
end

function DropDownListMenuPage:render(dt, t)
	DropDownListMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._drop_down_list:render(dt, t, self._gui, layout_settings.drop_down_list)
end

function DropDownListMenuPage:_update_input(input)
	DropDownListMenuPage.super._update_input(self, input)

	if not input then
		return
	end

	local controller_active = Managers.input:pad_active(1)

	if not controller_active and input:has("wheel") and input:get("wheel").y ~= 0 then
		local y = input:get("wheel").y

		if y == 1 then
			self._drop_down_list:scroll_up()
		elseif y == -1 then
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._drop_down_list:scroll_down(layout_settings.drop_down_list)
		end
	end
end

function DropDownListMenuPage:_auto_highlight_first_item()
	for index, item in ipairs(self._items) do
		if item:highlightable() then
			self:_highlight_item(index)

			break
		end
	end

	self._drop_down_list:set_top_visible_row(1)
end

function DropDownListMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if self._current_highlight == self:_last_highlightable_index() then
			return
		end

		local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

		self._drop_down_list:scroll_down(layout_settings.drop_down_list)
	end

	MenuPage.move_down(self)
end

function DropDownListMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if self._current_highlight == self:_first_highlightable_index() then
			return
		end

		self._drop_down_list:scroll_up()
	end

	MenuPage.move_up(self)
end

function DropDownListMenuPage:cb_scroll_bar_select_down(row)
	self._drop_down_list:set_top_visible_row(row)
end

function DropDownListMenuPage:cb_scroll_bar_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	return not self._drop_down_list:can_scroll(layout_settings.drop_down_list)
end

function DropDownListMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "drop_down_list",
		parent_page = parent_page,
		callback_object = callback_object,
		on_cancel_exit = page_config.on_cancel_exit,
		on_enter_options = page_config.on_enter_options,
		on_enter_options_args = page_config.on_enter_options_args or {},
		on_option_highlighted = page_config.on_option_highlighted,
		on_option_changed = page_config.on_option_changed,
		show_revision = page_config.show_revision,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return DropDownListMenuPage:new(config, item_groups, compiler_data.world)
end
