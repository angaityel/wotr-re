-- chunkname: @scripts/menu/menu_pages/battle_report_base_menu_page.lua

require("scripts/menu/menu_pages/sheet_menu_page")
require("scripts/menu/menu_containers/item_grid_menu_container")

BattleReportBaseMenuPage = class(BattleReportBaseMenuPage, SheetMenuPage)

function BattleReportBaseMenuPage:init(config, item_groups, world)
	BattleReportBaseMenuPage.super.init(self, config, item_groups, world)

	self._background_level_texture = TextureMenuContainer.create_from_config()
	self._header_items = ItemGridMenuContainer.create_from_config(item_groups.header_items)
	self._page_links = ItemListMenuContainer.create_from_config(item_groups.page_links)

	Managers.state.event:register(self, "game_start_countdown_tick", "event_game_start_countdown_tick")
end

function BattleReportBaseMenuPage:event_game_start_countdown_tick(t)
	self._game_start_countdown = t
end

function BattleReportBaseMenuPage:update(dt, t, input)
	BattleReportBaseMenuPage.super.update(self, dt, t, input)
	Managers.sale_popup:update()

	if Managers.sale_popup:new_data(true) then
		self._sale_popup_displayed = true

		self:open_sale_popup(Managers.sale_popup:get_loaded_data())
	end

	if self._game_start_countdown then
		local start_time = math.max(0, self._game_start_countdown)
		local countdown_item = self:find_item_by_name("countdown")
		local link_item = self:find_item_by_name("next_page_link")

		if start_time > 0 then
			countdown_item.config.text = L("battle_starts_in") .. " " .. string.format("%.0f", start_time)

			if link_item:pulse() then
				link_item:stop_pulse()
			end
		else
			countdown_item.config.text = L("prepare_for_battle")

			if not link_item:pulse() then
				link_item:start_pulse(5, 0, 70)
			end
		end
	end
end

function BattleReportBaseMenuPage:_update_container_size(dt, t)
	BattleReportBaseMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local res_width, res_height = Gui.resolution()
	local bgr_texture_width = layout_settings.background_level_texture.texture_width
	local bgr_texture_height = layout_settings.background_level_texture.texture_height

	layout_settings.background_level_texture.stretch_height = res_height
	layout_settings.background_level_texture.stretch_width = bgr_texture_width * (res_height / bgr_texture_height)

	self._background_level_texture:update_size(dt, t, self._gui, layout_settings.background_level_texture)
	self._header_items:update_size(dt, t, self._gui, layout_settings.header_items)
	self._page_links:update_size(dt, t, self._gui, layout_settings.page_links)
end

function BattleReportBaseMenuPage:_update_container_position(dt, t)
	BattleReportBaseMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._background_level_texture, layout_settings.background_level_texture)

	self._background_level_texture:update_position(dt, t, layout_settings.background_level_texture, x, y, self.config.z - 10)

	local x, y = MenuHelper:container_position(self._header_items, layout_settings.header_items)

	self._header_items:update_position(dt, t, layout_settings.header_items, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._page_links, layout_settings.page_links)

	self._page_links:update_position(dt, t, layout_settings.page_links, x, y, self.config.z + 20)
end

function BattleReportBaseMenuPage:render(dt, t)
	BattleReportBaseMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_level_texture:render(dt, t, self._gui, layout_settings.background_level_texture)
	self._header_items:render(dt, t, self._gui, layout_settings.header_items)

	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		self._page_links:render(dt, t, self._gui, layout_settings.page_links)
	end
end
