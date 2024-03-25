-- chunkname: @scripts/menu/menu_pages/character_sheet_menu_page.lua

require("scripts/menu/menu_pages/sheet_menu_page")
require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")
require("scripts/helpers/outfit_helper")

CharacterSheetMenuPage = class(CharacterSheetMenuPage, SheetMenuPage)

function CharacterSheetMenuPage:init(config, item_groups, world)
	CharacterSheetMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._selected_profile = 1

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._user_name_container = ItemListMenuContainer.create_from_config(item_groups.user_name)
	self._character_selection_container = ItemListMenuContainer.create_from_config(item_groups.character_selection)
	self._title_selection_container = ItemListMenuContainer.create_from_config(item_groups.title_selection)
	self._perk_header_container = ItemListMenuContainer.create_from_config(item_groups.perk_header)
	self._perk_offensive = PerkMenuContainer.create_from_config()
	self._perk_defensive = PerkMenuContainer.create_from_config()
	self._perk_supportive = PerkMenuContainer.create_from_config()
	self._perk_movement = PerkMenuContainer.create_from_config()
	self._perk_officer = PerkMenuContainer.create_from_config()
	self._skill_header_container = ItemListMenuContainer.create_from_config(item_groups.skill_header)
	self._skill_items_container = ItemListMenuContainer.create_from_config(item_groups.skill_items)
	self._weapon_header_container = ItemListMenuContainer.create_from_config(item_groups.weapon_header)
	self._weapon_items_container = ItemListMenuContainer.create_from_config(item_groups.weapon_items)
	self._armour_header_container = ItemListMenuContainer.create_from_config(item_groups.armour_header)
	self._armour_items_container = ItemListMenuContainer.create_from_config(item_groups.armour_items)
	self._modification_header_container = ItemListMenuContainer.create_from_config(item_groups.modification_header)
	self._modification_items_container = ItemListMenuContainer.create_from_config(item_groups.modification_items)
	self._xp_progress_bar_container = ItemListMenuContainer.create_from_config(item_groups.xp_progress_bar)
	self._horse_name_container = ItemListMenuContainer.create_from_config(item_groups.horse_name)
	self._split_delimiter_texture_top = TextureMenuContainer.create_from_config()
	self._split_delimiter_texture_outer_left = TextureMenuContainer.create_from_config()
	self._split_delimiter_texture_outer_right = TextureMenuContainer.create_from_config()
	self._split_delimiter_texture_left = TextureMenuContainer.create_from_config()
	self._split_delimiter_texture_right = TextureMenuContainer.create_from_config()
	self._skeleton_texture = TextureMenuContainer.create_from_config()
	self._vertical_line_texture_left = TextureMenuContainer.create_from_config()
	self._vertical_line_texture_right = TextureMenuContainer.create_from_config()
	self._vertical_line_texture_outer_left = TextureMenuContainer.create_from_config()
	self._vertical_line_texture_outer_right = TextureMenuContainer.create_from_config()
	self._background_texture_left = TextureMenuContainer.create_from_config()
	self._background_texture_right = TextureMenuContainer.create_from_config()
end

function CharacterSheetMenuPage:set_input(input)
	if not self._profile_data_loaded then
		return
	end

	CharacterSheetMenuPage.super.set_input(self, input)
end

function CharacterSheetMenuPage:_set_active(active)
	if active then
		self._coat_of_arms_viewer_world = Managers.world:create_world("coat_of_arms_viewer_world", nil, MenuHelper.light_adaption_fix_shading_callback, 5, Application.DISABLE_PHYSICS)
		self._coat_of_arms_viewer_viewport = ScriptWorld.create_viewport(self._coat_of_arms_viewer_world, "coat_of_arms_viewer_viewport", "default", 2)
		self._coat_of_arms_viewer = CoatOfArmsViewerMenuContainer.create_from_config("coat_of_arms_viewer_world", "coat_of_arms_viewer_viewport")

		local level_settings = LevelSettings.character_sheet

		self._coat_of_arms_viewer:load_level(level_settings.level_name)
		self._coat_of_arms_viewer:load_coat_of_arms(PlayerCoatOfArms, 2, -0.1, 0)
	else
		self._coat_of_arms_viewer:destroy()

		self._coat_of_arms_viewer = nil

		Managers.world:destroy_world(self._coat_of_arms_viewer_world)
	end
