-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_item_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_items/outfit_text_menu_item")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/menu/menu_pages/level_4_menu_page")
require("scripts/menu/menu_containers/outfit_info_menu_container")
require("scripts/menu/menu_containers/perk_simple_menu_container")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_helmet_attachments_menu_page")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_specialized_perk_menu_page")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_gear_attachments_menu_page")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_armour_attachments_menu_page")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_head_menu_page")

OutfitsEditorItemMenuPage = class(OutfitsEditorItemMenuPage, Level4MenuPage)

function OutfitsEditorItemMenuPage:init(config, item_groups, world)
	OutfitsEditorItemMenuPage.super.init(self, config, item_groups, world)

	self._armour_attachments_page = self:_create_armour_attachments_page()
	self._helmet_attachments_page = self:_create_helmet_attachments_page()
	self._specialized_perk_page = self:_create_specialized_perk_page()
	self._current_profile = nil
	self._outfit_info = OutfitInfoMenuContainer.create_from_config()

	self._outfit_info:set_active(false)

	self._perk_info = PerkSimpleMenuContainer.create_from_config()

	self._perk_info:set_active(false)
	Managers.state.event:register(self, "basic_perk_selected", "cb_basic_perk_selected2")
end

function OutfitsEditorItemMenuPage:on_enter()
	OutfitsEditorItemMenuPage.super.on_enter(self)

	if self._slot_name == "perks" then
		self._outfit_info:set_active(false)
		self._perk_info:set_active(true)

		local perk_spec_1, perk_spec_2 = self:_find_specialization_perks()

		self._perk_info:set_specialized_perk_1(perk_spec_1)
		self._perk_info:set_specialized_perk_2(perk_spec_2)
	else
		self._outfit_info:set_active(true)
		self._perk_info:set_active(false)
	end
end

function OutfitsEditorItemMenuPage:_find_specialization_perks()
	local perks = self._current_profile.perks or {}
	local perk_spec_1, perk_spec_2

	for perk_type, perk_name in pairs(perks) do
		if string.find(perk_type, "_1") then
			perk_spec_1 = perk_name
		elseif string.find(perk_type, "_2") then
			perk_spec_2 = perk_name
		end
	end

	return perk_spec_1, perk_spec_2
end

function OutfitsEditorItemMenuPage:on_exit()
	OutfitsEditorItemMenuPage.super.on_exit(self)
	self._outfit_info:set_active(false)
	self._perk_info:set_active(false)
end

function OutfitsEditorItemMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	OutfitsEditorItemMenuPage.super._highlight_item(self, index, ignore_sound)

	if not self:_highlighted_item() and highlighted_item then
		self._outfit_info:set_disabled(true)
		self._perk_info:set_basic_perk(nil)
	end
end

function OutfitsEditorItemMenuPage:set_outfit_category(slot_name, ui_header, category)
	self._slot_name = slot_name

	self:_add_outfit_items(slot_name, ui_header, category)
	self:_set_camera(slot_name)
end

function OutfitsEditorItemMenuPage:_set_camera(slot_name)
	if slot_name == "armour" then
		self.config.camera = "character_editor"
	elseif slot_name == "helmet" then
		self.config.camera = "character_editor_helmet"
	elseif slot_name == "mount" then
		self.config.camera = "character_editor"
	elseif slot_name == "perks" then
		self.config.camera = "character_editor"
	elseif slot_name == "two_handed_weapon" or slot_name == "one_handed_weapon" or slot_name == "dagger" or slot_name == "shield" then
		self.config.camera = "character_editor"
	end
end

function OutfitsEditorItemMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitsEditorItemMenuPage:_add_outfit_items(slot_name, ui_header, category)
	self:remove_items("item_list_header")
	self:remove_items("item_list")
	self._perk_info:set_basic_perk(nil)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		disabled = true,
		text = ui_header,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")

	local options, on_highlight, on_select, page, entity_type

	if slot_name == "armour" then
		options = OutfitHelper.outfit_editor_armour_options(category)
		on_highlight = "cb_armour_highlighted"
		on_select = "cb_armour_selected"

		self._outfit_info:set_active(true)
		self._outfit_info:load_armour(nil)

		entity_type = "armour"
	elseif slot_name == "helmet" then
		options = OutfitHelper.outfit_editor_helmet_options(category)
		on_highlight = "cb_helmet_highlighted"
		on_select = "cb_helmet_selected"

		self._outfit_info:set_active(true)
		self._outfit_info:load_helmet(nil)

		entity_type = "helmet"
	elseif slot_name == "mount" then
		options = OutfitHelper.outfit_editor_mount_options(category)
		on_highlight = "cb_mount_highlighted"
		on_select = "cb_mount_selected"

		self._outfit_info:set_active(true)
		self._outfit_info:load_mount(nil)

		entity_type = "mount"
	elseif slot_name == "two_handed_weapon" or slot_name == "one_handed_weapon" or slot_name == "dagger" or slot_name == "shield" then
		options = OutfitHelper.outfit_editor_gear_options(category)
		on_highlight = "cb_gear_highlighted"
		on_select = "cb_gear_selected"

		self._outfit_info:set_active(true)
		self._outfit_info:load_gear(slot_name, nil)

		entity_type = "gear"
	elseif slot_name == "perks" then
		options = OutfitHelper.outfit_editor_basic_perk_options(category, self._current_profile)
		on_highlight = "cb_basic_perk_highlighted"
		on_select = "cb_basic_perk_selected"
		page = self._specialized_perk_page
		entity_type = "perk"
	else
		assert(false, "[OutfitsEditorItemMenuPage] Unknown slot: " .. tostring(slot_name))
	end

	for i, option in ipairs(options) do
		local unlock_type = entity_type
		local unlock_key = option.key
		local entity_type = entity_type
		local entity_name = option.key
		local market_item_name = entity_type .. "|" .. entity_name
		local ui_name = L(option.text)
		local market_message_args = {
			ui_name
		}
		local item_config = {
			on_highlight = on_highlight,
			on_highlight_args = {
				option.key,
				option.slot_name,
				category
			},
			on_select = on_select,
			on_select_args = {
				option.key,
				option.slot_name
			},
			text = option.text,
			tooltip_text = option.description,
			tooltip_text_2 = option.fluff_text,
			z = self.config.z + 1,
			layout_settings = layout_settings.text,
			parent_page = self,
			sounds = self.config.sounds.items.text,
			default_page = page,
			unlock_type = unlock_type,
			unlock_key = unlock_key,
			entity_type = entity_type,
			entity_name = entity_name,
			release_name = option.release_name,
			market_item_name = market_item_name,
			market_message_args = market_message_args,
			ui_name = ui_name
		}
		local item = OutfitTextMenuItem.create_from_config({
			world = self._world
		}, item_config, self)

		self:add_item(item, "item_list")
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

function OutfitsEditorItemMenuPage:_create_armour_attachments_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		camera = "character_editor",
		z = self.config.z + 50,
		layout_settings = MainMenuSettings.pages.level_4_armour_attachments,
		sounds = self.config.sounds
	}
	local item_groups = {
		item_list_header = {},
		item_list_scroll = {},
		item_list = {},
		back_list = {}
	}

	return OutfitsEditorArmourAttachmentsMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitsEditorItemMenuPage:_create_helmet_attachments_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		camera = "character_editor_helmet",
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

	return OutfitsEditorHelmetAttachmentsMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitsEditorItemMenuPage:_create_specialized_perk_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		camera = "character_editor",
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

	return OutfitsEditorSpecializedPerkMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitsEditorItemMenuPage:_create_gear_attachment_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		camera = "character_editor",
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

function OutfitsEditorItemMenuPage:cb_armour_highlighted(armour_name)
	self._outfit_info:load_armour(armour_name)
end

function OutfitsEditorItemMenuPage:cb_helmet_highlighted(helmet_name)
	self._outfit_info:load_helmet(helmet_name)
end

function OutfitsEditorItemMenuPage:cb_mount_highlighted(mount_name)
	self._outfit_info:load_mount(mount_name)
end

function OutfitsEditorItemMenuPage:cb_basic_perk_highlighted(perk_name)
	self._perk_info:set_basic_perk(perk_name)
end

function OutfitsEditorItemMenuPage:cb_gear_highlighted(gear_name, slot_name)
	self._outfit_info:load_gear(slot_name, gear_name)
end

function OutfitsEditorItemMenuPage:cb_armour_selected(armour_name)
	Managers.state.event:trigger("event_outfit_editor_armour_selected", armour_name)

	local armour = Armours[armour_name]

	if #armour.attachments > 0 then
		self:_highlighted_item():set_page(self._armour_attachments_page)
		self._armour_attachments_page:set_profile(self._current_profile)
		self._armour_attachments_page:set_parent_item(self:_highlighted_item())
		self._armour_attachments_page:set_armour(armour_name, table.clone(armour.attachments))
	else
		self:_highlighted_item():set_page(nil)
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	end
end

function OutfitsEditorItemMenuPage:cb_helmet_selected(helmet_name)
	Managers.state.event:trigger("event_outfit_editor_helmet_selected", helmet_name)

	if Helmets[helmet_name].attachments then
		self:_highlighted_item():set_page(self._helmet_attachments_page)
		self._helmet_attachments_page:set_profile(self._current_profile)
		self._helmet_attachments_page:set_parent_item(self:_highlighted_item())
		self._helmet_attachments_page:set_helmet(helmet_name)
	else
		self:_highlighted_item():set_page(nil)
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	end
end

