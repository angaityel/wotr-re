-- chunkname: @scripts/menu/menu_pages/select_character_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/outfit_list_menu_container")
require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/menu/menu_containers/text_menu_container")

SelectCharacterMenuPage = class(SelectCharacterMenuPage, Level3MenuPage)

function SelectCharacterMenuPage:init(config, item_groups, world)
	SelectCharacterMenuPage.super.init(self, config, item_groups, world)

	self._local_player = config.local_player
	self._profile_info = ProfileInfoMenuContainer.create_from_config()

	self._profile_info:set_active(false)

	local viewer_world_name = self:_try_callback(self.config.callback_object, "cb_profile_viewer_world_name")
	local viewer_viewport = self:_try_callback(self.config.callback_object, "cb_profile_viewer_viewport_name", config.local_player)

	self._profile_viewer = ProfileViewerMenuContainer.create_from_config(viewer_world_name, viewer_viewport, MenuSettings.viewports.spawn_menu_profile_viewer)
	self._selected_profile_name = nil

	self:_add_items()
	Managers.state.event:register(self, "menu_alignment_dummy_spawned", "event_menu_alignment_dummy_spawned")
end

function SelectCharacterMenuPage:event_menu_alignment_dummy_spawned(name, unit)
	if name == "player_without_mount" then
		self._profile_viewer:add_alignment_unit("player_without_mount", unit)
	elseif name == "player_with_mount" then
		self._profile_viewer:add_alignment_unit("player_with_mount", unit)
	elseif name == "mount" then
		self._profile_viewer:add_alignment_unit("mount", unit)
	end
end

function SelectCharacterMenuPage:_add_items()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local header_item_config = {
		text = "menu_select_character",
		disabled = true,
		z = self.config.z + 1,
		layout_settings = layout_settings.header_text,
		parent_page = self,
		sounds = self.config.sounds.items.text
	}
	local header_item = TextMenuItem.create_from_config({
		world = self._world
	}, header_item_config, self)

	self:add_item(header_item, "item_list")

	local options = self:_try_callback(self.config.callback_object, self.config.on_init_options)

	for _, option in pairs(options) do
		local item_config = {
			no_localization = true,
			on_highlight = "cb_profile_highlighted",
			on_select = "cb_profile_selected",
			name = option.key,
			on_highlight_args = {
				option.key
			},
			on_select_args = {
				option.key,
				"character_profile"
			},
			text = option.value,
			z = self.config.z + 1,
			layout_settings = layout_settings.text,
			parent_page = self,
			sounds = self.config.sounds.items.text
		}
		local item = TextMenuItem.create_from_config({
			world = self._world
		}, item_config, self)

		self:add_item(item, "item_list")
	end
end

function SelectCharacterMenuPage:on_enter()
	local select_profile_index = self:_try_callback(self.config.callback_object, self.config.on_enter_selected_option, unpack(self.config.on_enter_selected_option_args or {}))
	local items = self:items_in_group("item_list")

	for _, item in ipairs(items) do
		if item.config.type == "text" and item.config.on_select_args and item.config.on_select_args[2] == "character_profile" then
			local profile_index = item.config.on_select_args[1]
			local unlock_type = "profile"
			local unlock_key = PlayerProfiles[profile_index].unlock_key
			local entity_type = "profile"
			local entity_name = PlayerProfiles[profile_index].unlock_key
			local avalible, unavalible_reason = ProfileHelper:is_entity_avalible(unlock_type, unlock_key, entity_type, entity_name, PlayerProfiles[profile_index].release_name)

			if avalible then
				item.config.disabled = false
				item.config.visible = true

				if select_profile_index == profile_index then
					self:cb_profile_selected(select_profile_index)
				end
			else
				item.config.disabled = true
				item.config.visible = false
			end
		end
	end

	self._on_enter_index = select_profile_index + 1 or true

	SelectCharacterMenuPage.super.on_enter(self)
end

function SelectCharacterMenuPage:_set_selected_profile(profile_name)
	for i, item in ipairs(self:items_in_group("item_list")) do
		if item.config.on_select_args[1] == profile_name then
			item:set_selected(true)
		else
			item:set_selected(false)
		end
	end

	self:_show_profile(profile_name)

	self._selected_profile_name = profile_name
end

function SelectCharacterMenuPage:_show_profile(profile_name)
	self._profile_info:set_active(true)

	if profile_name then
		self._profile_info:load(PlayerProfiles[profile_name])
		self._profile_viewer:load_profile(PlayerProfiles[profile_name])

		local team_name = self._local_player.team and self._local_player.team.name

		if team_name ~= "unassigned" then
			self._profile_viewer:update_coat_of_arms(self._local_player.team.name)

			self._coat_of_arms_team_name = team_name
		end
	else
		self._profile_info:clear()
		self._profile_viewer:clear()
	end
end

function SelectCharacterMenuPage:on_exit(on_cancel)
	SelectCharacterMenuPage.super.on_exit(self, on_cancel)
	self._profile_info:set_active(false)
	self._profile_viewer:clear()
