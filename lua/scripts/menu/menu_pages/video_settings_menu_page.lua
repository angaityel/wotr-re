-- chunkname: @scripts/menu/menu_pages/video_settings_menu_page.lua

require("scripts/settings/render_settings_templates")

VideoSettingsMenuPage = class(VideoSettingsMenuPage, Level3MenuPage)
VideoSettingsMenuPage.needs_restart = {
	"texture_quality_characters",
	"texture_quality_environment",
	"texture_quality_coat_of_arms"
}

function VideoSettingsMenuPage:init(config, item_groups, world)
	VideoSettingsMenuPage.super.init(self, config, item_groups, world)

	self._original_user_settings = {}
	self._original_render_settings = {}
	self._changed_user_settings = {}
	self._changed_render_settings = {}
end

function VideoSettingsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups)
	local config = {
		render_parent_page = true,
		type = "video_settings",
		parent_page = parent_page,
		show_revision = page_config.show_revision,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return VideoSettingsMenuPage:new(config, item_groups, compiler_data.world)
end

function VideoSettingsMenuPage:on_enter(on_cancel)
	if not on_cancel then
		self._original_user_settings = {
			fullscreen = Application.user_setting("fullscreen"),
			fullscreen_output = Application.user_setting("fullscreen_output"),
			screen_resolution = Application.user_setting("screen_resolution"),
			graphics_quality = Application.user_setting("graphics_quality"),
			shadow_quality = Application.user_setting("shadow_quality"),
			texture_quality_characters = Application.user_setting("texture_quality_characters"),
			texture_quality_environment = Application.user_setting("texture_quality_environment"),
			texture_quality_coat_of_arms = Application.user_setting("texture_quality_coat_of_arms"),
			particles_quality = Application.user_setting("particles_quality"),
			max_stacking_frames = Application.user_setting("max_stacking_frames"),
			light_casts_shadows = Application.user_setting("light_casts_shadows"),
			gamma = Application.user_setting("gamma"),
			vsync = Application.user_setting("vsync"),
			max_fps = Application.user_setting("max_fps")
		}
		self._original_render_settings = {
			fxaa_enabled = Application.user_setting("render_settings", "fxaa_enabled"),
			ssao_enabled = Application.user_setting("render_settings", "ssao_enabled"),
			lod_object_multiplier = Application.user_setting("render_settings", "lod_object_multiplier"),
			lod_decoration_density = Application.user_setting("render_settings", "lod_decoration_density"),
			lod_scatter_density = Application.user_setting("render_settings", "lod_scatter_density")
		}
	end

	VideoSettingsMenuPage.super.on_enter(self, on_cancel)
end

function VideoSettingsMenuPage:cb_apply_changes_disabled()
	return not self:_changes_made()
end

function VideoSettingsMenuPage:_changes_made()
	return table.size(self._changed_user_settings) > 0 or table.size(self._changed_render_settings) > 0
end

function VideoSettingsMenuPage:_cancel()
	if self:_changes_made() then
		local popup_item = self:find_item_by_name("unapplied_changes_popup")

		self._menu_logic:change_page(popup_item.config.page)
	else
		VideoSettingsMenuPage.super._cancel(self)
	end
end

function VideoSettingsMenuPage:cb_unapplied_changes_popup_item_selected(args)
	if args.action == "apply_changes" then
		self:cb_apply_changes()
	elseif args.action == "discard_changes" then
		self._changed_user_settings = {}
		self._changed_render_settings = {}

		local gamma = self._original_user_settings.gamma or 1

		Application.set_user_setting("gamma", gamma)
	end
end

function VideoSettingsMenuPage:cb_apply_changes()
	for key, value in pairs(self._changed_user_settings) do
		Application.set_user_setting(key, value)
	end

	for key, value in pairs(self._changed_render_settings) do
		Application.set_user_setting("render_settings", key, value)
	end

	local max_stacking_frames = self._changed_user_settings.max_stacking_frames

	if max_stacking_frames then
		Application.set_max_frame_stacking(max_stacking_frames)
	end

	local max_fps = self._changed_user_settings.max_fps

	if max_fps then
		Managers.state.event:trigger("apply_max_fps_cap", max_fps)
	end

	Application.apply_user_settings()
	Application.save_user_settings()
	Managers.state.event:trigger("reload_application_settings")

	local popup_item = self:find_item_by_name("keep_changes_popup")

	self._menu_logic:change_page(popup_item.config.page)
end

function VideoSettingsMenuPage:cb_keep_changes_popup_item_selected(args)
	if args.action == "keep_changes" then
		local changes_needs_restart = false

		for key, value in pairs(self._changed_user_settings) do
			self._original_user_settings[key] = self._changed_user_settings[key]

			if table.contains(VideoSettingsMenuPage.needs_restart, key) then
				changes_needs_restart = true
			end
		end

		for key, value in pairs(self._changed_render_settings) do
			self._original_render_settings[key] = self._changed_render_settings[key]

			if table.contains(VideoSettingsMenuPage.needs_restart, key) then
				changes_needs_restart = true
			end
		end

		self._changed_user_settings = {}
		self._changed_render_settings = {}

		if changes_needs_restart then
			local popup_item = self:find_item_by_name("changes_need_restart_popup")

			self._menu_logic:change_page(popup_item.config.page)
		end
	elseif args.action == "revert_changes" then
		for key, value in pairs(self._original_user_settings) do
			Application.set_user_setting(key, value)
		end

		for key, value in pairs(self._original_render_settings) do
			Application.set_user_setting("render_settings", key, value)
		end

		local max_stacking_frames = self._original_user_settings.max_stacking_frames

		if max_stacking_frames then
			Application.set_max_frame_stacking(max_stacking_frames)
		end

		Application.apply_user_settings()
		Application.save_user_settings()

		self._changed_user_settings = {}
		self._changed_render_settings = {}
	end
end

function VideoSettingsMenuPage:cb_restart_popup_item_selected(args)
	if args.action == "restart" then
		Managers.state.event:trigger("restart_game")
	end
end

function VideoSettingsMenuPage:cb_fullscreen_options()
	local options = {
		{
			key = true,
			value = L("menu_yes")
		},
		{
			key = false,
			value = L("menu_no")
		}
	}
	local saved_option = T(self._changed_user_settings.fullscreen, self._original_user_settings.fullscreen)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_fullscreen_option_changed(option)
	self._changed_user_settings.fullscreen = option.key
end

function VideoSettingsMenuPage:cb_fullscreen_output_options()
	local screens = {}

	for index, resolution in pairs(Application.enum_display_modes()) do
		if not table.find(screens, resolution[3]) then
			screens[#screens + 1] = resolution[3]
		end
	end

	local saved_fullscreen_output = T(self._changed_user_settings.fullscreen_output, self._original_user_settings.fullscreen_output)
	local options = {}
	local selected_index = 1

	for index, screen_index in ipairs(screens) do
		options[#options + 1] = {
			key = screen_index,
			value = screen_index
		}

		if saved_fullscreen_output and saved_fullscreen_output == screen_index then
			selected_index = #options
		end
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_fullscreen_output_option_changed(option)
	self._changed_user_settings.fullscreen_output = option.key

	local saved_resolution = T(self._changed_user_settings.screen_resolution, self._original_user_settings.screen_resolution)
	local resolution_exists = false

	for index, resolution in pairs(Application.enum_display_modes()) do
		if saved_resolution[1] == resolution[1] and saved_resolution[2] == resolution[2] and resolution[3] == option.key then
			resolution_exists = true

			break
		end
	end

	if not resolution_exists then
		for index, resolution in pairs(Application.enum_display_modes()) do
			if resolution[1] >= GameSettingsDevelopment.lowest_resolution and resolution[3] == option.key then
				self._changed_user_settings.screen_resolution = {
					resolution[1],
					resolution[2]
				}

				local resolution_item = self:find_item_by_name("screen_resolution")

				resolution_item:on_page_enter()

				break
			end
		end
	end
end

function VideoSettingsMenuPage:cb_resolution_drop_down_list_text()
	local resolution = T(self._changed_user_settings.screen_resolution, self._original_user_settings.screen_resolution)
	local description_text = L("menu_resolution") .. ": "
	local value_text = tostring(resolution[1]) .. "x" .. tostring(resolution[2])

	return description_text, value_text
end

function VideoSettingsMenuPage:cb_resolution_options()
	local saved_resolution = T(self._changed_user_settings.screen_resolution, self._original_user_settings.screen_resolution)
	local saved_fullscreen_output = T(self._changed_user_settings.fullscreen_output, self._original_user_settings.fullscreen_output)
	local options = {}
	local selected_index = 1

	for index, resolution in pairs(Application.enum_display_modes()) do
		if resolution[1] >= GameSettingsDevelopment.lowest_resolution and resolution[3] == saved_fullscreen_output then
			local option_key = {
				resolution[1],
				resolution[2]
			}
			local option_value = tostring(resolution[1]) .. "x" .. tostring(resolution[2])

			options[#options + 1] = {
				key = option_key,
				value = option_value
			}

			if saved_resolution and saved_resolution[1] == resolution[1] and saved_resolution[2] == resolution[2] then
				selected_index = #options
			end
		end
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_resolution_option_changed(option)
	self._changed_user_settings.screen_resolution = option.key
end

function VideoSettingsMenuPage:cb_graphics_quality_options()
	local options = {
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		},
		{
			key = "custom",
			value = L("menu_custom")
		}
	}
	local saved_option = T(self._changed_user_settings.graphics_quality, self._original_user_settings.graphics_quality)
	local selected_index = 2

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	elseif saved_option == options[4].key then
		selected_index = 4
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_graphics_quality_option_changed(option)
	local choice = option.key

	self._changed_user_settings.graphics_quality = choice

	local graphics_quality = GraphicsQuality[choice]

	for key, value in pairs(graphics_quality.user_settings) do
		self._changed_user_settings[key] = value
	end

	for key, value in pairs(graphics_quality.render_settings) do
		self._changed_render_settings[key] = value
	end

	for _, item in pairs(self._item_list._items) do
		if item.config.type == "enum" and item:name() ~= "graphics_quality" then
			item:on_page_enter()
			item:notify_value(true)
		end
	end
end

function VideoSettingsMenuPage:cb_vertical_sync_options()
	local options = {
		{
			key = false,
			value = L("menu_no")
		},
		{
			key = true,
			value = L("menu_yes")
		}
	}
	local saved_option = T(self._changed_user_settings.vsync, self._original_user_settings.vsync)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_vertical_sync_option_changed(option)
	self._changed_user_settings.vsync = option.key
end

function VideoSettingsMenuPage:cb_shadow_quality_options()
	local options = {
		{
			key = "off",
			value = L("menu_off")
		},
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		},
		{
			key = "extreme",
			value = L("menu_extreme")
		}
	}
	local saved_option = T(self._changed_user_settings.shadow_quality, self._original_user_settings.shadow_quality)
	local selected_index = 1

	if saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == nil or saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	elseif saved_option == options[4].key then
		selected_index = 4
	elseif saved_option == options[5].key then
		selected_index = 5
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_shadow_quality_option_changed(option, called_from_graphics_quality)
	local choice = option.key

	self._changed_user_settings.shadow_quality = choice
	self._changed_render_settings.shadow_map_size = GraphicsQuality.shadows[choice]

	if option.key == "off" then
		self._changed_render_settings.csm_enabled = false
	else
		self._changed_render_settings.csm_enabled = true
	end

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_texture_quality_characters_options()
	local options = {
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		},
		{
			key = "extreme",
			value = L("menu_extreme")
		}
	}
	local saved_option = T(self._changed_user_settings.texture_quality_characters, self._original_user_settings.texture_quality_characters)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	elseif saved_option == options[4].key then
		selected_index = 4
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_texture_quality_characters_option_changed(option, called_from_graphics_quality)
	local choice = option.key

	self._changed_user_settings.texture_quality_characters = choice

	for _, settings in ipairs(TextureQuality.characters[choice]) do
		Application.set_user_setting("texture_settings", settings.texture_setting, settings.mip_level)
	end

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_texture_quality_environment_options()
	local options = {
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		},
		{
			key = "extreme",
			value = L("menu_extreme")
		}
	}
	local saved_option = T(self._changed_user_settings.texture_quality_environment, self._original_user_settings.texture_quality_environment)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	elseif saved_option == options[4].key then
		selected_index = 4
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_texture_quality_environment_option_changed(option, called_from_graphics_quality)
	local choice = option.key

	self._changed_user_settings.texture_quality_environment = choice

	for _, settings in ipairs(TextureQuality.environment[choice]) do
		Application.set_user_setting("texture_settings", settings.texture_setting, settings.mip_level)
	end

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_texture_quality_coat_of_arms_options()
	local options = {
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		}
	}
	local saved_option = T(self._changed_user_settings.texture_quality_coat_of_arms, self._original_user_settings.texture_quality_coat_of_arms)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_texture_quality_coat_of_arms_option_changed(option, called_from_graphics_quality)
	local choice = option.key

	self._changed_user_settings.texture_quality_coat_of_arms = choice

	for _, settings in ipairs(TextureQuality.coat_of_arms[choice]) do
		Application.set_user_setting("texture_settings", settings.texture_setting, settings.mip_level)
	end

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_anti_aliasing_options()
	local options = {
		{
			key = false,
			value = L("menu_no")
		},
		{
			key = true,
			value = L("menu_fxaa")
		}
	}
	local saved_option = T(self._changed_render_settings.fxaa_enabled, self._original_render_settings.fxaa_enabled)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_anti_aliasing_option_changed(option, called_from_graphics_quality)
	self._changed_render_settings.fxaa_enabled = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_ssao_options()
	local options = {
		{
			key = false,
			value = L("menu_no")
		},
		{
			key = true,
			value = L("menu_yes")
		}
	}
	local saved_option = T(self._changed_render_settings.ssao_enabled, self._original_render_settings.ssao_enabled)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_ssao_option_changed(option, called_from_graphics_quality)
	self._changed_render_settings.ssao_enabled = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_lod_options()
	local options = {
		{
			key = 0.6,
			value = L("menu_low")
		},
		{
			key = 0.8,
			value = L("menu_medium")
		},
		{
			key = 1,
			value = L("menu_high")
		}
	}
	local saved_option = T(self._changed_render_settings.lod_object_multiplier, self._original_render_settings.lod_object_multiplier)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_lod_option_changed(option, called_from_graphics_quality)
	self._changed_render_settings.lod_object_multiplier = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_landscape_decoration_options()
	local options = {
		{
			key = 0.1,
			value = L("menu_low")
		},
		{
			key = 0.5,
			value = L("menu_medium")
		},
		{
			key = 1,
			value = L("menu_high")
		}
	}
	local saved_option = T(self._changed_render_settings.lod_decoration_density, self._original_render_settings.lod_decoration_density)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_landscape_decoration_option_changed(option, called_from_graphics_quality)
	self._changed_render_settings.lod_decoration_density = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_scatter_options()
	local options = {
		{
			key = 0,
			value = L("menu_low")
		},
		{
			key = 0.5,
			value = L("menu_medium")
		},
		{
			key = 1,
			value = L("menu_high")
		}
	}
	local saved_option = T(self._changed_render_settings.lod_scatter_density, self._original_render_settings.lod_scatter_density)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_scatter_option_changed(option, called_from_graphics_quality)
	self._changed_render_settings.lod_scatter_density = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_particles_quality_options()
	local options = {
		{
			key = "low",
			value = L("menu_low")
		},
		{
			key = "medium",
			value = L("menu_medium")
		},
		{
			key = "high",
			value = L("menu_high")
		}
	}
	local saved_option = T(self._changed_user_settings.particles_quality, self._original_user_settings.particles_quality)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	elseif saved_option == options[3].key then
		selected_index = 3
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_particles_quality_option_changed(option, called_from_graphics_quality)
	local particles_quality = ParticlesQuality[option.key]

	for key, value in pairs(particles_quality) do
		self._changed_render_settings[key] = value
	end

	self._changed_user_settings.particles_quality = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_max_stacking_frames_options()
	local options = {
		{
			key = -1,
			value = L("menu_auto")
		},
		{
			value = 1,
			key = 1
		},
		{
			value = 2,
			key = 2
		},
		{
			value = 3,
			key = 3
		},
		{
			value = 4,
			key = 4
		}
	}
	local max_stacking_frames = T(self._changed_user_settings.max_stacking_frames, self._original_user_settings.max_stacking_frames)
	local selected_index = 1

	for index, option in ipairs(options) do
		if option.key == max_stacking_frames then
			selected_index = index

			break
		end
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_max_stacking_frames_option_changed(option)
	self._changed_user_settings.max_stacking_frames = option.key
