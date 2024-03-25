-- chunkname: @scripts/managers/hud/hud_mockup/hud_mockup.lua

require("scripts/menu/menu_containers/profile_info_menu_container")
require("scripts/managers/hud/shared_hud_elements/hud_hit_indicator")

HUDMockup = class(HUDMockup, HUDBase)

function HUDMockup:init(world, player, menu_world)
	HUDMockup.super.init(self, world, player)

	self._world = world
	self._player = player

	local resolution_width, resolution_height = Gui.resolution()

	self._gui = World.create_screen_gui(self._world, "material", MenuSettings.font_group_materials.wotr_hud_text, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.font_gradient_100, "material", MenuSettings.font_group_materials.arial, "material", "materials/menu/menu", "material", "materials/fonts/hell_shark_font", "material", "materials/menu/loading_atlas", "immediate")
	self._menu_gui = World.create_screen_gui(menu_world, "material", MenuSettings.font_group_materials.font_gradient_100, "material", MenuSettings.font_group_materials.arial, "material", "materials/menu/menu", "material", "materials/menu/loading_atlas", "material", "materials/fonts/hell_shark_font", "immediate")
	self._profile_info = ProfileInfoMenuContainer.create_from_config()

	self._profile_info:set_active(false)

	self._show_profile = false

	local death_text_config = {
		z = 20,
		layout_settings = HUDSettings.death_text
	}
	local killer_name_config = {
		z = 20,
		layout_settings = HUDSettings.killer_name_text
	}

	self._death_text = HUDTextElement.create_from_config(death_text_config)
	self._killer_name_text = HUDTextElement.create_from_config(killer_name_config)

	Managers.state.event:register(self, "show_profile", "event_show_profile")
	Managers.state.event:register(self, "hide_profile", "event_hide_profile")
	Managers.state.event:register(self, "projectile_hit_afro", "event_projectile_hit_afro")

	self._hits = {}
end

function HUDMockup:event_show_profile(profile, name, death_type)
	self._profile_info:set_active(true)
	self._profile_info:load(profile)

	self._show_profile = true

	if death_type == "instakill" then
		self._death_text.config.text = L("you_were_instakilled_by")

		local w, h = Gui.resolution()
		local layout_settings = HUDHelper:layout_settings(self._killer_name_text.config.layout_settings)
		local scale = w / 1920
		local max_width = 900 * scale
		local name_table = Gui.word_wrap(self._gui, name, layout_settings.font.font, layout_settings.font_size, w - max_width, "", "-+&/*", "\n")
		local name = name_table[1]

		if name_table[2] then
			name = name .. "..."
		end

		self._killer_name_text.config.text = name
	end
end

function HUDMockup:event_hide_profile()
	self._profile_info:set_active(false)

	self._show_profile = false
end

function HUDMockup:event_projectile_hit_afro(player, projectile_unit)
	if player ~= self._player then
		return
	end

	local config = {
		layout_settings = table.clone(HUDSettings.hit_indicator)
	}
	local hit_indicator = HUDHitIndicator.create_from_config(config, player.viewport_name, Vector3.normalize(Vector3.flat(Quaternion.forward(Unit.world_rotation(projectile_unit, 0)))))
	local hit_time = Managers.time:time("game")

	table.insert(self._hits, 1, {
		hit_indicator = hit_indicator,
		time = hit_time
	})
end

local HIT_INDICATOR_DURATION = 1.5

function HUDMockup:_update_hit_indicator(dt, t, resolution_width, resolution_height)
	local remove_hits = false
	local gui = self._gui

	for i = 1, #self._hits do
		local hit = self._hits[i]
		local duration = hit.time + HIT_INDICATOR_DURATION - t

		if duration < 0 or remove_hits then
			hit[i] = nil
			remove_hits = true
		else
			local hit_indicator = hit.hit_indicator
			local hit_indicator_config = hit_indicator.config
			local layout_settings = HUDHelper:layout_settings(hit_indicator_config.layout_settings)

			layout_settings.color[1] = math.sin(duration / HIT_INDICATOR_DURATION * math.half_pi) * 255

			hit_indicator:update_size(dt, t, gui, layout_settings)

			local x, y = HUDHelper:element_position(nil, hit_indicator, layout_settings)

			hit_indicator:update_position(dt, t, layout_settings, x, y, layout_settings.z)
			hit_indicator:render(dt, t, gui, layout_settings)
		end
	end
