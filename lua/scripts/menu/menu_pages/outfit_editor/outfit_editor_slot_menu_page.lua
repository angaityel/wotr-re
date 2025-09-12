-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_slot_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_category_menu_page")

OutfitEditorSlotMenuPage = class(OutfitEditorSlotMenuPage, Level3MenuPage)

function OutfitEditorSlotMenuPage:init(config, item_groups, world, viewport)
	OutfitEditorSlotMenuPage.super.init(self, config, item_groups, world)

	self._current_profile = nil
end

function OutfitEditorSlotMenuPage:on_enter(on_cancel)
	OutfitEditorSlotMenuPage.super.on_enter(self, on_cancel)
	self:remove_items("item_list")
	self:_add_items()
end

function OutfitEditorSlotMenuPage:_add_items()
	self._category_page = self:_create_category_page()
	self._head_page = self:_create_head_page()

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		text = "main_menu_edit_profiles",
		disabled = true,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list")

	local options = OutfitHelper.outfit_editor_slot_options()

	for i, option in ipairs(options) do
		local item_config = {
			on_select = option.on_select_function or "cb_slot_selected",
			on_select_args = {
				option.key,
				option.value
			},
			text = option.value,
			z = self.config.z + 1,
			layout_settings = layout_settings.text,
			parent_page = self,
			sounds = self.config.sounds.items.text,
			required_perk = option.required_perk,
			character_profile = self._current_profile,
			default_page = self[option.default_page] or self._category_page,
			ui_name = L(option.value)
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

	local name_popup_page = MenuHelper:create_input_popup_page(self._world, self, self, "cb_name_popup_enter", "cb_name_popup_item_selected", "cb_name_popup_save_button_disabled", self.config.z + 50, self.config.sounds, "menu_rename_profile", MainMenuSettings.pages.text_input_popup, MainMenuSettings.items.popup_header, MainMenuSettings.items.popup_input, MainMenuSettings.items.popup_button, 3, 26)
	local name_config = {
		text = "menu_rename",
		name = "name_input",
		page = name_popup_page,
		z = self.config.z + 1,
		layout_settings = layout_settings.text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local name_input_item = TextMenuItem.create_from_config({
		world = self._world
	}, name_config, self)

	self:add_item(name_input_item, "item_list")

	local reset_popup_page = MenuHelper:create_confirmation_popup_page(self._world, self, self, "cb_reset_popup_enter", "cb_reset_popup_item_selected", self.config.z + 50, self.config.sounds, "menu_reset_profile", "menu_empty", MainMenuSettings.pages.text_input_popup, MainMenuSettings.items.popup_header, MainMenuSettings.items.popup_text, MainMenuSettings.items.popup_button)
	local reset_config = {
		text = "menu_reset",
		page = reset_popup_page,
		z = self.config.z + 1,
		layout_settings = layout_settings.text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local reset_input_item = TextMenuItem.create_from_config({
		world = self._world
	}, reset_config, self)

	self:add_item(reset_input_item, "item_list")

	local delimiter_item_config = {
		disabled = true,
		parent_page = self,
		layout_settings = layout_settings.delimiter_texture
	}
	local delimiter_item = TextureMenuItem.create_from_config({
		world = self._world
	}, delimiter_item_config, self)

	self:add_item(delimiter_item, "item_list")

	--

	local copy_build_popup_page = MenuHelper:create_confirmation_popup_page(self._world, self, self, "cb_copy_build_popup_enter", "cb_copy_build_popup_item_selected", self.config.z + 50, self.config.sounds, "copy_build", "menu_empty", MainMenuSettings.pages.text_input_popup, MainMenuSettings.items.popup_header, MainMenuSettings.items.popup_text, MainMenuSettings.items.popup_button)
	local copy_build_config = {
		text = "copy_build",
		page = copy_build_popup_page,
		z = self.config.z + 1,
		layout_settings = layout_settings.text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local copy_build_input_item = TextMenuItem.create_from_config({
		world = self._world
	}, copy_build_config, self)

	self:add_item(copy_build_input_item, "item_list")

	--
	local paste_build_popup_page = MenuHelper:create_confirmation_popup_page(self._world, self, self, "cb_paste_build_popup_enter", "cb_paste_build_popup_item_selected", self.config.z + 50, self.config.sounds, "paste_build", "menu_empty", MainMenuSettings.pages.text_input_popup, MainMenuSettings.items.popup_header, MainMenuSettings.items.popup_text, MainMenuSettings.items.popup_button)
	local paste_build_config = {
		text = "paste_build",
		page = paste_build_popup_page,
		z = self.config.z + 1,
		layout_settings = layout_settings.text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local paste_build_input_item = TextMenuItem.create_from_config({
		world = self._world
	}, paste_build_config, self)

	self:add_item(paste_build_input_item, "item_list")
	
	local delimiter_item_config = {
		disabled = true,
		parent_page = self,
		layout_settings = layout_settings.delimiter_texture
	}
	local delimiter_item = TextureMenuItem.create_from_config({
		world = self._world
	}, delimiter_item_config, self)

	self:add_item(delimiter_item, "item_list")

	--

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

function OutfitEditorSlotMenuPage:cb_name_popup_enter(args)
	local input_text = self._current_profile.display_name

	args.popup_page:find_item_by_name("text_input"):set_text(input_text)
end

function OutfitEditorSlotMenuPage:cb_name_popup_item_selected(args)
	if args.action == "save" then
		local input_text = args.popup_page:find_item_by_name("text_input"):text()

		self._current_profile.display_name = input_text

		Managers.state.event:trigger("event_outfit_editor_save_profile")
		Managers.state.event:trigger("event_profile_name_updated")
	end
end

function OutfitEditorSlotMenuPage:cb_set_profile_name(name)
	self._current_profile.display_name = name

	Managers.state.event:trigger("event_outfit_editor_save_profile")
	Managers.state.event:trigger("event_profile_name_updated")
end

function OutfitEditorSlotMenuPage:cb_name_popup_save_button_disabled(args)
	local input_text_item = args.popup_page:find_item_by_name("text_input")

	if not input_text_item:validate_text_length() then
		return true
	end
end

function OutfitEditorSlotMenuPage:cb_copy_build_popup_enter(args)
	local profile_name = self._current_profile.display_name
	local message_text = string.format("Copy build to clipboard?", profile_name)

	args.popup_page:find_item_by_name("text_message"):set_text(message_text)
end

function OutfitEditorSlotMenuPage:cb_copy_build_popup_item_selected(args)
	if args.action == "confirm" then
		Managers.state.event:trigger("event_profiles_copy_current_profile")
	end
end

function OutfitEditorSlotMenuPage:cb_paste_build_popup_enter(args)
	local profile_name = self._current_profile.display_name
	local message_text = string.format("Paste build from clipboard? Current build will be reset!", profile_name)

	args.popup_page:find_item_by_name("text_message"):set_text(message_text)
end

function OutfitEditorSlotMenuPage:cb_paste_build_popup_item_selected(args)
	if args.action == "confirm" then
		--Managers.state.event:trigger("event_profiles_reset_current_profile")
		Managers.state.event:trigger("event_profiles_paste_current_profile")
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		Managers.state.event:trigger("event_profile_name_updated")
	end
end

function OutfitEditorSlotMenuPage:cb_reset_popup_enter(args)
	local profile_name = self._current_profile.display_name
	local message_text = string.format(L("menu_confirm_reset_profile"), profile_name)

	args.popup_page:find_item_by_name("text_message"):set_text(message_text)
end

function OutfitEditorSlotMenuPage:cb_reset_popup_item_selected(args)
	if args.action == "confirm" then
		Managers.state.event:trigger("event_profiles_reset_current_profile")
		Managers.state.event:trigger("event_outfit_editor_save_profile")
		Managers.state.event:trigger("event_profile_name_updated")
	end
end

function OutfitEditorSlotMenuPage:_create_category_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		id = "select_outfit_category",
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

	return OutfitEditorCategoryMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitEditorSlotMenuPage:_create_head_page()
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

	return OutfitsEditorHeadMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitEditorSlotMenuPage:_try_cancel()
	MenuPage._try_cancel(self)
end

function OutfitEditorSlotMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitEditorSlotMenuPage:cb_head_slot_selected(slot_name, ui_slot_name)
	self._head_page:set_profile(self._current_profile)
	self._head_page:set_parent_item(self:_highlighted_item())
end

function OutfitEditorSlotMenuPage:cb_slot_selected(slot_name, ui_slot_name)
	self._category_page:set_profile(self._current_profile)
	self._category_page:set_parent_item(self:_highlighted_item())
	self._category_page:set_slot(slot_name, ui_slot_name)
end

function OutfitEditorSlotMenuPage:render_from_child_page(dt, t, leef)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:render_from_child_page(dt, t, self._gui, layout_settings.item_list)
	self.config.parent_page:render_from_child_page(dt, t, leef or self)
end

function OutfitEditorSlotMenuPage:destroy()
	OutfitEditorSlotMenuPage.super.destroy(self)

	if self._category_page then
		self._category_page:destroy()

		self._category_page = nil
	end
end

function OutfitEditorSlotMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "outfit_editor",
		id = page_config.id,
		parent_page = parent_page,
		callback_object = callback_object,
		viewport_name = compiler_data.menu_data.viewport_name,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return OutfitEditorSlotMenuPage:new(config, item_groups, compiler_data.world)
end
