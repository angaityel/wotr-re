-- chunkname: @scripts/menu/menu_definitions/battle_report_page_definition.lua

require("scripts/settings/menu_settings")
require("scripts/menu/menu_definitions/scoreboard_definition")
require("scripts/menu/menu_definitions/character_sheet_page_settings_1920")
require("scripts/menu/menu_definitions/character_sheet_page_settings_1366")
require("scripts/menu/menu_definitions/battle_report_page_settings_1920")
require("scripts/menu/menu_definitions/battle_report_page_settings_1366")
require("scripts/menu/menu_definitions/squad_menu_settings_1920")
require("scripts/menu/menu_definitions/squad_menu_settings_1366")

BattleReportScoreboardPageDefinition = {
	id = "battle_report_scoreboard",
	type = "EmptyMenuItem",
	page = {
		z = 10,
		type = "BattleReportScoreboardMenuPage",
		music_events = {
			on_page_enter = {
				{
					event = "Play_battlereport_music",
					play_once = true
				}
			}
		},
		layout_settings = BattleReportSettings.pages.scoreboard,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			header_items = {
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.header_delimiter_top
				},
				{
					text = "menu_battle_report",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = BattleReportSettings.items.header
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.header_delimiter_bottom
				},
				{
					text = "",
					name = "countdown",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = BattleReportSettings.items.countdown
				}
			},
			scoreboard_headers = {
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_delimiter
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					no_localization = true,
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_score_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_kills_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_deaths_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_cap_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_cap_assists_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_delimiter
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			scoreboard_items = {},
			scoreboard_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_scoreboard_scroll_select_down",
					disabled_func = "cb_scoreboard_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_scroll_bar
				}
			},
			player_details_header = ScoreboardPlayerDetailHeader,
			player_details = ScoreboardPlayerDetailItems,
			page_links = {
				{
					text = "menu_summary",
					name = "next_page_link",
					on_select = "cb_goto_menu_page",
					type = "TextureButtonMenuItem",
					callback_object = "page",
					on_select_args = {
						"battle_report_summary"
					},
					layout_settings = SquadMenuSettings.items.next_button
				}
			}
		}
	}
}
BattleReportSummaryPageDefinition = {
	id = "battle_report_summary",
	type = "EmptyMenuItem",
	page = {
		z = 10,
		type = "BattleReportSummaryMenuPage",
		layout_settings = BattleReportSettings.pages.summary,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			header_items = {
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.header_delimiter_top
				},
				{
					text = "menu_battle_report",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = BattleReportSettings.items.header
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.header_delimiter_bottom
				},
				{
					text = "",
					name = "countdown",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = BattleReportSettings.items.countdown
				}
			},
			summary_headers = {
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_delimiter
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					no_localization = true,
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_spoils_of_war",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "#",
					no_localization = true,
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_progress_xp",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_coins",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					text = "menu_awards_upper",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_text
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_header_delimiter
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			summary_items = {
				{
					header = "battle_summary_damage",
					name = "enemy_damage",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_enemy_knockdown",
					name = "enemy_knockdown",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_insta_kill",
					name = "enemy_instakill",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_execution",
					name = "execution",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_revive",
					name = "revive",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_kill_assist",
					name = "assist",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_successive_kill",
					name = "successive_kill",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_squad_spawn",
					name = "squad_spawn",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_squad_wipe",
					name = "squad_wipe",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_bandage",
					name = "team_bandage",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_headshot",
					name = "headshot",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_longshot",
					name = "longshot",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_capture",
					name = "objective_captured",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_capture_assist",
					name = "objective_captured_assist",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_tag_kill",
					name = "tag_kill",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_tagger_reward",
					name = "tagger_reward",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_objective_bonus",
					name = "objective_bonus",
					on_increment = "cb_increment_subtotal",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_subtotal",
					name = "sub_total",
					type = "BattleReportSummaryTotalMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					header = "battle_summary_win",
					name = "round_won",
					on_increment = "cb_increment_total",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					text_prefix = "-",
					name = "team_damage",
					header = "battle_summary_team_damage_penalty",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					on_increment = "cb_decrement_total",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					text_prefix = "-",
					name = "team_kill",
					header = "battle_summary_team_kill_penalty",
					type = "BattleReportSummaryMenuItem",
					on_finished = "cb_start_next_summary_item",
					on_increment = "cb_decrement_total",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary
				},
				{
					text_prefix = "-",
					name = "demo_penalty",
					header = "battle_summary_demo_penalty",
					type = "BattleReportSummaryMenuItem",
					remove_func = "cb_is_not_demo",
					on_increment = "cb_decrement_total",
					on_finished = "cb_start_next_summary_item",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary_demo
				},
				{
					header = "battle_summary_total",
					name = "total",
					type = "BattleReportSummaryTotalMenuItem",
					on_finished = "cb_total_finished",
					callback_object = "page",
					layout_settings = BattleReportSettings.items.summary_total
				}
			},
			awards = {},
			awards_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_awards_scroll_select_down",
					disabled_func = "cb_awards_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = BattleReportSettings.items.scoreboard_scroll_bar
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
					layout_settings = BattleReportSettings.items.xp_progress_bar
				}
			},
			page_links = {
				{
					text = "menu_scoreboard",
					callback_object = "page",
					on_select = "cb_goto_menu_page",
					type = "TextureButtonMenuItem",
					on_select_args = {
						"battle_report_scoreboard"
					},
					layout_settings = SquadMenuSettings.items.previous_button
				},
				{
					text = "menu_close",
					name = "next_page_link",
					on_select = "cb_goto_menu_page",
					type = "TextureButtonMenuItem",
					callback_object = "page",
					on_select_args = {
						"loading_screen"
					},
					layout_settings = SquadMenuSettings.items.next_button
				}
			}
		}
	}
}
BattleReportAwardsPageDefinition = {
	id = "battle_report_awards",
	type = "EmptyMenuItem",
	page = {
		z = 10,
		type = "BattleReportAwardsMenuPage",
		layout_settings = BattleReportSettings.pages.scoreboard,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			header_items = {},
			page_links = {}
		}
	}
}