end

function CharacterSheetMenuPage:on_enter(on_cancel)
	CharacterSheetMenuPage.super.on_enter(self, on_cancel)

	if not on_cancel then
		self:_set_active(true)
		self:_load_selected_profile()
		Managers.state.event:trigger("event_load_started", "menu_loading_profile", "menu_profile_loaded")
		Managers.persistence:load_profile(callback(self, "cb_profile_loaded"))

		self._profile_data_loaded = false
	end
end

function CharacterSheetMenuPage:on_exit(on_cancel)
	CharacterSheetMenuPage.super.on_exit(self, on_cancel)

	if on_cancel then
		self:_set_active(false)
	end
end

function CharacterSheetMenuPage:_load_selected_profile()
	local profile = PlayerProfiles[self._selected_profile]

	self:_load_perks(profile)
	self:_load_weapon_stats(profile)
	self:_load_armour_stats(profile)
	self:_load_modifications(profile)
end

function CharacterSheetMenuPage:_load_perks(profile)
	self._perk_offensive:load(profile, "offensive")
	self._perk_defensive:load(profile, "defensive")
	self._perk_supportive:load(profile, "supportive")
	self._perk_movement:load(profile, "movement")
	self._perk_officer:load(profile, "officer")
end

function CharacterSheetMenuPage:_clear_item_texts(item_group)
	for i, item in ipairs(self:items_in_group(item_group)) do
		if item.config.type == "text" then
			item:set_text("")
		end
	end
end

