-- chunkname: @scripts/menu/menu_pages/loading_screen_menu_page.lua

require("scripts/menu/menu_containers/tip_of_the_day_menu_container")

LoadingScreenMenuPage = class(LoadingScreenMenuPage, Level1MenuPage)

function LoadingScreenMenuPage:init(config, item_groups, world)
	LoadingScreenMenuPage.super.init(self, config, item_groups, world)

	self._local_player = config.local_player
	self._background_level_texture = TextureMenuContainer.create_from_config()
	self._tip_of_the_day = TipOfTheDayMenuContainer.create_from_config(world)
	self._demo_background_texture = TextureMenuContainer.create_from_config()
	self._countdown = TextMenuContainer.create_from_config("")

	Managers.state.event:register(self, "game_start_countdown_tick", "event_game_start_countdown_tick")
end

function LoadingScreenMenuPage:event_game_start_countdown_tick(t)
	self._game_start_countdown = t
end

function LoadingScreenMenuPage:on_enter(on_cancel)
	LoadingScreenMenuPage.super.on_enter(self, on_cancel)

	self:find_item_by_name("server_name").config.text = Managers.lobby:server_name() or ""
	self:find_item_by_name("server_description").config.text = Managers.lobby:game_description() or ""

	local game_data = self:_try_callback(self.config.callback_object, "cb_game_data")

	self:find_item_by_name("game_mode_name").config.text = L(GameModeSettings[game_data.game_mode].display_name)
	self:find_item_by_name("game_mode_description").config.text = L(GameModeSettings[game_data.game_mode].ui_description.unassigned)
	self:find_item_by_name("level_name").config.text = L(LevelSettings[game_data.level].display_name)
	self:find_item_by_name("level_description").config.text = L(LevelSettings[game_data.level].ui_description)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local tip_name = self:_randomize_tip(game_data.level, game_data.game_mode)

	self._tip_of_the_day:load_tip(tip_name, game_data.level, layout_settings.tip_of_the_day, self._gui)
end

function LoadingScreenMenuPage:_randomize_tip(level, game_mode)
	local num_game_mode_tips = #GameModeSettings[game_mode].tip_of_the_day
	local num_level_tips = #LevelSettings[level].tip_of_the_day
	local random_num = math.random(1, num_game_mode_tips + num_level_tips)
	local tip

	if random_num <= num_game_mode_tips then
		tip = GameModeSettings[game_mode].tip_of_the_day[random_num]
	else
		tip = LevelSettings[level].tip_of_the_day[random_num - num_game_mode_tips]
	end

	return tip
end

function LoadingScreenMenuPage:update(dt, t, input)
	LoadingScreenMenuPage.super.update(self, dt, t, input)

	if self._game_start_countdown then
		local start_time = math.max(0, self._game_start_countdown)
		local text

		if start_time > 0 then
			text = L("battle_starts_in") .. " " .. string.format("%.0f", start_time)
		else
			text = L("prepare_for_battle")
		end

		self._countdown:set_text(text)
	end
end

function LoadingScreenMenuPage:_update_container_size(dt, t)
	LoadingScreenMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_level_texture:update_size(dt, t, self._gui, layout_settings.background_level_texture)
	self._demo_background_texture:update_size(dt, t, self._gui, layout_settings.demo_screen)
	self._tip_of_the_day:update_size(dt, t, self._gui, layout_settings.tip_of_the_day)
	self._countdown:update_size(dt, t, self._gui, layout_settings.countdown)
end

function LoadingScreenMenuPage:_update_container_position(dt, t)
	LoadingScreenMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._background_level_texture, layout_settings.background_level_texture)

	self._background_level_texture:update_position(dt, t, layout_settings.background_level_texture, x, y, self.config.z)

	local x, y = MenuHelper:container_position(self._demo_background_texture, layout_settings.demo_screen)

	self._demo_background_texture:update_position(dt, t, layout_settings.demo_screen, x, y, self.config.z)

	local x, y = MenuHelper:container_position(self._tip_of_the_day, layout_settings.tip_of_the_day)

	self._tip_of_the_day:update_position(dt, t, layout_settings.tip_of_the_day, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._countdown, layout_settings.countdown)

	self._countdown:update_position(dt, t, layout_settings.countdown, x, y, self.config.z + 5)
end

function LoadingScreenMenuPage:render(dt, t)
	LoadingScreenMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local res_width, res_height = Gui.resolution()
	local bgr_texture_width = layout_settings.background_level_texture.texture_width
	local bgr_texture_height = layout_settings.background_level_texture.texture_height

	layout_settings.background_level_texture.stretch_height = res_height
	layout_settings.background_level_texture.stretch_width = bgr_texture_width * (res_height / bgr_texture_height)

	if not IS_DEMO then
		self._background_level_texture:render(dt, t, self._gui, layout_settings.background_level_texture)
		self._tip_of_the_day:render(dt, t, self._gui, layout_settings.tip_of_the_day)
	else
		Gui.rect(self._gui, Vector3(0, 0, self.config.z - 1), Vector2(res_width, res_height), Color(0, 0, 0))
		self._demo_background_texture:render(dt, t, self._gui, layout_settings.demo_screen)
	end

	self._countdown:render(dt, t, self._gui, layout_settings.countdown)
end

function LoadingScreenMenuPage:destroy()
	LoadingScreenMenuPage.super.destroy(self)
	self._tip_of_the_day:destroy()
end

function LoadingScreenMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		no_cancel_to_parent_page = true,
		type = "loading_screen",
		parent_page = parent_page,
		callback_object = callback_object,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		local_player = compiler_data.menu_data.local_player,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return LoadingScreenMenuPage:new(config, item_groups, compiler_data.world)
end
