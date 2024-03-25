-- chunkname: @scripts/managers/hud/hud_world_icons/floating_hud_icon.lua

FloatingHUDIcon = class(FloatingHUDIcon)

function FloatingHUDIcon:init(blackboard, gui, unit, camera, world, config, player, player_unit, node_name)
	self._blackboard = blackboard
	self._gui = gui
	self._unit = unit
	self._camera = camera
	self._world = world
	self._player = player
	self._player_unit = player_unit
	self._node_index = node_name and Unit.node(unit, node_name) or 0
	self.config = config

	if Unit.has_data(unit, "hud", "icon_world_fixed_position_offset") then
		self._unit_fixed_offset = Vector3Box(Unit.get_data(unit, "hud", "icon_world_fixed_position_offset", "x"), Unit.get_data(unit, "hud", "icon_world_fixed_position_offset", "y"), Unit.get_data(unit, "hud", "icon_world_fixed_position_offset", "z"))
	elseif Unit.has_data(unit, "hud", "icon_world_position_offset") then
		self._unit_offset = Vector3Box(Unit.get_data(unit, "hud", "icon_world_position_offset", "x"), Unit.get_data(unit, "hud", "icon_world_position_offset", "y"), Unit.get_data(unit, "hud", "icon_world_position_offset", "z"))
	end

	self._fade_duration = 0.4
	self._fade_settings = {
		tagging = {
			status = "hide"
		},
		texture_1 = {
			status = "hide"
		},
		texture_2 = {
			status = "hide"
		}
	}
end

function FloatingHUDIcon:post_update(dt, t, layout_settings, layout_settings_2)
	local config_tagging_layout_settings = self.config.tagging_layout_settings
	local tagging_layout_settings = config_tagging_layout_settings and HUDHelper:layout_settings(config_tagging_layout_settings)
	local unit = self._unit
	local world_position

	if self._player_unit and not Unit.alive(self._player_unit) or not Unit.alive(self._unit) then
		return
	end

	if self._unit_fixed_offset then
		world_position = Unit.world_position(unit, self._node_index) + self._unit_fixed_offset:unbox()
	elseif self._unit_offset then
		world_position = Unit.world_position(unit, self._node_index) + Quaternion.rotate(Unit.world_rotation(unit, self._node_index), self._unit_offset:unbox())
	else
		world_position = Unit.world_position(unit, self._node_index)
	end

	local world_to_screen = Camera.world_to_screen(self._camera, world_position)
	local screen_x = world_to_screen.x
	local screen_y = world_to_screen.z
	local screen_z = world_to_screen.y

	if HUDHelper:inside_attention_screen_zone(screen_x, screen_y, screen_z) then
		if tagging_layout_settings then
			self:_draw_floating_icon(tagging_layout_settings, screen_x, screen_y, screen_z, true, dt, t, self._fade_settings.tagging)
		end

		self:_draw_floating_icon(layout_settings, screen_x, screen_y, screen_z, true, dt, t, self._fade_settings.texture_1)

		if layout_settings_2 then
			self:_draw_floating_icon(layout_settings_2, screen_x, screen_y, screen_z, true, dt, t, self._fade_settings.texture_2)
		end
	elseif HUDHelper:inside_default_screen_zone(screen_x, screen_y, screen_z, dt, t) then
		if tagging_layout_settings then
			self:_draw_floating_icon(tagging_layout_settings, screen_x, screen_y, screen_z, false, dt, t, self._fade_settings.tagging)
		end

		self:_draw_floating_icon(layout_settings, screen_x, screen_y, screen_z, false, dt, t, self._fade_settings.texture_1)

		if layout_settings_2 then
			self:_draw_floating_icon(layout_settings_2, screen_x, screen_y, screen_z, false, dt, t, self._fade_settings.texture_2)
		end
	else
		if tagging_layout_settings then
			self:_draw_clamped_icon(tagging_layout_settings, screen_x, screen_y, screen_z, dt, t, self._fade_settings.tagging)
		end

		self:_draw_clamped_icon(layout_settings, screen_x, screen_y, screen_z, dt, t, self._fade_settings.texture_1)

		if layout_settings_2 then
			self:_draw_clamped_icon(layout_settings_2, screen_x, screen_y, screen_z, dt, t, self._fade_settings.texture_2)
		end
	end
end

function FloatingHUDIcon:_draw_floating_icon(layout_settings, screen_x, screen_y, screen_z, inside_attention_zone, dt, t, state_table)
	local blackboard = self._blackboard
	local settings = inside_attention_zone and layout_settings.attention_screen_zone or layout_settings.default_screen_zone
	local texture = settings.texture_func and settings.texture_func(blackboard, self._player, self._unit, self._world, self._player_unit)

	if texture and state_table.status == "show" then
		state_table.fade_alpha = 1
		state_table.last_texture = texture
	elseif not texture and (state_table.status == "hide" or not state_table.last_texture) then
		state_table.fade_alpha = 0
		state_table.status = "hide"

		return
	elseif not texture and state_table.last_texture then
		state_table.fade_alpha = math.clamp((state_table.fade_alpha or 1) - dt / self._fade_duration, 0, 1)

		if state_table.fade_alpha <= 0 then
			state_table.status = "hide"
			state_table.last_texture = nil

			return
		else
			state_table.status = "fade"
			texture = state_table.last_texture
		end
	elseif texture then
		state_table.last_texture = texture
		state_table.fade_alpha = math.clamp((state_table.fade_alpha or 0) + dt / self._fade_duration, 0, 1)

		if state_table.fade_alpha >= 1 then
			state_table.status = "show"
		else
			state_table.status = "fade"
		end
	end

	local color = HUDHelper.floating_hud_icon_color(self._player, settings, blackboard, dt, t)
	local x, y, z, w = Quaternion.to_elements(color)

	color = Quaternion.from_elements(x * state_table.fade_alpha, y, z, w)

	local uv00 = Vector2(texture.uv00[1], texture.uv00[2])
	local uv11 = Vector2(texture.uv11[1], texture.uv11[2])
	local width, height = HUDHelper:floating_icon_size(screen_z, texture.size[1], texture.size[2], settings.min_scale, settings.max_scale, settings.min_scale_distance, settings.max_scale_distance)
	local position = Vector3(screen_x - width * 0.5, screen_y - height * 0.5, 0)

	Gui.bitmap_uv(self._gui, settings.texture_atlas, uv00, uv11, position, Vector2(width, height), color)
end

function FloatingHUDIcon:_draw_clamped_icon(layout_settings, screen_x, screen_y, screen_z, dt, t)
	local blackboard = self._blackboard
	local settings = layout_settings.clamped_screen_zone
	local texture = settings.texture_func and settings.texture_func(blackboard, self._player, self._unit, self._world, self._player_unit)

	if not texture then
		return
	end

	local color = HUDHelper.floating_hud_icon_color(self._player, settings, blackboard, dt, t)
	local uv00 = Vector2(texture.uv00[1], texture.uv00[2])
	local uv11 = Vector2(texture.uv11[1], texture.uv11[2])
	local width = texture.size[1] * settings.scale
	local height = texture.size[2] * settings.scale
	local clamped_x, clamped_y = HUDHelper:clamped_icon_position(screen_x, screen_y, screen_z)
	local position = Vector3(clamped_x - width * 0.5, clamped_y - height * 0.5, 0)

	Gui.bitmap_uv(self._gui, settings.texture_atlas, uv00, uv11, position, Vector2(width, height), color)
end