function CharacterSheetMenuPage:_load_weapon_stats(profile)
	self:_clear_item_texts("weapon_items")

	local gear_table = {}

	gear_table[#gear_table + 1] = ProfileHelper:find_gear_by_slot(profile.gear, "two_handed_weapon")
	gear_table[#gear_table + 1] = ProfileHelper:find_gear_by_slot(profile.gear, "one_handed_weapon")
	gear_table[#gear_table + 1] = ProfileHelper:find_gear_by_slot(profile.gear, "dagger")
	gear_table[#gear_table + 1] = ProfileHelper:find_gear_by_slot(profile.gear, "shield")

	for i, gear in ipairs(gear_table) do
		local gear_settings = Gear[gear.name]
		local ui_header = gear_settings.ui_header

		self:find_item_by_name("weapon_name_" .. i):set_text(L(ui_header))

		local spd = OutfitHelper.gear_property(gear.name, "speed")
		local spd_text = spd and string.format("%.1f", spd) or L("menu_n_a")

		self:find_item_by_name("weapon_spd_" .. i):set_text(spd_text)

		local dmg = OutfitHelper.gear_property(gear.name, "base_damage")
		local dmg_text = dmg and string.format("%.1f", dmg) or L("menu_n_a")

		self:find_item_by_name("weapon_dmg_" .. i):set_text(dmg_text)

		local reach = OutfitHelper.gear_property(gear.name, "reach")
		local reach_text = reach and string.format("%.1f", reach) or L("menu_n_a")

		self:find_item_by_name("weapon_rng_" .. i):set_text(reach_text)

		local enc = OutfitHelper.gear_property(gear.name, "encumbrance")
		local enc_text = reach and string.format("%.1f", enc) or L("menu_n_a")

		self:find_item_by_name("weapon_enc_" .. i):set_text(string.format("%.1f", enc_text))
	end
end

function CharacterSheetMenuPage:_load_armour_stats(profile)
	self:_clear_item_texts("armour_items")

	local helmet_name = profile.helmet.name
	local helmet = Helmets[helmet_name]
	local ui_header = helmet.ui_header

	self:find_item_by_name("armour_name_1"):set_text(L(ui_header))
	self:find_item_by_name("armour_abs_1"):set_text(string.format("%.1f", helmet.absorption_value))
	self:find_item_by_name("armour_pen_1"):set_text(string.format("%.1f", helmet.penetration_value))
	self:find_item_by_name("armour_enc_1"):set_text(string.format("%.1f", helmet.encumbrance))

	local armour_name = profile.armour
	local armour = Armours[armour_name]
	local ui_header = armour.ui_header

	self:find_item_by_name("armour_name_2"):set_text(L(ui_header))
	self:find_item_by_name("armour_abs_2"):set_text(string.format("%.1f", armour.absorption_value))
	self:find_item_by_name("armour_pen_2"):set_text(string.format("%.1f", armour.penetration_value))
	self:find_item_by_name("armour_enc_2"):set_text(string.format("%.1f", armour.encumbrance))
end

function CharacterSheetMenuPage:_load_modifications(profile)
	self:_clear_item_texts("modification_items")

	local i = 1

	for _, modifier in ipairs(UIPerkModifications) do
		local name = L(modifier.ui_name)
		local value = modifier.modification_func(profile)

		if value ~= 0 then
			self:find_item_by_name("modification_name_" .. i):set_text(name)
			self:find_item_by_name("modification_value_" .. i):set_text(string.format("%.0f", value * 100))

			i = i + 1
		end
	end
end

function CharacterSheetMenuPage:cb_profile_loaded(data)
	Managers.state.event:trigger("event_load_finished")

	self._profile_data_loaded = true

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

function CharacterSheetMenuPage:_update_container_size(dt, t)
	CharacterSheetMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._user_name_container:update_size(dt, t, self._gui, layout_settings.user_name)
	self._character_selection_container:update_size(dt, t, self._gui, layout_settings.character_selection)
	self._title_selection_container:update_size(dt, t, self._gui, layout_settings.title_selection)
	self._perk_header_container:update_size(dt, t, self._gui, layout_settings.perk_header)
	self._perk_offensive:update_size(dt, t, self._gui, layout_settings.perks)
	self._perk_defensive:update_size(dt, t, self._gui, layout_settings.perks)
	self._perk_supportive:update_size(dt, t, self._gui, layout_settings.perks)
	self._perk_movement:update_size(dt, t, self._gui, layout_settings.perks)
	self._perk_officer:update_size(dt, t, self._gui, layout_settings.perks)
	self._skill_header_container:update_size(dt, t, self._gui, layout_settings.skill_header)
	self._skill_items_container:update_size(dt, t, self._gui, layout_settings.skill_items)
	self._weapon_header_container:update_size(dt, t, self._gui, layout_settings.weapon_header)
	self._weapon_items_container:update_size(dt, t, self._gui, layout_settings.weapon_items)
	self._armour_header_container:update_size(dt, t, self._gui, layout_settings.armour_header)
	self._armour_items_container:update_size(dt, t, self._gui, layout_settings.armour_items)
	self._modification_header_container:update_size(dt, t, self._gui, layout_settings.modification_header)
	self._modification_items_container:update_size(dt, t, self._gui, layout_settings.modification_items)
	self._xp_progress_bar_container:update_size(dt, t, self._gui, layout_settings.xp_progress_bar)
	self._horse_name_container:update_size(dt, t, self._gui, layout_settings.horse_name)
	self._split_delimiter_texture_top:update_size(dt, t, self._gui, layout_settings.split_delimiter_texture_top)
	self._split_delimiter_texture_outer_left:update_size(dt, t, self._gui, layout_settings.split_delimiter_texture_outer_left)
	self._split_delimiter_texture_outer_right:update_size(dt, t, self._gui, layout_settings.split_delimiter_texture_outer_right)
	self._split_delimiter_texture_left:update_size(dt, t, self._gui, layout_settings.split_delimiter_texture_left)
	self._split_delimiter_texture_right:update_size(dt, t, self._gui, layout_settings.split_delimiter_texture_right)
	self._skeleton_texture:update_size(dt, t, self._gui, layout_settings.skeleton_texture)
	self._vertical_line_texture_left:update_size(dt, t, self._gui, layout_settings.vertical_line_texture_left)
	self._vertical_line_texture_right:update_size(dt, t, self._gui, layout_settings.vertical_line_texture_right)
	self._vertical_line_texture_outer_left:update_size(dt, t, self._gui, layout_settings.vertical_line_texture_outer_left)
	self._vertical_line_texture_outer_right:update_size(dt, t, self._gui, layout_settings.vertical_line_texture_outer_right)
	self._background_texture_left:update_size(dt, t, self._gui, layout_settings.background_texture_left)
	self._background_texture_right:update_size(dt, t, self._gui, layout_settings.background_texture_right)
	self._coat_of_arms_viewer:update_size(dt, t, self._gui, layout_settings.coat_of_arms_viewer)
end

function CharacterSheetMenuPage:_update_container_position(dt, t)
	CharacterSheetMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._user_name_container, layout_settings.user_name)

	self._user_name_container:update_position(dt, t, layout_settings.user_name, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._character_selection_container, layout_settings.character_selection)

	self._character_selection_container:update_position(dt, t, layout_settings.character_selection, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._title_selection_container, layout_settings.title_selection)

	self._title_selection_container:update_position(dt, t, layout_settings.title_selection, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._perk_header_container, layout_settings.perk_header)

	self._perk_header_container:update_position(dt, t, layout_settings.perk_header, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._perk_offensive, layout_settings.perks)

	self._perk_offensive:update_position(dt, t, layout_settings.perks, x, y, self.config.z + 5)

	local perk_offset_y = -(self._perk_offensive:basic_perk() and self._perk_offensive:height() + 20 or 0)

	self._perk_defensive:update_position(dt, t, layout_settings.perks, x, y + perk_offset_y, self.config.z + 5)

	perk_offset_y = perk_offset_y - (self._perk_defensive:basic_perk() and self._perk_defensive:height() + 20 or 0)

	self._perk_supportive:update_position(dt, t, layout_settings.perks, x, y + perk_offset_y, self.config.z + 5)

	perk_offset_y = perk_offset_y - (self._perk_supportive:basic_perk() and self._perk_supportive:height() + 20 or 0)

	self._perk_movement:update_position(dt, t, layout_settings.perks, x, y + perk_offset_y, self.config.z + 5)

	perk_offset_y = perk_offset_y - (self._perk_movement:basic_perk() and self._perk_movement:height() + 20 or 0)

	self._perk_officer:update_position(dt, t, layout_settings.perks, x, y + perk_offset_y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._skill_header_container, layout_settings.skill_header)

	self._skill_header_container:update_position(dt, t, layout_settings.skill_header, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._skill_items_container, layout_settings.skill_items)

	self._skill_items_container:update_position(dt, t, layout_settings.skill_items, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._weapon_header_container, layout_settings.weapon_header)

	self._weapon_header_container:update_position(dt, t, layout_settings.weapon_header, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._weapon_items_container, layout_settings.weapon_items)

	self._weapon_items_container:update_position(dt, t, layout_settings.weapon_items, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._armour_header_container, layout_settings.armour_header)

	self._armour_header_container:update_position(dt, t, layout_settings.armour_header, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._armour_items_container, layout_settings.armour_items)

	self._armour_items_container:update_position(dt, t, layout_settings.armour_items, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._modification_header_container, layout_settings.modification_header)

	self._modification_header_container:update_position(dt, t, layout_settings.modification_header, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._modification_items_container, layout_settings.modification_items)

	self._modification_items_container:update_position(dt, t, layout_settings.modification_items, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._xp_progress_bar_container, layout_settings.xp_progress_bar)

	self._xp_progress_bar_container:update_position(dt, t, layout_settings.xp_progress_bar, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._horse_name_container, layout_settings.horse_name)

	self._horse_name_container:update_position(dt, t, layout_settings.horse_name, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._split_delimiter_texture_top, layout_settings.split_delimiter_texture_top)

	self._split_delimiter_texture_top:update_position(dt, t, layout_settings.split_delimiter_texture_top, x, y, self.config.z + 1)

	local x, y = MenuHelper:container_position(self._split_delimiter_texture_outer_left, layout_settings.split_delimiter_texture_outer_left)

	self._split_delimiter_texture_outer_left:update_position(dt, t, layout_settings.split_delimiter_texture_outer_left, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._split_delimiter_texture_outer_right, layout_settings.split_delimiter_texture_outer_right)

	self._split_delimiter_texture_outer_right:update_position(dt, t, layout_settings.split_delimiter_texture_outer_right, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._split_delimiter_texture_left, layout_settings.split_delimiter_texture_left)

	self._split_delimiter_texture_left:update_position(dt, t, layout_settings.split_delimiter_texture_left, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._split_delimiter_texture_right, layout_settings.split_delimiter_texture_right)

	self._split_delimiter_texture_right:update_position(dt, t, layout_settings.split_delimiter_texture_right, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._skeleton_texture, layout_settings.skeleton_texture)

	self._skeleton_texture:update_position(dt, t, layout_settings.skeleton_texture, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._vertical_line_texture_left, layout_settings.vertical_line_texture_left)

	self._vertical_line_texture_left:update_position(dt, t, layout_settings.vertical_line_texture_left, x, y, self.config.z + 3)

	local x, y = MenuHelper:container_position(self._vertical_line_texture_right, layout_settings.vertical_line_texture_right)

	self._vertical_line_texture_right:update_position(dt, t, layout_settings.vertical_line_texture_right, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._vertical_line_texture_outer_left, layout_settings.vertical_line_texture_outer_left)

	self._vertical_line_texture_outer_left:update_position(dt, t, layout_settings.vertical_line_texture_outer_left, x, y, self.config.z + 3)

	local x, y = MenuHelper:container_position(self._vertical_line_texture_outer_right, layout_settings.vertical_line_texture_outer_right)

	self._vertical_line_texture_outer_right:update_position(dt, t, layout_settings.vertical_line_texture_outer_right, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._background_texture_left, layout_settings.background_texture_left)

	self._background_texture_left:update_position(dt, t, layout_settings.background_texture_left, x, y, self.config.z + 1)

	local x, y = MenuHelper:container_position(self._background_texture_right, layout_settings.background_texture_right)

	self._background_texture_right:update_position(dt, t, layout_settings.background_texture_right, x, y, self.config.z + 1)

	local x, y = MenuHelper:container_position(self._coat_of_arms_viewer, layout_settings.coat_of_arms_viewer)

	self._coat_of_arms_viewer:update_position(dt, t, layout_settings.coat_of_arms_viewer, x, y, self.config.z + 5)
end

function CharacterSheetMenuPage:render(dt, t)
	CharacterSheetMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._user_name_container:render(dt, t, self._gui, layout_settings.user_name)
	self._character_selection_container:render(dt, t, self._gui, layout_settings.character_selection)
	self._title_selection_container:render(dt, t, self._gui, layout_settings.title_selection)
	self._perk_header_container:render(dt, t, self._gui, layout_settings.perk_header)
	self._perk_offensive:render(dt, t, self._gui, layout_settings.perks)
	self._perk_defensive:render(dt, t, self._gui, layout_settings.perks)
	self._perk_supportive:render(dt, t, self._gui, layout_settings.perks)
	self._perk_movement:render(dt, t, self._gui, layout_settings.perks)
	self._perk_officer:render(dt, t, self._gui, layout_settings.perks)
	self._skill_header_container:render(dt, t, self._gui, layout_settings.skill_header)
	self._skill_items_container:render(dt, t, self._gui, layout_settings.skill_items)
	self._weapon_header_container:render(dt, t, self._gui, layout_settings.weapon_header)
	self._weapon_items_container:render(dt, t, self._gui, layout_settings.weapon_items)
	self._armour_header_container:render(dt, t, self._gui, layout_settings.armour_header)
	self._armour_items_container:render(dt, t, self._gui, layout_settings.armour_items)
	self._modification_header_container:render(dt, t, self._gui, layout_settings.modification_header)
	self._modification_items_container:render(dt, t, self._gui, layout_settings.modification_items)
	self._xp_progress_bar_container:render(dt, t, self._gui, layout_settings.xp_progress_bar)
	self._horse_name_container:render(dt, t, self._gui, layout_settings.horse_name)
	self._split_delimiter_texture_top:render(dt, t, self._gui, layout_settings.split_delimiter_texture_top)
	self._split_delimiter_texture_outer_left:render(dt, t, self._gui, layout_settings.split_delimiter_texture_outer_left)
	self._split_delimiter_texture_outer_right:render(dt, t, self._gui, layout_settings.split_delimiter_texture_outer_right)
	self._split_delimiter_texture_left:render(dt, t, self._gui, layout_settings.split_delimiter_texture_left)
	self._split_delimiter_texture_right:render(dt, t, self._gui, layout_settings.split_delimiter_texture_right)
	self._skeleton_texture:render(dt, t, self._gui, layout_settings.skeleton_texture)
	self._vertical_line_texture_left:render(dt, t, self._gui, layout_settings.vertical_line_texture_left)
	self._vertical_line_texture_right:render(dt, t, self._gui, layout_settings.vertical_line_texture_right)
	self._vertical_line_texture_outer_left:render(dt, t, self._gui, layout_settings.vertical_line_texture_outer_left)
	self._vertical_line_texture_outer_right:render(dt, t, self._gui, layout_settings.vertical_line_texture_outer_right)
	self._background_texture_left:render(dt, t, self._gui, layout_settings.background_texture_left)
	self._background_texture_right:render(dt, t, self._gui, layout_settings.background_texture_right)
	self._coat_of_arms_viewer:render(dt, t, self._gui, layout_settings.coat_of_arms_viewer)
end

function CharacterSheetMenuPage:destroy()
	CharacterSheetMenuPage.super.destroy(self)

	if self._coat_of_arms_viewer then
		self._coat_of_arms_viewer:destroy()

		self._coat_of_arms_viewer = nil

		Managers.world:destroy_world(self._coat_of_arms_viewer_world)
	end
end

function CharacterSheetMenuPage:_user_name()
	return GameSettingsDevelopment.network_mode == "steam" and not Application.settings().dedicated_server and Steam.user_name() or "[no name]"
end

function CharacterSheetMenuPage:_save_title()
	SaveData.player_coat_of_arms = PlayerCoatOfArms

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_title_saved"))
	Managers.state.event:trigger("event_save_started", "menu_saving_profile", "menu_profile_saved")
end

function CharacterSheetMenuPage:_save_horse_name()
	SaveData.profiles = PlayerProfiles

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_horse_name_saved"))
	Managers.state.event:trigger("event_save_started", "menu_saving_profile", "menu_profile_saved")
end

function CharacterSheetMenuPage:cb_title_saved(info)
	if info.error then
		Application.warning("Save error %q", info.error)
	end

	Managers.state.event:trigger("event_save_finished")
end

function CharacterSheetMenuPage:cb_horse_name_saved(info)
	if info.error then
		Application.warning("Save error %q", info.error)
	end

	Managers.state.event:trigger("event_save_finished")
end

function CharacterSheetMenuPage:cb_user_name_with_title()
	for index, title in ipairs(PlayerTitles) do
		if title.name == PlayerCoatOfArms.title then
			return string.format(L(title.format_string), self:_user_name())
		end
	end
end

function CharacterSheetMenuPage:cb_profile_drop_down_list_text()
	return "", PlayerProfiles[self._selected_profile].display_name
end

function CharacterSheetMenuPage:cb_profile_options()
	local options = {}

	for index, profile in ipairs(PlayerProfiles) do
		options[#options + 1] = {
			key = index,
			value = profile.display_name
		}
	end

	return options, self._selected_profile
end

function CharacterSheetMenuPage:cb_profile_option_changed(option)
	self._selected_profile = option.key

	self:_load_selected_profile()
end

function CharacterSheetMenuPage:cb_title_drop_down_list_text()
	for index, title in ipairs(PlayerTitles) do
		if title.name == PlayerCoatOfArms.title then
			return L("title") .. ": ", L(title.ui_name)
		end
	end
end

function CharacterSheetMenuPage:cb_title_options(option)
	local options = {}
	local selected_option = 1

	for index, title in ipairs(PlayerTitles) do
		options[#options + 1] = {
			key = title.name,
			value = L(title.ui_name)
		}

		if title.ui_name == PlayerCoatOfArms.title then
			selected_option = index
		end
	end

	return options, selected_option
end

function CharacterSheetMenuPage:cb_title_option_changed(option)
	PlayerCoatOfArms.title = option.key

	self:_save_title()
end

function CharacterSheetMenuPage:cb_horse_name()
	return PlayerProfiles[self._selected_profile].mount_name or L("menu_horse_name")
end

function CharacterSheetMenuPage:cb_horse_name_popup_enter(args)
	local input_text = PlayerProfiles[self._selected_profile].mount_name or ""

	args.popup_page:find_item_by_name("horse_name_text_input"):set_text(input_text)
end

function CharacterSheetMenuPage:cb_horse_name_popup_item_selected(args)
	if args.action == "save" then
		local input_text = args.popup_page:find_item_by_name("horse_name_text_input"):text()

		PlayerProfiles[self._selected_profile].mount_name = input_text

		self:_save_horse_name()
	end
end

function CharacterSheetMenuPage:cb_horse_name_popup_save_disabled(args)
	local input_text_item = args.popup_page:find_item_by_name("horse_name_text_input")

	if not input_text_item:validate_text_length() then
		return true
	end
end

function CharacterSheetMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "character_sheet",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return CharacterSheetMenuPage:new(config, item_groups, compiler_data.world)
end
