-- chunkname: @scripts/managers/admin/auto_rules.lua

AutoRules = class(AutoRules)

function AutoRules:init(settings)
	self._auto_rules = {}

	for stat_name, props in pairs(settings.autokick_rules or {}) do
		fassert(StatsContexts.player[stat_name], "Invalid autokick rule, parameter %q doesn't exist", stat_name)

		self._auto_rules[#self._auto_rules + 1] = {
			action = "kick_player",
			stat_name = stat_name,
			props = props
		}
	end

	for stat_name, props in pairs(settings.autoban_rules or {}) do
		fassert(StatsContexts.player[stat_name], "Invalid autoban rule, parameter %q doesn't exist", stat_name)

		self._auto_rules[#self._auto_rules + 1] = {
			action = "ban_player",
			stat_name = stat_name,
			props = props
		}
	end
end

function AutoRules:setup()
	self._stats = Managers.state.stats_collection
	self._players = Managers.player:players()

	Managers.state.event:register(self, "player_joined", "event_player_joined")
end

function AutoRules:event_player_joined(player)
	for _, rule in pairs(self._auto_rules) do
		local ban_reason = sprintf("%s >= %d", rule.stat_name, rule.props.value)
		local ban_time = rule.props.ban_time or 1800
		local cb = callback(Managers.admin, rule.action, player:network_id(), ban_reason, ban_time)

		self._stats:register_callback(player:network_id(), rule.stat_name, ">=", rule.props.value, cb)
	end
end

function AutoRules:update(dt, t)
	for _, rule in pairs(self._auto_rules) do
		local cooldown = rule.props.cooldown

		if cooldown and dt >= t % cooldown then
			for _, player in pairs(self._players) do
				self._stats:set(player:network_id(), rule.stat_name, 0)
			end
		end
	end
end
