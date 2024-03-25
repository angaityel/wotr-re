-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_helmet_attachments_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/menu/menu_pages/level_4_menu_page")
require("scripts/menu/menu_containers/outfit_info_menu_container")
require("scripts/menu/menu_items/texture_button_menu_item")

OutfitsEditorHelmetAttachmentsMenuPage = class(OutfitsEditorHelmetAttachmentsMenuPage, Level4MenuPage)

function OutfitsEditorHelmetAttachmentsMenuPage:init(config, item_groups, world)
	OutfitsEditorHelmetAttachmentsMenuPage.super.init(self, config, item_groups, world)

	self._helmet_attachment_ddl_pages = {
		visor = self:_create_helmet_attachment_ddl_page(),
		plume = self:_create_helmet_attachment_ddl_page(),
		feathers = self:_create_helmet_attachment_ddl_page(),
		coif = self:_create_helmet_attachment_ddl_page(),
		bevor = self:_create_helmet_attachment_ddl_page(),
		pattern = self:_create_helmet_attachment_ddl_page()
	}
	self._current_profile = nil
	self._ddl_selected_options = {}
end

function OutfitsEditorHelmetAttachmentsMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitsEditorHelmetAttachmentsMenuPage:_create_helmet_attachment_ddl_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		on_option_highlighted = "cb_helmet_attachment_highlighted",
		on_exit_page = "cb_reset_selection",
		on_enter_options = "cb_helmet_attachment_options",
		on_option_changed = "cb_helmet_attachment_option_changed",
		backup_event = "event_save_outfit_editor_helmet_attachments",
		z = self.config.z + 50,
		layout_settings = MainMenuSettings.pages.outfit_ddl_left_aligned,
		sounds = self.config.sounds
	}
	local item_groups = {
		item_list = {},
		scroll_bar = {},
		back_list = {}
	}
	local attachment_ddl_page = OutfitDropDownListMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self)
	local scroll_bar_config = {
		on_select_down = "cb_scroll_bar_select_down",
		disabled_func = "cb_scroll_bar_disabled",
		callback_object = "page",
		parent_page = attachment_ddl_page,
		layout_settings = MainMenuSettings.items.drop_down_list_scroll_bar,
		sounds = self.config.sounds.items.drop_down_list
	}
	local scroll_bar_item = ScrollBarMenuItem.create_from_config({
		world = self._world
	}, scroll_bar_config, attachment_ddl_page)

	attachment_ddl_page:add_item(scroll_bar_item, "scroll_bar")

	return attachment_ddl_page
end

function OutfitsEditorHelmetAttachmentsMenuPage:set_helmet(helmet_name)
	self._max_num_selected_items = nil
	self._ddl_selected_options = {}
	self._helmet_name = helmet_name

	self:_add_helmet_attachment_items(helmet_name)
end

function OutfitsEditorHelmetAttachmentsMenuPage:_add_helmet_attachment_items(helmet_name)
	self:remove_items("item_list_header")
	self:remove_items("item_list")

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		disabled = true,
		text = Helmets[helmet_name].ui_header,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")
	self:add_item(self:_create_helmet_attachment_ddl_item("visor", helmet_name, layout_settings), "item_list")
	self:add_item(self:_create_helmet_attachment_ddl_item("plume", helmet_name, layout_settings), "item_list")
	self:add_item(self:_create_helmet_attachment_ddl_item("feathers", helmet_name, layout_settings), "item_list")
	self:add_item(self:_create_helmet_attachment_ddl_item("coif", helmet_name, layout_settings), "item_list")
	self:add_item(self:_create_helmet_attachment_ddl_item("bevor", helmet_name, layout_settings), "item_list")
	self:add_item(self:_create_helmet_attachment_ddl_item("pattern", helmet_name, layout_settings), "item_list")

	if Helmets[helmet_name].has_crest then
		local item_config = {
			text = "menu_helmet_attachment_crest",
			tooltip_text_2 = "menu_helmet_attachment_fluff_text_crest",
			tooltip_text = "menu_helmet_attachment_description_crest",
			on_select = "cb_show_crest_selected",
			on_select_args = {
				"show_crest"
			},
			z = self.config.z + 1,
			layout_settings = layout_settings.checkbox,
			parent_page = self,
			sounds = self.config.sounds.items.checkbox
		}
		local crest_item = CheckboxMenuItem.create_from_config({
			world = self._world
		}, item_config, self)

		crest_item:set_selected(self._current_profile.helmet.show_crest)
		self:add_item(crest_item, "item_list")
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

