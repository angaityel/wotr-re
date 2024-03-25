-- chunkname: @scripts/menu/menu_pages/battle_report_scoreboard_menu_page.lua

require("scripts/menu/menu_containers/item_grid_menu_container")

BattleReportScoreboardMenuPage = class(BattleReportScoreboardMenuPage, BattleReportBaseMenuPage)

function BattleReportScoreboardMenuPage:init(config, item_groups, world)
	BattleReportScoreboardMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._local_player_index = config.local_player_index
	self._detailed_player = self._local_player_index
	self._scoreboard = ItemGridMenuContainer.create_from_config(item_groups.scoreboard_items, item_groups.scoreboard_headers, item_groups.scoreboard_scroll_bar)
	self._player_details = ItemGridMenuContainer.create_from_config(item_groups.player_details, item_groups.player_details_header)

	self:load_scoreboard(config.stats_collection, config.players, config.local_player_index)
end

function BattleReportScoreboardMenuPage:load_scoreboard(stats_collection, players, local_player_index)
	self:remove_items("scoreboard_items")

	if not stats_collection then
		return
	end

	for player_index, player in pairs(players) do
		local player_item_config = {
			name = player_index,
			parent_page = self,
			layout_settings = BattleReportSettings.items.scoreboard_player,
			player_index = player_index,
			player_id = player.player_id,
			network_id = player.player_id,
			player_name = player.player_name,
			team_name = player.team_name,
			stats = stats_collection,
			local_player_index = local_player_index
		}
		local player_item = BattleReportScoreboardMenuItem.create_from_config({
			world = self._world
		}, player_item_config, self)

		self:add_item(player_item, "scoreboard_items")
	end

	local items = self:items_in_group("scoreboard_items")

	local function sort_function(item1, item2)
		if item1:score() ~= item2:score() then
			return item1:score() > item2:score()
		else
			return tostring(item1:player_name()) < tostring(item2:player_name())
		end
	end

	table.sort(items, sort_function)

	for i = 1, #items do
		items[i].row_index = i
	end
end

function BattleReportScoreboardMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	BattleReportScoreboardMenuPage.super._highlight_item(self, index, ignore_sound)

	if highlighted_item ~= self:_highlighted_item() then
		if self:_highlighted_item() then
			self._detailed_player = self:_highlighted_item().config.player_index
		else
			self._detailed_player = self._local_player_index
		end
	end
end

function BattleReportScoreboardMenuPage:_update_container_size(dt, t)
	BattleReportScoreboardMenuPage.super._update_container_size(self, dt, t)

	if self._detailed_player then
		self:_update_player_details(self._detailed_player)
	end

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._scoreboard:update_size(dt, t, self._gui, layout_settings.scoreboard)
	self._player_details:update_size(dt, t, self._gui, layout_settings.player_details)
end

function BattleReportScoreboardMenuPage:_update_container_position(dt, t)
	BattleReportScoreboardMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._scoreboard, layout_settings.scoreboard)

	self._scoreboard:update_position(dt, t, layout_settings.scoreboard, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._player_details, layout_settings.player_details)

	self._player_details:update_position(dt, t, layout_settings.player_details, x, y, self.config.z + 20)
end

function BattleReportScoreboardMenuPage:update(dt, t)
	self.super.update(self, dt, t)

	local controller_active = Managers.input:pad_active(1)

	if controller_active and not self._current_highlight then
		local potential_items = self:find_items_of_type("battle_report_scoreboard")
		local min_y = math.huge
		local potential_item

		for _, item in ipairs(potential_items) do
			if min_y > item._y then
				potential_item = item
				min_y = item._y
			end
		end

		for _, item in ipairs(self._items) do
			if item == potential_item then
				self:_highlight_item(index)
			end
		end
	end
end

function BattleReportScoreboardMenuPage:_update_input(input)
	self.super._update_input(self, input)

	local pad_active = Managers.input:pad_active(1)

	if input:has("wheel") and input:get("wheel").y ~= 0 then
		local y = input:get("wheel").y
		local mouse_pos = input:get("cursor")

		if y > 0.9 then
			if pad_active or self._scoreboard:is_mouse_inside(mouse_pos.x, mouse_pos.y) then
				self._scoreboard:scroll_up()

				if pad_active then
					-- block empty
				end
			end
		elseif y < -0.9 and (pad_active or self._scoreboard:is_mouse_inside(mouse_pos.x, mouse_pos.y)) then
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._scoreboard:scroll_down(layout_settings.scoreboard)

			if pad_active then
				-- block empty
			end
		end
	end

	if pad_active and input:get("summary") then
		self:cb_goto_menu_page("battle_report_summary")
	end
end

function BattleReportScoreboardMenuPage:render(dt, t)
	BattleReportScoreboardMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._scoreboard:render(dt, t, self._gui, layout_settings.scoreboard)
	self._player_details:render(dt, t, self._gui, layout_settings.player_details)
