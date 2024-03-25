-- chunkname: @scripts/menu/menu_definitions/final_scoreboard_menu_definition.lua

FinalScoreboardMenuDefinition = {
	page = {
		type = "EmptyMenuPage",
		item_groups = {
			item_list = {
				{
					id = "final_scoreboard",
					type = "EmptyMenuItem",
					page = {
						z = 1,
						type = "FinalScoreboardMenuPage",
						layout_settings = FinalScoreboardMenuSettings.pages.main_page,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							center_items = {
								{
									text = "",
									name = "battle_result",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								},
								{
									text = "",
									name = "battle_details",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.battle_details
								},
								{
									disabled = true,
									name = "center_team_rose",
									type = "TextureMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.center_team_rose
								}
							},
							left_team_items = {
								{
									disabled = true,
									name = "left_team_rose",
									type = "TextureMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.left_team_rose
								},
								{
									text = "",
									name = "left_team_score",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.left_team_score
								},
								{
									text = "",
									name = "left_team_text",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.left_team_text
								}
							},
							right_team_items = {
								{
									disabled = true,
									name = "right_team_rose",
									type = "TextureMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.right_team_rose
								},
								{
									text = "",
									name = "right_team_score",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.right_team_score
								},
								{
									text = "",
									name = "right_team_text",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = FinalScoreboardMenuSettings.items.right_team_text
								}
							}
						}
					}
				}
			}
		}
	}
}
