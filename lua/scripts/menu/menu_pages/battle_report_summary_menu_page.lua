-- chunkname: @scripts/menu/menu_pages/battle_report_summary_menu_page.lua

require("scripts/menu/menu_containers/item_grid_menu_container")

BattleReportSummaryMenuPage = class(BattleReportSummaryMenuPage, BattleReportBaseMenuPage)

function BattleReportSummaryMenuPage:init(config, item_groups, world)
	BattleReportSummaryMenuPage.super.init(self, config, item_groups, world)

	self._world = world
	self._local_player_index = config.local_player_index
	self._local_player_won = config.local_player_won
	self._stats_collection = config.stats_collection
	self._gained_xp_and_coins = config.gained_xp_and_coins
	self._penalty_xp = config.penalty_xp
	self._awarded_prizes = config.awarded_prizes
	self._awarded_medals = config.awarded_medals
	self._awarded_ranks = config.awarded_ranks
	self._summary_list = ItemGridMenuContainer.create_from_config(item_groups.summary_items, item_groups.summary_headers)
	self._award_list = ItemGridMenuContainer.create_from_config(item_groups.awards, nil, item_groups.awards_scroll_bar)
	self._xp_progress_bar_container = ItemListMenuContainer.create_from_config(item_groups.xp_progress_bar)
	self._sub_total_xp = 0
	self._sub_total_coins = 0
	self._bar_xp = nil
	self._bar_xp_target = nil
	self._bar_coins = nil
	self._bar_coins_target = nil
	self._total_finished = false
	self._award_items_added = false
	self._first_enter = true
	self._objective_bonus = {
		"enemy_kill_within_objective",
		"section_cleared_payload"
	}

	local sub_total_xp = 0
	local sub_total_coins = 0
	local bonus_count = 0
	local bonus_xp = 0
	local bonus_coins = 0

	if self._gained_xp_and_coins then
		for _, data in pairs(self._gained_xp_and_coins) do
			sub_total_xp = sub_total_xp + data.xp
			sub_total_coins = sub_total_coins + data.coins
		end

		bonus_count = 1
		bonus_xp = sub_total_xp * (ExperienceSettings.round_won / 100)
		bonus_coins = sub_total_coins * (ExperienceSettings.round_won / 100)

		if self._local_player_won then
			self._gained_xp_and_coins.round_won = {
				count = bonus_count,
				xp = bonus_xp,
				coins = bonus_coins
			}
		else
			self._gained_xp_and_coins.round_won = {
				coins = 0,
				count = 0,
				xp = 0
			}
		end
	end

	if self._penalty_xp then
		local team_damage_count = self._penalty_xp.team_damage and self._penalty_xp.team_damage.count or 0
		local team_damage_penalty = self._penalty_xp.team_damage and (self._penalty_xp.team_damage.amount or 0) * ExperienceSettings.team_damage / 100 or 0
		local penalty_xp = math.ceil((sub_total_xp + bonus_xp) * team_damage_penalty)
		local penalty_coins = math.ceil((sub_total_coins + bonus_coins) * team_damage_penalty)

		self._penalty_xp.team_damage = {
			count = team_damage_count,
			xp = penalty_xp,
			coins = penalty_coins
		}

		local team_kill_count = self._penalty_xp.team_kill and self._penalty_xp.team_kill.count or 0
		local team_kill_penalty = self._penalty_xp.team_kill and (self._penalty_xp.team_kill.amount or 0) * ExperienceSettings.team_kill / 100 or 0
		local penalty_xp = math.ceil((sub_total_xp + bonus_xp) * team_kill_penalty)
		local penalty_coins = math.ceil((sub_total_coins + bonus_coins) * team_kill_penalty)

		self._penalty_xp.team_kill = {
			count = team_kill_count,
			xp = penalty_xp,
			coins = penalty_coins
		}

		local demo_penalty = ExperienceSettings.DEMO_MULTIPLIER
		local total_xp = math.ceil(sub_total_xp + bonus_xp)
		local penalty_xp = total_xp / demo_penalty - total_xp
		local total_coins = math.ceil(sub_total_coins + bonus_coins)
		local penalty_coins = total_coins / demo_penalty - total_coins

		self._penalty_xp.demo_penalty = {
			count = demo_penalty,
			xp = penalty_xp * demo_penalty,
			coins = penalty_coins * demo_penalty
		}
	end
