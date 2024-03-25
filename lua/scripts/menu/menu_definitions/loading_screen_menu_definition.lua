-- chunkname: @scripts/menu/menu_definitions/loading_screen_menu_definition.lua

require("scripts/settings/menu_settings")
require("scripts/menu/menu_definitions/battle_report_page_definition")
require("scripts/menu/menu_definitions/loading_screen_menu_settings_1920")
require("scripts/menu/menu_definitions/loading_screen_menu_settings_1366")

LoadingScreenMenuDefinition = {
	page = {
		type = "EmptyMenuPage",
		item_groups = {
			item_list = {
				BattleReportScoreboardPageDefinition,
				BattleReportSummaryPageDefinition,
				BattleReportAwardsPageDefinition,
				{
					id = "loading_screen",
					type = "EmptyMenuItem",
					page = {
						z = 10,
						type = "LoadingScreenMenuPage",
						layout_settings = LoadingScreenMenuSettings.pages.loading_screen,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "[SERVER NAME]",
									name = "server_name",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned
								},
								{
									disabled = true,
									name = "server_banner",
									type = "URLTextureMenuItem",
									layout_settings = LoadingScreenMenuSettings.items.server_banner
								},
								{
									disabled = true,
									name = "server_description",
									type = "TextBoxMenuItem",
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned
								},
								{
									text = "[GAME MODE NAME]",
									name = "game_mode_name",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned
								},
								{
									disabled = true,
									name = "game_mode_description",
									type = "TextBoxMenuItem",
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned
								},
								{
									text = "[LEVEL NAME]",
									name = "level_name",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned
								},
								{
									disabled = true,
									name = "level_description",
									type = "TextBoxMenuItem",
									layout_settings = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned
								}
							}
						}
					}
				}
			}
		}
	}
}
