-- chunkname: @scripts/menu/menu_pages/coat_of_arms_menu_page.lua

require("scripts/menu/menu_containers/coat_of_arms_viewer_menu_container")
require("scripts/helpers/coat_of_arms_helper")

CoatOfArmsMenuPage = class(CoatOfArmsMenuPage, Level3MenuPage)

function CoatOfArmsMenuPage:init(config, item_groups, world)
	CoatOfArmsMenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._containers = {}

	for name, group in pairs(item_groups) do
		if name ~= "back_list" and not string.find(name, "_scroll") then
			self._containers[name] = ItemListMenuContainer.create_from_config(group, item_groups[name .. "_scroll"])
		end
	end

	self._coat_of_arms_viewer = CoatOfArmsViewerMenuContainer.create_from_config("menu_level_world", "menu_level_viewport")

	local alignment_dummy_units = self:_try_callback(self.config.callback_object, "cb_alignment_dummy_units")

	for name, unit in pairs(alignment_dummy_units) do
		self:add_menu_alignment_dummy(name, unit)
	end

	Managers.state.event:register(self, "menu_alignment_dummy_spawned", "add_menu_alignment_dummy")
end

function CoatOfArmsMenuPage:add_menu_alignment_dummy(name, unit)
	if name == "coat_of_arms" then
		self._coat_of_arms_viewer:add_alignment_unit("coat_of_arms", unit)
	end
end

function CoatOfArmsMenuPage:_auto_highlight_first_item()
	return
end

function CoatOfArmsMenuPage:_find_closest_item_in_division()
	local highlighted_item = self._items[self._current_highlight]
	local x, y = highlighted_item._x, highlighted_item._y
	local min_total_diff = math.huge
	local potential_item
	local potential_items = self._division_groups[self._division_selected]

	for _, item in ipairs(potential_items) do
		local diff_x = math.abs(item._y - y)
		local diff_y = math.abs(item._x - x)
		local total_diff = diff_x + diff_y

		if item:visible() and not item.config.hidden and min_total_diff >= math.abs(total_diff - min_total_diff) then
			potential_item = item
			min_total_diff = total_diff
		end
	end

	for index, item in ipairs(self._items) do
		if item == potential_item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:_move_in_division_left()
	local highlighted_item = self._items[self._current_highlight]
	local x, y = highlighted_item._x, highlighted_item._y
	local min_x = math.huge
	local potential_item
	local potential_items = self._division_groups[self._division_selected]

	for _, item in ipairs(potential_items) do
		if item ~= highlighted_item and item:visible() and not item.config.hidden and x > item._x and min_x > x - item._x and item._y == y then
			potential_item = item
			min_x = x - item._x
		end
	end

	for index, item in ipairs(self._items) do
		if item == potential_item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:_move_in_division_right()
	local highlighted_item = self._items[self._current_highlight]
	local x, y = highlighted_item._x, highlighted_item._y
	local min_x = math.huge
	local potential_item
	local potential_items = self._division_groups[self._division_selected]

	for _, item in ipairs(potential_items) do
		if item ~= highlighted_item and item:visible() and not item.config.hidden and x < item._x and min_x > item._x - x and item._y == y then
			potential_item = item
			min_x = item._x - x
		end
	end

	for index, item in ipairs(self._items) do
		if item == potential_item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:_move_in_division_up()
	local highlighted_item = self._items[self._current_highlight]
	local x, y = highlighted_item._x, highlighted_item._y
	local min_diff = math.huge
	local min_y = math.huge
	local potential_item
	local potential_items = self._division_groups[self._division_selected]

	for _, item in ipairs(potential_items) do
		local diff = math.abs(item._y - y)

		if item ~= potential_item and item:visible() and not item.config.hidden and y < item._y and diff <= min_y then
			local total_diff = math.abs(item._x - x) + diff

			if total_diff <= min_diff then
				potential_item = item
				min_diff = total_diff
				min_y = math.abs(item._y - y)
			end
		end
	end

	for index, item in ipairs(self._items) do
		if item == potential_item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:_move_in_division_down()
	local highlighted_item = self._items[self._current_highlight]
	local x, y = highlighted_item._x, highlighted_item._y
	local min_diff = math.huge
	local min_y = math.huge
	local potential_item
	local potential_items = self._division_groups[self._division_selected]

	for _, item in ipairs(potential_items) do
		local diff = math.abs(item._y - y)

		if item ~= highlighted_item and item:visible() and not item.config.hidden and y > item._y and diff <= min_y then
			local total_diff = math.abs(item._x - x) + diff

			if total_diff <= min_diff then
				potential_item = item
				min_diff = total_diff
				min_y = math.abs(item._y - y)
			end
		end
	end

	for index, item in ipairs(self._items) do
		if item == potential_item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:move_left()
	if self._division_selected then
		self:_move_in_division_left()
	else
		self.super.move_left(self)
	end
