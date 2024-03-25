-- chunkname: @scripts/menu/menu_definitions/character_sheet_page_definition.lua

require("scripts/menu/menu_definitions/main_menu_settings_1920")
require("scripts/menu/menu_definitions/main_menu_settings_1366")
require("scripts/menu/menu_definitions/main_menu_settings_low")
require("scripts/menu/menu_definitions/main_menu_definition")
require("scripts/menu/menu_definitions/server_browser_page_definition")
require("scripts/menu/menu_definitions/character_sheet_page_settings_1920")
require("scripts/menu/menu_definitions/character_sheet_page_settings_1366")

CharacterSheetSkillsItems = {}

local num_columns = 6
local num_rows = 15

for i = 1, num_rows * num_columns do
	if i % num_columns == 1 then
		CharacterSheetSkillsItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			layout_settings = CharacterSheetSettings.items.list_text_first_column
		}
	elseif i % 2 == 0 then
		CharacterSheetSkillsItems[i] = {
			disabled = true,
			type = "TextureMenuItem",
			layout_settings = CharacterSheetSettings.items.column_delimiter_texture
		}
	else
		CharacterSheetSkillsItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			layout_settings = CharacterSheetSettings.items.list_text
		}
	end
end

CharacterSheetWeaponItems = {}

local num_columns = 10
local num_rows = 4

for i = 1, num_rows * num_columns do
	local row = math.ceil(i / num_columns)
	local column = (i - 1) % num_columns + 1

	if i % num_columns == 1 then
		CharacterSheetWeaponItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "weapon_name_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text_first_column
		}
	elseif column == 3 then
		CharacterSheetWeaponItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "weapon_spd_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	elseif column == 5 then
		CharacterSheetWeaponItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "weapon_dmg_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	elseif column == 7 then
		CharacterSheetWeaponItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "weapon_rng_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	elseif column == 9 then
		CharacterSheetWeaponItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "weapon_enc_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	else
		CharacterSheetWeaponItems[i] = {
			disabled = true,
			type = "TextureMenuItem",
			layout_settings = CharacterSheetSettings.items.column_delimiter_texture
		}
	end
end

CharacterSheetArmourItems = {}

local num_columns = 8
local num_rows = 2

for i = 1, num_rows * num_columns do
	local row = math.ceil(i / num_columns)
	local column = (i - 1) % num_columns + 1

	if i % num_columns == 1 then
		CharacterSheetArmourItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "armour_name_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text_first_column
		}
	elseif column == 3 then
		CharacterSheetArmourItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "armour_abs_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	elseif column == 5 then
		CharacterSheetArmourItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "armour_pen_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	elseif column == 7 then
		CharacterSheetArmourItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "armour_enc_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	else
		CharacterSheetArmourItems[i] = {
			disabled = true,
			type = "TextureMenuItem",
			layout_settings = CharacterSheetSettings.items.column_delimiter_texture
		}
	end
end

CharacterSheetModificationItems = {}

local num_columns = 4
local num_rows = 13

for i = 1, num_rows * num_columns do
	local row = math.ceil(i / num_columns)

	if i % num_columns == 1 then
		CharacterSheetModificationItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "modification_name_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text_first_column
		}
	elseif i % 2 == 0 then
		CharacterSheetModificationItems[i] = {
			disabled = true,
			type = "TextureMenuItem",
			layout_settings = CharacterSheetSettings.items.column_delimiter_texture
		}
	else
		CharacterSheetModificationItems[i] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = "modification_value_" .. row,
			layout_settings = CharacterSheetSettings.items.list_text
		}
	end
end

