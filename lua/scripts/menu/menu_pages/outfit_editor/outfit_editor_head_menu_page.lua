-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_head_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/menu/menu_pages/level_4_menu_page")
require("scripts/menu/menu_containers/outfit_info_menu_container")
require("scripts/menu/menu_items/texture_button_menu_item")

OutfitsEditorHeadMenuPage = class(OutfitsEditorHeadMenuPage, Level4MenuPage)

function OutfitsEditorHeadMenuPage:init(config, item_groups, world)
	OutfitsEditorHeadMenuPage.super.init(self, config, item_groups, world)

	self._head_ddl_pages = {
		head = self:_create_head_ddl_page(),
		material = self:_create_head_ddl_page(),
		voice = self:_create_head_ddl_page()
	}
	self._current_profile = nil
	self._ddl_selected_options = {}

	self:_add_head_items()

	local head_options = {}

	for key, head in pairs(Heads) do
		head_options[#head_options + 1] = {
			category = "head",
			key = key,
			value = L("menu_" .. key)
		}
	end

	self._head_options = head_options

	local voice_options = {}

	for voice_name, props in pairs(Voices) do
		if props.required_dlc == nil or props.required_dlc == true then
			voice_options[#voice_options + 1] = {
				category = "voice",
				key = voice_name,
				value = L("menu_vo_" .. voice_name)
			}
		end
	end

	self._voice_options = voice_options
end

function OutfitsEditorHeadMenuPage:set_profile(player_profile)
	self._current_profile = player_profile
end

function OutfitsEditorHeadMenuPage:_create_head_ddl_page()
	local compiler_data = {
		world = self._world
	}
	local page_config = {
		on_option_highlighted = "cb_head_highlighted",
		on_exit_page = "cb_reset_selection",
		on_enter_options = "cb_head_options",
		on_option_changed = "cb_head_option_changed",
		backup_event = "event_save_outfit_editor_head",
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

function OutfitsEditorHeadMenuPage:_add_head_items()
	self:remove_items("item_list_header")
	self:remove_items("item_list")

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		text = "menu_head",
		disabled = true,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list_header")
	self:add_item(self:_create_head_ddl_item("head", layout_settings), "item_list")
	self:add_item(self:_create_head_ddl_item("material", layout_settings), "item_list")
	self:add_item(self:_create_head_ddl_item("voice", layout_settings), "item_list")

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

function OutfitsEditorHeadMenuPage:_create_head_ddl_item(category, layout_settings)
	local page = self._head_ddl_pages[category]

	page.config.on_enter_options_args = {
		category
	}

	local item_config = {
		tooltip_text_2 = "menu_head_fluff",
		tooltip_text = "menu_head_tooltip",
		on_enter_text = "cb_head_ddl_text",
		callback_object = "page",
		page = page,
		on_enter_text_args = {
			category
		},
		z = self.config.z + 1,
		layout_settings = layout_settings.drop_down_list,
		parent_page = self,
		sounds = self.config.sounds.items.drop_down_list
	}

	return DropDownListMenuItem.create_from_config({
		world = self._world
	}, item_config, self)
end

function OutfitsEditorHeadMenuPage:cb_head_ddl_text(category)
	local ui_name
	local profile = self._current_profile
	local category_name

	if category == "head" then
		local head = profile.head

		ui_name = Heads[head].ui_name
		category_name = L("menu_face")
	elseif category == "material" then
		local material = profile.head_material or Heads[profile.head].material_variations[1]

		ui_name = HeadMaterials[material].ui_name
		category_name = L("menu_material")
	elseif category == "voice" then
		local voice = profile.voice or "commoner"

		ui_name = "menu_vo_" .. voice
		category_name = L("menu_voice")
	end

	return category_name, L(ui_name)
end

function OutfitsEditorHeadMenuPage:cb_head_highlighted(item)
	if item then
		local option = item.config.on_select_args[1]
		local cloned = table.clone(self._ddl_selected_options)

		cloned[option.category] = option.key

		if option.category == "head" then
			cloned.material = Heads[option.key].material_variations[1]
		end

		Managers.state.event:trigger("event_outfit_editor_head_selected", cloned)
	end
end

function OutfitsEditorHeadMenuPage:cb_head_options(category)
	local selected_index = 1

	if category == "head" then
		return self._head_options, selected_index
	elseif category == "material" then
		local profile = self._current_profile
		local materials = Heads[profile.head].material_variations
		local current_material = profile.head_material
		local options = {}

		for i, material_name in ipairs(materials) do
			options[i] = {
				category = "material",
				value = L(HeadMaterials[material_name].ui_name),
				key = material_name
			}

			if current_material == material_name then
				selected_index = i
			end
		end

		return options, selected_index
	elseif category == "voice" then
		return self._voice_options, selected_index
	end
end

function OutfitsEditorHeadMenuPage:cb_selection_done()
	Managers.state.event:trigger("event_outfit_editor_head_selected", self._ddl_selected_options)
	Managers.state.event:trigger("event_outfit_editor_save_profile")
	self:_try_callback(self.config.callback_object, "cb_cancel_to", "select_outfit_slot")
end

function OutfitsEditorHeadMenuPage:cb_head_option_changed(option)
	self._ddl_selected_options[option.category] = option.key

	if option.category == "head" then
		self._ddl_selected_options.material = Heads[option.key].material_variations[1]
	end

	self._head_changed = true

	Managers.state.event:trigger("event_outfit_editor_head_selected", self._ddl_selected_options)
end

function OutfitsEditorHeadMenuPage:cb_reset_selection()
	if not self._head_changed then
		Managers.state.event:trigger("event_reset_outfit_editor_head", self._helmet_name)
	end

	self._head_changed = nil
end

function OutfitsEditorHeadMenuPage:on_exit(on_cancel)
	OutfitsEditorHeadMenuPage.super.on_exit(self, on_cancel)

	if on_cancel then
		Managers.state.event:trigger("event_profiles_reload_current_profile")
	end
end

function OutfitsEditorHeadMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
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

	return OutfitsEditorHeadMenuPage:new(config, item_groups, compiler_data.world)
end