function OutfitsEditorHelmetAttachmentsMenuPage:_create_helmet_attachment_ddl_item(attachment_type, helmet_name, layout_settings)
	local has_attachments = false

	for attachment_name, attachment_config in pairs(Helmets[helmet_name].attachments) do
		if attachment_type == attachment_config.type then
			local unlock_type = "helmet_attachment"
			local unlock_key = helmet_name .. "|" .. attachment_config.unlock_key
			local entity_type = "helmet_attachment"
			local entity_name = helmet_name .. "|" .. attachment_config.unlock_key
			local available, unavalible_reason = ProfileHelper:is_entity_avalible(unlock_type, unlock_key, entity_type, entity_name, attachment_config.release_name)

			if available or not OutfitHelper.gear_hidden(attachment_config) then
				has_attachments = true

				break
			end
		end
	end

	if has_attachments then
		local page = self._helmet_attachment_ddl_pages[attachment_type]

		page.config.on_enter_options_args = {
			helmet_name,
			attachment_type
		}

		local item_config = {
			on_enter_text = "cb_helmet_attachment_ddl_text",
			callback_object = "page",
			page = page,
			on_enter_text_args = {
				attachment_type
			},
			tooltip_text = "menu_helmet_attachment_description_" .. attachment_type,
			tooltip_text_2 = "menu_helmet_attachment_fluff_text_" .. attachment_type,
			z = self.config.z + 1,
			layout_settings = layout_settings.drop_down_list,
			parent_page = self,
			sounds = self.config.sounds.items.drop_down_list
		}

		return DropDownListMenuItem.create_from_config({
			world = self._world
		}, item_config, self)
	end
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_helmet_attachment_ddl_text(attachment_type)
	local description_text = L("menu_helmet_attachment_" .. attachment_type) .. ": "
	local helmet = self._current_profile.helmet
	local attachment_name = self._ddl_selected_options[attachment_type] or helmet.attachments[attachment_type]
	local value_text

	if not attachment_name or attachment_name == "none" then
		value_text = L("menu_helmet_attachment_none")
	else
		value_text = L(Helmets[helmet.name].attachments[attachment_name].ui_header)
	end

	return description_text, value_text
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_helmet_attachment_highlighted(item)
	if not item or not item.config.tooltip_text then
		self._tooltip_text_box:clear_text()
	else
		local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

		self._tooltip_text_box:set_text(L(item.config.tooltip_text), layout_settings.tooltip_text_box, self._gui)
	end

	if not item or not item.config.tooltip_text_2 then
		self._tooltip_text_box_2:clear_text()
	else
		local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

		self._tooltip_text_box_2:set_text(L(item.config.tooltip_text_2), layout_settings.tooltip_text_box_2)
	end

	if item and item.config.entity_type == "helmet_attachment" then
		local select_args = item.config.on_select_args[1]
		local attachment_type = select_args.attachment_type
		local key = select_args.key
		local cloned = table.clone(self._ddl_selected_options)

		cloned[attachment_type] = key

		Managers.state.event:trigger("event_outfit_editor_helmet_attachments_selected", self._helmet_name, cloned, self:_show_crest_selected())
	end
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_helmet_attachment_options(helmet_name, attachment_type)
	local sorted_table = {}
	local helmet_data = Helmets[helmet_name]

	for attachment_name, attachment_config in pairs(helmet_data.attachments) do
		if attachment_type == attachment_config.type then
			sorted_table[#sorted_table + 1] = attachment_config
			sorted_table[#sorted_table].attachment_name = attachment_name
		end
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local current_attachment = self._ddl_selected_options[attachment_type] or self._current_profile.helmet.attachments[attachment_type]
	local options = {}
	local selected_index = 1

	for attachment_name, attachment_config in ipairs(sorted_table) do
		if attachment_type == attachment_config.type then
			local tooltip_text, tooltip_text_2

			if attachment_config.ui_description then
				tooltip_text = attachment_config.ui_description
			end

			if attachment_config.ui_fluff_text then
				tooltip_text_2 = attachment_config.ui_fluff_text
			end

			local unlock_type = "helmet_attachment"
			local unlock_key = helmet_name .. "|" .. attachment_config.unlock_key
			local entity_type = "helmet_attachment"
			local entity_name = helmet_name .. "|" .. attachment_config.unlock_key
			local market_item_name = entity_type .. "|" .. entity_name
			local ui_name = L(attachment_config.ui_header)
			local market_message_args = {
				ui_name,
				L(Helmets[helmet_name].ui_header)
			}
			local available, unavalible_reason = ProfileHelper:is_entity_avalible(unlock_type, unlock_key, entity_type, entity_name, attachment_config.release_name)

			if available or not OutfitHelper.gear_hidden(attachment_config) then
				options[#options + 1] = {
					key = attachment_config.attachment_name,
					value = L(attachment_config.ui_header),
					tooltip_text = tooltip_text,
					tooltip_text_2 = tooltip_text_2,
					helmet_name = helmet_name,
					attachment_type = attachment_type,
					unlock_type = unlock_type,
					unlock_key = unlock_key,
					entity_type = entity_type,
					entity_name = entity_name,
					market_item_name = market_item_name,
					market_message_args = market_message_args,
					release_name = attachment_config.release_name,
					ui_name = ui_name
				}

				if current_attachment and current_attachment == attachment_config.attachment_name then
					selected_index = #options
				end
			end
		end
	end

	if (helmet_data.no_coif_allowed or attachment_type ~= "coif") and attachment_type ~= "pattern" then
		options[#options + 1] = {
			key = "none",
			entity_type = "helmet_attachment",
			disabled = false,
			value = L("menu_helmet_attachment_none"),
			helmet_name = helmet_name,
			attachment_type = attachment_type
		}
	end

	return options, selected_index
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_helmet_attachment_option_changed(option)
	self._ddl_selected_options[option.attachment_type] = option.key
	self._attachment_changed = true

	Managers.state.event:trigger("event_outfit_editor_helmet_attachments_selected", self._helmet_name, self._ddl_selected_options, self:_show_crest_selected())
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_reset_selection()
	if not self._attachment_changed then
		Managers.state.event:trigger("event_reset_outfit_editor_helmet_attachments", self._helmet_name)
	end

	self._attachment_changed = nil
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_show_crest_selected()
	Managers.state.event:trigger("event_outfit_editor_helmet_attachments_selected", self._helmet_name, self._ddl_selected_options, self:_show_crest_selected())
end

function OutfitsEditorHelmetAttachmentsMenuPage:cb_selection_done()
	Managers.state.event:trigger("event_outfit_editor_helmet_attachments_selected", self._helmet_name, self._ddl_selected_options, self:_show_crest_selected())
	Managers.state.event:trigger("event_outfit_editor_save_profile")
	self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
end

function OutfitsEditorHelmetAttachmentsMenuPage:_show_crest_selected()
	local items = self:items_in_group("item_list")
	local show_crest

	for _, item in ipairs(items) do
		if item.config.type == "checkbox" and item.config.on_select_args[1] == "show_crest" then
			show_crest = item:selected()
		end
	end

	return show_crest
end

function OutfitsEditorHelmetAttachmentsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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

	return OutfitsEditorHelmetAttachmentsMenuPage:new(config, item_groups, compiler_data.world)
end
