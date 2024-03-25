-- chunkname: @scripts/managers/hud/hud_game_mode_status/hud_game_mode_status.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")

HUDGameModeStatus = class(HUDGameModeStatus, HUDBase)

function HUDGameModeStatus:init(world, player)
	HUDGameModeStatus.super.init(self, world, player)

	self._world = world
	self._player = player
	self._show_game_mode_status = true
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.wotr_hud_text, "immediate")
	self._objective_text = ""

	self:_setup()
	Managers.state.event:register(self, "refresh_game_mode_objective", "event_refresh_objective")
	Managers.state.event:register(self, "set_game_mode_objective_text", "event_set_objective_text")
	Managers.state.event:register(self, "show_game_mode_status", "event_show_game_mode_status")
end

function HUDGameModeStatus:_setup()
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.game_mode_status.container
	})

	local round_timer_config = {
		text = "",
		z = 1,
		layout_settings = table.clone(HUDSettings.game_mode_status.round_timer)
	}

	self._round_timer = HUDTextElement.create_from_config(round_timer_config)

	self._container:add_element("round_timer", self._round_timer)

	local own_team_score_config = {
		text = "",
		z = 1,
		layout_settings = HUDSettings.game_mode_status.own_team_score
	}

	self._own_team_score = HUDTextElement.create_from_config(own_team_score_config)

	self._container:add_element("own_team_score", self._own_team_score)

	local enemy_team_score_config = {
		text = "",
		z = 1,
		layout_settings = HUDSettings.game_mode_status.enemy_team_score
	}

	self._enemy_team_score = HUDTextElement.create_from_config(enemy_team_score_config)

	self._container:add_element("enemy_team_score", self._enemy_team_score)

	local own_team_rose_config = {
		z = 1,
		blackboard = {
			player = self._player
		},
		layout_settings = HUDSettings.game_mode_status.own_team_rose
	}

	self._container:add_element("own_team_rose", HUDTextureElement.create_from_config(own_team_rose_config))

	local enemy_team_rose_config = {
		z = 1,
		blackboard = {
			player = self._player
		},
		layout_settings = HUDSettings.game_mode_status.enemy_team_rose
	}

	self._container:add_element("enemy_team_rose", HUDTextureElement.create_from_config(enemy_team_rose_config))

	local own_progress_bar_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.game_mode_status.own_progress_bar)
	}

	self._own_progress_bar = HUDTextureElement.create_from_config(own_progress_bar_config)

	self._container:add_element("own_progress_bar", self._own_progress_bar)

	local texture_atlas_settings = HUDHelper:layout_settings(self._own_progress_bar.config.layout_settings).texture_atlas_settings

	texture_atlas_settings.uv00[1] = texture_atlas_settings.uv00[1] + 0.002
	texture_atlas_settings.uv11[1] = texture_atlas_settings.uv11[1] - 0.002

	local enemy_progress_bar_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.game_mode_status.enemy_progress_bar)
	}

	self._enemy_progress_bar = HUDTextureElement.create_from_config(enemy_progress_bar_config)

	self._container:add_element("enemy_progress_bar", self._enemy_progress_bar)

	local texture_atlas_settings = HUDHelper:layout_settings(self._enemy_progress_bar.config.layout_settings).texture_atlas_settings

	texture_atlas_settings.uv00[1] = texture_atlas_settings.uv00[1] + 0.002
	texture_atlas_settings.uv11[1] = texture_atlas_settings.uv11[1] - 0.002

	local own_progress_bar_cap_config = {
		z = 2,
		layout_settings = HUDSettings.game_mode_status.own_progress_bar_cap
	}

	self._container:add_element("own_progress_bar_cap", HUDTextureElement.create_from_config(own_progress_bar_cap_config))

	local enemy_progress_bar_cap_config = {
		z = 2,
		layout_settings = HUDSettings.game_mode_status.enemy_progress_bar_cap
	}

	self._container:add_element("enemy_progress_bar_cap", HUDTextureElement.create_from_config(enemy_progress_bar_cap_config))

	local progress_bar_bgr_config = {
		z = 3,
		layout_settings = HUDSettings.game_mode_status.progress_bar_bgr
	}

	self._container:add_element("progress_bar_bgr", HUDTextureElement.create_from_config(progress_bar_bgr_config))

	local progress_bar_divider_config = {
		z = 4,
		layout_settings = HUDSettings.game_mode_status.progress_bar_divider
	}

	self._progress_bar_divider = HUDTextureElement.create_from_config(progress_bar_divider_config)

	self._container:add_element("progress_bar_divider", self._progress_bar_divider)

	local progress_bar_center_config = {
		z = 5,
		layout_settings = HUDSettings.game_mode_status.progress_bar_center
	}

	self._container:add_element("progress_bar_center", HUDTextureElement.create_from_config(progress_bar_center_config))

	local objective_text_config = {
		text = "Mission Objectives",
		z = 6,
		layout_settings = HUDSettings.game_mode_status.objective_text
	}

	self._objective_text_element = HUDTextElement.create_from_config(objective_text_config)

	self._container:add_element("objective_text", self._objective_text_element)

	self._container_menu = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.game_mode_status.container
	})

	local round_timer_config = {
		text = "",
		z = 1,
		layout_settings = table.clone(HUDSettings.game_mode_status.round_timer_menu)
	}

	self._round_timer_menu = HUDTextElement.create_from_config(round_timer_config)

	self._container_menu:add_element("round_timer", self._round_timer_menu)
end

function HUDGameModeStatus:event_refresh_objective()
	local objective, param1, param2 = Managers.state.game_mode:objective(self._player)

	self:_set_objective_texts(self._player, objective, param1, param2)
