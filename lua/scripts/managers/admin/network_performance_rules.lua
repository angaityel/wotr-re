-- chunkname: @scripts/managers/admin/network_performance_rules.lua

NetworkPerformanceRules = class(NetworkPerformanceRules)

function NetworkPerformanceRules:init(server_settings)
	local settings = server_settings.network_performance_rules

	if not settings then
		print("[NetworkPerformanceRules:init()] Network Performance Rules disabled, no network_performance rules in server settings.")

		return
	end

	self._max_ping = settings.max_allowed_ping
	self._grace_time = settings.violation_grace_time
	self._ping_sample_method = settings.ping_sample_method or "single"
end

function NetworkPerformanceRules:update(dt, t)
	local max_ping = self._max_ping

	if not max_ping then
		return
	end

	for key, player in pairs(Managers.player:players()) do
		local ping_data = player.ping_data
		local sample_method = self._ping_sample_method
		local ping

		if sample_method == "mean" then
			ping = ping_data.mean_ping or 0
		else
			ping = (ping_data.ping_table[ping_data.ping_table_index] or 0) * 1000
		end

		local ping_violation = max_ping < ping

		if ping_violation and ping_data.max_ping_violation_time and t > ping_data.max_ping_violation_time then
			Managers.admin:kick_player(player:network_id(), "Ping limit exceeded: " .. max_ping .. "ms")
		elseif ping_violation then
			ping_data.max_ping_violation_time = ping_data.max_ping_violation_time or t + self._grace_time
		else
			ping_data.max_ping_violation_time = nil
		end
	end
end
