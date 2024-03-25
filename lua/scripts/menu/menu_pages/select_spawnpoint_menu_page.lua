-- chunkname: @scripts/menu/menu_pages/select_spawnpoint_menu_page.lua

require("scripts/menu/menu_containers/spawn_point_menu_container")

SelectSpawnpointMenuPage = class(SelectSpawnpointMenuPage, Level3MenuPage)

function SelectSpawnpointMenuPage:init(config, item_groups, world)
	SelectSpawnpointMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._local_player = config.local_player

	self:add_item_group("spawn_map")
	self:add_item_group("local_player_marker")
	self:add_item_group("squad_markers")
	self:add_item_group("objective_markers")
	self:add_item_group("spawn_area_markers")

	self._squad_header = ItemListMenuContainer.create_from_config(item_groups.squad_header)
	self._squad_info = ItemListMenuContainer.create_from_config(item_groups.squad_info)
	self._squad_button = ItemListMenuContainer.create_from_config(item_groups.squad_button)
	self._spawnpoint = SpawnPointMenuContainer.create_from_config(config.local_player, self:items_in_group("spawn_map"), self:items_in_group("squad_markers"), self:items_in_group("spawn_area_markers"), self:items_in_group("objective_markers"), self:items_in_group("local_player_marker"))
	self._squad_info_items = self:items_in_group("squad_info")
	self._squad_button_items = self:items_in_group("squad_button")

	self:_add_map_item()

	self._selected_spawn_target = nil
	self._last_selected_spawn_target = nil

	Managers.state.event:register(self, "player_joined_squad", "event_player_joined_squad")
	Managers.state.event:register(self, "player_left_squad", "event_player_left_squad")
	Managers.state.event:register(self, "player_joined_team", "event_player_joined_team")
end

function SelectSpawnpointMenuPage:_add_map_item()
	local map_item_config = {
		disabled = true,
		layout_settings = SquadMenuSettings.items.spawn_map
	}
	local map_item = SpawnMapMenuItem.create_from_config({
		world = self._world
	}, map_item_config, self)

	self:add_item(map_item, "spawn_map")
end

function SelectSpawnpointMenuPage:update(dt, t, input)
	if not self._local_player.team then
		return
	end

	self:_update_map_markers(dt, t)
	self:_update_game_start_timer()

	if GameSettingsDevelopment.enable_robot_player then
		self:cb_request_spawn_target()
	end

	SelectSpawnpointMenuPage.super.update(self, dt, t, input)
end

function SelectSpawnpointMenuPage:_update_game_start_timer()
	local round_time = Managers.time:time("round")
	local link_item = self:find_item_by_name("spawn_button")

	if not link_item then
		return
	end

	if round_time < 0 then
		if link_item:pulse() then
			link_item:stop_pulse()
		end
	elseif not link_item:pulse() then
		link_item:start_pulse(5)
	end
end

function SelectSpawnpointMenuPage:on_enter()
	SelectSpawnpointMenuPage.super.on_enter(self)

	if self._selected_spawn_target then
		local highest_prio_area = Managers.state.spawn:spawn_area_with_highest_priority(self._local_player.team.name)
		local potential_spawn_target = self:find_item_by_name(highest_prio_area)

		if highest_prio_area and potential_spawn_target then
			self._selected_spawn_target = potential_spawn_target:name()
		end

		local spawn_marker = self:find_item_by_name(self._selected_spawn_target)
		local spawn_target = spawn_marker.config.on_select_args[1]
		local spawn_mode = spawn_marker.config.on_select_args[2]
		local spawn_data = self._local_player.spawn_data

		if not spawn_data.mode or spawn_mode == "area" and spawn_target ~= spawn_data.area_name or not (spawn_mode ~= "squad_member" and spawn_mode ~= "unconfirmed_squad_member") and spawn_target ~= spawn_data.squad_unit or not Unit.alive(spawn_data.squad_unit) then
			self._selected_spawn_target = nil
		end
	end

	if self._selected_spawn_target then
		local local_player = self._local_player

		if Unit.alive(local_player.player_unit) and Unit.get_data(local_player.player_unit, "player_profile") ~= local_player.state_data.spawn_profile then
			self._selected_spawn_target = nil
		end
	end

	for i, squad in ipairs(self._local_player.team.squads) do
		self._squad_info_items[i]:set_num_max_members(squad:max_size())
	end