end

function HUDMockup:post_update(dt, t)
	local resolution_width, resolution_height = Gui.resolution()

	self:_update_rush_cooldown(dt, t, resolution_width, resolution_height)
	self:_update_interaction_progress(dt, t, resolution_width, resolution_height)
	self:_update_reticule(dt, t, resolution_width, resolution_height)
	self:_update_visor_overlay(dt, t, resolution_width, resolution_height)
	self:_update_damage_indicator(dt, t, resolution_width, resolution_height)
	self:_update_interaction(dt, t, resolution_width, resolution_height)

	if self._show_profile then
		self:_update_profile_info(dt, t, resolution_width, resolution_height)
	end

	self:_update_hit_indicator(dt, t, resolution_width, resolution_height)

	if script_data.map_dump_mode then
		self:_update_map_dump_mode(dt, t, resolution_width, resolution_height)
	end
end

function HUDMockup:_update_interaction(dt, t, resolution_width, resolution_height)
	local state_data = self._player.state_data

	if state_data.interaction then
		local font = MenuSettings.fonts.wotr_hud_text_36.font
		local font_material = MenuSettings.fonts.wotr_hud_text_36.material
		local text = ""

		if Managers.input:pad_active(1) then
			local full_text = L(state_data.interaction)
			local prefix, suffix, button = self:_handle_pad_interaction_text(state_data.interaction)
			local text_extent_min, text_extent_max = Gui.text_extents(self._gui, full_text, font, 40)
			local text_width = text_extent_max[1] - text_extent_min[1]
			local text_height = text_extent_max[3] - text_extent_min[3]
			local x = resolution_width / 2 - text_width / 2
			local y = resolution_height / 2.5 - 120

			if prefix then
				Gui.text(self._gui, prefix, font, 40, font_material, Vector3(x, y, 0), Color(255, 255, 255))
			end

			if button and prefix then
				local min, max = Gui.text_extents(self._gui, prefix, font, 40)
				local button_offset = max[1] - min[1]

				Gui.text(self._gui, button, "materials/fonts/hell_shark_36", 40, "hell_shark_36", Vector3(x + button_offset, y, 0), Color(255, 255, 255))
			end

			if prefix and button and suffix then
				local min, max = Gui.text_extents(self._gui, prefix .. button, font, 40)
				local suffix_offset = max[1] - min[1]

				Gui.text(self._gui, suffix, font, 40, font_material, Vector3(x + suffix_offset, y, 0), Color(255, 255, 255))
			end
		else
			text = L(state_data.interaction)

			local text_extent_min, text_extent_max = Gui.text_extents(self._gui, text, font, 40)
			local text_width = text_extent_max[1] - text_extent_min[1]
			local text_height = text_extent_max[3] - text_extent_min[3]
			local x = resolution_width / 2 - text_width / 2
			local y = resolution_height / 2.5 - 120

			Gui.text(self._gui, text, font, 40, font_material, Vector3(x, y, 0), Color(255, 255, 255))
		end
	end
end

function HUDMockup:_handle_pad_interaction_text(text)
	text = Managers.localizer:simple_lookup(text)

	local prefix_arg_start, prefix_arg_end = string.find(text, "KEY")

	if prefix_arg_start then
		local prefix = string.sub(text, 1, prefix_arg_start - 2) .. " "
		local suffix_arg_start, suffix_arg_end = string.find(text, ":")
		local suffix = string.sub(text, suffix_arg_end + 1, -2)
		local button = Managers.localizer:_find_macro(string.sub(text, prefix_arg_start - 1, suffix_arg_start))

		return prefix, suffix, button
	else
		return L(text)
	end
end

