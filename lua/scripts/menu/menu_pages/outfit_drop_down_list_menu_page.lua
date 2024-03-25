-- chunkname: @scripts/menu/menu_pages/outfit_drop_down_list_menu_page.lua

require("scripts/menu/menu_containers/drop_down_list_menu_container")

OutfitDropDownListMenuPage = class(OutfitDropDownListMenuPage, DropDownListMenuPage)

function OutfitDropDownListMenuPage:init(config, item_groups, world)
	OutfitDropDownListMenuPage.super.init(self, config, item_groups, world)
end

function OutfitDropDownListMenuPage:_select_item(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if highlighted_item then
		highlighted_item:on_select()

		if highlighted_item.config.type == "outfit_text" or highlighted_item.config.type == "outfit_checkbox" then
			self._menu_logic:change_page(highlighted_item.config.page)
		elseif highlighted_item.config.type == "text" then
			self._menu_logic:change_page(highlighted_item.config.page)
		end
	end
end

function OutfitDropDownListMenuPage:on_enter()
	self:remove_items("items")

	if self.config.backup_event then
		Managers.state.event:trigger(self.config.backup_event)
	end

	local options, selection = self:_try_callback(self.config.callback_object, self.config.on_enter_options, unpack(self.config.on_enter_options_args or {}))
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	for _, option in pairs(options) do
		local item

		if option.key == "none" then
			local entity_type = option.entity_type
			local item_config = {
				no_localization = true,
				page = self.config.parent_page,
				on_select = self.config.on_option_changed,
				on_select_args = {
					option
				},
				text = option.value,
				entity_type = entity_type,
				tooltip_text = option.tooltip_text,
				tooltip_text_2 = option.tooltip_text_2,
				layout_settings = layout_settings.drop_down_list.item_config,
				parent_page = self,
				sounds = self.config.sounds.items.text,
				default_page = self.config.parent_page
			}

			item = OutfitTextMenuItem.create_from_config({
				world = self._world
			}, item_config, self.config.callback_object)
		else
			local unlock_type = option.unlock_type
			local unlock_key = option.unlock_key
			local entity_type = option.entity_type
			local entity_name = option.entity_name
			local market_item_name = option.market_item_name
			local ui_name = option.ui_name
			local market_message_args = option.market_message_args
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
				sounds = self.config.sounds.items.text,
				default_page = self.config.parent_page,
				unlock_type = unlock_type,
				unlock_key = unlock_key,
				entity_type = entity_type,
				entity_name = entity_name,
				market_item_name = market_item_name,
				market_message_args = market_message_args,
				ui_name = ui_name,
				release_name = option.release_name
			}

			item = OutfitTextMenuItem.create_from_config({
				world = self._world
			}, item_config, self.config.callback_object)
		end

		self:add_item(item, "items")
	end

	local controller_active = Managers.input:pad_active(1)

	if controller_active and not self.config.do_not_select_first_index then
		self:_auto_highlight_first_item()
	end
end

function OutfitDropDownListMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "drop_down_list",
		backup_event = page_config.backup_event,
		parent_page = parent_page,
		callback_object = callback_object,
		on_exit_page = page_config.on_exit_page,
		on_enter_options = page_config.on_enter_options,
		on_enter_options_args = page_config.on_enter_options_args or {},
		on_option_highlighted = page_config.on_option_highlighted,
		on_option_changed = page_config.on_option_changed,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return OutfitDropDownListMenuPage:new(config, item_groups, compiler_data.world)
end
