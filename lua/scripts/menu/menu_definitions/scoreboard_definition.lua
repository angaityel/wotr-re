-- chunkname: @scripts/menu/menu_definitions/scoreboard_definition.lua

require("scripts/settings/hud_settings")
require("scripts/menu/menu_definitions/scoreboard_settings_1920")
require("scripts/menu/menu_definitions/scoreboard_settings_1366")

ScoreboardPlayerDetailHeader = {
	{
		disabled = true,
		type = "TextureMenuItem",
		layout_settings = ScoreboardSettings.items.player_details_coat_of_arms
	},
	{
		text = "[Player Name]",
		name = "player_details_name",
		disabled = true,
		type = "TextMenuItem",
		no_localization = true,
		layout_settings = ScoreboardSettings.items.player_details_stat
	},
	{
		text = "[Points]",
		name = "player_details_score",
		disabled = true,
		type = "TextMenuItem",
		no_localization = true,
		layout_settings = ScoreboardSettings.items.player_details_stat_score
	},
	{
		type = "EmptyMenuItem",
		layout_settings = MainMenuSettings.items.empty
	},
	{
		disabled = true,
		type = "TextureMenuItem",
		layout_settings = ScoreboardSettings.items.player_details_delimiter
	},
	{
		type = "EmptyMenuItem",
		layout_settings = MainMenuSettings.items.empty
	}
}

local ScoreboardPlayerDetailStats = {
	{
		text = "scoreboard_kills",
		stat = "enemy_kills"
	},
	{
		text = "scoreboard_deaths",
		stat = "deaths"
	},
	{
		text = "scoreboard_enemy_damage",
		stat = "enemy_damage"
	},
	{
		text = "scoreboard_executions",
		stat = "executions"
	},
	{
		text = "scoreboard_headshots",
		stat = "headshots"
	},
	{
		text = "scoreboard_longest_kill_streak",
		stat = "longest_kill_streak"
	},
	{
		text = "scoreboard_objectives_captured",
		stat = "objectives_captured"
	},
	{
		text = "scoreboard_bandages",
		stat = "team_bandages"
	},
	{
		text = "scoreboard_yields",
		stat = "yields"
	}
}

ScoreboardPlayerDetailItems = {}

for i, config in ipairs(ScoreboardPlayerDetailStats) do
	local column = (i - 1) % 4 + 1

	if column == 1 then
		ScoreboardPlayerDetailItems[#ScoreboardPlayerDetailItems + 1] = {
			type = "EmptyMenuItem",
			layout_settings = MainMenuSettings.items.empty
		}
	end

	if config then
		ScoreboardPlayerDetailItems[#ScoreboardPlayerDetailItems + 1] = {
			disabled = true,
			type = "TextMenuItem",
			text = config.text,
			layout_settings = ScoreboardSettings.items.player_details_stat
		}
		ScoreboardPlayerDetailItems[#ScoreboardPlayerDetailItems + 1] = {
			text = "",
			no_localization = true,
			disabled = true,
			type = "TextMenuItem",
			name = config.stat,
			layout_settings = ScoreboardSettings.items.player_details_stat
		}
	end
end

ScoreboardDefinition = {
	page = {
		z = 1,
		type = "ScoreboardMenuPage",
		layout_settings = ScoreboardSettings.pages.main_page,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			center_items = {},
			left_team_items = {
				{
					disabled = true,
					name = "left_team_rose",
					type = "TextureMenuItem",
					layout_settings = ScoreboardSettings.items.left_team_rose
				},
				{
					text = "",
					name = "left_team_text",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.left_team_text
				},
				{
					text = "",
					name = "left_team_score",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.team_score
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "AAA",
					name = "left_team_num_members",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.team_num_members
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			right_team_items = {
				{
					text = "",
					name = "right_team_score",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.team_score
				},
				{
					text = "",
					name = "right_team_text",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.right_team_text
				},
				{
					disabled = true,
					name = "right_team_rose",
					type = "TextureMenuItem",
					layout_settings = ScoreboardSettings.items.right_team_rose
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "BBB",
					name = "right_team_num_members",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ScoreboardSettings.items.team_num_members
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			left_team_players_headers = {
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_name_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				},
				{
					text = "menu_rank_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_score_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				},
				{
					text = "menu_ping_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header_bgr_texture_left
				}
			},
			right_team_players_headers = {
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_name_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header_bgr_texture_right
				},
				{
					text = "menu_rank_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_score_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				},
				{
					text = "menu_ping_lower",
					disabled = true,
					type = "TextMenuItem",
					layout_settings = ScoreboardSettings.items.players_header
				}
			},
			left_team_players_items = {},
			right_team_players_items = {},
			left_team_players_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_left_team_players_scroll_select_down",
					disabled_func = "cb_left_team_players_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = ScoreboardSettings.items.players_scroll_bar
				}
			},
			right_team_players_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_right_team_players_scroll_select_down",
					disabled_func = "cb_right_team_players_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = ScoreboardSettings.items.players_scroll_bar
				}
			},
			player_details_header = ScoreboardPlayerDetailHeader,
			player_details = ScoreboardPlayerDetailItems
		}
	}
}
