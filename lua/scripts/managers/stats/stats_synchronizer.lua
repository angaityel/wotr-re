-- chunkname: @scripts/managers/stats/stats_synchronizer.lua

StatsSynchronizer = class(StatsSynchronizer)
StatsSynchronizer.STATS_TO_SYNC = {
	"rank",
	"enemy_kills",
	"deaths",
	"experience_round",
	"kill_streak",
	"longest_kill_streak",
	"headshots",
	"yields",
	"enemy_damage",
	"team_bandages",
	"headshot_range",
	"longshots",
	"objectives_captured",
	"objectives_captured_assist",
	"executions"
}

function StatsSynchronizer:init(stats_collection)
	self._stats = stats_collection
	self._players = Managers.player:players()

	if Managers.lobby.server then
		self._is_client = false
	else
		self._is_client = true
	end

	Managers.state.event:register(self, "player_stats_object_created", "event_player_stats_object_created")
end

function StatsSynchronizer:update(dt, t, network_game)
	Profiler.start("StatsSynchronizer")

	if self._is_client then
		self:_client_update(network_game)
	else
		self:_server_update(network_game)
	end

	Profiler.stop()
end

function StatsSynchronizer:event_player_stats_object_created(network_game, player, stat_game_object_id)
	local network_id = player:network_id()

	for _, stat_name in pairs(self.STATS_TO_SYNC) do
		local stat_value = GameSession.game_object_field(network_game, stat_game_object_id, stat_name)

		if stat_value ~= self._stats:get(network_id, stat_name) then
			self._stats:raw_set(network_id, stat_name, stat_value)
		end
	end
end

function StatsSynchronizer:_client_update(network_game)
	for _, player in pairs(self._players) do
		local network_id = player:network_id()
		local game_object_id = player.stat_game_object_id

		if game_object_id then
			for _, stat_name in pairs(self.STATS_TO_SYNC) do
				local stat_value = GameSession.game_object_field(network_game, game_object_id, stat_name)

				if stat_value ~= self._stats:get(network_id, stat_name) then
					self._stats:set(network_id, stat_name, stat_value)
				end
			end
		end
	end
end

function StatsSynchronizer:_server_update(network_game)
	for _, player in pairs(self._players) do
		local network_id = player:network_id()
		local game_object_id = player.stat_game_object_id

		if game_object_id then
			for _, stat_name in pairs(self.STATS_TO_SYNC) do
				local stat_value = self._stats:get(network_id, stat_name)

				GameSession.set_game_object_field(network_game, game_object_id, stat_name, stat_value)
			end
		end
	end
end
