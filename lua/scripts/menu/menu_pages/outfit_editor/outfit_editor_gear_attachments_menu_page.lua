-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_gear_attachments_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/menu/menu_pages/level_4_menu_page")
require("scripts/menu/menu_containers/attachment_info_menu_container")
require("scripts/menu/menu_items/texture_button_menu_item")

OutfitsEditorGearAttachmentsMenuPage = class(OutfitsEditorGearAttachmentsMenuPage, Level4MenuPage)

function OutfitsEditorGearAttachmentsMenuPage:init(config, item_groups, world)
	OutfitsEditorGearAttachmentsMenuPage.super.init(self, config, item_groups, world)

	self._gear_name = nil
	self._current_profile = nil
	self._child_page = nil
	self._attachment_info = AttachmentInfoMenuContainer.create_from_config()
end

function OutfitsEditorGearAttachmentsMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	OutfitsEditorGearAttachmentsMenuPage.super._highlight_item(self, index, ignore_sound)

	if not self:_highlighted_item() and highlighted_item then
		self._attachment_info:clear()
	end
end

function OutfitsEditorGearAttachmentsMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitsEditorGearAttachmentsMenuPage:set_gear(gear_name, attachments_table)
	local attachment_config = table.remove(attachments_table, 1)

	if #attachments_table > 0 then
		self._child_page = self:_create_gear_attachment_page()

		self._child_page:set_profile(self._current_profile)
		self._child_page:set_gear(gear_name, attachments_table)
	end

	self._gear_name = gear_name

	self:_add_gear_attachment_items(gear_name, attachment_config)
end

function OutfitsEditorGearAttachmentsMenuPage:destroy()
	OutfitsEditorGearAttachmentsMenuPage.super.destroy(self)

	if self._child_page then
		self._child_page:destroy()

		self._child_page = nil
	end
end

function OutfitsEditorGearAttachmentsMenuPage:_create_gear_attachment_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		z = self.config.z + 50,
		layout_settings = MainMenuSettings.pages.level_4_character_profiles,
		sounds = self.config.sounds
	}
	local item_groups = {
		item_list_header = {},
		item_list_scroll = {},
		item_list = {},
		back_list = {}
	}

	return OutfitsEditorGearAttachmentsMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitsEditorGearAttachmentsMenuPage:_add_gear_attachment_items(gear_name, attachment_config)
	self:remove_items("item_list_header")
	self:remove_items("item_list")
	self._attachment_info:clear()

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		disabled = true,
		text = attachment_config.ui_header,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")

	for i, attachment_item in ipairs(attachment_config.items) do
		local unlock_type = "gear_attachment"
		local unlock_key = gear_name .. "|" .. attachment_item.unlock_key
		local entity_type = "gear_attachment"
		local entity_name = gear_name .. "|" .. attachment_item.unlock_key
		local market_item_name = "gear_attachment|" .. gear_name .. "|" .. attachment_item.unlock_key
		local ui_name = L(attachment_item.ui_header)
		local market_message_args = {
			ui_name,
			L(Gear[gear_name].ui_header)
		}
		local item
		local available, unavalible_reason = ProfileHelper:is_entity_avalible(unlock_type, unlock_key, entity_type, entity_name, attachment_item.release_name)

		if available or not OutfitHelper.gear_hidden(attachment_item) then
			if attachment_config.menu_page_type == "checkbox" then
				local item_config = {
					on_highlight = "cb_attachment_highlighted",
					on_select_args = {
						attachment_item.name
					},
					on_highlight_args = {
						gear_name,
						attachment_config.category,
						attachment_item.name
					},
					text = attachment_item.ui_header,
					tooltip_text = attachment_item.ui_description,
					tooltip_text_2 = attachment_item.ui_fluff_text,
					z = self.config.z + 1,
					layout_settings = layout_settings.checkbox,
					parent_page = self,
					sounds = self.config.sounds.items.checkbox,
					unlock_type = unlock_type,
					unlock_key = unlock_key,
					entity_type = entity_type,
					entity_name = entity_name,
					release_name = attachment_item.release_name,
					market_item_name = market_item_name,
					market_message_args = market_message_args,
					ui_name = ui_name
				}

				item = OutfitCheckboxMenuItem.create_from_config({
					world = self._world
				}, item_config, self)
			elseif attachment_config.menu_page_type == "text" then
				local item_config = {
					on_highlight = "cb_attachment_highlighted",
					on_select = "cb_text_selected",
					on_select_args = {
						attachment_config.category,
						attachment_item.name
					},
					on_highlight_args = {
						gear_name,
						attachment_config.category,
						attachment_item.name
					},
					text = attachment_item.ui_header,
					tooltip_text = attachment_item.ui_description,
					tooltip_text_2 = attachment_item.ui_fluff_text,
					z = self.config.z + 1,
					layout_settings = layout_settings.text,
					parent_page = self,
					sounds = self.config.sounds.items.text,
					default_page = self._child_page,
					unlock_type = unlock_type,
					unlock_key = unlock_key,
					entity_type = entity_type,
					entity_name = entity_name,
					release_name = attachment_item.release_name,
					market_item_name = market_item_name,
					market_message_args = market_message_args,
					ui_name = ui_name
				}

				item = OutfitTextMenuItem.create_from_config({
					world = self._world
				}, item_config, self)
			end

			self:add_item(item, "item_list")
		end
	end

	if attachment_config.menu_page_type == "checkbox" then
		local done_button_item_config = {
			text = "menu_done",
			on_select = "cb_checkbox_done_selected",
			callback_object = "page",
			on_select_args = {
				attachment_config.category
			},
			z = self.config.z + 1,
			layout_settings = layout_settings.texture_button,
			parent_page = self,
			sounds = self.config.sounds.items.texture_button
		}
		local done_button_item = TextureButtonMenuItem.create_from_config({
			world = self._world
		}, done_button_item_config, self)

		self:add_item(done_button_item, "item_list")

		if self._child_page then
			done_button_item:set_page(self._child_page)
			self._child_page:set_parent_item(done_button_item)
		end
	end

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

