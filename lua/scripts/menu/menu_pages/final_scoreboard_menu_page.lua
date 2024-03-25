-- chunkname: @scripts/menu/menu_pages/final_scoreboard_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")
require("scripts/menu/menu_pages/teams_menu_page")

FinalScoreboardMenuPage = class(FinalScoreboardMenuPage, TeamsMenuPage)

function FinalScoreboardMenuPage:init(config, item_groups, world)
	FinalScoreboardMenuPage.super.init(self, config, item_groups, world)
	Managers.state.event:register(self, "gm_event_end_conditions_met", "gm_event_end_conditions_met")
end

function FinalScoreboardMenuPage:render(dt, t)
	if not self._local_player.team or self._local_player.team.name == "unassigned" then
		return
	end

	FinalScoreboardMenuPage.super.render(self, dt, t)
end

function FinalScoreboardMenuPage:gm_event_end_conditions_met(winning_team_name, red_team_score, white_team_score, only_end_of_round)
	if not self._local_player.team or self._local_player.team.name == "unassigned" then
		return
	end

	local player_team_name = self._local_player.team.name
	local player_team_side = self._local_player.team.side
	local own_team_result

	own_team_result = winning_team_name == "draw" and "draw" or winning_team_name == player_team_name and "won" or "lost"

	if only_end_of_round then
		own_team_result = own_team_result .. "_round"
		self._render_backgrounds = false
	else
		self._render_backgrounds = true
	end

	local text_color = player_team_name == "red" and HUDSettings.player_colors.red_team or HUDSettings.player_colors.white_team
	local battle_result_item = self:find_item_by_name("battle_result")

	battle_result_item.config.text = L("menu_battle_" .. own_team_result)
	battle_result_item.config.color = text_color

	local battle_details_item = self:find_item_by_name("battle_details")
	local level_settings = LevelHelper:current_level_settings()
	local level_name = L(level_settings.display_name)
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	local battle_details = GameModeSettings[game_mode_key].battle_details[own_team_result]
	local battle_details_localized = string.gsub(L(battle_details), "&level_name;", level_name)

	battle_details_item.config.visible = true
	battle_details_item.config.text = battle_details_localized
	battle_details_item.config.color = text_color

	local own_team_score_item = self:find_item_by_name("left_team_score")

	own_team_score_item.config.text = player_team_name == "red" and red_team_score or white_team_score

	local enemy_team_score_item = self:find_item_by_name("right_team_score")

	enemy_team_score_item.config.text = player_team_name == "red" and white_team_score or red_team_score

	local own_team_rose_item = self:find_item_by_name("left_team_rose")
	local layout_settings = MenuHelper:layout_settings(own_team_rose_item.config.layout_settings)

	own_team_rose_item.config.texture = player_team_name == "red" and layout_settings.texture_red or layout_settings.texture_white

	local enemy_team_rose_item = self:find_item_by_name("right_team_rose")
	local layout_settings = MenuHelper:layout_settings(enemy_team_rose_item.config.layout_settings)

	enemy_team_rose_item.config.texture = player_team_name == "red" and layout_settings.texture_white or layout_settings.texture_red

	local center_team_rose = self:find_item_by_name("center_team_rose")

	if only_end_of_round then
		own_team_rose_item.config.hide = true
		enemy_team_rose_item.config.hide = true

		local layout_settings = MenuHelper:layout_settings(center_team_rose.config.layout_settings)

		center_team_rose.config.texture = winning_team_name == "red" and layout_settings.texture_red or layout_settings.texture_white
	else
		own_team_rose_item.config.hide = false
		enemy_team_rose_item.config.hide = false
		center_team_rose.config.hide = true
	end

	local own_team_text_item = self:find_item_by_name("left_team_text")
	local layout_settings = MenuHelper:layout_settings(own_team_text_item.config.layout_settings)

	own_team_text_item.config.text = player_team_name == "red" and string.upper(L("lancaster")) or string.upper(L("york"))
	own_team_text_item.config.color = player_team_name == "red" and layout_settings.color_red or layout_settings.color_white

	local enemy_team_text_item = self:find_item_by_name("right_team_text")
	local layout_settings = MenuHelper:layout_settings(enemy_team_text_item.config.layout_settings)

	enemy_team_text_item.config.text = player_team_name == "red" and string.upper(L("york")) or string.upper(L("lancaster"))
	enemy_team_text_item.config.color = player_team_name == "red" and layout_settings.color_white or layout_settings.color_red
end

function FinalScoreboardMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "final_scoreboard",
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return FinalScoreboardMenuPage:new(config, item_groups, compiler_data.world)
end
