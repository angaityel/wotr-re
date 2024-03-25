-- chunkname: @scripts/menu/menu_pages/scoreboard_menu_page.lua

require("scripts/menu/menu_pages/teams_menu_page")
require("scripts/menu/menu_containers/item_grid_menu_container")

ScoreboardMenuPage = class(ScoreboardMenuPage, TeamsMenuPage)

function ScoreboardMenuPage:init(config, item_groups, world)
	ScoreboardMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._stats = Managers.state.stats_collection
	self._local_player = config.local_player
	self._detailed_player = self._local_player
	self._left_team_players = ItemGridMenuContainer.create_from_config(item_groups.left_team_players_items, item_groups.left_team_players_headers, item_groups.left_team_players_scroll_bar)
	self._right_team_players = ItemGridMenuContainer.create_from_config(item_groups.right_team_players_items, item_groups.right_team_players_headers, item_groups.right_team_players_scroll_bar)
	self._player_details = ItemGridMenuContainer.create_from_config(item_groups.player_details, item_groups.player_details_header)
end

function ScoreboardMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	ScoreboardMenuPage.super._highlight_item(self, index, ignore_sound)

	if highlighted_item ~= self:_highlighted_item() then
		if self:_highlighted_item() then
			self._detailed_player = self:_highlighted_item().config.player
		else
			self._detailed_player = self._local_player
		end
	end
end

function ScoreboardMenuPage:_update_container_size(dt, t)
	ScoreboardMenuPage.super._update_container_size(self, dt, t)

	local local_player = self._local_player

	if not local_player.team or local_player.team.name == "unassigned" then
		return
	end

	local player_team = local_player.team
	local player_team_name = player_team.name
	local enemy_team_name = player_team_name == "red" and "white" or "red"
	local enemy_team = Managers.state.team:team_by_name(enemy_team_name)

	self:_update_players(player_team, "left")
	self:_update_players(enemy_team, "right")

	if self._detailed_player then
		self:_update_player_details(self._detailed_player)
	end

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._left_team_players:update_size(dt, t, self._gui, layout_settings.left_team_players)
	self._right_team_players:update_size(dt, t, self._gui, layout_settings.right_team_players)
	self._player_details:update_size(dt, t, self._gui, layout_settings.player_details)
end

function ScoreboardMenuPage:_update_players(team, side)
	local team_members = team.members
	local team_item_group = side .. "_team_players_items"
	local player_manager = Managers.player

	for player_index, player in pairs(team_members) do
		if not self:find_item_by_name_in_group(team_item_group, "player_" .. player_index) and player_manager:player_exists(player_index) then
			self:_add_player_item(side, player_index, player)
		end
	end

	local items = self:items_in_group(team_item_group)

	for i = #items, 1, -1 do
		local item = items[i]
		local player_index = item.config.player.index

		if not team_members[player_index] or not player_manager:player_exists(player_index) then
			self:remove_item_from_group(team_item_group, item)
		end
	end

	local function sort_function(item1, item2)
		if item1:score() ~= item2:score() then
			return item1:score() > item2:score()
		else
			return tostring(item1:player_name()) < tostring(item2:player_name())
		end
	end

	table.sort(items, sort_function)
end

function ScoreboardMenuPage:_add_player_item(side, player_index, player)
	local player_item_config = {
		name = "player_" .. player_index,
		layout_settings = ScoreboardSettings.items["player_" .. side],
		parent_page = self,
		player = player,
		local_player = self._local_player
	}
	local player_item = ScoreboardPlayerMenuItem.create_from_config({
		world = self._world
	}, player_item_config, self)

	self:add_item(player_item, side .. "_team_players_items")
end

