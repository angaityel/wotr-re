-- chunkname: @scripts/menu/menu_pages/outfit_editor/outfit_editor_profile_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_slot_menu_page")
require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/settings/demo_settings")
require("scripts/helpers/profile_helper")
require("scripts/utils/base64")

OutfitEditorProfileMenuPage = class(OutfitEditorProfileMenuPage, Level2MenuPage)

function OutfitEditorProfileMenuPage:init(config, item_groups, world)
	OutfitEditorProfileMenuPage.super.init(self, config, item_groups, world)

	self._profile_info = ProfileInfoMenuContainer.create_from_config()

	self._profile_info:set_active(false)

	local viewer_world_name = self:_try_callback(self.config.callback_object, "cb_profile_viewer_world_name")
	local viewer_viewport = self:_try_callback(self.config.callback_object, "cb_profile_viewer_viewport_name", config.local_player)

	self._profile_viewer = ProfileViewerMenuContainer.create_from_config(viewer_world_name, viewer_viewport, MenuSettings.viewports.main_menu_profile_viewer)
	self._xp_progress_bar_container = ItemListMenuContainer.create_from_config(item_groups.xp_progress_bar)
	self._current_profile_name = nil
	self._current_profile_copy = {}
	self._slots_page = self:_create_slots_page()

	self:_add_items()

	local alignment_dummy_units = self:_try_callback(self.config.callback_object, "cb_alignment_dummy_units")

	for name, unit in pairs(alignment_dummy_units) do
		self:add_menu_alignment_dummy(name, unit)
	end

	Managers.state.event:register(self, "event_outfit_editor_armour_selected", "armour_selected")
	Managers.state.event:register(self, "event_outfit_editor_helmet_selected", "helmet_selected")
	Managers.state.event:register(self, "event_outfit_editor_mount_selected", "mount_selected")
	Managers.state.event:register(self, "event_outfit_editor_gear_selected", "gear_selected")
	Managers.state.event:register(self, "event_outfit_editor_basic_perk_selected", "basic_perk_selected")
	Managers.state.event:register(self, "event_outfit_editor_specialized_perks_selected", "specialized_perks_selected")
	Managers.state.event:register(self, "event_outfit_editor_helmet_attachments_selected", "helmet_attachments_selected")
	Managers.state.event:register(self, "event_save_outfit_editor_helmet_attachments", "save_helmet_attachments")
	Managers.state.event:register(self, "event_reset_outfit_editor_helmet_attachments", "reset_helmet_attachments")
	Managers.state.event:register(self, "event_outfit_editor_head_selected", "head_selected")
	Managers.state.event:register(self, "event_save_outfit_editor_head", "save_head")
	Managers.state.event:register(self, "event_reset_outfit_editor_head", "reset_head")
	Managers.state.event:register(self, "event_outfit_editor_gear_attachments_selected", "gear_attachments_selected")
	Managers.state.event:register(self, "event_outfit_editor_armour_attachments_selected", "armour_attachments_selected")
	Managers.state.event:register(self, "event_profiles_reload_current_profile", "reload_current_profile")
	Managers.state.event:register(self, "event_profiles_copy_current_profile", "copy_current_profile")
	Managers.state.event:register(self, "event_profiles_paste_current_profile", "paste_current_profile")
	Managers.state.event:register(self, "event_profiles_reset_current_profile", "reset_current_profile")
	Managers.state.event:register(self, "event_profile_name_updated", "profile_name_updated")
	Managers.state.event:register(self, "event_outfit_editor_save_profile", "save_profile")
	Managers.state.event:register(self, "menu_alignment_dummy_spawned", "add_menu_alignment_dummy")
	Managers.state.event:register(self, "purchase_complete", "event_purchase_complete")
	Managers.state.event:register(self, "profile_gold_reloaded", "event_profile_gold_reloaded")
end

function OutfitEditorProfileMenuPage:event_purchase_complete()
	self:_load_xp_and_coins()
end

