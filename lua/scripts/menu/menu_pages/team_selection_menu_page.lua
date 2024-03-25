-- chunkname: @scripts/menu/menu_pages/team_selection_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")
require("scripts/menu/menu_pages/teams_menu_page")

TeamSelectionMenuPage = class(TeamSelectionMenuPage, TeamsMenuPage)

function TeamSelectionMenuPage:init(config, item_groups, world)
	TeamSelectionMenuPage.super.init(self, config, item_groups, world)

	self._local_player = config.local_player

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.back_list and item_groups.back_list then
		self._back_list = ItemListMenuContainer.create_from_config(item_groups.back_list)
	end

	if layout_settings.page_links and item_groups.page_links then
		self._page_links = ItemListMenuContainer.create_from_config(item_groups.page_links)
	end

	local event_manager = Managers.state.event

	event_manager:register(self, "join_team_confirmed", "event_join_team_confirmed")
	event_manager:register(self, "join_team_denied", "event_join_team_denied")
end

function TeamSelectionMenuPage:event_join_team_confirmed()
	local player_team = self._local_player.team.name
	local timpani_world = World.timpani_world(self._world)
	local sound_event = HUDSettings.side_select_sound_events[player_team]

	if sound_event then
		local event_id = TimpaniWorld.trigger_event(timpani_world, sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, "character_announcer", HUDSettings.announcement_voice_over)
	end
end

function TeamSelectionMenuPage:event_join_team_denied()
	self._joining_team = false
end

function TeamSelectionMenuPage:on_enter()
	TeamSelectionMenuPage.super.on_enter(self)

	self._joining_team = false

	if GameSettingsDevelopment.enable_robot_player then
		self:cb_auto_join_team()
	end
end

function TeamSelectionMenuPage:move_left()
	local team_item = self:find_item_by_name_in_group("left_team_items", "red_team_rose")

	for index, item in ipairs(self._items) do
		if item == team_item then
			self:_highlight_item(index, true)
		end
	end
end

function TeamSelectionMenuPage:move_right()
	local team_item = self:find_item_by_name_in_group("right_team_items", "white_team_rose")

	for index, item in ipairs(self._items) do
		if item == team_item then
			self:_highlight_item(index, true)
		end
	end
end

function TeamSelectionMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		self.super.move_up(self)
	end
end

function TeamSelectionMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		self.super.move_down(self)
	end
end

function TeamSelectionMenuPage:update(dt, t)
	TeamSelectionMenuPage.super.update(self, dt, t)

	local red_team = Managers.state.team:team_by_name("red")
	local red_team_score_item = self:find_item_by_name("red_num_members")

	red_team_score_item.config.text = red_team.num_members .. " " .. L("menu_players_lower")

	local white_team = Managers.state.team:team_by_name("white")
	local white_team_score_item = self:find_item_by_name("white_num_members")

	white_team_score_item.config.text = white_team.num_members .. " " .. L("menu_players_lower")

	local round_time = Managers.time:time("round")
	local link_item = self:find_item_by_name("auto_join_team_button")

	if round_time < 0 then
		if link_item:pulse() then
			link_item:stop_pulse()
		end
	elseif not link_item:pulse() then
		link_item:start_pulse(5)
	end

	local controller_active = Managers.input:pad_active(1)

	if controller_active and not self._current_highlight then
		local selected_item
		local team_item = self:find_item_by_name_in_group("left_team_items", "red_team_rose")

		if team_item and team_item:highlightable() then
			selected_item = team_item
		end

		team_item = self:find_item_by_name_in_group("left_team_items", "white_team_rose")

		if not selected_item and team_item and team_item:highlightable() then
			selected_item = team_item
		end

		if selected_item then
			for index, item in ipairs(self._items) do
				if item == selected_item then
					self:_highlight_item(index, true)
				end
			end
		end
	end
end

function TeamSelectionMenuPage:_update_input(input)
	self.super._update_input(self, input)

	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if input:get("auto_join_team") then
			self:cb_auto_join_team()
		elseif input:get("leave_battle") then
			local child_page = self._item_groups.back_list[1]:page()

			self._menu_logic:change_page(child_page)
		end
	end
end

function TeamSelectionMenuPage:_update_container_size(dt, t)
	TeamSelectionMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._back_list then
		self._back_list:update_size(dt, t, self._gui, layout_settings.back_list)
	end

	if self._page_links then
		self._page_links:update_size(dt, t, self._gui, layout_settings.page_links)
	end