function HUDMockup:_update_map_dump_mode(dt, t, resolution_width, resolution_height)
	local size = Vector2((resolution_width - resolution_height) * 0.5, resolution_height)
	local pos1 = Vector2(0, 0)
	local pos2 = Vector2((resolution_width - resolution_height) * 0.5 + resolution_height, 0)

	Gui.rect(self._gui, pos1, size, Color(0, 0, 0))
	Gui.rect(self._gui, pos2, size, Color(0, 0, 0))

	if Keyboard.pressed(Keyboard.button_index("space")) then
		local z1 = 0
		local z2 = 0
		local data = Managers.free_flight.data.global
		local ortho_data = data.orthographic_data
		local pose = Managers.free_flight:camera_pose(data)
		local pos = Vector3.flat(Matrix4x4.translation(pose))
		local rot = Matrix4x4.rotation(pose)
		local size2 = ortho_data.size
		local p1 = Vector3Box(pos - size2 * (Quaternion.up(rot) + Quaternion.right(rot)))
		local p2 = Vector3Box(pos + size2 * (Quaternion.up(rot) + Quaternion.right(rot)))

		p1.z = 0
		p2.z = 0

		print("\nminimap\t= { p1 = ", p1, ", p2 =", p2, " },")
	end
end

function HUDMockup:_update_profile_info(dt, t, resolution_width, resolution_height)
	local gui = self._gui
	local layout_settings = MenuHelper:layout_settings(SquadMenuSettings.pages.level_2_character_profiles)

	self._profile_info:update_size(dt, t, self._menu_gui, layout_settings.profile_info)

	local profile_x, y = MenuHelper:container_position(self._profile_info, layout_settings.profile_info)

	self._profile_info:update_position(dt, t, layout_settings.profile_info, profile_x, y, 20)
	self._profile_info:render(dt, t, self._menu_gui, layout_settings.profile_info)

	local layout_settings_death_text = HUDHelper:layout_settings(self._death_text.config.layout_settings)
	local w, h = Gui.resolution()
	local area_width = w - profile_x
	local min, max = Gui.text_extents(self._gui, self._death_text.config.text, layout_settings_death_text.font.font, layout_settings_death_text.font_size)
	local width = max[1] - min[1]

	layout_settings_death_text.screen_offset_x = (w - area_width) / 2 / w

	self._death_text:update_size(dt, t, gui, layout_settings_death_text)

	local x, y = HUDHelper:element_position(nil, self._death_text, layout_settings_death_text)

	self._death_text:update_position(dt, t, layout_settings_death_text, x, y, layout_settings_death_text.z)
	self._death_text:render(dt, t, gui, layout_settings_death_text)

	local layout_settings_killer_name = HUDHelper:layout_settings(self._killer_name_text.config.layout_settings)
	local min, max = Gui.text_extents(self._gui, self._killer_name_text.config.text, layout_settings_killer_name.font.font, layout_settings_killer_name.font_size)
	local width = max[1] - min[1]

	layout_settings_killer_name.screen_offset_x = (w - area_width) / 2 / w

	self._killer_name_text:update_size(dt, t, gui, layout_settings_killer_name)

	local x, y = HUDHelper:element_position(nil, self._killer_name_text, layout_settings_killer_name)

	self._killer_name_text:update_position(dt, t, layout_settings_killer_name, x, y, layout_settings_killer_name.z)
	self._killer_name_text:render(dt, t, gui, layout_settings_killer_name)
end