end

function SelectSpawnpointMenuPage:_update_map_markers(dt, t)
	self:_update_area_markers()
	self:_update_squad_markers()
	self:_update_objective_markers()

	if not self._selected_spawn_target then
		self:_select_next_spawn_target()
	end

	self:_update_local_player_markers()
end

function SelectSpawnpointMenuPage:_update_area_markers()
	local spawn_manager = Managers.state.spawn
	local local_player = self._local_player
	local spawn_areas = spawn_manager:spawn_areas()

	for spawn_area_name, spawn_area in pairs(spawn_areas) do
		if not self:find_item_by_name_in_group("spawn_area_markers", spawn_area_name) and spawn_manager:valid_area_spawn_target(local_player, spawn_area_name) then
			self:_add_spawn_area_marker(spawn_area_name, spawn_area.position)
		end
	end

	local spawn_area_markers = self:items_in_group("spawn_area_markers")

	for i = #spawn_area_markers, 1, -1 do
		local item = spawn_area_markers[i]
		local spawn_area_name = item:name()

		if not spawn_manager:valid_area_spawn_target(local_player, spawn_area_name) then
			self:_remove_spawn_area_marker(item)
		end
	end

	local spawn_area_markers = self:items_in_group("spawn_area_markers")

	for _, item in pairs(spawn_area_markers) do
		item.config.selected_spawn_target = item:name() == self._selected_spawn_target
	end
end

function SelectSpawnpointMenuPage:_update_squad_markers()
	local spawn_manager = Managers.state.spawn
	local local_player = self._local_player

	if local_player.team then
		for squad_index, squad in ipairs(local_player.team.squads) do
			for member, _ in pairs(squad:members()) do
				if not self:find_item_by_name_in_group("squad_markers", member) and (spawn_manager:valid_squad_spawn_target(local_player, member.player_unit) or self:_disabled_squad_marker(member)) then
					self:_add_squad_marker(member)
				end
			end
		end
	end

	local squad_markers = self:items_in_group("squad_markers")

	for i = #squad_markers, 1, -1 do
		local item = squad_markers[i]
		local member = item:name()

		if not spawn_manager:valid_squad_spawn_target(local_player, member.player_unit, false) and not self:_disabled_squad_marker(member) then
			self:_remove_squad_marker(item)
		end
	end

	for _, item in ipairs(self:items_in_group("squad_markers")) do
		local member = item:name()

		item.config.disabled = self:_disabled_squad_marker(member)

		if item.config.disabled and self._selected_spawn_target == member then
			self._selected_spawn_target = nil
		end

		item.config.selected_spawn_target = member == self._selected_spawn_target
	end
end

function SelectSpawnpointMenuPage:_update_objective_markers()
	local local_player = self._local_player
	local objective_units = Managers.state.game_mode:objective_units()

	for _, unit in ipairs(objective_units) do
		if not self:find_item_by_name_in_group("objective_markers", unit) and self:_valid_objective_marker(unit) then
			self:_add_objective_marker(unit)
		end
	end

	local objective_markers = self:items_in_group("objective_markers")

	for i = #objective_markers, 1, -1 do
		local item = objective_markers[i]
		local unit = item:name()

		if not self:_valid_objective_marker(unit) then
			self:_remove_objective_marker(item)
		end
	end
end

function SelectSpawnpointMenuPage:_update_local_player_markers()
	local local_player = self._local_player

	if not self:find_item_by_name_in_group("local_player_marker", local_player) and self:_valid_local_player_marker() then
		self:_add_local_player_marker()
	end

	if self:find_item_by_name_in_group("local_player_marker", local_player) and not self:_valid_local_player_marker() then
		self:_remove_local_player_marker()
	end
end

function SelectSpawnpointMenuPage:_disabled_squad_marker(member)
	if not Unit.alive(member.player_unit) or ScriptUnit.extension(member.player_unit, "locomotion_system").ghost_mode then
		return false
	end

	local damage_ext = ScriptUnit.extension(member.player_unit, "damage_system")
	local own_squad_not_corporal = not member.is_corporal and self:_in_own_squad(member) and not damage_ext:is_dead()
	local own_corporal_knocked_down = member.is_corporal and self:_in_own_squad(member) and damage_ext:is_knocked_down() and not damage_ext:is_dead()

	return own_squad_not_corporal or own_corporal_knocked_down