function OutfitsEditorItemMenuPage:cb_mount_selected(mount_name)
	Managers.state.event:trigger("event_outfit_editor_mount_selected", mount_name)
	Managers.state.event:trigger("event_outfit_editor_save_profile")
	self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
end

function OutfitsEditorItemMenuPage:cb_basic_perk_selected(perk_name, perk_type)
	self._specialized_perk_page:set_profile(self._current_profile)
	self._specialized_perk_page:set_parent_item(self:_highlighted_item())
	self._specialized_perk_page:set_basic_perk(perk_name, perk_type)
end

function OutfitsEditorItemMenuPage:cb_basic_perk_selected2(perk_name, perk_type)
	Managers.state.event:trigger("event_outfit_editor_basic_perk_selected", perk_type, perk_name)
end

function OutfitsEditorItemMenuPage:_goto_gear_attachment_page(gear_name)
	if self._gear_attachment_page then
		self._gear_attachment_page:destroy()

		self._gear_attachment_page = nil
	end

	self._gear_attachment_page = self:_create_gear_attachment_page()

	self:_highlighted_item():set_page(self._gear_attachment_page)
	self._gear_attachment_page:set_profile(self._current_profile)
	self._gear_attachment_page:set_parent_item(self:_highlighted_item())
	self._gear_attachment_page:set_gear(gear_name, table.clone(Gear[gear_name].attachments))
end

function OutfitsEditorItemMenuPage:cb_gear_selected(gear_name, slot_name)
	Managers.state.event:trigger("event_outfit_editor_gear_selected", gear_name, slot_name)

	if #Gear[gear_name].attachments > 1 then
		self:_goto_gear_attachment_page(gear_name)
	elseif #Gear[gear_name].attachments > 0 then
		local attachment = Gear[gear_name].attachments[1]

		if #attachment.items > 1 then
			self:_goto_gear_attachment_page(gear_name)
		else
			local attachment_item = attachment.items[1]

			Managers.state.event:trigger("event_outfit_editor_gear_attachments_selected", gear_name, attachment.category, {
				attachment_item.name
			})
			self:_highlighted_item():set_page(nil)
			Managers.state.event:trigger("event_outfit_editor_save_profile")
			self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
		end
	else
		self:_highlighted_item():set_page(nil)
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	end
end

function OutfitsEditorItemMenuPage:_update_container_size(dt, t)
	OutfitsEditorItemMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._outfit_info:update_size(dt, t, self._gui, layout_settings.outfit_info)
	self._perk_info:update_size(dt, t, self._gui, layout_settings.perks)

	local max_height = self._item_list:height() + self._item_list_header:height()

	if self._outfit_info:active() and max_height < self._outfit_info:height() then
		max_height = self._outfit_info:height()
	end

	if self._perk_info:active() and max_height < self._perk_info:height() then
		max_height = self._perk_info:height()
	end

	if max_height < self._tooltip_text_box:height() + self._tooltip_text_box_2:height() then
		max_height = self._tooltip_text_box:height() + self._tooltip_text_box_2:height()
	end

	layout_settings.background_texture.stretch_height = max_height

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
end

function OutfitsEditorItemMenuPage:_update_container_position(dt, t)
	OutfitsEditorItemMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x = MenuHelper:container_position(self._outfit_info, layout_settings.outfit_info)
	local y = self._background_texture:y() + self._background_texture:height() - self._outfit_info:height()

	self._outfit_info:update_position(dt, t, layout_settings.outfit_info, x, y, self.config.z + 20)

	local x = MenuHelper:container_position(self._perk_info, layout_settings.perks)
	local y = self._background_texture:y() + self._background_texture:height() - self._perk_info:height()

	self._perk_info:update_position(dt, t, layout_settings.perks, x, y, self.config.z + 20)
end

function OutfitsEditorItemMenuPage:render(dt, t)
	OutfitsEditorItemMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._outfit_info:render(dt, t, self._gui, layout_settings.outfit_info)
	self._perk_info:render(dt, t, self._gui, layout_settings.perks)
end

function OutfitsEditorItemMenuPage:destroy()
	OutfitsEditorItemMenuPage.super.destroy(self)

	if self._helmet_attachments_page then
		self._helmet_attachments_page:destroy()

		self._helmet_attachments_page = nil
	end

	if self._specialized_perk_page then
		self._specialized_perk_page:destroy()

		self._specialized_perk_page = nil
	end

	if self._gear_attachment_page then
		self._gear_attachment_page:destroy()

		self._gear_attachment_page = nil
	end
end

function OutfitsEditorItemMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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

	return OutfitsEditorItemMenuPage:new(config, item_groups, compiler_data.world)
end
