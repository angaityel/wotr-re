-- chunkname: @scripts/game_state/state_test_gear.lua

require("scripts/menu/menu_containers/profile_viewer_menu_container")
require("scripts/managers/camera/camera_manager")
require("scripts/menu/menus/main_menu")
require("scripts/settings/menu_settings")
require("scripts/settings/player_profiles")
require("scripts/settings/gear_to_test")
require("scripts/settings/release_settings")
require("scripts/menu/menu_definitions/main_menu_settings_1920")
require("scripts/menu/menu_definitions/main_menu_settings_1366")
require("scripts/menu/menu_definitions/main_menu_settings_low")

StateTestGear = class(StateTestGear)

function StateTestGear:on_enter()
	self:_setup_default_profile()
	self:_setup_world()
	self:_setup_state_context()
	self:_load_level()
	self:_setup_profile_viewer()
	self:_setup_variables()
end

function StateTestGear:_setup_world()
	self._world_name = "test_gear_world"
	self._viewport_name = "test_gear_viewport"

	local shading_callback = callback(self, "shading_callback")

	self._world = Managers.world:create_world(self._world_name, GameSettingsDevelopment.default_environment, shading_callback, nil, Application.DISABLE_PHYSICS)
	self._viewport = ScriptWorld.create_viewport(self._world, self._viewport_name, "default")
	self._gui = World.create_screen_gui(self._world, "material", "materials/menu/menu", "material", "materials/fonts/hell_shark_font", "material", MenuSettings.font_group_materials.arial, "immediate")
end

function StateTestGear:_load_level()
	self._level = ScriptWorld.load_level(self._world, "levels/test_gear/world")

	World.set_flow_callback_object(self._world, self)
	Level.spawn_background(self._level)
	Level.trigger_level_loaded(self._level)
end

function StateTestGear:_setup_profile_viewer()
	self._profile_viewer = ProfileViewerMenuContainer.create_from_config(self._world_name, self._viewport_name, MenuSettings.viewports.main_menu_profile_viewer)
end

function StateTestGear:_setup_state_context()
	Managers.time:register_timer("menu", "main")

	Managers.state.event = EventManager:new()
	Managers.state.camera = CameraManager:new(self._world)

	Managers.state.camera:add_viewport(self._viewport_name, Vector3.zero(), Quaternion.identity())
	Managers.state.camera:load_node_tree(self._viewport_name, "default", "main_menu")
	Managers.state.camera:set_camera_node(self._viewport_name, "default", "default")
	Managers.state.camera:set_variable(self._viewport_name, "look_controller_input", Vector3.zero())
	Managers.state.camera:change_environment("default", 0)
end

function StateTestGear:_setup_variables()
	self._start_testing = false
	self._categories = {
		"Helmets",
		"Armours",
		"Gear",
		"MountProfiles",
		"Heads"
	}
	self._current_category = 1
	self._current_index = 1
	self._current_attachment = 1
	self._attachment_category_index = 1
	self._current_attachment_items = nil
end

function StateTestGear:shading_callback(world, shading_env)
	Managers.state.camera:shading_callback(world, shading_env)
end

function StateTestGear:update(dt, t)
	local t = Managers.time:time("menu")

	self:_update_input()
	self:_update_managers(dt)

	local layout_settings = MenuHelper:layout_settings(MainMenuSettings.pages.level_2_character_profiles)

	self:_update_size(dt, t, layout_settings)
	self:_update_position(dt, t, layout_settings)
	self:_update_gear()
	self:_render(dt, t, layout_settings)
end