end

function TeamSelectionMenuPage:_update_container_position(dt, t)
	TeamSelectionMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._back_list then
		local x, y = MenuHelper:container_position(self._back_list, layout_settings.back_list)

		self._back_list:update_position(dt, t, layout_settings.back_list, x, y, self.config.z + 15)
	end

	if self._page_links then
		local x, y = MenuHelper:container_position(self._page_links, layout_settings.page_links)

		self._page_links:update_position(dt, t, layout_settings.page_links, x, y, self.config.z + 15)
	end
end

function TeamSelectionMenuPage:render(dt, t, rendered_from_child_page)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	layout_settings.left_gradient_texture.color = layout_settings.left_gradient_texture.color_red
	layout_settings.right_gradient_texture.color = layout_settings.right_gradient_texture.color_white

	self._center_items_container:render(dt, t, self._gui, layout_settings.center_items)
	self._left_team_items_container:render(dt, t, self._gui, layout_settings.left_team_items)
	self._right_team_items_container:render(dt, t, self._gui, layout_settings.right_team_items)
	self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)
	self._left_gradient_texture:render(dt, t, self._gui, layout_settings.left_gradient_texture)
	self._left_vertical_line_texture:render(dt, t, self._gui, layout_settings.left_vertical_line_texture)
	self._left_corner_top_texture:render(dt, t, self._gui, layout_settings.left_corner_top_texture)
	self._left_corner_bottom_texture:render(dt, t, self._gui, layout_settings.left_corner_bottom_texture)
	self._right_gradient_texture:render(dt, t, self._gui, layout_settings.right_gradient_texture)
	self._right_vertical_line_texture:render(dt, t, self._gui, layout_settings.right_vertical_line_texture)
	self._right_corner_top_texture:render(dt, t, self._gui, layout_settings.right_corner_top_texture)
	self._right_corner_bottom_texture:render(dt, t, self._gui, layout_settings.right_corner_bottom_texture)

	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		if self._back_list then
			self._back_list:render(dt, t, self._gui, layout_settings.back_list)
		end

		if self._page_links then
			self._page_links:render(dt, t, self._gui, layout_settings.page_links)
		end
	end

	self._rendered_from_child_page = rendered_from_child_page

	local layout_settings

	if self.config.layout_settings then
		layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	end

	if controller_active and (not layout_settings or not layout_settings.do_not_render_buttons) then
		local button_info

		if layout_settings and layout_settings.button_info then
			button_info = layout_settings.button_info
		else
			button_info = MenuHelper:layout_settings(MainMenuSettings.default_button_info)
		end

		self:_render_button_info(button_info)
	end
end

function TeamSelectionMenuPage:_render_button_info(layout_settings)
	if not self._rendered_from_child_page then
		self.super._render_button_info(self, layout_settings)
	end
end

function TeamSelectionMenuPage:cb_quote_text()
	return L("team_selection_quote")
end

function TeamSelectionMenuPage:cb_join_team_selected(team_name)
	Managers.state.team:request_join_team(self._local_player, team_name)

	self._joining_team = true
end

function TeamSelectionMenuPage:cb_join_team_selection_disabled(team_name)
	return self._joining_team or not Managers.state.team:verify_join_team(self._local_player, team_name)
end

function TeamSelectionMenuPage:cb_auto_join_team()
	local red_verified = Managers.state.team:verify_join_team(self._local_player, "red")
	local white_verified = Managers.state.team:verify_join_team(self._local_player, "white")
	local join_team

	if red_verified and white_verified then
		join_team = Math.random(1, 2) == 1 and "red" or "white"
	elseif red_verified then
		join_team = "red"
	elseif white_verified then
		join_team = "white"
	end

	if join_team then
		Managers.state.team:request_join_team(self._local_player, join_team)

		self._joining_team = true
	end
end

function TeamSelectionMenuPage:_auto_highlight_first_item()
	return
end

function TeamSelectionMenuPage:cb_auto_join_team_disabled()
	return self._joining_team
end

function TeamSelectionMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "team_selection",
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		do_not_select_first_index = page_config.do_not_select_first_index,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		on_enter_highlight_item = page_config.on_enter_highlight_item,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return TeamSelectionMenuPage:new(config, item_groups, compiler_data.world)
end
