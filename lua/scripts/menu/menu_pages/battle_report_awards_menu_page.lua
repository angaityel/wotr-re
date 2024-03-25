-- chunkname: @scripts/menu/menu_pages/battle_report_awards_menu_page.lua

require("scripts/menu/menu_containers/item_grid_menu_container")

BattleReportAwardsMenuPage = class(BattleReportAwardsMenuPage, BattleReportBaseMenuPage)

function BattleReportAwardsMenuPage:init(config, item_groups, world)
	BattleReportAwardsMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._local_player_index = config.local_player_index
end

function BattleReportAwardsMenuPage:_update_container_size(dt, t)
	BattleReportAwardsMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
end

function BattleReportAwardsMenuPage:_update_container_position(dt, t)
	BattleReportAwardsMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
end

function BattleReportAwardsMenuPage:render(dt, t)
	BattleReportAwardsMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
end

function BattleReportAwardsMenuPage:cb_goto_menu_page(id)
	self._menu_logic:goto(id)
end

function BattleReportAwardsMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "battle_report_awards",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		players = compiler_data.menu_data.players,
		local_player_index = compiler_data.menu_data.local_player_index,
		stats_collection = compiler_data.menu_data.stats_collection,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return BattleReportAwardsMenuPage:new(config, item_groups, compiler_data.world)
end