function OutfitEditorProfileMenuPage:event_profile_gold_reloaded()
	self:_load_xp_and_coins()
end

function OutfitEditorProfileMenuPage:add_menu_alignment_dummy(name, unit)
	if name == "player_without_mount" then
		self._profile_viewer:add_alignment_unit("player_without_mount", unit)
	elseif name == "player_with_mount" then
		self._profile_viewer:add_alignment_unit("player_with_mount", unit)
	elseif name == "mount" then
		self._profile_viewer:add_alignment_unit("mount", unit)
	end
end

function OutfitEditorProfileMenuPage:set_input(input)
	if not self._profile_data_loaded then
		return
	end

	self:_update_mouse_hover(input)
	self:_update_input(input)
end

function OutfitEditorProfileMenuPage:_update_input(input)
	OutfitEditorProfileMenuPage.super._update_input(self, input)

	if not input then
		return
	end

	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if input:has("leave_battle") and input:get("leave_battle") then
			local child_page = self._item_groups.back_list[1]:page()

			self._menu_logic:change_page(child_page)
		elseif input:has("select_team") and input:get("select_team") then
			self:_try_callback(self.config.callback_object, "cb_goto", "select_team")
		end
	end
end

function OutfitEditorProfileMenuPage:on_enter(on_cancel)
	OutfitEditorProfileMenuPage.super.on_enter(self, on_cancel)
	self._profile_info:set_active(true)

	if not on_cancel then
		local items = self:items_in_group("item_list")

		if not GameSettingsDevelopment.unlock_all then
			Managers.state.event:trigger("event_load_started", "menu_loading_profile", "menu_profile_loaded")
			Managers.persistence:connect(callback(self, "cb_backend_setup"))

			self._profile_data_loaded = false

			for _, item in ipairs(items) do
				if item.config.name == "character_profile" then
					item.config.loading_profile = true
				end
			end
		else
			self:_highlight_first_avalible_profile()

			self._profile_data_loaded = true
		end
	end
end

function OutfitEditorProfileMenuPage:menu_deactivated(tab)
	OutfitEditorProfileMenuPage.super.menu_deactivated(self, tab)
	self._profile_info:set_active(false)
	self._profile_viewer:clear()
end

function OutfitEditorProfileMenuPage:cb_deactivate_outfit_editor()
	self._profile_info:set_active(false)
	self._profile_viewer:clear()
end

function OutfitEditorProfileMenuPage:_highlight_first_avalible_profile()
	for i, item in ipairs(self._items) do
		if item.config.name == "character_profile" then
			item:update_disabled()

			if item.config.avalible then
				local profile = item.config.on_select_args[1]

				self:cb_profile_highlighted(profile)
			end
		end
	end
end

function OutfitEditorProfileMenuPage:cb_backend_setup(error_code)
	if error_code == nil then
		Managers.persistence:load_profile(callback(self, "cb_profile_loaded"))
	else
		Managers.state.event:trigger("event_load_finished")

		self._profile_data_loaded = true
	end
end

function OutfitEditorProfileMenuPage:cb_profile_loaded(data)
	Managers.state.event:trigger("event_load_finished")

	self._profile_data_loaded = true

	local items = self:items_in_group("item_list")

	for _, item in ipairs(items) do
		if item.config.name == "character_profile" then
			item.config.loading_profile = false
		end
	end

	self:_highlight_first_avalible_profile()
	self:_load_xp_and_coins()
end

function OutfitEditorProfileMenuPage:_load_xp_and_coins()
	local data = Managers.persistence:profile_data()

	if not data then
		return
	end

	local rank = data.attributes.rank
	local next_rank_exists = RANKS[rank + 1]
	local next_rank = next_rank_exists and rank + 1 or nil
	local xp = math.floor(data.attributes.experience)
	local xp_next_rank = next_rank_exists and RANKS[rank].xp.base + RANKS[rank].xp.span or nil
	local xp_current_rank = RANKS[rank].xp.base
	local bar_data = {
		value = xp,
		value_min = xp_current_rank,
		value_max = xp_next_rank,
		left_text = rank,
		right_text = next_rank
	}

	self:find_item_by_name("xp_progress_bar"):set_bar_data(bar_data)

	local coins = data.attributes.coins

	self:find_item_by_name("coins").config.text = coins
