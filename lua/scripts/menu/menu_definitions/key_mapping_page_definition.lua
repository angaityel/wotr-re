-- chunkname: @scripts/menu/menu_definitions/key_mapping_page_definition.lua

require("scripts/menu/menu_definitions/key_mapping_page_settings_1920")
require("scripts/menu/menu_definitions/key_mapping_page_settings_1366")

local page_settings = KeyMappingPageDefinition.page_settings
local item_page_settings = KeyMappingPageDefinition.item_page_settings
local key_map_item_settings = KeyMappingPageDefinition.key_map_item_settings
local delimiter_item_settings = KeyMappingPageDefinition.delimiter_item_settings
local definition = definition or {
	text = "menu_key_mapping",
	type = "TextMenuItem",
	disabled = GameSettingsDevelopment.disable_key_mappings,
	layout_settings = MainMenuSettings.items.text_right_aligned,
	page = {
		z = 150,
		show_revision = true,
		type = "KeyMappingsMenuPage",
		layout_settings = page_settings,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			item_list_header = {},
			item_list_scroll = {},
			item_list = {
				{
					text = "menu_key_move_forward",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"move_forward",
						"mount_cruise_control_gear_up"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_move_back",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"move_back",
						"mount_cruise_control_gear_down"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_move_left",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"move_left",
						"mount_move_left"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_move_right",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"move_right",
						"mount_move_right"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_jump",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"jump"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_crouch",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"crouch"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_rush",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"rush",
						"rush_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_melee_swing",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"melee_swing",
						"melee_pose",
						"ranged_weapon_fire",
						"couch_lance"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_shield_bash",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"shield_bash_pose",
						"shield_bash_initiate"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_push",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"push"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_one_handed_weapon",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_one_handed_weapon"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_two_handed_weapon",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_two_handed_weapon"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_dagger",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_dagger"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_shield",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_shield"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_block",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"block",
						"raise_block",
						"lower_block",
						"ranged_weapon_aim"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_bandage",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"bandage",
						"bandage_start"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_interact",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"interact",
						"interacting"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_switch_weapon_grip",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"switch_weapon_grip"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_scoreboard",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"scoreboard"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_chat",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_chat_input_all"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_team_chat",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_chat_input_team"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_last_chat",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_chat_input"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_officer_buff_one",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"officer_buff_one"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_officer_buff_two",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"officer_buff_two"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_tag",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_tag"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_call_horse",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"call_horse",
						"call_horse_released"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_hold_breath",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"hold_breath"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_ranged_zoom",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"ranged_weapon_zoom"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_toggle_visor",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"toggle_visor"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_mounted_charge",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"mounted_charge",
						"mounted_charge_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_vote_yes",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"vote_yes"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_vote_no",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"vote_no"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_mount_move_forward",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"mount_move_forward_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_mount_move_back",
					remove_func = "cb_controller_enabled",
					type = "KeyMappingMenuItem",
					keys = {
						"mount_move_back_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					remove_func = "cb_controller_enabled",
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = delimiter_item_settings
				},
				{
					remove_func = "cb_controller_enabled",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "main_menu_apply_settings",
					on_select = "cb_apply_key_mappings",
					disabled_func = "cb_apply_changes_disabled",
					type = "TextMenuItem",
					remove_func = "cb_controller_enabled",
					callback_object = "page",
					layout_settings = MainMenuSettings.items.text_left_aligned
				},
				{
					remove_func = "cb_controller_enabled",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_reset",
					on_select = "cb_reset",
					type = "TextMenuItem",
					remove_func = "cb_controller_enabled",
					callback_object = "page",
					layout_settings = MainMenuSettings.items.text_left_aligned
				},
				{
					remove_func = "cb_controller_enabled",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "main_menu_cancel",
					on_select = "cb_cancel",
					type = "TextMenuItem",
					remove_func = "cb_controller_enabled",
					callback_object = "page",
					layout_settings = MainMenuSettings.items.text_left_aligned
				},
				{
					remove_func = "cb_controller_enabled",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_key_jump",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"jump"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_crouch",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"crouch"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_rush",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"rush",
						"rush_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_melee_swing",
					static_prefix = "right_thumb",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"melee_swing",
						"melee_pose",
						"ranged_weapon_fire",
						"couch_lance"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_shield_bash",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"shield_bash_pose",
						"shield_bash_initiate"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_push",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"push"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_one_handed_weapon",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_one_handed_weapon"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_two_handed_weapon",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_two_handed_weapon"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_dagger",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_dagger"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_wield_shield",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"wield_shield"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_block",
					static_prefix = "right_thumb",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"block",
						"raise_block",
						"lower_block",
						"ranged_weapon_aim"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_bandage",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"bandage",
						"bandage_start"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_interact",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"interact",
						"interacting"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_scoreboard",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"scoreboard"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_mounted_charge",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"mounted_charge",
						"mounted_charge_pressed"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_tag",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_tag"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_hold_breath",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"hold_breath"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_ranged_zoom",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"ranged_weapon_zoom"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"shift_function"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_switch_weapon_grip",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"toggle_visor"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					remove_func = "cb_controller_disabled",
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = delimiter_item_settings
				},
				{
					remove_func = "cb_controller_disabled",
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = delimiter_item_settings
				},
				{
					text = "menu_key_officer_buff_one",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"officer_buff_one"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_officer_buff_two",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"officer_buff_two"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_call_horse",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"call_horse",
						"call_horse_released"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_toggle_visor",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"switch_weapon_grip"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_vote_yes",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"vote_yes"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_vote_no",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"vote_no"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_zoom_in",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"zoom_in"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_zoom_out",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"zoom_out"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				},
				{
					text = "menu_key_chat",
					prefix = "menu_key_shift_function",
					remove_func = "cb_controller_disabled",
					type = "KeyMappingMenuItem",
					keys = {
						"activate_chat_input_all"
					},
					layout_settings = key_map_item_settings,
					page = {
						render_parent_page = true,
						z = 200,
						type = "KeyMappingPadMenuPage",
						layout_settings = item_page_settings,
						sounds = MenuSettings.sounds.default,
						item_groups = {}
					}
				}
			}
		}
	}
}

KeyMappingPageDefinition.main_menu_definition = definition
KeyMappingPageDefinition.ingame_menu_definition = definition
