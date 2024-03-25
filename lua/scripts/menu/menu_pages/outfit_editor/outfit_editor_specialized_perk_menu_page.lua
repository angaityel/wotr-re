-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_specialized_perk_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_items/outfit_checkbox_menu_item")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/menu/menu_pages/level_4_menu_page")
require("scripts/menu/menu_containers/outfit_info_menu_container")
require("scripts/menu/menu_items/texture_button_menu_item")

OutfitsEditorSpecializedPerkMenuPage = class(OutfitsEditorSpecializedPerkMenuPage, Level4MenuPage)

function OutfitsEditorSpecializedPerkMenuPage:init(config, item_groups, world)
	OutfitsEditorSpecializedPerkMenuPage.super.init(self, config, item_groups, world)

	self._perk_info = PerkSimpleMenuContainer.create_from_config()

	self._perk_info:set_active(false)

	self._current_profile = nil
end

function OutfitsEditorSpecializedPerkMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	OutfitsEditorSpecializedPerkMenuPage.super._highlight_item(self, index, ignore_sound)

	if self:_highlighted_item() ~= highlighted_item then
		local perk_name

		if self:_highlighted_item() and self:_highlighted_item().config.type == "outfit_checkbox" and not self:_highlighted_item():selected() then
			perk_name = self:_highlighted_item().config.on_select_args[1]
		end

		local num_selected = #self:_selected_perk_items()

		if num_selected == 0 then
			self._perk_info:set_specialized_perk_1(perk_name)
			self._perk_info:set_specialized_perk_2(nil)
		elseif num_selected == 1 then
			self._perk_info:set_specialized_perk_2(perk_name)
		end
	end
end

function OutfitsEditorSpecializedPerkMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitsEditorSpecializedPerkMenuPage:set_basic_perk(basic_perk, perk_type)
	self._max_num_selected_items = 2
	self._basic_perk = basic_perk
	self._perk_type = perk_type

	self:_add_specialized_perk_items(basic_perk)
	self._perk_info:clear()
	self._perk_info:set_basic_perk(basic_perk)
	self._perk_info:set_active(true)

	local selected_items = self:_selected_perk_items()

	if #selected_items == 1 then
		self._perk_info:set_specialized_perk_1(selected_items[1].config.on_select_args[1])
		self._perk_info:set_specialized_perk_2(nil)
	elseif #selected_items == 2 then
		self._perk_info:set_specialized_perk_1(selected_items[1].config.on_select_args[1])
		self._perk_info:set_specialized_perk_2(selected_items[2].config.on_select_args[1])
	end

	self:_enable_disable_items()
end

function OutfitsEditorSpecializedPerkMenuPage:_add_specialized_perk_items(basic_perk)
	self:remove_items("item_list_header")
	self:remove_items("item_list")

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		disabled = true,
		text = Perks[basic_perk].ui_header,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")

	local options = OutfitHelper.outfit_editor_specialized_perk_options(basic_perk, self._current_profile)

	for i, option in ipairs(options) do
		local unlock_type = "perk"
		local unlock_key = option.key
		local entity_type = "perk"
		local entity_name = option.key
		local market_item_name = entity_type .. "|" .. entity_name
		local ui_name = L(Perks[option.key].ui_header)
		local market_message_args = {
			ui_name
		}
		local item_config = {
			on_select = "cb_specialized_perk_selected",
			name = option.key,
			on_select_args = {
				option.key
			},
			text = option.text,
			tooltip_text = option.description,
			tooltip_text_2 = option.fluff_text,
			z = self.config.z + 1,
			layout_settings = layout_settings.checkbox,
			parent_page = self,
			sounds = self.config.sounds.items.checkbox,
			unlock_type = unlock_type,
			unlock_key = unlock_key,
			entity_type = entity_type,
			entity_name = entity_name,
			market_item_name = market_item_name,
			market_message_args = market_message_args,
			ui_name = ui_name
		}
		local item = OutfitCheckboxMenuItem.create_from_config({
			world = self._world
		}, item_config, self)

		item:set_selected(option.selected)
		self:add_item(item, "item_list")
	end

	local done_button_item_config = {
		text = "menu_done",
		on_select = "cb_selection_done",
		callback_object = "page",
		z = self.config.z + 1,
		layout_settings = layout_settings.texture_button,
		parent_page = self,
		sounds = self.config.sounds.items.texture_button
	}
	local done_button_item = TextureButtonMenuItem.create_from_config({
		world = self._world
	}, done_button_item_config, self)

	self:add_item(done_button_item, "item_list")

	local delimiter_item_config = {
		disabled = true,
		parent_page = self,
		layout_settings = layout_settings.delimiter_texture
	}
	local delimiter_item = TextureMenuItem.create_from_config({
		world = self._world
	}, delimiter_item_config, self)

	self:add_item(delimiter_item, "item_list")

	local back_item_config = {
		text = "main_menu_cancel",
		on_select = "cb_cancel",
		callback_object = "page",
		parent_page = self,
		layout_settings = layout_settings.text_back,
		sounds = self.config.sounds.items.text
	}
	local back_item = TextMenuItem.create_from_config({
		world = self._world
	}, back_item_config, self)

	self:add_item(back_item, "item_list")