end

function OutfitEditorProfileMenuPage:_add_items()
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

	local options = OutfitHelper.outfit_editor_character_profiles_options()

	for _, option in pairs(options) do
		local unlock_type = "profile"
		local unlock_key = PlayerProfiles[option.key].unlock_key
		local entity_type = "profile"
		local entity_name = PlayerProfiles[option.key].unlock_key
		local market_item_name = entity_type .. "|" .. entity_name
		local ui_name = PlayerProfiles[option.key].display_name
		local market_message_args = {
			ui_name
		}
		local item_config = {
			no_localization = true,
			name = "character_profile",
			on_highlight = "cb_profile_highlighted",
			no_editing = option.no_editing,
			on_highlight_args = {
				option.key
			},
			on_select_args = {
				option.key
			},
			text = option.value,
			z = self.config.z + 1,
			layout_settings = layout_settings.text,
			parent_page = self,
			sounds = self.config.sounds.items.text,
			release_name = PlayerProfiles[option.key].release_name,
			default_page = self._slots_page,
			unlock_type = unlock_type,
			unlock_key = unlock_key,
			entity_type = entity_type,
			entity_name = entity_name,
			market_item_name = market_item_name,
			market_message_args = market_message_args,
			ui_name = ui_name
		}
		local item = OutfitTextMenuItem.create_from_config({
			world = self._world
		}, item_config, self)

		self:add_item(item, "item_list")
	end

	if not self.config.no_cancel_to_parent_page then
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
end

function OutfitEditorProfileMenuPage:_create_slots_page()
	local compiler_data = {
		world = self._world,
		menu_data = {
			viewport_name = self.config.viewport_name,
			local_player = self.config.local_player
		}
	}
	local page_config = {
		id = "select_outfit_slot",
		z = self.config.z + 50,
		layout_settings = MainMenuSettings.pages.level_3_character_profiles,
		sounds = self.config.sounds
	}
	local item_groups = {
		item_list = {},
		back_list = {}
	}

	return OutfitEditorSlotMenuPage.create_from_config(compiler_data, page_config, self, item_groups, self.config.callback_object)
end

function OutfitEditorProfileMenuPage:cb_profile_highlighted(profile_name)
	self._current_profile_name = profile_name
	self._current_profile_copy = table.clone(PlayerProfiles[self._current_profile_name])

	self:_profile_updated("profile")
end

function OutfitEditorProfileMenuPage:cb_profile_selected(profile_name)
	return
end

function OutfitEditorProfileMenuPage:_update_container_size(dt, t)
	OutfitEditorProfileMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._profile_info:update_size(dt, t, self._gui, layout_settings.profile_info)
	self._profile_viewer:update_size(dt, t, self._gui, layout_settings.profile_viewer)
	self._xp_progress_bar_container:update_size(dt, t, self._gui, layout_settings.xp_progress_bar)
end

function OutfitEditorProfileMenuPage:_update_container_position(dt, t)
	OutfitEditorProfileMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._profile_info, layout_settings.profile_info)

	self._profile_info:update_position(dt, t, layout_settings.profile_info, x, y, self.config.z + 10)

	x = self._item_list:x() + self._item_list:width() + (self._profile_info:x() - (self._item_list:x() + self._item_list:width())) / 2 - self._horizontal_line_top_texture:width() / 2
	y = self._background_texture:y() + self._background_texture:height()

	self._horizontal_line_top_texture:update_position(dt, t, layout_settings, x, y, self.config.z + 5)

	x = self._item_list:x() + self._item_list:width() + (self._profile_info:x() - (self._item_list:x() + self._item_list:width())) / 2 - self._horizontal_line_top_texture:width() / 2
	y = self._background_texture:y() - self._horizontal_line_bottom_texture:height()

	self._horizontal_line_bottom_texture:update_position(dt, t, layout_settings, x, y, self.config.z + 5)

	x, y = MenuHelper:container_position(self._profile_viewer, layout_settings.profile_viewer)

	self._profile_viewer:update_position(dt, t, layout_settings.profile_viewer, x, y, self.config.z + 10)

	local x, y = MenuHelper:container_position(self._xp_progress_bar_container, layout_settings.xp_progress_bar)

	self._xp_progress_bar_container:update_position(dt, t, layout_settings.xp_progress_bar, x, y, self.config.z + 5)