end

function CoatOfArmsMenuPage:move_right()
	if self._division_selected then
		self:_move_in_division_right()
	else
		self.super.move_right(self)
	end
end

function CoatOfArmsMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if not self._current_division_highlighted then
			self:_select_first_division()

			return
		end

		local items = self:find_items_of_type("division")

		if self._division_selected then
			self:_move_in_division_up()
		else
			self._current_division_highlighted = math.max((self._current_division_highlighted or 0) - 1, 1)

			local selected_item

			for index, item in ipairs(items) do
				if item.config.division_index == self._current_division_highlighted then
					selected_item = item

					break
				end
			end

			for index, item in ipairs(self._items) do
				if selected_item == item then
					self:_highlight_item(index)

					break
				end
			end
		end
	end
end

function CoatOfArmsMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if not self._current_division_highlighted then
			self:_select_first_division()

			return
		end

		local items = self:find_items_of_type("division")

		if self._division_selected then
			self:_move_in_division_down()
		else
			self._current_division_highlighted = math.min((self._current_division_highlighted or 0) + 1, #items)

			local selected_item

			for index, item in ipairs(items) do
				if item.config.division_index == self._current_division_highlighted then
					selected_item = item

					break
				end
			end

			for index, item in ipairs(self._items) do
				if selected_item == item then
					self:_highlight_item(index)

					break
				end
			end
		end
	end
end

function CoatOfArmsMenuPage:on_enter()
	CoatOfArmsMenuPage.super.on_enter(self)

	self._coat_of_arms_copy = table.clone(PlayerCoatOfArms)

	self._coat_of_arms_viewer:load_coat_of_arms(self._coat_of_arms_copy, 2, -0.15, 0.2)

	self._last_selected_name_in_group = {}

	self:_set_item_group_selection("division_field_color_picker", self._coat_of_arms_copy.field_color)
	self:_set_item_group_selection("division_color_picker", self._coat_of_arms_copy.division_color)
	self:_set_item_group_selection("division_field_variation_type_picker", self._coat_of_arms_copy.variation_1_type)
	self:_set_item_group_selection("division_variation_type_picker", self._coat_of_arms_copy.variation_2_type)
	self:_set_item_group_selection("division_field_variation_color_picker", self._coat_of_arms_copy.variation_1_color)
	self:_set_item_group_selection("division_variation_color_picker", self._coat_of_arms_copy.variation_2_color)
	self:_set_item_group_selection("division_type_picker", self._coat_of_arms_copy.division_type)
	self:_set_item_group_selection("ordinary_color_picker", self._coat_of_arms_copy.ordinary_color)
	self:_set_item_group_selection("ordinary_type_picker", self._coat_of_arms_copy.ordinary_type)
	self:_set_item_group_selection("charge_color_picker", self._coat_of_arms_copy.charge_color)
	self:_set_item_group_selection("charge_type_picker", self._coat_of_arms_copy.charge_type)
	self:_set_item_group_selection("crest_picker", self._coat_of_arms_copy.crest)
	self:_create_division_groups()

	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		self._division_selected = nil
		self._current_division_highlighted = nil

		self:_select_first_division()
	end
end

function CoatOfArmsMenuPage:_select_first_division()
	local items = self:find_items_of_type("division")

	self._current_division_highlighted = 1

	local selected_item

	for index, item in ipairs(items) do
		if item.config.division_index == self._current_division_highlighted then
			selected_item = item

			break
		end
	end

	for index, item in ipairs(self._items) do
		if selected_item == item then
			self:_highlight_item(index)

			break
		end
	end
end

function CoatOfArmsMenuPage:_create_division_groups()
	local division = {}

	table.append(division, self._item_groups.division_field_color_picker)
	table.append(division, self._item_groups.division_color_picker)
	table.append(division, self._item_groups.division_field_variation_type_picker)
	table.append(division, self._item_groups.division_variation_type_picker)
	table.append(division, self._item_groups.division_field_variation_color_picker)
	table.append(division, self._item_groups.division_variation_color_picker)
	table.append(division, self._item_groups.division_type_picker)

	local ordinary = {}

	table.append(ordinary, self._item_groups.ordinary_color_picker)
	table.append(ordinary, self._item_groups.ordinary_type_picker)

	local charge = {}

	table.append(charge, self._item_groups.charge_color_picker)
	table.append(charge, self._item_groups.charge_type_picker)

	local crest = {}

	table.append(crest, self._item_groups.crest_picker)

	self._division_groups = {
		division = division,
		ordinary = ordinary,
		charge = charge,
		crest = crest
	}
end

function CoatOfArmsMenuPage:on_exit()
	CoatOfArmsMenuPage.super.on_exit(self)
	self._coat_of_arms_viewer:clear()

	if self._changes_made then
		self:_save_coat_of_arms()

		self._changes_made = false
	end
end

function CoatOfArmsMenuPage:_save_coat_of_arms()
	PlayerCoatOfArms = self._coat_of_arms_copy
	SaveData.player_coat_of_arms = self._coat_of_arms_copy

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_coat_of_arms_saved"))
	Managers.state.event:trigger("event_save_started", "menu_saving_profile", "menu_profile_saved")
end

function CoatOfArmsMenuPage:cb_coat_of_arms_saved(info)
	if info.error then
		Application.warning("Save error %q", info.error)
	end

	Managers.state.event:trigger("event_save_finished")
end

function CoatOfArmsMenuPage:_set_item_group_selection(group_name, selection_name)
	for _, item in ipairs(self._item_groups[group_name]) do
		local selected = item.config.on_select_args[1] == selection_name

		item:set_selected(selected)

		if selected then
			self._last_selected_name_in_group[group_name] = selection_name
		end
	end
end

function CoatOfArmsMenuPage:_update_ui_team_name(group_name, selection_name)
	if (selection_name == "team_primary" or selection_name == "team_secondary") and self._last_selected_name_in_group[group_name] == selection_name then
		self._coat_of_arms_copy.ui_team_name = self._coat_of_arms_copy.ui_team_name == "red" and "white" or "red"
	end
end

function CoatOfArmsMenuPage:_update_container_size(dt, t)
	CoatOfArmsMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	for name, container in pairs(self._containers) do
		container:update_size(dt, t, self._gui, layout_settings[name])
	end

	self._coat_of_arms_viewer:update_size(dt, t, self._gui, layout_settings.coat_of_arms_viewer)

	layout_settings.background_texture.stretch_height = self._containers.header:y() + self._containers.header:height() - self._containers.crest_picker:y()

	self._background_texture:update_size(dt, t, self._gui, layout_settings.background_texture)
end

function CoatOfArmsMenuPage:_update_container_position(dt, t)
	CoatOfArmsMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	for name, container in pairs(self._containers) do
		local x, y = MenuHelper:container_position(container, layout_settings[name])

		container:update_position(dt, t, layout_settings[name], x, y, self.config.z + 15)
	end

	local x, y = MenuHelper:container_position(self._coat_of_arms_viewer, layout_settings.coat_of_arms_viewer)

	self._coat_of_arms_viewer:update_position(dt, t, layout_settings.coat_of_arms_viewer, x, y, self.config.z + 20)

	local x = self._containers.header:x() + self._containers.header:width() - self._background_texture:width()
	local y = self._containers.crest_picker:y()

	self._background_texture:update_position(dt, t, layout_settings.background_texture, x, y, self.config.z + 10)
end

function CoatOfArmsMenuPage:render(dt, t)
	CoatOfArmsMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	for name, container in pairs(self._containers) do
		container:render(dt, t, self._gui, layout_settings[name])
	end

	self._coat_of_arms_viewer:render(dt, t, self._gui, layout_settings.coat_of_arms_viewer)
	self._background_texture:render(dt, t, self._gui, layout_settings.background_texture)

	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		self._current_division_highlighted = nil
		self._division_selected = nil
	elseif self._division_selected then
		self:_render_division_buttons(layout_settings)
	end
end

function CoatOfArmsMenuPage:_render_division_buttons(layout_settings)
	local division_specific_rendering = layout_settings.button_info.division_specific_rendering[self._division_selected]

	if division_specific_rendering then
		self[division_specific_rendering](self, layout_settings)
	end
end

function CoatOfArmsMenuPage:_render_charge_buttons(layout_settings)
	local items = self:find_items_of_type("division")
	local dimensions

	for _, item in pairs(items) do
		if item.config.name == "charge" then
			local item_layout_settings = MenuHelper:layout_settings(item.config.layout_settings)

			dimensions = {
				item._x,
				item._y,
				item_layout_settings.division_rect[1],
				item_layout_settings.division_rect[2]
			}
		end
	end

	if dimensions then
		local w, h = Gui.resolution()
		local x = dimensions[1] + dimensions[3]
		local y = dimensions[2] - dimensions[4] * 0.18
		local offset_x = 0
		local scale_x = math.min(w / 1920, 1)
		local material, uv00, uv11, size = self:get_button_bitmap("right_button")

		Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x - size[1] * scale_x, y - size[2] * 0.5 * scale_x, 999), size * scale_x)

		offset_x = offset_x - size[1] * scale_x

		local text_data = layout_settings.button_info.text_data
		local font = text_data.font.font
		local material = text_data.font.material
		local font_size = text_data.font_size
		local current_page = self._containers.charge_type_picker:current_page(layout_settings.charge_type_picker)
		local num_pages = self._containers.charge_type_picker:num_pages(layout_settings.charge_type_picker)
		local text = current_page .. "/" .. num_pages
		local min, max = Gui.text_extents(self._button_gui, text, font, font_size)
		local extents = {
			max[1] - min[1],
			max[3] - min[3]
		}

		Gui.text(self._button_gui, text, font, font_size, material, Vector3(x + offset_x - extents[1] * 0.5 - size[1] * scale_x * 0.5, y - size[1] * 0.1, 999))

		offset_x = offset_x - size[1] * scale_x

		local material, uv00, uv11, size = self:get_button_bitmap("left_button")

		Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x - size[1] * scale_x, y - size[2] * 0.5 * scale_x, 999), size * scale_x)
	end