end

function SelectSpawnpointMenuPage:_valid_local_player_marker()
	local local_player = self._local_player

	if Unit.alive(local_player.player_unit) and not ScriptUnit.extension(local_player.player_unit, "damage_system"):is_dead() then
		return true
	end
end

function SelectSpawnpointMenuPage:_valid_objective_marker(unit)
	local objective_units = Managers.state.game_mode:objective_units()

	return table.find(objective_units, unit)
end

function SelectSpawnpointMenuPage:_in_own_squad(member)
	return member.squad_index and member.squad_index == self._local_player.squad_index and self._local_player.team and member.team == self._local_player.team and member ~= self._local_player
end

function SelectSpawnpointMenuPage:_in_other_squad_same_team(member)
	return member.squad_index and member.squad_index ~= self._local_player.squad_index and self._local_player.team and member.team == self._local_player.team and member ~= self._local_player
end

function SelectSpawnpointMenuPage:_select_next_spawn_target()
	for _, item in ipairs(self:items_in_group("squad_markers")) do
		if not item.config.disabled then
			self:cb_select_squad_member(item:name())

			return
		end
	end

	local spawn_manager = Managers.state.spawn
	local highest_prio_area = spawn_manager:spawn_area_with_highest_priority(self._local_player.team.name)

	if highest_prio_area and self:find_item_by_name(highest_prio_area) then
		self:cb_select_spawn_area(highest_prio_area)

		return
	end

	if self._last_selected_spawn_target then
		local item = self:find_item_by_name(self._last_selected_spawn_target)

		if item and item.config.on_select_args[2] == "area" then
			self:cb_select_spawn_area(self._last_selected_spawn_target)

			return
		end
	end

	local random_area_name = spawn_manager:random_area_name(self._local_player.team.name)

	if random_area_name and self:find_item_by_name(random_area_name) then
		self:cb_select_spawn_area(random_area_name)
	end
end

function SelectSpawnpointMenuPage:event_player_joined_squad(player, squad_index)
	if self._local_player.team ~= player.team then
		return
	end

	if self._local_player == player then
		self._squad_info_items[squad_index]:set_joined(true)
		self._squad_button_items[squad_index]:set_text(L("menu_leave_squad"))
		self._squad_button_items[squad_index]:set_callback_name("on_select", "cb_leave_squad")
	end

	local squad_members = player.team.squads[squad_index]:members()
	local num_members = table.size(squad_members)

	self._squad_info_items[squad_index]:set_num_members(num_members)
end

function SelectSpawnpointMenuPage:event_player_left_squad(player, squad_index)
	if self._local_player.team ~= player.team then
		return
	end

	if self._local_player == player then
		self._squad_info_items[squad_index]:set_joined(false)
		self._squad_button_items[squad_index]:set_text(L("menu_join_squad"))
		self._squad_button_items[squad_index]:set_callback_name("on_select", "cb_join_squad")

		local spawn_marker = self:find_item_by_name(self._selected_spawn_target)

		if spawn_marker and spawn_marker.config.on_select_args[2] == "squad_member" then
			self._selected_spawn_target = nil
		end
	end

	local squad_members = player.team.squads[squad_index]:members()
	local num_members = table.size(squad_members)

	self._squad_info_items[squad_index]:set_num_members(num_members)
end

function SelectSpawnpointMenuPage:event_player_joined_team(player)
	if self._local_player.team == player.team then
		for index, squad in pairs(player.team.squads) do
			local num_members = table.size(squad:members())

			self._squad_info_items[index]:set_num_members(num_members)
		end
	end
end

function SelectSpawnpointMenuPage:cb_select_spawn_area(spawn_area_name)
	local local_player = self._local_player

	self:_set_selected_spawn_target(spawn_area_name)

	if local_player.spawn_data.state ~= "spawned" then
		Managers.state.spawn:set_area_spawn_target(local_player, spawn_area_name)
	end
end

