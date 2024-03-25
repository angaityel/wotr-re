-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_category_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_item_menu_page")
require("scripts/menu/menu_pages/level_4_menu_page")

OutfitEditorCategoryMenuPage = class(OutfitEditorCategoryMenuPage, Level4MenuPage)

function OutfitEditorCategoryMenuPage:init(config, item_groups, world)
	OutfitEditorCategoryMenuPage.super.init(self, config, item_groups, world)

	self._outfit_page = self:_create_item_page()
	self._current_profile = nil
end

function OutfitEditorCategoryMenuPage:on_exit(on_cancel)
	OutfitEditorCategoryMenuPage.super.on_exit(self, on_cancel)

	if on_cancel then
		Managers.state.event:trigger("event_profiles_reload_current_profile")
	end
end

function OutfitEditorCategoryMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitEditorCategoryMenuPage:set_slot(slot_name, ui_slot_name)
	self:_add_category_items(slot_name, ui_slot_name)
	self:_set_camera(slot_name)
end

function OutfitEditorCategoryMenuPage:_set_camera(slot_name)
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

function OutfitEditorCategoryMenuPage:_add_category_items(slot_name, ui_slot_name)
	self:remove_items("item_list_header")
	self:remove_items("item_list")

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		disabled = true,
		text = ui_slot_name,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")

	local options, on_select

	if slot_name == "armour" then
		options = OutfitHelper.outfit_editor_armour_category_options()
	elseif slot_name == "helmet" then
		options = OutfitHelper.outfit_editor_helmet_category_options()
	elseif slot_name == "mount" then
		options = OutfitHelper.outfit_editor_mount_category_options()
	elseif slot_name == "perks" then
		options = OutfitHelper.outfit_editor_perk_category_options()
	elseif slot_name == "two_handed_weapon" or slot_name == "one_handed_weapon" or slot_name == "dagger" or slot_name == "shield" then
		options = OutfitHelper.outfit_editor_gear_category_options(slot_name)
	else
		assert(false, "[OutfitEditorCategoryMenuPage] Unknown slot: " .. tostring(slot_name))
	end

	for i, option in ipairs(options) do
		local item_config = {
			on_select = "cb_outfit_category_selected",
			on_select_args = {
				slot_name,
				option.text,
				option.category
			},
			text = option.text,
			tooltip_text = option.description,
			tooltip_text_2 = option.fluff_text,
			z = self.config.z + 1,
			layout_settings = layout_settings.text,
			parent_page = self,
			sounds = self.config.sounds.items.text,
			required_perk = option.required_perk,
			character_profile = self._current_profile,
			default_page = option.category ~= "none" and self._outfit_page,
			ui_name = L(option.text)
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

	if not IS_DEMO and GameSettingsDevelopment.enable_micro_transactions then
		local buy_gold_item_config = {
			text = "buy_gold_upper",
			page = self._popup_page,
			z = self.config.z + 1,
			parent_page = self,
			layout_settings = layout_settings.buy_coins,
			sounds = self.config.sounds.items.text
		}
		local gold_item = TextMenuItem.create_from_config({
			world = self._world
		}, buy_gold_item_config, self)

		self:add_item(gold_item, "item_list")
	end

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

function OutfitEditorCategoryMenuPage:_create_item_page()
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

	return OutfitsEditorItemMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitEditorCategoryMenuPage:cb_outfit_category_selected(slot_name, ui_slot_name, category)
	if category == "none" then
		if slot_name == "mount" then
			Managers.state.event:trigger("event_outfit_editor_mount_selected", nil)
		elseif slot_name == "two_handed_weapon" or slot_name == "shield" then
			Managers.state.event:trigger("event_outfit_editor_gear_selected", nil, slot_name)
		end

		Managers.state.event:trigger("event_outfit_editor_save_profile")
		self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
	else
		self._outfit_page:set_profile(self._current_profile)
		self._outfit_page:set_parent_item(self:_highlighted_item())
		self._outfit_page:set_outfit_category(slot_name, ui_slot_name, category)
	end
end

function OutfitEditorCategoryMenuPage:_update_container_size(dt, t)
	OutfitEditorCategoryMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local max_height = self._item_list:height() + self._item_list_header:height()

	if max_height < self._tooltip_text_box:height() + self._tooltip_text_box_2:height() then
		max_height = self._tooltip_text_box:height() + self._tooltip_text_box_2:height()
	end

	layout_settings.background_texture.stretch_height = max_height

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
end

function OutfitEditorCategoryMenuPage:destroy()
	OutfitEditorCategoryMenuPage.super.destroy(self)

	if self._outfit_page then
		self._outfit_page:destroy()

		self._outfit_page = nil
	end
end

function OutfitEditorCategoryMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "outfit_editor",
		id = page_config.id,
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return OutfitEditorCategoryMenuPage:new(config, item_groups, compiler_data.world)
end