end

function VideoSettingsMenuPage:cb_light_casts_shadows_options()
	local options = {
		{
			key = false,
			value = L("menu_no")
		},
		{
			key = true,
			value = L("menu_yes")
		}
	}
	local saved_option = T(self._changed_user_settings.light_casts_shadows, self._original_user_settings.light_casts_shadows)
	local selected_index = 1

	if saved_option == nil or saved_option == options[1].key then
		selected_index = 1
	elseif saved_option == options[2].key then
		selected_index = 2
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_light_casts_shadows_option_changed(option, called_from_graphics_quality)
	self._changed_user_settings.light_casts_shadows = option.key

	if not called_from_graphics_quality then
		self:find_item_by_name("graphics_quality"):select_entry_by_key("custom")
	end
end

function VideoSettingsMenuPage:cb_gamma_options()
	local saved_option = math.round(self._original_user_settings.gamma or 1, 1)
	local options = {}
	local found_val = false
	local selected_index

	for i = 0.8, 1.6, 0.1 do
		local index = #options + 1

		options[index] = {
			key = i,
			value = string.format("%.1f", i)
		}

		if saved_option <= i and not found_val then
			found_val = true
			selected_index = index
		end
	end

	return options, selected_index or #options
end

function VideoSettingsMenuPage:cb_gamma_option_changed(option)
	self._changed_user_settings.gamma = option.key

	Application.set_user_setting("gamma", option.key)
end

function VideoSettingsMenuPage:cb_max_fps_options()
	local options = {
		{
			key = 0,
			value = L("menu_no")
		},
		{
			value = 30,
			key = 30
		},
		{
			value = 40,
			key = 40
		},
		{
			value = 50,
			key = 50
		},
		{
			value = 60,
			key = 60
		},
		{
			value = 70,
			key = 70
		},
		{
			value = 80,
			key = 80
		},
		{
			value = 90,
			key = 90
		},
		{
			value = 100,
			key = 100
		},
		{
			value = 110,
			key = 110
		},
		{
			value = 120,
			key = 120
		}
	}
	local saved_option = T(self._changed_user_settings.max_fps, self._original_user_settings.max_fps)
	local selected_index = 1

	for index, option in ipairs(options) do
		if option.key == saved_option then
			selected_index = index

			break
		end
	end

	return options, selected_index
end

function VideoSettingsMenuPage:cb_max_fps_option_changed(option)
	local max_fps = option.key

	self._changed_user_settings.max_fps = max_fps

	Application.set_user_setting("max_fps", max_fps)
end