function OutfitsEditorGearAttachmentsMenuPage:_update_container_size(dt, t)
	OutfitsEditorGearAttachmentsMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._attachment_info:update_size(dt, t, self._gui, layout_settings.attachment_info)

	local max_height = self._item_list:height() + self._item_list_header:height()

	if max_height < self._attachment_info:height() then
		max_height = self._attachment_info:height()
	end

	if max_height < self._tooltip_text_box:height() + self._tooltip_text_box_2:height() then
		max_height = self._tooltip_text_box:height() + self._tooltip_text_box_2:height()
	end

	layout_settings.background_texture.stretch_height = max_height

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
end

function OutfitsEditorGearAttachmentsMenuPage:_update_container_position(dt, t)
	OutfitsEditorGearAttachmentsMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x = MenuHelper:container_position(self._attachment_info, layout_settings.attachment_info)
	local y = self._background_texture:y() + self._background_texture:height() - self._attachment_info:height()

	self._attachment_info:update_position(dt, t, layout_settings.attachment_info, x, y, self.config.z + 20)
end

function OutfitsEditorGearAttachmentsMenuPage:render(dt, t)
	OutfitsEditorGearAttachmentsMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._attachment_info:render(dt, t, self._gui, layout_settings.attachment_info)
end

function OutfitsEditorGearAttachmentsMenuPage:cb_attachment_highlighted(gear_name, attachment_category, attachment_name)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._attachment_info:load_gear_attachment(gear_name, attachment_category, attachment_name)
end

function OutfitsEditorGearAttachmentsMenuPage:cb_text_selected(category, attachment_name)
	Managers.state.event:trigger("event_outfit_editor_gear_attachments_selected", self._gear_name, category, {
		attachment_name
	})

	if not self._child_page then
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	end
end

function OutfitsEditorGearAttachmentsMenuPage:cb_checkbox_done_selected(category)
	local items = self:items_in_group("item_list")
	local attachment_names = {}

	for _, item in ipairs(items) do
		if item.config.type == "outfit_checkbox" and item:selected() then
			attachment_names[#attachment_names + 1] = item.config.on_select_args[1]
		end
	end

	Managers.state.event:trigger("event_outfit_editor_gear_attachments_selected", self._gear_name, category, attachment_names)

	if not self._child_page then
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	end
end

function OutfitsEditorGearAttachmentsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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

	return OutfitsEditorGearAttachmentsMenuPage:new(config, item_groups, compiler_data.world)
end