function SelectSpawnpointMenuPage:cb_select_squad_member(squad_member)
	local local_player = self._local_player

	if Managers.state.spawn:valid_squad_spawn_target(self._local_player, squad_member.player_unit, false) then
		self:_set_selected_spawn_target(squad_member)

		if local_player.spawn_data.state ~= "spawned" then
			Managers.state.spawn:set_unconfirmed_squad_spawn_target(self._local_player, squad_member.player_unit)
		end
	end
end

function SelectSpawnpointMenuPage:cb_request_spawn_target()
	local spawn_marker = self:find_item_by_name(self._selected_spawn_target)

	if not spawn_marker then
		print("ERROR: SelectSpawnpointMenuPage:cb_request_spawn_target() Requested spawn target does not exist", self._selected_spawn_target)

		return
	end

	Managers.state.event:trigger("close_ingame_menu")
end

function SelectSpawnpointMenuPage:cb_request_spawn_disabled()
	return not self._selected_spawn_target
end

function SelectSpawnpointMenuPage:cb_join_squad(squad_index)
	if self._local_player.team then
		self._local_player.team.squads[squad_index]:request_to_join(self._local_player)
	end
end

function SelectSpawnpointMenuPage:cb_leave_squad(squad_index)
	if self._local_player.team then
		self._local_player.team.squads[squad_index]:request_to_leave(self._local_player)
	end
end

function SelectSpawnpointMenuPage:_add_spawn_area_marker(spawn_area_name, position)
	local config = {
		on_select = "cb_select_spawn_area",
		name = spawn_area_name,
		on_select_args = {
			spawn_area_name,
			"area"
		},
		position = position,
		layout_settings = table.clone(SquadMenuSettings.items.spawn_area_marker),
		parent_page = self,
		sounds = self.config.sounds.items.spawn_area_marker
	}
	local marker = SpawnAreaMarkerMenuItem.create_from_config({
		world = self._world
	}, config, self)

	self:add_item(marker, "spawn_area_markers")
end

function SelectSpawnpointMenuPage:_remove_spawn_area_marker(item)
	if self._selected_spawn_target == item:name() then
		self._selected_spawn_target = nil
	end

	self:remove_item_from_group("spawn_area_markers", item)
end

function SelectSpawnpointMenuPage:_add_objective_marker(objective_unit)
	local icon_name = Unit.get_data(objective_unit, "hud", "icon_name")
	local layout_settings = HUDSettings.world_icons[icon_name]
	local layout_settings_2
	local icon_name_2 = Unit.get_data(objective_unit, "hud", "icon_name_2")

	if icon_name_2 and icon_name_2 ~= "" then
		layout_settings_2 = HUDSettings.world_icons[icon_name_2]
	end

	local objective_ext = ScriptUnit.extension(objective_unit, "objective_system")
	local config = {
		disabled = true,
		name = objective_unit,
		objective_unit = objective_unit,
		blackboard = objective_ext._blackboard,
		local_player = self._local_player,
		layout_settings = layout_settings,
		layout_settings_2 = layout_settings_2
	}
	local marker = ObjectiveMarkerMenuItem.create_from_config({
		world = self._world
	}, config, self)

	self:add_item(marker, "objective_markers")
end

function SelectSpawnpointMenuPage:_remove_objective_marker(item)
	self:remove_item_from_group("objective_markers", item)
end

function SelectSpawnpointMenuPage:_add_squad_marker(player)
	local config = {
		on_select = "cb_select_squad_member",
		name = player,
		on_select_args = {
			player,
			"squad_member"
		},
		player = player,
		local_player = self._local_player,
		layout_settings = table.clone(SquadMenuSettings.items.squad_marker),
		parent_page = self,
		sounds = self.config.sounds.items.squad_marker
	}
	local marker = SquadMarkerMenuItem.create_from_config({
		world = self._world
	}, config, self)

	self:add_item(marker, "squad_markers")
end

function SelectSpawnpointMenuPage:_remove_squad_marker(item)
	if self._selected_spawn_target == item:name() then
		self._selected_spawn_target = nil
	end

	self:remove_item_from_group("squad_markers", item)
end

