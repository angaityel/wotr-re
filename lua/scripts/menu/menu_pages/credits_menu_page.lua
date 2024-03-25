-- chunkname: @scripts/menu/menu_pages/credits_menu_page.lua

CreditsMenuPage = class(CreditsMenuPage, MainMenuPage)

function CreditsMenuPage:init(config, item_groups, world)
	CreditsMenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
end

function CreditsMenuPage:_update_input(input)
	CreditsMenuPage.super._update_input(self, input)

	if not input then
		self._wanted_speed = Credits.settings.speed
		self._wanted_speed_linger = nil

		return
	end

	if input:has("move_up_hold") and input:get("move_up_hold") == 1 then
		self._wanted_speed = -Credits.settings.scroll_speed
		self._wanted_speed_linger = nil
	elseif input:has("move_down_hold") and input:get("move_down_hold") == 1 then
		self._wanted_speed = Credits.settings.scroll_speed
		self._wanted_speed_linger = nil
	elseif input:has("wheel") and input:get("wheel").y ~= 0 then
		local y = input:get("wheel").y

		if y == -1 then
			self._wanted_speed = Credits.settings.scroll_speed
		elseif y == 1 then
			self._wanted_speed = -Credits.settings.scroll_speed
		end

		self._wanted_speed_linger = 0.3
	elseif not self._wanted_speed_linger then
		self._wanted_speed = Credits.settings.speed
	end
end

function CreditsMenuPage:on_enter(on_cancel)
	CreditsMenuPage.super.on_enter(self, on_cancel)

	self._wanted_speed = Credits.settings.speed
	self._wanted_speed_linger = nil
	self._speed = self._wanted_speed
	self._list_offset_y = 0
	self._max_speed = 0
end

function CreditsMenuPage:update(dt, t)
	CreditsMenuPage.super.update(self, dt, t)

	self._speed = math.lerp(self._speed, self._wanted_speed, dt * Credits.settings.lerp_speed)

	if self._wanted_speed_linger then
		self._wanted_speed_linger = self._wanted_speed_linger - dt
	end

	if self._wanted_speed_linger and self._wanted_speed_linger <= 0 then
		self._wanted_speed_linger = nil
	end

	if self._speed > self._max_speed then
		self._max_speed = self._speed
	end

	self._list_offset_y = self._list_offset_y + self._speed * dt
end

function CreditsMenuPage:_update_container_size(dt, t)
	CreditsMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
end

function CreditsMenuPage:_update_container_position(dt, t)
	CreditsMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

	self._item_list:update_position(dt, t, layout_settings.item_list, x, y + self._list_offset_y, self.config.z + 20)
end

function CreditsMenuPage:render(dt, t)
	CreditsMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._item_list:render(dt, t, self._gui, layout_settings.item_list)
end

function CreditsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "credits",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return CreditsMenuPage:new(config, item_groups, compiler_data.world)
end