end

function CoatOfArmsMenuPage:_render_button_info(layout_settings)
	local button_config = self._division_selected and layout_settings.division_selected_buttons or layout_settings.default_buttons
	local text_data = layout_settings.text_data
	local w, h = Gui.resolution()
	local x = text_data.offset_x
	local y = text_data.offset_y
	local offset_x = 0

	for _, button in ipairs(button_config) do
		local material, uv00, uv11, size = self:get_button_bitmap(button.button_name)

		Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x, y - size[2], 999), size)

		local text = string.upper(L(button.text))

		Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + size[1] + offset_x, y - size[2] * 0.62, 999))

		local min, max = Gui.text_extents(self._button_gui, text, text_data.font.font, text_data.font_size)

		offset_x = offset_x + (max[1] - min[1]) + size[2]
	end
end

function CoatOfArmsMenuPage:_update_input(input)
	self.super._update_input(self, input)

	local controller_active = Managers.input:pad_active(1)

	if controller_active and self._division_selected then
		if input:get("tab_left") then
			self:cb_scroll_up_charge_type_picker()

			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._containers.charge_type_picker:update_size(0, 0, self._gui, layout_settings.charge_type_picker)
			self:_find_closest_item_in_division()
		elseif input:get("tab_right") then
			self:cb_scroll_down_charge_type_picker()

			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._containers.charge_type_picker:update_size(0, 0, self._gui, layout_settings.charge_type_picker)
			self:_find_closest_item_in_division()
		end
	end