end

function OutfitsEditorSpecializedPerkMenuPage:cb_selection_done()
	local items = self:items_in_group("item_list")
	local selected_item_args = {}

	for _, item in ipairs(items) do
		if item.config.type == "outfit_checkbox" and item:selected() then
			selected_item_args[#selected_item_args + 1] = item.config.on_select_args[1]
		end
	end

	Managers.state.event:trigger("basic_perk_selected", self._basic_perk, self._perk_type)
	Managers.state.event:trigger("event_outfit_editor_specialized_perks_selected", self._perk_type, selected_item_args)
	Managers.state.event:trigger("event_outfit_editor_save_profile")
	self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_category")
end

function OutfitsEditorSpecializedPerkMenuPage:_update_container_size(dt, t)
	OutfitsEditorSpecializedPerkMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._perk_info:update_size(dt, t, self._gui, layout_settings.perks)

	local max_height = self._item_list:height() + self._item_list_header:height()

	if self._perk_info:active() and max_height < self._perk_info:height() then
		max_height = self._perk_info:height()
	end

	if max_height < self._tooltip_text_box:height() + self._tooltip_text_box_2:height() then
		max_height = self._tooltip_text_box:height() + self._tooltip_text_box_2:height()
	end

	layout_settings.background_texture.stretch_height = max_height

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
end

function OutfitsEditorSpecializedPerkMenuPage:_update_container_position(dt, t)
	OutfitsEditorSpecializedPerkMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x = MenuHelper:container_position(self._perk_info, layout_settings.perks)
	local y = self._background_texture:y() + self._background_texture:height() - self._perk_info:height()

	self._perk_info:update_position(dt, t, layout_settings.perks, x, y, self.config.z + 20)
end

function OutfitsEditorSpecializedPerkMenuPage:render(dt, t)
	OutfitsEditorSpecializedPerkMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._perk_info:render(dt, t, self._gui, layout_settings.perks)
end

function OutfitsEditorSpecializedPerkMenuPage:cb_specialized_perk_selected(perk_name)
	local num_selected = #self:_selected_perk_items()
	local item = self:find_item_by_name(perk_name)
	local selected = item:selected()

	if num_selected == 0 then
		self._perk_info:set_specialized_perk_1(nil)
		self._perk_info:set_specialized_perk_2(nil)
	elseif num_selected == 1 then
		if not selected then
			local selected_item = self:_selected_perk_items()[1]

			self._perk_info:set_specialized_perk_1(selected_item.config.on_select_args[1])
		else
			self._perk_info:set_specialized_perk_1(perk_name)
		end

		self._perk_info:set_specialized_perk_2(nil)
	elseif num_selected == 2 then
		self._perk_info:set_specialized_perk_2(perk_name)
	end

	self:_enable_disable_items()
end

function OutfitsEditorSpecializedPerkMenuPage:_enable_disable_items()
	local items = self:items_in_group("item_list")
	local num_selected_items = #self:_selected_perk_items()

	for _, item in ipairs(items) do
		if item.config.type == "outfit_checkbox" then
			if num_selected_items == self._max_num_selected_items and not item:selected() then
				item.config.disabled = true
			else
				item.config.disabled = false
			end
		end
	end
end

function OutfitsEditorSpecializedPerkMenuPage:_selected_perk_items()
	local items = self:items_in_group("item_list")
	local selected_items = {}

	for _, item in ipairs(items) do
		if item.config.type == "outfit_checkbox" and item:selected() then
			selected_items[#selected_items + 1] = item
		end
	end

	return selected_items
end

function OutfitsEditorSpecializedPerkMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "outfit_editor",
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return OutfitsEditorSpecializedPerkMenuPage:new(config, item_groups, compiler_data.world)
end