function SelectSpawnpointMenuPage:_add_local_player_marker()
	local config = {
		disabled = true,
		name = self._local_player,
		player = self._local_player,
		layout_settings = table.clone(SquadMenuSettings.items.local_player_marker)
	}
	local marker = LocalPlayerMarkerMenuItem.create_from_config({
		world = self._world
	}, config, self)

	self:add_item(marker, "local_player_marker")
end

function SelectSpawnpointMenuPage:_remove_local_player_marker()
	local item = self:find_item_by_name_in_group("local_player_marker", self._local_player)

	self:remove_item_from_group("local_player_marker", item)
end

function SelectSpawnpointMenuPage:_set_selected_spawn_target(selected_spawn_target)
	if self._selected_spawn_target then
		local item = self:find_item_by_name(self._selected_spawn_target)

		item:set_selected(false)
	end

	local item = self:find_item_by_name(selected_spawn_target)

	item:set_selected(true)

	self._selected_spawn_target = selected_spawn_target
	self._last_selected_spawn_target = selected_spawn_target
end

function SelectSpawnpointMenuPage:_update_container_size(dt, t)
	SelectSpawnpointMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._squad_header:update_size(dt, t, self._gui, layout_settings.squad_header)
	self._squad_info:update_size(dt, t, self._gui, layout_settings.squad_info)
	self._squad_button:update_size(dt, t, self._gui, layout_settings.squad_button)
	self._spawnpoint:update_size(dt, t, self._gui, layout_settings.spawnpoint)
end

function SelectSpawnpointMenuPage:_update_container_position(dt, t)
	SelectSpawnpointMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._squad_header, layout_settings.squad_header)

	self._squad_header:update_position(dt, t, layout_settings.squad_header, x, y, self.config.z + 15)

	local x, y = MenuHelper:container_position(self._squad_info, layout_settings.squad_info)

	self._squad_info:update_position(dt, t, layout_settings.squad_info, x, y, self.config.z + 15)

	local x, y = MenuHelper:container_position(self._squad_button, layout_settings.squad_button)

	self._squad_button:update_position(dt, t, layout_settings.squad_button, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._spawnpoint, layout_settings.spawnpoint)

	self._spawnpoint:update_position(dt, t, layout_settings.spawnpoint, x, y, self.config.z + 10)
end

function SelectSpawnpointMenuPage:render(dt, t)
	SelectSpawnpointMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._squad_header:render(dt, t, self._gui, layout_settings.squad_header)
	self._squad_info:render(dt, t, self._gui, layout_settings.squad_info)
	self._squad_button:render(dt, t, self._gui, layout_settings.squad_button)
	self._spawnpoint:render(dt, t, self._gui, layout_settings.spawnpoint)
end

function SelectSpawnpointMenuPage:_first_highlightable_index_of_type(type)
	for index, item in ipairs(self._items) do
		if item:highlightable() and (not type or item.config.type == type) then
			return index
		end
	end
end

function SelectSpawnpointMenuPage:_first_item_of_type(type)
	for index, item in ipairs(self._items) do
		if item:highlightable() and (not type or item.config.type == type) then
			return index
		end
	end
end

function SelectSpawnpointMenuPage:_find_index_of_item(selected_item)
	local current_index = 1

	for index, item in ipairs(self._items) do
		if item == selected_item then
			current_index = index

			break
		end
	end

	return current_index
end

function SelectSpawnpointMenuPage:_select_next_spawnpoint()
	local index

	if self._current_spawn_target then
		index = self:_find_index_of_item(self._current_spawn_target)

		local start_index = index

		repeat
			index = index - 1

			if index < 1 then
				index = self:num_items()
			end

			if self._items[index] ~= self._current_spawn_target and self._items[index].config.type == "area_marker" or self._items[index].config.type == "squad_marker" then
				break
			end
		until index == start_index
	else
		index = self:_first_item_of_type("area_marker")
	end

	if index then
		self._items[index]:on_select()

		self._current_spawn_target = self._items[index]
	end
end

function SelectSpawnpointMenuPage:_select_previous_spawnpoint()
	local index

	if self._current_spawn_target then
		index = self:_find_index_of_item(self._current_spawn_target)

		local start_index = index

		repeat
			index = index % self:num_items() + 1

			if self._items[index] ~= self._current_spawn_target and self._items[index].config.type == "area_marker" or self._items[index].config.type == "squad_marker" then
				break
			end
		until index == start_index
	else
		index = self:_first_item_of_type("area_marker")
	end

	if index then
		self._items[index]:on_select()

		self._current_spawn_target = self._items[index]
	end
