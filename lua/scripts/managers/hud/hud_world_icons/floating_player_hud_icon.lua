-- chunkname: @scripts/managers/hud/hud_world_icons/floating_player_hud_icon.lua

FloatingPlayerHUDIcon = class(FloatingPlayerHUDIcon)

function FloatingPlayerHUDIcon:init(gui, local_player, player_unit, camera, world, config)
	self._gui = gui
	self._local_player = local_player
	self._player_unit = player_unit
	self._camera = camera
	self._world = world
	self.config = config
	self._show_time = nil
	self._hide_time = nil
	self._render = false
	self._player_visible = false
	self._line_of_sight_check_result = false
	self._raycast_node_list = HUDSettings.player_icons.line_of_sight_nodes
	self._raycast_node_list_index = 0

	self:_init_raycast()
end

function FloatingPlayerHUDIcon:destroy()
	self._raycast = nil
end

function FloatingPlayerHUDIcon:unit()
	return self._player_unit
end

function FloatingPlayerHUDIcon:_init_raycast()
	local function raycast_result(hit, position, distance, normal, actor)
		self:_raycast_result(hit, position, distance, normal, actor)
	end

	local physics_world = World.physics_world(self._world)

	self._raycast = PhysicsWorld.make_raycast(physics_world, raycast_result, "closest", "collision_filter", "husk_in_line_of_sight")
end

function FloatingPlayerHUDIcon:post_update(dt, t, layout_settings)
	local local_player = self._local_player
	local local_player_unit = local_player.camera_follow_unit
	local other_player_unit = self._player_unit
	local other_player = Managers.player:owner(other_player_unit)

	if not Unit.alive(local_player_unit) or not Unit.alive(other_player_unit) or not local_player.team or not other_player or not other_player.team or not not ScriptUnit.extension(other_player_unit, "locomotion_system").ghost_mode then
		self._wants_line_of_sight_check = false

		return
	end

	local screen_x, screen_y, screen_z = self:_icon_screen_pos(other_player_unit, local_player_unit)

	if not HUDHelper:inside_screen(screen_x, screen_y, screen_z) then
		self._wants_line_of_sight_check = false

		return
	end

	local local_player_pos = Unit.world_position(local_player_unit, 0)
	local other_player_pos = Unit.world_position(other_player_unit, 0)
	local distance = Vector3.length(local_player_pos - other_player_pos)
	local inside_attention_zone = HUDHelper:inside_attention_screen_zone(screen_x, screen_y, screen_z)
	local player_visible = self:_player_visible_check(local_player, other_player, distance, inside_attention_zone, local_player_unit, other_player_unit)

	if player_visible and not self._player_visible and not self._show_time then
		self._hide_time = nil

		if local_player.team == other_player.team then
			if local_player.squad_index and local_player.squad_index == other_player.squad_index then
				self._show_time = t + HUDSettings.player_icons.squad_member_show_delay
			else
				self._show_time = t + HUDSettings.player_icons.team_member_show_delay
			end
		elseif distance <= HUDSettings.player_icons.near_enemy_max_distance then
			self._show_time = t + HUDSettings.player_icons.near_enemy_show_delay
		else
			local level_key = Managers.state.game_mode:level_key()
			local far_enemy_max_distance = HUDSettings.player_icons.level_far_enemy_max_distance[level_key] or HUDSettings.player_icons.default_far_enemy_max_distance
			local k = (HUDSettings.player_icons.far_enemy_show_delay_max - HUDSettings.player_icons.far_enemy_show_delay_min) / (far_enemy_max_distance - HUDSettings.player_icons.near_enemy_max_distance)
			local delay = k * (distance - HUDSettings.player_icons.near_enemy_max_distance) + HUDSettings.player_icons.far_enemy_show_delay_min
			local local_locomotion = ScriptUnit.extension(local_player_unit, "locomotion_system")
			local delay_multiplier = local_locomotion:has_perk("keen_eyes") and Perks.keen_eyes.delay_multiplier or 1

			self._show_time = t + delay * delay_multiplier
		end
	elseif not player_visible and self._player_visible then
		self._show_time = nil

		if local_player.team == other_player.team then
			if local_player.squad_index and local_player.squad_index == other_player.squad_index then
				self._hide_time = t + HUDSettings.player_icons.squad_member_hide_delay
			else
				self._hide_time = t + HUDSettings.player_icons.team_member_hide_delay
			end
		elseif distance <= HUDSettings.player_icons.near_enemy_max_distance then
			self._hide_time = t + HUDSettings.player_icons.near_enemy_hide_delay
		else
			self._hide_time = t + HUDSettings.player_icons.far_enemy_hide_delay
		end
	end

	self._player_visible = player_visible

	if self._show_time and t >= self._show_time then
		self._show_time = nil
		self._render = true
	elseif self._hide_time and t >= self._hide_time then
		self._hide_time = nil
		self._render = false
	end

	if self._render then
		self:_render_floating_icon(layout_settings, screen_x, screen_y, screen_z, inside_attention_zone, t)
	end