end

function CoatOfArmsMenuPage:cb_scroll_up_charge_type_picker()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._containers.charge_type_picker:scroll_up(layout_settings.charge_type_picker)
end

function CoatOfArmsMenuPage:cb_scroll_down_charge_type_picker()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._containers.charge_type_picker:scroll_down(layout_settings.charge_type_picker)
end

function CoatOfArmsMenuPage:cb_field_color_selected(name)
	self:_update_ui_team_name("division_field_color_picker", name)
	self:_set_item_group_selection("division_field_color_picker", name)

	self._coat_of_arms_copy.field_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_division_color_selected(name)
	self:_update_ui_team_name("division_color_picker", name)
	self:_set_item_group_selection("division_color_picker", name)

	self._coat_of_arms_copy.division_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_field_variation_color_selected(name)
	self:_update_ui_team_name("division_field_variation_color_picker", name)
	self:_set_item_group_selection("division_field_variation_color_picker", name)

	self._coat_of_arms_copy.variation_1_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_division_variation_color_selected(name)
	self:_update_ui_team_name("division_variation_color_picker", name)
	self:_set_item_group_selection("division_variation_color_picker", name)

	self._coat_of_arms_copy.variation_2_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_division_variation_type_selected(name)
	self:_set_item_group_selection("division_variation_type_picker", name)

	self._coat_of_arms_copy.variation_2_type = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_field_variation_type_selected(name)
	self:_set_item_group_selection("division_field_variation_type_picker", name)

	self._coat_of_arms_copy.variation_1_type = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_division_type_selected(name)
	self:_set_item_group_selection("division_type_picker", name)

	self._coat_of_arms_copy.division_type = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_ordinary_color_selected(name)
	self:_update_ui_team_name("ordinary_color_picker", name)
	self:_set_item_group_selection("ordinary_color_picker", name)

	self._coat_of_arms_copy.ordinary_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_ordinary_type_selected(name)
	self:_set_item_group_selection("ordinary_type_picker", name)

	self._coat_of_arms_copy.ordinary_type = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_charge_color_selected(name)
	self:_update_ui_team_name("charge_color_picker", name)
	self:_set_item_group_selection("charge_color_picker", name)

	self._coat_of_arms_copy.charge_color = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_charge_type_selected(name)
	self:_set_item_group_selection("charge_type_picker", name)

	self._coat_of_arms_copy.charge_type = name
	self._changes_made = true

	self._coat_of_arms_viewer:set_coat_of_arms_material_properties(self._coat_of_arms_copy)