end

function SelectSpawnpointMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		local index

		if self._current_highlight then
			index = self._current_highlight

			repeat
				index = index - 1

				if index < 1 then
					index = self:num_items()
				end
			until self._items[index].config.type == "texture_button"
		else
			index = self:_first_highlightable_index_of_type("texture_button")
		end

		if index then
			self:_highlight_item(index, false)
		else
			self:_highlight_item(nil, true)
		end
	else
		self.super.move_up(self)
	end
end

function SelectSpawnpointMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		local index

		if self._current_highlight then
			index = self._current_highlight

			repeat
				index = index % self:num_items() + 1
			until self._items[index]:highlightable() and self._items[index].config.type == "texture_button"
		else
			index = self:_first_highlightable_index_of_type("texture_button")
		end

		if index then
			self:_highlight_item(index, false)
		else
			self:_highlight_item(nil, true)
		end
	else
		self.super.move_down(self)
	end
end

function SelectSpawnpointMenuPage:_update_input(input)
	if not input then
		return
	end

	local controller_active = Managers.input:pad_active(1)

	if input:has("select_spawnpoint") and input:get("select_spawnpoint") then
		self:_select_item()

		self._mouse = false
	elseif input:has("move_up") and input:get("move_up") then
		self:move_up()

		self._mouse = false
	elseif input:has("move_down") and input:get("move_down") then
		self:move_down()

		self._mouse = false
	elseif input:has("move_left") and input:get("move_left") then
		self:_select_item()

		self._mouse = false
	elseif input:has("move_right") and input:get("move_right") then
		self:_select_item()

		self._mouse = false
	elseif input:has("cancel") and input:get("cancel") then
		self._mouse = false

		if self.config.on_cancel_input then
			local callback_object = self.config.callback_object

			if self.config.on_cancel_input_callback_object == "page" then
				callback_object = self
			end

			self:_try_callback(callback_object, self.config.on_cancel_input, self.config.on_cancel_input_args)
		end

		if not self.config.no_cancel_to_parent_page then
			self:_cancel()
		end
	end

	if controller_active then
		if input:get("next_spawn_point") then
			self:_select_next_spawnpoint()
		elseif input:get("previous_spawn_point") then
			self:_select_previous_spawnpoint()
		elseif input:get("select_profile") then
			self:_try_callback(self.config.callback_object, "cb_goto", "select_profile")
		elseif input:get("spawn") then
			self:cb_request_spawn_target()
		elseif input:get("leave_battle") then
			local child_page = self._item_groups.back_list[1]:page()

			self._menu_logic:change_page(child_page)
		end
	end
end

function SelectSpawnpointMenuPage:cb_squad_text_visible(squad_num)
	return self._local_player.team and squad_num <= #self._local_player.team.squads
end

function SelectSpawnpointMenuPage:cb_squad_button_visible(squad_num)
	return self._local_player.team and squad_num <= #self._local_player.team.squads
end

function SelectSpawnpointMenuPage:cb_squad_button_disabled(squad_num)
	local player = self._local_player

	if Unit.alive(player.player_unit) and player.spawn_data.state ~= "ghost_mode" then
		return true
	end

	local squad = self._local_player.team and self._local_player.team.squads[squad_num]

	return not squad or not squad:can_join(self._local_player) and not squad:can_leave(self._local_player)
end

function SelectSpawnpointMenuPage:destroy()
	SelectSpawnpointMenuPage.super.destroy(self)
end

function SelectSpawnpointMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = page_config.type_override or "select_spawnpoint",
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		on_enter_highlight_item = page_config.on_enter_highlight_item,
		on_cancel_exit_callback_object = page_config.on_cancel_exit_callback_object,
		on_cancel_exit = page_config.on_cancel_exit,
		on_cancel_exit_args = page_config.on_cancel_exit_args,
		on_cancel_input = page_config.on_cancel_input,
		on_cancel_input_args = page_config.on_cancel_input_args,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return SelectSpawnpointMenuPage:new(config, item_groups, compiler_data.world)
end
