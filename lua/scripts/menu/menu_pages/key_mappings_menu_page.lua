-- chunkname: @scripts/menu/menu_pages/key_mappings_menu_page.lua

KeyMappingsMenuPage = class(KeyMappingsMenuPage, Level4MenuPage)
DirtyPlayerControllerSettings = {}

function KeyMappingsMenuPage:init(config, item_groups, world)
	KeyMappingsMenuPage.super.init(self, config, item_groups, world)

	DirtyPlayerControllerSettings = {}
end

function KeyMappingsMenuPage:on_exit(on_cancel)
	KeyMappingsMenuPage.super.on_exit(self, on_cancel)

	if on_cancel then
		DirtyPlayerControllerSettings = {}
	end
end

function KeyMappingsMenuPage:move_left()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local columns = layout_settings.item_list.number_of_columns
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			if index % columns == 1 then
				index = index - 1
			else
				index = index + columns - 1
			end

			if index < 1 or not self._items[index] then
				index = self:num_items()
			end
		until self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function KeyMappingsMenuPage:move_right()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local columns = layout_settings.item_list.number_of_columns
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			if index % columns == 0 then
				index = index + 1
			else
				index = index - 1
			end

			if index < 1 or not self._items[index] then
				index = self:num_items()
			end
		until self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function KeyMappingsMenuPage:first_item_in_column(current_item)
	local col = current_item.config.column
	local lowest = math.huge

	for i, item in ipairs(self._items) do
		if item:highlightable() and i <= lowest and item.config.column == col then
			lowest = i
		end
	end

	print("LOWEST:", lowest)

	return lowest
end

function KeyMappingsMenuPage:last_item_in_column(current_item)
	local col = current_item.config.column
	local highest = -1

	for i, item in ipairs(self._items) do
		if item:highlightable() and highest <= i and item.config.column == col then
			highest = i
		end
	end

	print("HIGHEST:", highest)

	return highest
end

function KeyMappingsMenuPage:move_up()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local columns = layout_settings.item_list.number_of_columns
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			index = index - columns

			if index < 1 then
				local current_item = self._items[self._current_highlight]

				index = self:last_item_in_column(current_item)

				break
			end
		until not self._items[index] or self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function KeyMappingsMenuPage:move_down()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local columns = layout_settings.item_list.number_of_columns
	local index

	if self._current_highlight then
		index = self._current_highlight

		repeat
			if index > self:num_items() then
				local current_item = self._items[self._current_highlight]

				index = self:first_item_in_column(current_item)

				break
			else
				index = index + columns
			end
		until self._items[index] and self._items[index]:highlightable()
	else
		index = self:_first_highlightable_index()
	end

	if index then
		self:_highlight_item(index, false)
	else
		self:_highlight_item(nil, true)
	end
end

function KeyMappingsMenuPage:set_key_mapping(key, new_key, controller)
	DirtyPlayerControllerSettings[key] = {
		key = new_key,
		controller_type = controller
	}
end

function KeyMappingsMenuPage:cb_reset()
	if Managers.input:active_mapping(1) == "keyboard_mouse" then
		for key, entry in pairs(PlayerControllerSettings.keyboard_mouse) do
			ActivePlayerControllerSettings.keyboard_mouse[key].key = entry.key
			ActivePlayerControllerSettings.keyboard_mouse[key].controller_type = entry.controller_type
		end
	elseif Managers.input:pad_active(1) then
		for key, entry in pairs(PlayerControllerSettings.pad360) do
			ActivePlayerControllerSettings.pad360[key].key = entry.key
			ActivePlayerControllerSettings.pad360[key].controller_type = entry.controller_type
		end
	end

	DirtyPlayerControllerSettings = {}
	SaveData.controls = table.clone(ActivePlayerControllerSettings)

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_done"))

	if self.config.local_player then
		local player = self.config.local_player

		Managers.input:unmap_input_source(player.input_source)

		local input_source = Managers.input:map_slot(player.input_slot, ActivePlayerControllerSettings, nil)

		player.input_source = input_source
	end
end

function KeyMappingsMenuPage:cb_apply_key_mappings()
	for key, entry in pairs(DirtyPlayerControllerSettings) do
		if entry.controller_type == "keyboard" or entry.controller_type == "mouse" then
			ActivePlayerControllerSettings.keyboard_mouse[key].key = entry.key
			ActivePlayerControllerSettings.keyboard_mouse[key].controller_type = entry.controller_type
		elseif entry.controller_type == "pad" then
			ActivePlayerControllerSettings.pad360[key].key = entry.key
			ActivePlayerControllerSettings.pad360[key].controller_type = entry.controller_type
		end
	end

	DirtyPlayerControllerSettings = {}
	SaveData.controls = table.clone(ActivePlayerControllerSettings)

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_done"))

	if self.config.local_player then
		local player = self.config.local_player

		Managers.input:unmap_input_source(player.input_source)

		local input_source = Managers.input:map_slot(player.input_slot, ActivePlayerControllerSettings, nil)

		player.input_source = input_source
	end
end

function KeyMappingsMenuPage:cb_save_done(info)
	if info.error then
		Application.warning("Save error! %q", info.error)
	else
		print("Controls saved!")
	end
end

function KeyMappingsMenuPage:cb_apply_changes_disabled()
	return table.size(DirtyPlayerControllerSettings) == 0
end

function KeyMappingsMenuPage:_handle_input_switch()
	local pad_active = Managers.input:pad_active(1)

	if self._pad_active == nil or pad_active ~= self._pad_active then
		self._pad_active = pad_active
		DirtyPlayerControllerSettings = {}

		return true
	end
end

function KeyMappingsMenuPage:_update_identical_keybindings(highlighted_item)
	if not highlighted_item then
		return
	end

	local selected_key_name = highlighted_item.config.key_name

	if not selected_key_name then
		return
	end

	local prefix = highlighted_item.config.prefix
	local pad_active = Managers.input:pad_active(1)
	local controller_settings = pad_active and "pad360" or "keyboard_mouse"
	local settings = ActivePlayerControllerSettings[controller_settings]
	local dirty_settings = DirtyPlayerControllerSettings
	local selected_key = dirty_settings[selected_key_name] and dirty_settings[selected_key_name].key or settings[selected_key_name].key

	if not selected_key then
		return
	end

	for i, item in ipairs(self._items) do
		if item:highlightable() and item.set_identical_keybinding then
			local key_name = item.config.key_name
			local key = key_name and (dirty_settings[key_name] and dirty_settings[key_name].key or settings[key_name].key)

			if key and key == selected_key and item.config.prefix == prefix then
				item:set_identical_keybinding(true)
			else
				item:set_identical_keybinding(false)
			end
		end
	end
end

function KeyMappingsMenuPage:_update_input(input)
	KeyMappingsMenuPage.super._update_input(self, input)

	if not self:_handle_input_switch() then
		self:_update_identical_keybindings(self:_highlighted_item())
	end

	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if input:get("reset") then
			self:cb_reset()
		elseif input:get("apply") and table.size(DirtyPlayerControllerSettings) > 0 then
			self:cb_apply_key_mappings()
		end
	end

	if table.size(DirtyPlayerControllerSettings) > 0 then
		self.config.button_info_name = "apply_buttons"
	else
		self.config.button_info_name = nil
	end
end

function KeyMappingsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups)
	local config = {
		render_parent_page = true,
		type = "key_mappings",
		parent_page = parent_page,
		z = page_config.z,
		show_revision = page_config.show_revision,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return KeyMappingsMenuPage:new(config, item_groups, compiler_data.world)
end