function StateTestGear:_index_items(in_table)
	local items = {}

	if in_table then
		for name, _ in pairs(in_table) do
			items[#items + 1] = name
		end
	end

	return items
end

function StateTestGear:_get_gear_attachments(attachments)
	local temp = 3
	local selected_attachments = {}
	local increment_category = false
	local next_item = false
	local unreleased_attachments

	for index, data in ipairs(attachments) do
		if index == self._attachment_category_index then
			selected_attachments[data.category] = data.items[self._current_attachment].name

			local release_setting = ReleaseSettings[data.items[self._current_attachment].release_name]

			if release_setting == "test" or release_setting == "hide" then
				unreleased_attachments = unreleased_attachments or {}
				unreleased_attachments[#unreleased_attachments + 1] = {
					type = data.items[self._current_attachment].type,
					name = data.items[self._current_attachment].name,
					release_name = data.items[self._current_attachment].release_name,
					release_setting = release_setting
				}
			end

			self._current_attachment = self._current_attachment + 1

			if not data.items[self._current_attachment] then
				increment_category = true
			end
		else
			selected_attachments[data.category] = data.items[1].name

			local release_setting = ReleaseSettings[data.items[1].release_name]

			if release_setting == "test" or release_setting == "hide" then
				unreleased_attachments = unreleased_attachments or {}
				unreleased_attachments[#unreleased_attachments + 1] = {
					type = data.items[1].type,
					name = data.items[1].name,
					release_name = data.items[1].release_name,
					release_setting = release_setting
				}
			end
		end
	end

	if increment_category then
		self._attachment_category_index = self._attachment_category_index + 1
		self._current_attachment = 1

		if not attachments[self._attachment_category_index] then
			self._attachment_category_index = 1
			self._crests = nil
			self._current_crest = nil
			next_item = true
		end
	end

	return selected_attachments, next_item, unreleased_attachments
end

function StateTestGear:_stringify_attachment_table(attachment_table)
	local str = ""

	for name, attachment in pairs(attachment_table) do
		str = str .. " name: " .. name .. " - " .. attachment .. "    "
	end

	return str
end

function StateTestGear:_update_gear()
	if not self._start_testing then
		return
	end

	local category = self._categories[self._current_category]
	local gear_list = GearToTest[category]
	local gear_to_test = gear_list and gear_list[self._current_index]
	local attachment_name
	local show_unreleased_warning = false
	local show_test_warning = false
	local available_in_release = ""
	local skip_test = false
	local selected_attachments, next_index, unreleased_attachments

	self._crests = self._crests or self:_index_items(HelmetCrests)
	self._current_crest = self._current_crest or 1

	if gear_to_test then
		if category == "Helmets" then
			show_unreleased_warning = ReleaseSettings[Helmets[gear_to_test].release_name] == "hide"
			show_test_warning = ReleaseSettings[Helmets[gear_to_test].release_name] == "test"
			available_in_release = Helmets[gear_to_test].release_name
			self._default_profile.helmet.name = gear_to_test
			self._default_profile.helmet.attachments = {}
			self._current_attachment_items = self._current_attachment_items or self:_index_items(Helmets[gear_to_test].attachments)

			local available_attachments = Helmets[gear_to_test].attachments

			if Helmets[gear_to_test].has_crest and self._crests[self._current_crest] then
				attachment_name = self._crests[self._current_crest]
				PlayerCoatOfArms.crest = self._crests[self._current_crest]
				self._current_crest = self._current_crest + 1
				self._default_profile.helmet.show_crest = true
			else
				self._default_profile.helmet.show_crest = false
				attachment_name = self._current_attachment_items[self._current_attachment]

				if attachment_name ~= "default_unlocks" and attachment_name then
					local current_attachment = available_attachments[self._current_attachment_items[self._current_attachment]]

					self._default_profile.helmet.attachments[current_attachment.type] = attachment_name

					local release_setting = ReleaseSettings[current_attachment.release_name]

					if release_setting == "test" or release_setting == "hide" then
						unreleased_attachments = unreleased_attachments or {}
						unreleased_attachments[#unreleased_attachments + 1] = {
							type = current_attachment.type,
							name = attachment_name,
							release_name = current_attachment.release_name,
							release_setting = release_setting
						}
					end
				end

				self._current_attachment = self._current_attachment + 1
			end

			if not self._current_attachment_items[self._current_attachment] then
				self._current_index = self._current_index + 1
				self._current_attachment_items = nil
				self._current_attachment = 1
				self._current_crest = 1
				next_index = true
			end
		elseif category == "Armours" then
			show_unreleased_warning = ReleaseSettings[Armours[gear_to_test].release_name] == "hide"
			show_test_warning = ReleaseSettings[Armours[gear_to_test].release_name] == "test"
			available_in_release = Armours[gear_to_test].release_name

			local test = Armours[gear_to_test]

			self._default_profile.armour = gear_to_test
			self._default_profile.armour_attachments = {
				patterns = 1
			}
			self._current_attachment_items = self._current_attachment_items or Armours[gear_to_test].attachment_definitions.patterns

			if self._current_attachment_items[self._current_attachment] then
				self._default_profile.armour_attachments = {
					patterns = self._current_attachment
				}
				attachment_name = self._current_attachment_items[self._current_attachment].name

				local release_setting = ReleaseSettings[self._current_attachment_items[self._current_attachment].release_name]

				if release_setting == "test" or release_setting == "hide" then
					unreleased_attachments = unreleased_attachments or {}
					unreleased_attachments[#unreleased_attachments + 1] = {
						type = self._current_attachment_items[self._current_attachment].type,
						name = self._current_attachment_items[self._current_attachment].name,
						release_name = self._current_attachment_items[self._current_attachment].release_name,
						release_setting = release_setting
					}
				end

				self._current_attachment = self._current_attachment + 1
			else
				self._current_index = self._current_index + 1
				self._current_attachment_items = nil
				self._current_attachment = 1
				skip_test = true
				next_index = true
			end
		elseif category == "Gear" then
			show_unreleased_warning = ReleaseSettings[Gear[gear_to_test].release_name] == "hide"
			show_test_warning = ReleaseSettings[Gear[gear_to_test].release_name] == "test"
			available_in_release = Gear[gear_to_test].release_name

			local test = Gear[gear_to_test]

			self._default_profile.wielded_gear = {
				{
					name = gear_to_test
				}
			}

			local attachments = Gear[gear_to_test].attachments

			selected_attachments, next_index, unreleased_attachments = self:_get_gear_attachments(attachments)
			self._default_profile.gear = {
				{
					name = gear_to_test,
					attachments = selected_attachments
				}
			}
			attachment_name = self:_stringify_attachment_table(selected_attachments)

			if next_index then
				self._current_index = self._current_index + 1
				self._attachment_category_index = 1
				self._current_attachment = 1
				next_index = true
			end
		elseif category == "MountProfiles" then
			show_unreleased_warning = ReleaseSettings[MountProfiles[gear_to_test].release_name] == "hide"
			show_test_warning = ReleaseSettings[MountProfiles[gear_to_test].release_name] == "test"
			self._default_profile.mount = gear_to_test
			self._current_index = self._current_index + 1
			next_index = true
		elseif category == "Heads" then
			self._default_profile.head = gear_to_test

			local material_variation = Heads[gear_to_test].material_variations[self._current_attachment]

			self._default_profile.head_material = material_variation
			attachment_name = material_variation
			self._current_attachment = self._current_attachment + 1

			if not Heads[gear_to_test].material_variations[self._current_attachment] then
				self._current_index = self._current_index + 1
				self._current_attachment = 1
				next_index = true
			end
		end

		if not gear_list[self._current_index] then
			self._current_category = self._current_category + 1
			self._current_index = 1
		end

		if not skip_test and attachment_name ~= "default_unlocks" then
			if show_unreleased_warning then
				Application.error(category .. " Name: " .. gear_to_test .. " attachment: " .. tostring(attachment_name) .. " Release: " .. available_in_release)

				if next_index then
					Application.error("")
				end
			elseif show_test_warning then
				Application.warning(category .. " Name: " .. gear_to_test .. " attachment: " .. tostring(attachment_name) .. " Release: " .. available_in_release)

				if next_index then
					Application.warning("")
				end
			else
				print(category, "Name:", gear_to_test, "attachment:", attachment_name)

				if next_index then
					print("")
				end
			end

			if unreleased_attachments then
				Application.error(gear_to_test .. " has unreleased attachments: ")

				for _, data in ipairs(unreleased_attachments) do
					if data.release_setting == "hide" then
						Application.error("\t" .. "type: " .. tostring(data.type) .. " name: " .. data.name .. " release: " .. data.release_name)
					elseif data.release_setting == "test" then
						Application.warning("\t" .. "type: " .. tostring(data.type) .. " name: " .. data.name .. " release: " .. data.release_name)
					end
				end
			end
		end

		if not skip_test then
			self._profile_viewer:load_profile(self._default_profile)
		end
	elseif self._categories[self._current_category + 1] then
		self._current_category = self._current_category + 1
	else
		print("")
		self:_verify_item_list()

		self._start_testing = false

		print("##################### TEST ENDED #####################")
		print("")
	end
end

function StateTestGear:_verify_item_list()
	local list = GearToTest

	for _, category in ipairs(self._categories) do
		local category_table = rawget(_G, category)

		for name, item in pairs(category_table) do
			if not table.contains(GearToTest[category], name) and ReleaseSettings[item.release_name] == "live" then
				Application.error(category .. ": " .. name .. " is live but isn't specified in the test list")
			end
		end
	end
end

function StateTestGear:post_update(dt)
	Managers.state.camera:post_update(dt, self._viewport_name)
end

function StateTestGear:_update_managers(dt)
	Managers.state.camera:update(dt, self._viewport_name)
end

function StateTestGear:_render(dt, t, layout_settings)
	self._profile_viewer:render(dt, t, nil, layout_settings)
end

function StateTestGear:_update_input()
	if Keyboard.pressed(Keyboard.button_index("enter")) then
		self._profile_viewer:load_profile(self._default_profile)

		self._start_testing = true
		self._current_category = 1
		self._current_index = 1
		self._current_attachment = 1
		self._current_attachment_items = nil
		self._attachment_category_index = 1

		print("##################### TEST STARTED #####################")
	end

	if Keyboard.pressed(Keyboard.button_index("esc")) then
		Application.quit()
	end
end

function StateTestGear:_update_size(dt, t, layout_settings)
	self._profile_viewer:update_size(dt, t, self._gui, layout_settings.profile_viewer)
end

function StateTestGear:_update_position(dt, t, layout_settings)
	local x, y = MenuHelper:container_position(self._profile_viewer, layout_settings.profile_viewer)

	self._profile_viewer:update_position(dt, t, layout_settings.profile_viewer, x, y, 10)
end

function StateTestGear:on_exit()
	World.destroy_gui(self._world, self._gui)
	Managers.world:destroy_world(self._world)
end

function StateTestGear:_setup_default_profile()
	self._default_profile = {
		head = "squire",
		unlock_key = "footman",
		display_name = "profile_slot_1",
		demo_unlocked = true,
		no_editing = true,
		armour = "armour_medium_tights",
		release_name = "test_dude",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			officer_specialization_2 = "armour",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "courage",
			offensive_specialization_2 = "break_block",
			defensive_specialization_1 = "shield_wall",
			defensive_basic = "shield_bearer",
			movement_basic = "cavalry",
			supportive_specialization_2 = "barber_surgeon",
			defensive_specialization_2 = "shield_expert",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "runner",
			supportive_basic = "surgeon",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "steel_domed_shield"
			}
		},
		gear = {
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"italian_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"convex"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "steel_domed_shield",
				attachments = {
					plate_shield_plate = {
						"steel"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				visor = "visor_standard",
				coif = "bevor_01"
			}
		},
		script_input = ScriptInputSettings.melee
	}
end