end

function BattleReportSummaryMenuPage:on_enter()
	BattleReportSummaryMenuPage.super.on_enter(self)

	if script_data.debug_battle_report then
		self._gained_xp_and_coins = {
			objective_captured = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			enemy_kills = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			assist = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			enemy_damage = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			executions = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			headshots = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			enemy_instakill = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			squad_wipes = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			revives = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			team_bandages = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			},
			round_won = {
				count = math.random(1, 10),
				xp = math.random(1, 1000),
				coins = math.random(1, 1000)
			}
		}
		self._penalty_xp = self._penalty_xp or {}
		self._awarded_prizes = {}

		for name, config in pairs(Prizes.COLLECTION) do
			self._awarded_prizes[name] = math.random(1, 3)
		end

		self._awarded_medals = {}

		for name, config in pairs(Medals.COLLECTION) do
			self._awarded_medals[name] = math.random(1, 3)
		end

		self._awarded_ranks = {}

		for i = 0, 60 do
			self._awarded_ranks[#self._awarded_ranks + 1] = i
		end
	end

	self:remove_items("awards")

	local profile_data = Managers.persistence:profile_data()

	if profile_data then
		self._bar_xp = math.floor(profile_data.attributes.experience)
		self._bar_xp_target = self._bar_xp
		self._bar_coins = profile_data.attributes.coins
		self._bar_coins_target = self._bar_coins
	else
		self._bar_xp = nil
		self._bar_xp_target = nil
		self._bar_coins = nil
		self._bar_coins_target = nil
	end

	self._total_finished = false
	self._award_items_added = false

	local items = self:items_in_group("summary_items")
	local reason = items[1]:name()
	local data = self._gained_xp_and_coins[reason] or self._penalty_xp[reason] or {
		coins = 0,
		count = 0,
		xp = 0
	}

	self._sub_total_xp = 0
	self._sub_total_coins = 0

	items[1]:start(data, self._first_enter)
end

function BattleReportSummaryMenuPage:_update_xp_and_coins(xp, coins)
	local rank

	for i = 0, #RANKS do
		local props = RANKS[i]

		if xp >= props.xp.base and xp < props.xp.base + props.xp.span then
			rank = i

			break
		end
	end

	local next_rank_exists = RANKS[rank + 1]
	local next_rank = next_rank_exists and rank + 1 or nil
	local xp_next_rank = next_rank_exists and RANKS[rank].xp.base + RANKS[rank].xp.span or nil
	local xp_current_rank = RANKS[rank].xp.base
	local bar_data = {
		value = string.format("%.0f", math.ceil(xp)),
		value_min = xp_current_rank,
		value_max = xp_next_rank,
		left_text = rank,
		right_text = next_rank
	}

	self:find_item_by_name("xp_progress_bar"):set_bar_data(bar_data)

	self:find_item_by_name("coins").config.text = string.format("%.0f", math.ceil(coins))
end

function BattleReportSummaryMenuPage:on_exit()
	BattleReportSummaryMenuPage.super.on_exit(self)

	self._first_enter = false
end

function BattleReportSummaryMenuPage:_add_award_items()
	for _, rank in ipairs(self._awarded_ranks) do
		for _, unlock in ipairs(RANKS[rank].unlocks) do
			self:_add_award_item(unlock.ui_settings.name, 1, unlock.ui_settings.battle_report_summary_textures, unlock.ui_settings.name, unlock.ui_settings.description)
		end
	end

	for name, amount in pairs(self._awarded_prizes) do
		local prize = Prizes.COLLECTION[name]

		self:_add_award_item(prize.ui_settings.name, amount, prize.ui_settings.battle_report_summary_textures, prize.ui_settings.name, prize.ui_settings.description)
	end

	for name, amount in pairs(self._awarded_medals) do
		local medal = Medals.COLLECTION[name]

		self:_add_award_item(medal.ui_settings.name, amount, medal.ui_settings.battle_report_summary_textures, medal.ui_settings.name, medal.ui_settings.description)
	end

	local items = self:items_in_group("awards")

	if items[1] then
		items[1]:start(self._first_enter)
	end
end

function BattleReportSummaryMenuPage:_add_award_item(award_name, award_amount, award_textures, tooltip_header, tooltip_text)
	local floating_tooltip

	if tooltip_header or tooltip_text then
		floating_tooltip = {
			header = tooltip_header,
			text = tooltip_text,
			layout_settings = BattleReportSettings.items.summary_award_tooltip
		}
	end

	local item_config = {
		on_finished = "cb_start_next_award_item",
		disabled = true,
		parent_page = self,
		z = self.config.z + 10,
		award_name = award_name,
		award_amount = award_amount,
		award_textures = award_textures,
		layout_settings = BattleReportSettings.items.summary_award,
		floating_tooltip = floating_tooltip
	}
	local item = BattleReportSummaryAwardMenuItem.create_from_config({
		world = self._world
	}, item_config, self)

	self:add_item(item, "awards")
end

function BattleReportSummaryMenuPage:_update_container_size(dt, t)
	BattleReportSummaryMenuPage.super._update_container_size(self, dt, t)

	if self._bar_xp then
		self._bar_xp = math.lerp(self._bar_xp, self._bar_xp_target, dt * 5)
		self._bar_coins = math.lerp(self._bar_coins, self._bar_coins_target, dt * 5)

		self:_update_xp_and_coins(self._bar_xp, self._bar_coins)

		if not self._award_items_added and (not self._first_enter or self._total_finished and self._bar_xp >= self._bar_xp_target - 1 and self._bar_coins >= self._bar_coins_target - 1) then
			self:_add_award_items()

			self._award_items_added = true
		end
	elseif not self._award_items_added then
		self:_add_award_items()

		self._award_items_added = true
	end

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._summary_list:update_size(dt, t, self._gui, layout_settings.summary_list)
	self._award_list:update_size(dt, t, self._gui, layout_settings.award_list)
	self._xp_progress_bar_container:update_size(dt, t, self._gui, layout_settings.xp_progress_bar)
end

function BattleReportSummaryMenuPage:_update_container_position(dt, t)
	BattleReportSummaryMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._summary_list, layout_settings.summary_list)

	self._summary_list:update_position(dt, t, layout_settings.summary_list, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._award_list, layout_settings.award_list)

	self._award_list:update_position(dt, t, layout_settings.award_list, x, y, self.config.z + 40)

	local x, y = MenuHelper:container_position(self._xp_progress_bar_container, layout_settings.xp_progress_bar)

	self._xp_progress_bar_container:update_position(dt, t, layout_settings.xp_progress_bar, x, y, self.config.z + 5)