end

function SelectCharacterMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	SelectCharacterMenuPage.super._highlight_item(self, index, ignore_sound)

	if highlighted_item ~= self:_highlighted_item() and not self:is_in_group(self:_highlighted_item(), "item_list") and self:is_in_group(highlighted_item, "item_list") then
		self:_show_profile(self._selected_profile_name)
	end
end

function SelectCharacterMenuPage:cb_profile_highlighted(profile_name)
	self:_show_profile(profile_name)
end

function SelectCharacterMenuPage:cb_profile_selected(profile_name)
	self:_set_selected_profile(profile_name)
	self:_try_callback(self.config.callback_object, self.config.on_option_changed, profile_name)
	Application.set_win32_user_setting("character_selection_profile", profile_name)
	Application.save_win32_user_settings()
end

function SelectCharacterMenuPage:update(dt, t, input)
	self:_update_game_start_timer()
	self:_update_coat_of_arms()
	SelectCharacterMenuPage.super.update(self, dt, t, input)
	self:_update_pad_index()
end

function SelectCharacterMenuPage:_update_pad_index()
	local controller_active = Managers.input:pad_active(1)

	if controller_active and self._on_enter_index then
		if self._on_enter_index == true then
			self:_auto_highlight_first_item()
		else
			local item = self._items[self._on_enter_index]

			if item:highlightable() then
				self:_highlight_item(self._on_enter_index)

				self._on_enter_index = false
			end
		end
	end
end

function SelectCharacterMenuPage:_update_game_start_timer()
	local round_time = Managers.time:time("round")
	local link_item = self:find_item_by_name("select_spawnpoint_button") or self:find_item_by_name("select_spawnpoint_button_ingame")

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

function SelectCharacterMenuPage:_update_coat_of_arms()
	local local_player = self._local_player

	if local_player and local_player.team and local_player.team.name ~= self._coat_of_arms_team_name and local_player.team.name ~= "unassigned" and self._profile_viewer:player_unit() then
		self._profile_viewer:update_coat_of_arms(local_player.team.name)

		self._coat_of_arms_team_name = local_player.team.name
	end
end

function SelectCharacterMenuPage:_update_container_size(dt, t)
	SelectCharacterMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._profile_info:update_size(dt, t, self._gui, layout_settings.profile_info)
	self._profile_viewer:update_size(dt, t, self._gui, layout_settings.profile_viewer)
end

function SelectCharacterMenuPage:_update_container_position(dt, t)
	SelectCharacterMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._profile_info, layout_settings.profile_info)

	self._profile_info:update_position(dt, t, layout_settings.profile_info, x, y, self.config.z + 8)

	local x, y = MenuHelper:container_position(self._profile_viewer, layout_settings.profile_viewer)

	self._profile_viewer:update_position(dt, t, layout_settings.profile_viewer, x, y, self.config.z + 7)
end

function SelectCharacterMenuPage:render(dt, t)
	SelectCharacterMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._profile_info:render(dt, t, self._gui, layout_settings.profile_info)
	self._profile_viewer:render(dt, t, self._gui, layout_settings.profile_viewer)
end

function SelectCharacterMenuPage:_update_input(input)
	if not input then
		return
	end

	local controller_active = Managers.input:pad_active(1)

	if input:has("select") and input:get("select") then
		self:_select_item()

		self._mouse = false
	elseif input:has("move_up") and input:get("move_up") then
		self:move_up()

		self._mouse = false
	elseif input:has("move_down") and input:get("move_down") then
		self:move_down()

		self._mouse = false
	elseif input:has("move_left") and input:get("move_left") then
		self:move_left()

		self._mouse = false
	elseif input:has("move_right") and input:get("move_right") then
		self:move_right()

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
		if input:get("select_team") then
			self:_try_callback(self.config.callback_object, "cb_goto", "select_team")
		elseif input:get("select_spawnpoint") then
			self:_try_callback(self.config.callback_object, "cb_goto", "select_spawnpoint")
		elseif input:get("leave_battle") then
			local child_page = self._item_groups.back_list[1]:page()

			self._menu_logic:change_page(child_page)
		end
	end
end

function SelectCharacterMenuPage:destroy()
	SelectCharacterMenuPage.super.destroy(self)

	if self._profile_viewer then
		self._profile_viewer:destroy()

		self._profile_viewer = nil
	end
end

function SelectCharacterMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "select_character",
		parent_page = parent_page,
		callback_object = callback_object,
		viewport_name = compiler_data.menu_data.viewport_name,
		on_init_options = page_config.on_init_options,
		on_option_changed = page_config.on_option_changed,
		on_enter_highlight_item = page_config.on_enter_highlight_item,
		on_enter_selected_option = page_config.on_enter_selected_option,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		on_cancel_input = page_config.on_cancel_input,
		on_cancel_input_args = page_config.on_cancel_input_args,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return SelectCharacterMenuPage:new(config, item_groups, compiler_data.world)
end