end

function OutfitEditorProfileMenuPage:render(dt, t)
	OutfitEditorProfileMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._profile_info:render(dt, t, self._gui, layout_settings.profile_info)
	self._profile_viewer:render(dt, t, self._gui, layout_settings.profile_viewer)
	self._xp_progress_bar_container:render(dt, t, self._gui, layout_settings.xp_progress_bar)
end

function OutfitEditorProfileMenuPage:armour_selected(armour_name)
	self._current_profile_copy.armour = armour_name
	self._current_profile_copy.armour_attachments = {
		patterns = 1
	}

	self:_profile_updated("profile")
end

function OutfitEditorProfileMenuPage:helmet_selected(helmet_name)
	if self._current_profile_copy.helmet.name ~= helmet_name then
		self._current_profile_copy.helmet.attachments.visor = nil
		self._current_profile_copy.helmet.attachments.plume = nil
		self._current_profile_copy.helmet.attachments.feathers = nil

		local coif, pattern

		for attachment_name, attachment in pairs(Helmets[helmet_name].attachments.default_unlocks) do
			if attachment.type == "coif" then
				coif = attachment_name
			elseif attachment.type == "pattern" then
				pattern = attachment_name
			end
		end

		self._current_profile_copy.helmet.attachments.coif = coif
		self._current_profile_copy.helmet.attachments.bevor = nil
		self._current_profile_copy.helmet.attachments.pattern = pattern or Helmets[helmet_name].attachments.pattern_standard and "pattern_standard"
		self._current_profile_copy.helmet.show_crest = false
	end

	self._current_profile_copy.helmet.name = helmet_name

	self:_profile_updated("helmet")
	self:_profile_updated("helmet_attachments")
end

function OutfitEditorProfileMenuPage:head_selected(selections)
	local head = selections.head

	if head then
		self._current_profile_copy.head = head
	end

	local material = selections.material

	if material then
		self._current_profile_copy.head_material = material
	end

	local voice = selections.voice

	if voice then
		self._current_profile_copy.voice = voice
	end

	if material or head or voice then
		self:_profile_updated("head")
	end
end

function OutfitEditorProfileMenuPage:save_head()
	self._saved_head = self._current_profile_copy.head
	self._saved_head_material = self._current_profile_copy.head_material
	self._saved_voice = self._current_profile_copy.voice
end

function OutfitEditorProfileMenuPage:reset_head()
	self._current_profile_copy.head = self._saved_head
	self._current_profile_copy.head_material = self._saved_head_material
	self._current_profile_copy.voice = self._saved_voice

	self:_profile_updated("head")
end

function OutfitEditorProfileMenuPage:helmet_attachments_selected(helmet_name, attachments, show_crest)
	for attachment_type, attachment_name in pairs(attachments) do
		if attachment_name ~= "none" then
			self._current_profile_copy.helmet.attachments[attachment_type] = attachment_name
		else
			self._current_profile_copy.helmet.attachments[attachment_type] = nil

			self._profile_viewer:remove_unit(attachment_type)
		end
	end

	if show_crest then
		self._current_profile_copy.helmet.show_crest = true
	else
		self._current_profile_copy.helmet.show_crest = false

		self._profile_viewer:remove_unit("crest")
	end

	self:_profile_updated("helmet_attachments")
end