CharacterSheetPageDefinition = {
	text = "main_menu_character_sheet",
	type = "TextMenuItem",
	disabled = GameSettingsDevelopment.disable_character_sheet,
	layout_settings = MainMenuSettings.items.text_right_aligned,
	page = {
		z = 50,
		type = "CharacterSheetMenuPage",
		layout_settings = CharacterSheetSettings.pages.character_sheet,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			user_name = {
				{
					text = "",
					disabled = true,
					on_enter_text = "cb_user_name_with_title",
					type = "TextMenuItem",
					no_localization = true,
					callback_object = "page",
					layout_settings = CharacterSheetSettings.items.user_name
				}
			},
			character_selection = {
				{
					callback_object = "page",
					on_enter_text = "cb_profile_drop_down_list_text",
					type = "DropDownListMenuItem",
					layout_settings = CharacterSheetSettings.items.ddl_closed_text,
					page = {
						on_enter_options = "cb_profile_options",
						z = 100,
						type = "DropDownListMenuPage",
						on_option_changed = "cb_profile_option_changed",
						callback_object = "parent_page",
						layout_settings = CharacterSheetSettings.pages.ddl,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				}
			},
			title_selection = {
				{
					callback_object = "page",
					on_enter_text = "cb_title_drop_down_list_text",
					type = "DropDownListMenuItem",
					layout_settings = CharacterSheetSettings.items.ddl_closed_text,
					page = {
						on_enter_options = "cb_title_options",
						z = 100,
						type = "DropDownListMenuPage",
						on_option_changed = "cb_title_option_changed",
						callback_object = "parent_page",
						layout_settings = CharacterSheetSettings.pages.ddl,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				}
			},
			perk_header = {
				{
					text = "menu_perks_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_first_column
				}
			},
			skill_header = {
				{
					text = "menu_skills",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_first_column
				},
				{
					text = "AAA",
					no_localization = true,
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header
				},
				{
					text = "BBB",
					no_localization = true,
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header
				}
			},
			skill_items = CharacterSheetSkillsItems,
			weapon_header = {
				{
					text = "menu_weapons",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_first_column
				},
				{
					text = "menu_spd",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				},
				{
					text = "menu_dmg",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				},
				{
					text = "menu_rng",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				},
				{
					text = "menu_enc",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				}
			},
			weapon_items = CharacterSheetWeaponItems,
			armour_header = {
				{
					text = "menu_armour_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_first_column
				},
				{
					text = "menu_abs",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				},
				{
					text = "menu_pen",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				},
				{
					text = "menu_enc",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				}
			},
			armour_items = CharacterSheetArmourItems,
			modification_header = {
				{
					text = "menu_modifications",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_first_column
				},
				{
					text = "%",
					no_localization = true,
					disabled = true,
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.list_header_narrow
				}
			},
			modification_items = CharacterSheetModificationItems,
			horse_name = {
				{
					text = "",
					disabled = true,
					on_enter_text = "cb_horse_name",
					type = "TextMenuItem",
					no_localization = true,
					callback_object = "page",
					layout_settings = CharacterSheetSettings.items.horse_name_text
				},
				{
					text = "menu_rename_horse",
					type = "TextMenuItem",
					layout_settings = CharacterSheetSettings.items.rename_horse_text,
					page = {
						on_enter_options = "cb_horse_name_popup_enter",
						z = 100,
						type = "PopupMenuPage",
						on_item_selected = "cb_horse_name_popup_item_selected",
						callback_object = "parent_page",
						layout_settings = MainMenuSettings.pages.text_input_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "menu_rename_horse",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									max_text_length = 26,
									name = "horse_name_text_input",
									min_text_length = 3,
									type = "TextInputMenuItem",
									layout_settings = MainMenuSettings.items.popup_input
								}
							},
							button_list = {
								{
									text = "menu_cancel",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close"
									},
									layout_settings = MainMenuSettings.items.popup_button
								},
								{
									disabled_func_args = "cb_horse_name_popup_save_disabled",
									name = "save_button",
									disabled_func = "cb_item_disabled",
									type = "TextureButtonMenuItem",
									on_select = "cb_item_selected",
									text = "menu_ok",
									callback_object = "page",
									on_select_args = {
										"close",
										"save"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				}
			},
			xp_progress_bar = {
				{
					text = "",
					name = "coins",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					callback_object = "page",
					layout_settings = CharacterSheetSettings.items.money_text
				},
				{
					text = "menu_progress_xp",
					name = "xp_progress_bar",
					disabled = true,
					type = "ProgressBarMenuItem",
					callback_object = "page",
					layout_settings = CharacterSheetSettings.items.xp_progress_bar
				}
			}
		}
	}
}
