-- chunkname: @scripts/managers/hud/hud_xp_coins/hud_xp_coins.lua

require("scripts/managers/hud/hud_base")
require("scripts/managers/hud/hud_xp_coins/hud_xp_coins_text")

local DELAY_BETWEEN_AWARDS = 1

HUDXPCoins = class(HUDXPCoins, HUDBase)

function HUDXPCoins:init(world, player)
	HUDXPCoins.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", MenuSettings.font_group_materials.wotr_hud_text, "immediate")

	Managers.state.event:register(self, "gained_xp_and_coins", "event_gained_xp_and_coins")

	self._queued_awards = {}
	self._showing_awards = {}
end

function HUDXPCoins:event_gained_xp_and_coins(reason, xp, coins)
	if not HUDSettings.show_xp_awards then
		return
	end

	if xp > 0 or coins > 0 then
		local time = Managers.time:time("game")
		local award = HUDXPCoinsText.create_from_config(reason, xp, coins)

		if table.is_empty(self._showing_awards) then
			award:set_start_time(time)
			table.insert(self._queued_awards, 1, award)
		else
			local last_start_time = (self._queued_awards[1] or self._showing_awards[1]):start_time()

			award:set_start_time(last_start_time + DELAY_BETWEEN_AWARDS)
			table.insert(self._queued_awards, 1, award)
		end
	end
end

function HUDXPCoins:post_update(dt, t)
	self:_update_queued_awards(dt, t)
	self:_update_showing_awards(dt, t)
end

function HUDXPCoins:_update_queued_awards(dt, t)
	if table.is_empty(self._queued_awards) then
		return
	end

	local index = #self._queued_awards
	local award = self._queued_awards[index]

	if t >= award:start_time() then
		award:start(t)
		table.insert(self._showing_awards, 1, award)

		self._queued_awards[index] = nil
	end
end

function HUDXPCoins:_update_showing_awards(dt, t)
	for index, award in ipairs(self._showing_awards) do
		local layout_settings = HUDHelper:layout_settings(award.config.layout_settings)
		local x, y = HUDHelper:element_position(nil, award, layout_settings)

		if award:update(dt, t, x, y - (index - 1) * 50, layout_settings, self._gui) then
			self._showing_awards[index] = nil
		end
	end
end

function HUDXPCoins:destroy()
	World.destroy_gui(self._world, self._gui)
end