function HUDMockup:_update_damage_indicator(dt, t, resolution_width, resolution_height)
	local state_data = self._player.state_data

	if state_data.damage then
		local new_damage = state_data.damage / state_data.health
		local world = self._world

		if new_damage > 0.1 and not self._id1 then
			self._id1 = World.create_particles(world, "fx/screenspace_damage_4", Vector3(0, 0, 0))
		elseif new_damage < 0.1 and self._id1 then
			self:_clear_damage_indicator("_id1")
		end

		if new_damage > 0.3 and not self._id2 then
			self._id2 = World.create_particles(world, "fx/screenspace_damage_3", Vector3(0, 0, 0))
		elseif new_damage < 0.3 and self._id2 then
			self:_clear_damage_indicator("_id2")
		end

		if new_damage > 0.5 and not self._id3 then
			self._id3 = World.create_particles(world, "fx/screenspace_damage_2", Vector3(0, 0, 0))
		elseif new_damage < 0.5 and self._id3 then
			self:_clear_damage_indicator("_id3")
		end

		if new_damage > 0.7 and not self._id4 then
			self._id4 = World.create_particles(world, "fx/screenspace_damage_1", Vector3(0, 0, 0))
		elseif new_damage < 0.7 and self._id4 then
			self:_clear_damage_indicator("_id4")
		end
	else
		self:_clear_damage_indicator("_id1")
		self:_clear_damage_indicator("_id2")
		self:_clear_damage_indicator("_id3")
		self:_clear_damage_indicator("_id4")
	end
end

function HUDMockup:_clear_damage_indicator(key)
	local id = self[key]

	if not id then
		return
	end

	World.destroy_particles(self._world, id)

	self[key] = nil
end

function HUDMockup:_update_rush_cooldown(dt, t, resolution_width, resolution_height)
	local state_data = self._player.state_data
	local text
	local cooldown_time = state_data.rush_cooldown_time

	if cooldown_time and t < cooldown_time then
		text = string.format("%.1f", cooldown_time - t)
	end

	if text then
		local text_extent_min, text_extent_max = Gui.text_extents(self._gui, text, MenuSettings.fonts.menu_font.font, 30)
		local text_width = text_extent_max[1] - text_extent_min[1]
		local text_height = text_extent_max[3] - text_extent_min[3]
		local x = resolution_width / 2 - text_width / 2
		local y = resolution_height / 2 - 70
		local r = 20
		local g = 20
		local b = 255

		Gui.text(self._gui, text, MenuSettings.fonts.menu_font.font, 30, MenuSettings.fonts.menu_font.material, Vector3(x, y, 0), Color(r, g, b))
	end
end

function HUDMockup:_update_interaction_progress(dt, t, resolution_width, resolution_height)
	local state_data = self._player.state_data
	local text
	local interaction_progress = state_data.interaction_progress

	if interaction_progress then
		local font = MenuSettings.fonts.wotr_hud_text_36.font
		local font_material = MenuSettings.fonts.wotr_hud_text_36.material
		local text = string.format("%.0f", interaction_progress)
		local text_extent_min, text_extent_max = Gui.text_extents(self._gui, text, font, 40)
		local text_width = text_extent_max[1] - text_extent_min[1]
		local text_height = text_extent_max[3] - text_extent_min[3]
		local x = resolution_width / 2 - text_width / 2
		local y = resolution_height / 2 - 120

		Gui.text(self._gui, text, font, 40, font_material, Vector3(x, y, 0), Color(255, 255, 255))
	end
end

function HUDMockup:_update_reticule(dt, t, resolution_width, resolution_height)
	if HUDSettings.show_reticule then
		local player = self._player
		local player_unit = player.player_unit
		local locomotion = player and Unit.alive(player_unit) and ScriptUnit.has_extension(player_unit, "locomotion_system") and ScriptUnit.extension(player_unit, "locomotion_system")

		if locomotion and locomotion.aiming then
			Gui.bitmap(self._gui, "mockup_hud", Vector3(resolution_width / 2 - 4, resolution_height / 2 - 4, 400), Vector2(8, 8))
		end
	end
end

function HUDMockup:_update_visor_overlay(dt, t, resolution_width, resolution_height)
	local state_data = self._player.state_data

	if not state_data.visor_open and state_data.helmet_name and state_data.visor_name then
		local texture = state_data.visor_name

		Gui.bitmap(self._gui, texture, Vector3(0, 0, -90), Vector2(resolution_width, resolution_height), Color(255, 0, 0, 0))
	end
end

function HUDMockup:destroy()
	World.destroy_gui(self._world, self._gui)
end