function OutfitEditorProfileMenuPage:reset_helmet_attachments(helmet_name)
	for attachment_type, attachment_name in pairs(self._current_profile_copy.helmet.attachments) do
		if attachment_name ~= "none" then
			self._profile_viewer:remove_unit(attachment_type)
		end
	end

	self._current_profile_copy.helmet.attachments = {}

	for attachment_type, attachment_name in pairs(self._saved_helmet_attachments) do
		self._current_profile_copy.helmet.attachments[attachment_type] = attachment_name
	end

	if self._saved_show_crest then
		self._current_profile_copy.helmet.show_crest = true
	else
		self._current_profile_copy.helmet.show_crest = false

		self._profile_viewer:remove_unit("crest")
	end

	self:_profile_updated("helmet_attachments")
end

function OutfitEditorProfileMenuPage:save_helmet_attachments()
	self._saved_helmet_attachments = table.clone(self._current_profile_copy.helmet.attachments)
	self._saved_show_crest = self._current_profile_copy.helmet.show_crest
end

function OutfitEditorProfileMenuPage:gear_attachments_selected(gear_name, category, attachments)
	local gear = ProfileHelper:find_gear_by_name(self._current_profile_copy.gear, gear_name)

	gear.attachments[category] = attachments

	self:_profile_updated("gear")
end

function OutfitEditorProfileMenuPage:armour_attachments_selected(armour, category, attachments)
	self._current_profile_copy.armour_attachments[category] = attachments

	self:_profile_updated("armour_attachments")
end

function OutfitEditorProfileMenuPage:mount_selected(mount_name)
	self._current_profile_copy.mount = mount_name

	self:_update_wielded_gear(self._current_profile_copy)
	self:_profile_updated("mount")
end

function OutfitEditorProfileMenuPage:gear_selected(gear_name, slot_name)
	local player_profile = self._current_profile_copy

	ProfileHelper:remove_gear_by_slot(player_profile.gear, slot_name)

	if gear_name then
		player_profile.gear[#player_profile.gear + 1] = {
			name = gear_name,
			attachments = {}
		}
	end

	self:_update_wielded_gear(player_profile)
	self:_profile_updated("profile")
end

function OutfitEditorProfileMenuPage:basic_perk_selected(perk_type, perk_name)
	self._current_profile_copy.perks[perk_type .. "_basic"] = perk_name
end

function OutfitEditorProfileMenuPage:specialized_perks_selected(perk_type, perk_names)
	self._current_profile_copy.perks[perk_type .. "_specialization_1"] = nil
	self._current_profile_copy.perks[perk_type .. "_specialization_2"] = nil

	for i, perk_name in ipairs(perk_names) do
		local slot_name = perk_type .. "_specialization_" .. i

		self._current_profile_copy.perks[slot_name] = perk_name
	end

	self:_resolve_perk_conflicts(self._current_profile_copy)
	self:_update_wielded_gear(self._current_profile_copy)
	self:_profile_updated("profile")
end

function OutfitEditorProfileMenuPage:_resolve_perk_conflicts(profile_table)
	if not table.contains(profile_table.perks, "archer") then
		ProfileHelper:remove_gear_by_type(profile_table.gear, "hunting_bow")
		ProfileHelper:remove_gear_by_type(profile_table.wielded_gear, "hunting_bow")
		ProfileHelper:remove_gear_by_type(profile_table.gear, "longbow")
		ProfileHelper:remove_gear_by_type(profile_table.wielded_gear, "longbow")
		ProfileHelper:remove_gear_by_type(profile_table.gear, "short_bow")
		ProfileHelper:remove_gear_by_type(profile_table.wielded_gear, "short_bow")
		ProfileHelper:remove_gear_by_type(profile_table.gear, "crossbow")
		ProfileHelper:remove_gear_by_type(profile_table.wielded_gear, "crossbow")
	end

	if not table.contains(profile_table.perks, "shield_bearer") then
		ProfileHelper:remove_gear_by_type(profile_table.gear, "shield")
		ProfileHelper:remove_gear_by_type(profile_table.wielded_gear, "shield")
	end

	if not table.contains(profile_table.perks, "cavalry") and profile_table.mount then
		profile_table.mount = nil
	end

	if not table.contains(profile_table.perks, "heavy_cavalry") and profile_table.mount and MountProfiles[profile_table.mount].category == "barded" then
		profile_table.mount = nil
	end