end

function BattleReportScoreboardMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		local potential_items = self:find_items_of_type("battle_report_scoreboard")
		local current_item = self._items[self._current_highlight]

		if not current_item then
			return
		end

		local y = current_item._y
		local min_diff = math.huge
		local potential_item

		for _, test_item in ipairs(potential_items) do
			local diff = math.abs(test_item._y - y)

			if test_item:highlightable() and current_item ~= test_item and y < test_item._y and diff < min_diff then
				potential_item = test_item
				min_diff = diff
			end
		end

		if potential_item then
			for index, item in ipairs(self._items) do
				if item == potential_item then
					self:_highlight_item(index)

					local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
					local top_row = self._scoreboard:top_visible_row()
					local start_index, end_index = self._scoreboard:row_info()
					local mid = math.floor(start_index + (end_index - start_index) / 2) + 1
					local row_index = current_item.row_index

					if row_index <= mid then
						self._scoreboard:scroll_up(layout_settings.scoreboard)
					end

					break
				end
			end
		end
	else
		local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

		self._relative_index = (self._relative_index or 0) + 1

		if self._relative_index > layout_settings.scoreboard.number_of_visible_rows then
			self._relative_index = layout_settings.scoreboard.number_of_visible_rows

			self._browser:scroll_down(layout_settings.scoreboard)
			self:_update_server_highlight()
		end

		self.super.move_up(self)
	end
end

function BattleReportScoreboardMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		local potential_items = self:find_items_of_type("battle_report_scoreboard")
		local current_item = self._items[self._current_highlight]

		if not current_item then
			return
		end

		local y = current_item._y
		local min_diff = math.huge
		local potential_item

		for _, test_item in ipairs(potential_items) do
			local diff = math.abs(test_item._y - y)

			if test_item:highlightable() and current_item ~= test_item and y > test_item._y and diff < min_diff then
				potential_item = test_item
				min_diff = diff
			end
		end

		if potential_item then
			for index, item in ipairs(self._items) do
				if item == potential_item then
					self:_highlight_item(index)

					local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
					local top_row = self._scoreboard:top_visible_row()
					local start_index, end_index = self._scoreboard:row_info()
					local mid = math.floor(start_index + (end_index - start_index) / 2) + 1
					local row_index = current_item.row_index

					if mid <= row_index then
						self._scoreboard:scroll_down(layout_settings.scoreboard)
					end

					break
				end
			end
		end
	else
		self.super.move_down(self)
	end
end

function BattleReportScoreboardMenuPage:_render_button_info(layout_settings)
	local button_config = layout_settings.default_buttons
	local text_data = layout_settings.text_data
	local w, h = Gui.resolution()
	local x = self._scoreboard._x
	local y = text_data.offset_y
	local offset_x = 0

	for _, button in ipairs(button_config) do
		local material, uv00, uv11, size = self:get_button_bitmap(button.button_name)

		Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x, y - size[2], 999), size)

		local text = string.upper(L(button.text))

		Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + size[1] + offset_x, y - size[2] * 0.62, 999))

		if text_data.drop_shadow then
			local drop_x, drop_y = unpack(text_data.drop_shadow)

			Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + size[1] + offset_x, y - size[2] * 0.62, 998), Color(0, 0, 0))
		end

		local min, max = Gui.text_extents(self._button_gui, text, text_data.font.font, text_data.font_size)

		offset_x = offset_x + (max[1] - min[1]) + size[2]
	end
end

function BattleReportScoreboardMenuPage:_update_player_details(player_index)
	local stats_items = self:items_in_group("player_details")
	local player_item = self:find_item_by_name(player_index)

	for _, stats_item in ipairs(stats_items) do
		if stats_item.config.name then
			stats_item.config.text = player_item:stats(stats_item.config.name)
		end
	end

	self:find_item_by_name("player_details_name").config.text = player_item:player_name()
	self:find_item_by_name("player_details_score").config.text = player_item:score()
end

function BattleReportScoreboardMenuPage:cb_scoreboard_scroll_select_down(row)
	self._scoreboard:set_top_visible_row(row)
end

function BattleReportScoreboardMenuPage:cb_scoreboard_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	return not self._scoreboard:can_scroll(layout_settings.scoreboard)
end

function BattleReportScoreboardMenuPage:cb_goto_menu_page(id)
	self._menu_logic:goto(id)
end

function BattleReportScoreboardMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		no_cancel_to_parent_page = true,
		type = "battle_report_scoreboard",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		music_events = page_config.music_events,
		players = compiler_data.menu_data.players,
		local_player_index = compiler_data.menu_data.local_player_index,
		stats_collection = compiler_data.menu_data.stats_collection,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return BattleReportScoreboardMenuPage:new(config, item_groups, compiler_data.world)
end