end

function FloatingPlayerHUDIcon:_icon_screen_pos(player_unit, local_player_unit)
	local icon_world_pos = Unit.world_position(player_unit, Unit.node(player_unit, "Head")) + Vector3(0, 0, 0.35)

	if Unit.has_data(player_unit, "crest_name") then
		local crest_name = Unit.get_data(player_unit, "crest_name")
		local crest_offset = 0

		if player_unit ~= local_player_unit then
			crest_offset = HelmetCrests[crest_name].player_name_offset
		end

		icon_world_pos.z = icon_world_pos.z + crest_offset
	end

	local world_to_screen = Camera.world_to_screen(self._camera, icon_world_pos)

	return world_to_screen.x, world_to_screen.z, world_to_screen.y
end

function FloatingPlayerHUDIcon:_player_visible_check(local_player, other_player, distance, aimed, local_player_unit, other_player_unit)
	if local_player.team == other_player.team then
		if local_player.squad_index and local_player.squad_index == other_player.squad_index and distance <= HUDSettings.player_icons.squad_member_max_distance then
			self._wants_line_of_sight_check = false

			return true
		elseif distance <= HUDSettings.player_icons.team_member_max_distance then
			self._wants_line_of_sight_check = false

			return true
		end
	elseif local_player_unit == other_player_unit then
		return true
	else
		local level_key = Managers.state.game_mode:level_key()
		local far_enemy_max_distance = HUDSettings.player_icons.level_far_enemy_max_distance[level_key] or HUDSettings.player_icons.default_far_enemy_max_distance

		if distance <= HUDSettings.player_icons.near_enemy_max_distance or aimed and distance <= far_enemy_max_distance then
			if not self._wants_line_of_sight_check then
				self._line_of_sight_check_result = false
			end

			self._wants_line_of_sight_check = true

			return self._line_of_sight_check_result
		end
	end

	self._wants_line_of_sight_check = false
end

function FloatingPlayerHUDIcon:wants_line_of_sight_check()
	return self._wants_line_of_sight_check, self._player_unit
end

function FloatingPlayerHUDIcon:check_line_of_sight()
	local local_player = self._local_player
	local other_player_unit = self._player_unit

	if not Unit.alive(local_player.camera_follow_unit) or not Unit.alive(other_player_unit) then
		return
	end

	local camera_unit = Camera.get_data(self._camera, "unit")
	local cam_pos = Unit.local_position(camera_unit, 0)

	self._raycast_node_list_index = self._raycast_node_list_index % #self._raycast_node_list + 1

	local other_player_pos = Unit.world_position(other_player_unit, Unit.node(other_player_unit, self._raycast_node_list[self._raycast_node_list_index]))
	local length = Vector3.length(other_player_pos - cam_pos)

	self._raycast:cast(cam_pos, other_player_pos - cam_pos, length)
end

function FloatingPlayerHUDIcon:_raycast_result(hit, position, distance, normal, actor)
	self._line_of_sight_check_result = not hit
end