end

function BattleReportSummaryMenuPage:_select_item(change_page_delay, ignore_sound)
	local controller_active = Managers.input:pad_active(1)

	if not controller_active then
		self.super._select_item(self, change_page_delay, ignore_sound)
	end
end

function BattleReportSummaryMenuPage:_update_input(input)
	self.super._update_input(self, input)

	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		if input:get("scoreboard") then
			self:cb_goto_menu_page("battle_report_scoreboard")
		end

		if input:get("next_battle") then
			self:cb_goto_menu_page("loading_screen")
		end
	end
end

function BattleReportSummaryMenuPage:render(dt, t)
	BattleReportSummaryMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._summary_list:render(dt, t, self._gui, layout_settings.summary_list)
	self._award_list:render(dt, t, self._gui, layout_settings.award_list)
	self._xp_progress_bar_container:render(dt, t, self._gui, layout_settings.xp_progress_bar)
end

function BattleReportSummaryMenuPage:cb_start_next_summary_item(item)
	local item_index = self:_item_index(item)
	local next_item_index = item_index + 1
	local next_item = self._items[next_item_index]

	if next_item and self:is_in_group(next_item, "summary_items") then
		local reason = next_item:name()

		if reason == "objective_bonus" then
			local data = {
				coins = 0,
				count = 0,
				xp = 0
			}

			for gained_reason, gained_data in pairs(self._gained_xp_and_coins) do
				if table.contains(self._objective_bonus, gained_reason) then
					data.count = data.count + gained_data.count
					data.xp = data.xp + gained_data.xp
					data.coins = data.coins + gained_data.coins
				end
			end

			next_item:start(data, self._first_enter)
		else
			local data = self._gained_xp_and_coins[reason] or self._penalty_xp[reason] or {
				coins = 0,
				count = 0,
				xp = 0
			}

			next_item:start(data, self._first_enter)
		end
	end