function ScoreboardMenuPage:_update_container_position(dt, t)
	ScoreboardMenuPage.super._update_container_position(self, dt, t)

	local local_player = self._local_player

	if not local_player.team or local_player.team.name == "unassigned" then
		return
	end

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._left_team_players, layout_settings.left_team_players)

	self._left_team_players:update_position(dt, t, layout_settings.left_team_players, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._right_team_players, layout_settings.right_team_players)

	self._right_team_players:update_position(dt, t, layout_settings.right_team_players, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._player_details, layout_settings.player_details)

	self._player_details:update_position(dt, t, layout_settings.player_details, x, y, self.config.z + 20)
end

function ScoreboardMenuPage:render(dt, t)
	local local_player = self._local_player

	if not local_player.team or local_player.team.name == "unassigned" then
		return
	end

	local player_team = local_player.team
	local player_team_name = player_team.name
	local enemy_team_name = player_team_name == "red" and "white" or "red"
	local enemy_team = Managers.state.team:team_by_name(enemy_team_name)
	local red_team_score = Managers.state.game_mode:hud_score_text("red")
	local white_team_score = Managers.state.game_mode:hud_score_text("white")
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

	local own_team_text_item = self:find_item_by_name("left_team_text")
	local layout_settings = MenuHelper:layout_settings(own_team_text_item.config.layout_settings)

	own_team_text_item.config.text = player_team_name == "red" and string.upper(L("lancaster")) or string.upper(L("york"))
	own_team_text_item.config.color = player_team_name == "red" and layout_settings.color_red or layout_settings.color_white

	local enemy_team_text_item = self:find_item_by_name("right_team_text")
	local layout_settings = MenuHelper:layout_settings(enemy_team_text_item.config.layout_settings)

	enemy_team_text_item.config.text = player_team_name == "red" and string.upper(L("york")) or string.upper(L("lancaster"))
	enemy_team_text_item.config.color = player_team_name == "red" and layout_settings.color_white or layout_settings.color_red

	local own_team_text_item = self:find_item_by_name("left_team_num_members")
	local layout_settings = MenuHelper:layout_settings(own_team_text_item.config.layout_settings)

	own_team_text_item.config.text = player_team.num_members .. " " .. L("menu_players_lower")
	own_team_text_item.config.color = player_team_name == "red" and layout_settings.color_red or layout_settings.color_white

	local enemy_team_text_item = self:find_item_by_name("right_team_num_members")
	local layout_settings = MenuHelper:layout_settings(enemy_team_text_item.config.layout_settings)

	enemy_team_text_item.config.text = enemy_team.num_members .. " " .. L("menu_players_lower")
	enemy_team_text_item.config.color = player_team_name == "red" and layout_settings.color_white or layout_settings.color_red

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._left_team_players:render(dt, t, self._gui, layout_settings.left_team_players)
	self._right_team_players:render(dt, t, self._gui, layout_settings.right_team_players)
	self._player_details:render(dt, t, self._gui, layout_settings.player_details)
	ScoreboardMenuPage.super.render(self, dt, t)
end

function ScoreboardMenuPage:_update_player_details(player)
	local items = self:items_in_group("player_details")

	for _, item in ipairs(items) do
		if item.config.name then
			item.config.text = self._stats:get(player:network_id(), item.config.name)
		end
	end

	self:find_item_by_name("player_details_name").config.text = player:name()
	self:find_item_by_name("player_details_score").config.text = self._stats:get(player:network_id(), "experience_round") .. " " .. L("menu_points")
end

function ScoreboardMenuPage:cb_left_team_players_scroll_select_down(row)
	self._left_team_players:set_top_visible_row(row)
end

function ScoreboardMenuPage:cb_right_team_players_scroll_select_down(row)
	self._right_team_players:set_top_visible_row(row)
end

function ScoreboardMenuPage:cb_left_team_players_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	return not self._left_team_players:can_scroll(layout_settings.left_team_players)
end

function ScoreboardMenuPage:cb_right_team_players_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	return not self._right_team_players:can_scroll(layout_settings.right_team_players)
end

function ScoreboardMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "scoreboard",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return ScoreboardMenuPage:new(config, item_groups, compiler_data.world)
end