end

function CoatOfArmsMenuPage:cb_crest_selected(name)
	self:_set_item_group_selection("crest_picker", name)

	self._coat_of_arms_copy.crest = name
	self._changes_made = true

	self._coat_of_arms_viewer:load_coat_of_arms(self._coat_of_arms_copy, 2, -0.15, 0.2)
end

function CoatOfArmsMenuPage:_find_top_left_item(items)
	local x, y = math.huge, -math.huge
	local selected_item

	for _, item in ipairs(items) do
		if x >= item._x then
			x = item._x

			if y <= item._y then
				y = item._y
				selected_item = item
			end
		end
	end

	return selected_item
end

function CoatOfArmsMenuPage:cb_division_selected(division)
	local items = self._division_groups[division]

	if items and #items > 0 then
		self._division_selected = division

		local selected_item = self:_find_top_left_item(items)

		for index, item in ipairs(self._items) do
			if item == selected_item then
				self:_highlight_item(index)

				break
			end
		end
	end
end

function CoatOfArmsMenuPage:_cancel()
	local controller_active = Managers.input:pad_active(1)

	if self._division_selected and controller_active then
		self._division_selected = nil

		local items = self:find_items_of_type("division")
		local selected_item

		for index, item in ipairs(items) do
			if item.config.division_index == self._current_division_highlighted then
				selected_item = item

				break
			end
		end

		for index, item in ipairs(self._items) do
			if selected_item == item then
				self:_highlight_item(index)

				break
			end
		end
	else
		self.super._cancel(self)
	end
end

function CoatOfArmsMenuPage:destroy()
	CoatOfArmsMenuPage.super.destroy(self)

	if self._coat_of_arms_viewer then
		self._coat_of_arms_viewer:destroy()

		self._coat_of_arms_viewer = nil
	end
end

function CoatOfArmsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "coat_of_arms_level_2",
		parent_page = parent_page,
		callback_object = callback_object,
		viewport_name = compiler_data.menu_data.viewport_name,
		on_option_changed = page_config.on_option_changed,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return CoatOfArmsMenuPage:new(config, item_groups, compiler_data.world)
end