end

function BattleReportSummaryMenuPage:cb_increment_subtotal(xp, coins)
	local item = self:find_item_by_name("sub_total")

	self._sub_total_xp = self._sub_total_xp + xp

	item:set_xp(self._sub_total_xp)

	self._sub_total_coins = self._sub_total_coins + coins

	item:set_coins(self._sub_total_coins)
end

function BattleReportSummaryMenuPage:cb_increment_total(xp, coins)
	local item = self:find_item_by_name("total")

	self._sub_total_xp = self._sub_total_xp + xp

	item:set_xp(self._sub_total_xp)

	self._sub_total_coins = self._sub_total_coins + coins

	item:set_coins(self._sub_total_coins)
end

function BattleReportSummaryMenuPage:cb_decrement_total(xp, coins)
	local item = self:find_item_by_name("total")

	self._sub_total_xp = math.max(self._sub_total_xp - xp, 0)

	item:set_xp(self._sub_total_xp)

	self._sub_total_coins = math.max(self._sub_total_coins - coins, 0)

	item:set_coins(self._sub_total_coins)
end

function BattleReportSummaryMenuPage:cb_total_finished()
	if self._bar_xp then
		self._bar_xp_target = self._bar_xp + self._sub_total_xp
		self._bar_coins_target = self._bar_coins + self._sub_total_coins
	end

	self._total_finished = true
end

function BattleReportSummaryMenuPage:cb_start_next_award_item(item)
	local item_index = self:_item_index(item)
	local next_item_index = item_index + 1
	local next_item = self._items[next_item_index]

	if next_item and self:is_in_group(next_item, "awards") then
		next_item:start(self._first_enter)
	end
end

function BattleReportSummaryMenuPage:cb_awards_scroll_select_down(row)
	self._award_list:set_top_visible_row(row)
end

function BattleReportSummaryMenuPage:cb_awards_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	return not self._award_list:can_scroll(layout_settings.award_list)
end

function BattleReportSummaryMenuPage:cb_goto_menu_page(id)
	self._menu_logic:goto(id)
end

function BattleReportSummaryMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		no_cancel_to_parent_page = true,
		type = "battle_report_summary",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		players = compiler_data.menu_data.players,
		local_player_index = compiler_data.menu_data.local_player_index,
		local_player_won = compiler_data.menu_data.local_player_won,
		stats_collection = compiler_data.menu_data.stats_collection,
		gained_xp_and_coins = compiler_data.menu_data.gained_xp_and_coins,
		penalty_xp = compiler_data.menu_data.penalty_xp,
		awarded_prizes = compiler_data.menu_data.awarded_prizes,
		awarded_medals = compiler_data.menu_data.awarded_medals,
		awarded_ranks = compiler_data.menu_data.awarded_ranks,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return BattleReportSummaryMenuPage:new(config, item_groups, compiler_data.world)
end