end

function OutfitEditorProfileMenuPage:_profile_updated(updated_outfit)
	self._slots_page:set_profile(self._current_profile_copy)
	self._profile_info:set_active(true)
	self._profile_info:load(self._current_profile_copy)

	local profile_viewer = self._profile_viewer

	if updated_outfit == "mount" then
		if self._current_profile_copy.mount then
			profile_viewer:load_mount(MountProfiles[self._current_profile_copy.mount])
		else
			profile_viewer:remove_unit("mount")
		end
	else
		profile_viewer["load_" .. updated_outfit](profile_viewer, self._current_profile_copy)

		if profile_viewer:player_unit() then
			profile_viewer:update_coat_of_arms(PlayerCoatOfArms.ui_team_name)
		end
	end

	if updated_outfit == "head" then
		self:_profile_updated("helmet")
		self:_profile_updated("helmet_attachments")
	end
end

function OutfitEditorProfileMenuPage:reload_current_profile()
	self._current_profile_copy = table.clone(PlayerProfiles[self._current_profile_name])

	self:_profile_updated("profile")
end

function OutfitEditorProfileMenuPage:copy_current_profile()
	local base64_table_string = "base64:" .. base64_encode("return " .. table.table_to_string(PlayerProfiles[self._current_profile_name]))
	os.execute("echo " .. base64_table_string .. "|clip.exe")
end

function OutfitEditorProfileMenuPage:paste_current_profile()
	local pipe = io.popen([[powershell -NoProfile -Command "Get-Clipboard"]])
	local clip_text = pipe:read("*a")
	pipe:close()

	if string.find(clip_text, "base64:") then
		clip_text = string.sub(clip_text, 8)
		clip_text = clip_text:gsub("[\r\n]+$", "")

		local table_string = base64_decode(clip_text)
		local func = loadstring(table_string)
		local result = func()	

		PlayerProfiles[self._current_profile_name] = table.clone(result)

		self:reload_current_profile()
	else
		print("Not valid build string")
	end
end

function OutfitEditorProfileMenuPage:reset_current_profile()
	PlayerProfiles[self._current_profile_name] = table.clone(PlayerProfilesDefault[self._current_profile_name])

	self:reload_current_profile()
end

function OutfitEditorProfileMenuPage:profile_name_updated()
	self._profile_info:set_active(true)
	self._profile_info:load(self._current_profile_copy)

	local items = self._item_groups.item_list
	local options = OutfitHelper.outfit_editor_character_profiles_options()

	for _, item in ipairs(items) do
		local profile_index = item.config.on_select_args[1]

		if profile_index then
			local profile_name = options[profile_index].value

			item:set_text(profile_name)
		end
	end
end

function OutfitEditorProfileMenuPage:save_profile()
	PlayerProfiles[self._current_profile_name] = self._current_profile_copy

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_profiles_saved"))
	Managers.state.event:trigger("event_save_started", "menu_saving_profile", "menu_profile_saved")
end

function OutfitEditorProfileMenuPage:cb_profiles_saved(info)
	if info.error then
		Application.warning("Save error %q", info.error)
	end

	Managers.state.event:trigger("event_save_finished")
end

function OutfitEditorProfileMenuPage:_update_wielded_gear(profile_table)
	profile_table.wielded_gear = {}

	self:_check_has_wielded_gear(profile_table)
	self:_check_complementing_wielded_gear(profile_table)
end