end

function HUDGameModeStatus:event_set_objective_text(objective)
	local param1, param2 = GameModeHelper:objective_parameters(objective, self._player, self._world)

	self:_set_objective_texts(self._player, objective, param1, param2)
end

function HUDGameModeStatus:event_show_game_mode_status(show)
	self._show_game_mode_status = show
end

function HUDGameModeStatus:_update_objective(player)
	local objective, param1, param2 = Managers.state.game_mode:objective(player)

	if not objective then
		return
	end

	if objective ~= self._objective or param1 ~= self._param1 or param2 ~= self._param2 then
		self:_set_objective_texts(player, objective, param1, param2)
	end

	self._objective = objective
	self._param1 = param1
	self._param2 = param2
end

function HUDGameModeStatus:_set_objective_texts(player, objective, param1, param2)
	if objective == "" then
		self._objective_text = ""
	else
		self._objective_text = string.format(L(objective), param1, param2)
	end

	local announcement = GameModeObjectives[objective].announcement

	if announcement then
		local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

		Managers.state.event:trigger("game_mode_announcement", announcement, param1, param2)
	end
end

function HUDGameModeStatus:disabled_post_update(dt, t)
	local player = self._player

	if not player.team or player.team.name == "unassigned" then
		return
	end

	self:_update_objective(player)
end

function HUDGameModeStatus:post_update(dt, t)
	local player = self._player

	if not player.team or player.team.name == "unassigned" or script_data.map_dump_mode then
		return
	end

	self:_update_objective(player)

	local own_team_name = player.team.name
	local enemy_team_name = own_team_name == "red" and "white" or "red"

	self._objective_text_element.config.text = self._objective_text
	self._own_team_score.config.text = Managers.state.game_mode:hud_score_text(own_team_name)
	self._enemy_team_score.config.text = Managers.state.game_mode:hud_score_text(enemy_team_name)

	local timer_text, timer_alert = Managers.state.game_mode:hud_timer_text()

	self._round_timer.config.text = timer_text

	if timer_alert then
		local round_timer_layout_settings = HUDHelper:layout_settings(self._round_timer.config.layout_settings)

		round_timer_layout_settings.text_color[1] = 100 * math.cos(t * 6) + 155
	end

	self._round_timer_menu.config.text = timer_text

	if timer_alert then
		local round_timer_layout_settings = HUDHelper:layout_settings(self._round_timer_menu.config.layout_settings)

		round_timer_layout_settings.text_color[1] = 100 * math.cos(t * 6) + 155
	end

	local bar_left, bar_center, bar_right, show_bar_center_divider = Managers.state.game_mode:hud_progress(player)
	local bar_lerp_speed = 3

	self._bar_left_lerped = self._bar_left_lerped and math.lerp(self._bar_left_lerped, bar_left, dt * bar_lerp_speed) or bar_left
	self._bar_center_lerped = self._bar_center_lerped and math.lerp(self._bar_center_lerped, bar_center, dt * bar_lerp_speed) or bar_center
	self._bar_right_lerped = self._bar_right_lerped and math.lerp(self._bar_right_lerped, bar_right, dt * bar_lerp_speed) or bar_right

	local own_bar_layout_settings = HUDHelper:layout_settings(self._own_progress_bar.config.layout_settings)
	local own_bar_offset_x = own_bar_layout_settings.progress_bar_offset_x
	local own_bar_max_w = own_bar_layout_settings.progress_bar_max_width

	own_bar_layout_settings.pivot_offset_x = own_bar_offset_x + self._bar_left_lerped * own_bar_max_w
	own_bar_layout_settings.texture_width = own_bar_offset_x + self._bar_center_lerped * own_bar_max_w - own_bar_layout_settings.pivot_offset_x

	local enemy_bar_layout_settings = HUDHelper:layout_settings(self._enemy_progress_bar.config.layout_settings)
	local enemy_bar_offset_x = enemy_bar_layout_settings.progress_bar_offset_x
	local enemy_bar_max_w = enemy_bar_layout_settings.progress_bar_max_width

	enemy_bar_layout_settings.pivot_offset_x = enemy_bar_offset_x + self._bar_center_lerped * enemy_bar_max_w
	enemy_bar_layout_settings.texture_width = enemy_bar_offset_x + self._bar_right_lerped * enemy_bar_max_w - enemy_bar_layout_settings.pivot_offset_x

	local bar_divider_layout_settings = HUDHelper:layout_settings(HUDSettings.game_mode_status.progress_bar_divider)

	if show_bar_center_divider then
		local bar_divider_offset_x = bar_divider_layout_settings.progress_bar_offset_x
		local bar_divider_max_w = bar_divider_layout_settings.progress_bar_max_width

		bar_divider_layout_settings.pivot_offset_x = bar_divider_offset_x + self._bar_center_lerped * bar_divider_max_w - bar_divider_layout_settings.texture_width / 2
		bar_divider_layout_settings.color = {
			255,
			255,
			255,
			255
		}
	else
		bar_divider_layout_settings.color = {
			0,
			255,
			255,
			255
		}
	end

	if self._show_game_mode_status then
		local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
		local gui = self._gui

		self._container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

		self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._container:render(dt, t, gui, layout_settings)
	else
		local layout_settings = HUDHelper:layout_settings(self._container_menu.config.layout_settings)
		local gui = self._gui

		self._container_menu:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._container_menu, layout_settings)

		self._container_menu:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._container_menu:render(dt, t, gui, layout_settings)
	end
end

function HUDGameModeStatus:destroy()
	World.destroy_gui(self._world, self._gui)
end