function FloatingPlayerHUDIcon:_render_floating_icon(layout_settings, screen_x, screen_y, screen_z, inside_attention_zone, t, distance)
	local gui = self._gui
	local settings = inside_attention_zone and layout_settings.attention_screen_zone or layout_settings.default_screen_zone
	local alpha_multiplier = 1

	if self._hide_time and self._hide_time - t <= HUDSettings.player_icons.hide_fade_time then
		alpha_multiplier = (self._hide_time - t) / HUDSettings.player_icons.hide_fade_time
	end

	local other_player_unit = self._player_unit
	local other_player = Managers.player:owner(other_player_unit)
	local local_player = self._local_player
	local name_color_table = HUDHelper:player_color(local_player, other_player)
	local name_color = Color(name_color_table[1] * alpha_multiplier, name_color_table[2], name_color_table[3], name_color_table[4])
	local name_shadow_color = Color(HUDSettings.player_colors.shadow[1] * alpha_multiplier, HUDSettings.player_colors.shadow[2], HUDSettings.player_colors.shadow[3], HUDSettings.player_colors.shadow[4])
	local name_text = other_player:name()
	local name_scaled_font_size = HUDHelper:floating_text_icon_size(screen_z, settings.font_size, settings.min_scale, settings.max_scale, settings.min_scale_distance, settings.max_scale_distance)
	local font = MenuSettings.fonts.player_name_font
	local min, max = Gui.text_extents(gui, name_text, font.font, name_scaled_font_size)
	local name_width = max[1] - min[1]
	local name_mid = (min[1] + max[1]) / 2
	local name_height = max[3] - min[3]
	local name_position = Vector3(screen_x - name_mid, screen_y, 0)
	local shadow_offset = Vector3(1, -1, 0)

	if local_player ~= other_player then
		Gui.text(gui, name_text, font.font, name_scaled_font_size, font.material, name_position + shadow_offset, name_shadow_color)
		Gui.text(gui, name_text, font.font, name_scaled_font_size, font.material, name_position, name_color)

		if (local_player.team ~= other_player.team or local_player.squad_index and local_player.squad_index == other_player.squad_index) and other_player.is_corporal then
			local corporal_texture = HUDAtlas.line_32x4
			local corporal_texture_uv00 = Vector2(corporal_texture.uv00[1] + 0.002, corporal_texture.uv00[2])
			local corporal_texture_uv11 = Vector2(corporal_texture.uv11[1] - 0.002, corporal_texture.uv11[2])
			local corporal_texture_width = name_width
			local corporal_texture_height = 2
			local corporal_texture_position = Vector3(screen_x - name_width / 2, screen_y + name_height * -0.35, 0)

			Gui.bitmap_uv(gui, settings.texture_atlas, corporal_texture_uv00, corporal_texture_uv11, corporal_texture_position + shadow_offset, Vector2(corporal_texture_width, corporal_texture_height), name_shadow_color)
			Gui.bitmap_uv(gui, settings.texture_atlas, corporal_texture_uv00, corporal_texture_uv11, corporal_texture_position, Vector2(corporal_texture_width, corporal_texture_height), name_color)
		end
	end

	if local_player.team == other_player.team or Unit.alive(local_player.player_unit) and ScriptUnit.extension(local_player.player_unit, "locomotion_system"):has_perk("second_opinion") then
		local damage_ext = ScriptUnit.extension(other_player_unit, "damage_system")
		local status_texture

		if damage_ext._dead then
			status_texture = settings.texture_dead
		elseif damage_ext._knocked_down then
			status_texture = settings.texture_knocked_down
		elseif damage_ext._wounded then
			status_texture = settings.texture_wounded
		end

		if status_texture then
			local status_texture_uv00 = Vector2(status_texture.uv00[1], status_texture.uv00[2])
			local status_texture_uv11 = Vector2(status_texture.uv11[1], status_texture.uv11[2])
			local status_texture_width, status_texture_height = HUDHelper:floating_icon_size(screen_z, status_texture.size[1], status_texture.size[2], settings.min_scale, settings.max_scale, settings.min_scale_distance, settings.max_scale_distance)
			local status_texture_position = Vector3(screen_x - status_texture_width * settings.texture_scale * 0.5, screen_y + name_height * 1.5, 0)
			local status_texture_color = Color(255 * alpha_multiplier, 255, 255, 255)

			Gui.bitmap_uv(gui, settings.texture_atlas, status_texture_uv00, status_texture_uv11, status_texture_position, Vector2(status_texture_width * settings.texture_scale, status_texture_height * settings.texture_scale), status_texture_color)
		end
	end
end
