-- chunkname: @scripts/menu/menu_compiler.lua

require("scripts/menu/menu_pages/menu_page")
require("scripts/menu/menu_pages/standard_menu_page")
require("scripts/menu/menu_pages/level_1_menu_page")
require("scripts/menu/menu_pages/level_2_menu_page")
require("scripts/menu/menu_pages/level_3_menu_page")
require("scripts/menu/menu_pages/select_character_menu_page")
require("scripts/menu/menu_pages/outfit_editor/outfit_editor_profile_menu_page")
require("scripts/menu/menu_pages/video_settings_menu_page")
require("scripts/menu/menu_pages/drop_down_list_menu_page")
require("scripts/menu/menu_pages/outfit_drop_down_list_menu_page")
require("scripts/menu/menu_pages/loading_screen_menu_page")
require("scripts/menu/menu_pages/key_mappings_menu_page")
require("scripts/menu/menu_pages/key_mapping_menu_page")
require("scripts/menu/menu_pages/key_mapping_pad_menu_page")
require("scripts/menu/menu_pages/scoreboard_menu_page")
require("scripts/menu/menu_pages/coat_of_arms_menu_page")
require("scripts/menu/menu_pages/select_spawnpoint_menu_page")
require("scripts/menu/menu_pages/teams_menu_page")
require("scripts/menu/menu_pages/final_scoreboard_menu_page")
require("scripts/menu/menu_pages/empty_menu_page")
require("scripts/menu/menu_pages/character_sheet_menu_page")
require("scripts/menu/menu_pages/popup_menu_page")
require("scripts/menu/menu_pages/demo_popup_menu_page")
require("scripts/menu/menu_pages/team_selection_menu_page")
require("scripts/menu/menu_pages/server_browser_menu_page")
require("scripts/menu/menu_pages/battle_report_base_menu_page")
require("scripts/menu/menu_pages/battle_report_scoreboard_menu_page")
require("scripts/menu/menu_pages/battle_report_summary_menu_page")
require("scripts/menu/menu_pages/battle_report_awards_menu_page")
require("scripts/menu/menu_pages/splash_screen_menu_page")
require("scripts/menu/menu_pages/credits_menu_page")
require("scripts/menu/menu_pages/expandable_popup_menu_page")
require("scripts/menu/menu_pages/sale_popup_menu_page")
require("scripts/menu/menu_pages/changelog_popup_menu_page")
require("scripts/menu/menu_items/menu_item")
require("scripts/menu/menu_items/text_menu_item")
require("scripts/menu/menu_items/division_text_menu_item")
require("scripts/menu/menu_items/checkbox_menu_item")
require("scripts/menu/menu_items/texture_menu_item")
require("scripts/menu/menu_items/enum_menu_item")
require("scripts/menu/menu_items/lobby_host_menu_item")
require("scripts/menu/menu_items/lobby_practice_menu_item")
require("scripts/menu/menu_items/lobby_join_menu_item")
require("scripts/menu/menu_items/spawn_map_menu_item")
require("scripts/menu/menu_items/squad_marker_menu_item")
require("scripts/menu/menu_items/local_player_marker_menu_item")
require("scripts/menu/menu_items/objective_marker_menu_item")
require("scripts/menu/menu_items/drop_down_list_menu_item")
require("scripts/menu/menu_items/button_menu_item")
require("scripts/menu/menu_items/squad_text_menu_item")
require("scripts/menu/menu_items/spawn_area_marker_menu_item")
require("scripts/menu/menu_items/key_mapping_menu_item")
require("scripts/menu/menu_items/coat_of_arms_menu_item")
require("scripts/menu/menu_items/coat_of_arms_color_picker_menu_item")
require("scripts/menu/menu_items/texture_button_menu_item")
require("scripts/menu/menu_items/texture_link_button_menu_item")
require("scripts/menu/menu_items/texture_button_countdown_menu_item")
require("scripts/menu/menu_items/empty_menu_item")
require("scripts/menu/menu_items/progress_bar_menu_item")
require("scripts/menu/menu_items/text_input_menu_item")
require("scripts/menu/menu_items/text_box_menu_item")
require("scripts/menu/menu_items/server_menu_item")
require("scripts/menu/menu_items/column_header_text_menu_item")
require("scripts/menu/menu_items/column_header_texture_menu_item")
require("scripts/menu/menu_items/player_info_menu_item")
require("scripts/menu/menu_items/scroll_bar_menu_item")
require("scripts/menu/menu_items/tab_menu_item")
require("scripts/menu/menu_items/scoreboard_player_menu_item")
require("scripts/menu/menu_items/loading_texture_menu_item")
require("scripts/menu/menu_items/animated_texture_menu_item")
require("scripts/menu/menu_items/battle_report_scoreboard_menu_item")
require("scripts/menu/menu_items/battle_report_summary_menu_item")
require("scripts/menu/menu_items/battle_report_summary_total_menu_item")
require("scripts/menu/menu_items/battle_report_summary_award_menu_item")
require("scripts/menu/menu_items/video_menu_item")
require("scripts/menu/menu_items/bitsquid_splash_menu_item")
require("scripts/menu/menu_items/url_texture_menu_item")
require("scripts/menu/menu_items/atlas_texture_menu_item")
require("scripts/menu/menu_items/selection_indicator_menu_item")
require("scripts/menu/menu_items/scrolling_text_box_menu_item")

MenuCompiler = class(MenuCompiler)

function MenuCompiler:init(data)
	self._data = data
end

function MenuCompiler:compile(menu_def)
	local shortcut_table = {}

	return self:_compile_page(table.clone(menu_def.page), nil, shortcut_table), shortcut_table
end

function MenuCompiler:_compile_page(page_config, parent_page, shortcut_table, ...)
	local page
	local item_groups = {}

	for group_name, _ in pairs(page_config.item_groups) do
		item_groups[group_name] = {}
	end

	local callback_object = self._data.callback_object

	if page_config.callback_object == "parent_page" then
		callback_object = parent_page
	end

	local page_class = rawget(_G, page_config.type)

	page = page_class.create_from_config(self._data, page_config, parent_page, item_groups, callback_object)

	local key = 1

	for group_name, items in pairs(page_config.item_groups) do
		for _, item_config in ipairs(items) do
			local item

			if ... then
				item = self:_compile_item(item_config, page, shortcut_table, ..., key)
			else
				item = self:_compile_item(item_config, page, shortcut_table, key)
			end

			page:add_item(item, group_name)

			if item_config.id then
				fassert(not shortcut_table[item_config.id], "[MenuLogic] Id already assigned %s", item_config.id)

				local shortcut = {
					...
				}

				shortcut[#shortcut + 1] = key
				shortcut_table[item_config.id] = shortcut
			end

			key = key + 1
		end
	end

	return page
end

function MenuCompiler:_compile_item(item_config, parent_page, shortcut_table, ...)
	fassert(item_config.type, "Item type not declared")

	if item_config.page then
		item_config.page = self:_compile_page(item_config.page, parent_page, shortcut_table, ...)
	end

	item_config.parent_page = parent_page

	local callback_object = self._data.callback_object

	if item_config.callback_object == "page" then
		callback_object = parent_page
	elseif item_config.callback_object ~= nil then
		callback_object = rawget(_G, item_config.callback_object)
	end

	local item_class = rawget(_G, item_config.type)
	local item = item_class.create_from_config(self._data, item_config, callback_object)

	return item
end