function OutfitEditorProfileMenuPage:_unwield_slots_on_wield(profile_table, wielded_gear_name)
	local wielded_gear_type = wielded_gear_name and Gear[wielded_gear_name].gear_type
	local unwield_slots_on_wield = wielded_gear_type and GearTypes[wielded_gear_type].unwield_slots_on_wield
	local unwield_slot_exception_gear_types = wielded_gear_type and GearTypes[wielded_gear_type].unwield_slot_exception_gear_types

	if unwield_slots_on_wield then
		for i = #profile_table.wielded_gear, 1, -1 do
			local wielded_gear = Gear[profile_table.wielded_gear[i].name]
			local wielded_gear_slot = GearTypes[wielded_gear.gear_type].inventory_slot

			if table.contains(unwield_slots_on_wield, wielded_gear_slot) and not unwield_slot_exception_gear_types[wielded_gear.gear_type] then
				table.remove(profile_table.wielded_gear, i)
			end
		end
	end
end

function OutfitEditorProfileMenuPage:_check_has_wielded_gear(profile_table)
	if not ProfileHelper:find_gear_by_slot(profile_table.wielded_gear, "two_handed_weapon") and not ProfileHelper:find_gear_by_slot(profile_table.wielded_gear, "one_handed_weapon") and not ProfileHelper:find_gear_by_slot(profile_table.wielded_gear, "dagger") then
		local fallback_gear
		local two_handed_weapon = ProfileHelper:find_gear_by_slot(profile_table.gear, "two_handed_weapon")

		if two_handed_weapon and not ProfileHelper:find_gear_by_slot(profile_table.wielded_gear, "shield") and (Gear[two_handed_weapon.name].gear_type ~= "lance" or profile_table.mount) then
			fallback_gear = two_handed_weapon
		elseif ProfileHelper:find_gear_by_slot(profile_table.gear, "one_handed_weapon") then
			fallback_gear = ProfileHelper:find_gear_by_slot(profile_table.gear, "one_handed_weapon")
		else
			fallback_gear = ProfileHelper:find_gear_by_slot(profile_table.gear, "dagger")
		end

		profile_table.wielded_gear[#profile_table.wielded_gear + 1] = {
			name = fallback_gear.name
		}
	end
end

function OutfitEditorProfileMenuPage:_check_complementing_wielded_gear(profile_table)
	if #profile_table.wielded_gear == 1 then
		local solo_gear = profile_table.wielded_gear[1]
		local complementing_gear = ProfileHelper:find_complementing_gear(solo_gear.name, profile_table.gear)

		if complementing_gear then
			profile_table.wielded_gear[#profile_table.wielded_gear + 1] = {
				name = complementing_gear.name
			}
		end
	end
end

function OutfitEditorProfileMenuPage:render_from_child_page(dt, t, leef)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._profile_info:render(dt, t, self._gui, layout_settings.profile_info)
	self._profile_viewer:render(dt, t, self._gui, layout_settings.profile_viewer)
	self._xp_progress_bar_container:render(dt, t, self._gui, layout_settings.xp_progress_bar)

	if self._center_items_container then
		self._center_items_container:render(dt, t, self._gui, layout_settings.center_items)
	end

	self.config.parent_page:render_from_child_page(dt, t, leef or self)
end

function OutfitEditorProfileMenuPage:destroy()
	OutfitEditorProfileMenuPage.super.destroy(self)

	if self._profile_viewer then
		self._profile_viewer:destroy()

		self._profile_viewer = nil
	end

	if self._slots_page then
		self._slots_page:destroy()

		self._slots_page = nil
	end
end

function OutfitEditorProfileMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "outfit_editor",
		parent_page = parent_page,
		callback_object = callback_object,
		viewport_name = compiler_data.menu_data.viewport_name,
		on_enter_highlight_item = page_config.on_enter_highlight_item,
		on_option_changed = page_config.on_option_changed,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		on_cancel_exit_callback_object = page_config.on_cancel_exit_callback_object,
		on_cancel_exit = page_config.on_cancel_exit,
		on_cancel_exit_args = page_config.on_cancel_exit_args,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return OutfitEditorProfileMenuPage:new(config, item_groups, compiler_data.world)
end
