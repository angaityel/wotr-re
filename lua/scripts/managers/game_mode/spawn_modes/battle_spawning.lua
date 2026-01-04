-- chunkname: @scripts/managers/game_mode/spawn_modes/battle_spawning.lua

require("scripts/managers/game_mode/spawn_modes/spawning_base")

BattleSpawning = class(BattleSpawning, SpawningBase)

function BattleSpawning:init(settings, game_mode)
	BattleSpawning.super.init(self, settings, game_mode)

	self._settings = settings
	self._spawn_timer = settings.spawn_timer

	assert(self._spawn_timer, "[BattleSpawning] Missing spawn_timer in spawn settings! (either for dedicated server or in game mode settings)")

	self._spawned = false
	self._teams_ready = false
	self._spawn_time_left = self._spawn_timer
	self._game_mode = game_mode
	self._minimum_players_per_team = settings.minimum_players_per_team or 1
	self._tie_break_started = false
end

function BattleSpawning:setup()
	self:init(self._settings)
end

function BattleSpawning:next_spawn_time(player)
	if not self._teams_ready then
		return math.huge
	elseif self._spawned then
		return Managers.time:time("round") + self._settings.yield_timer
	else
		return self._spawn_time_left
	end
end

function BattleSpawning:update(dt)
	local t = Managers.time:time("round")

	if not self._spawned then
		self._teams_ready = self:_are_teams_ready() or self._teams_ready

		if self._teams_ready then
			if not Managers.time:active("round") then
				self:_unpause_round_timer(t)
			end

			if t >= self._spawn_time_left then
				Managers.state.spawn:force_spawn()
				self._game_mode:spawned()

				self._spawned = true
			end
		else
			if Managers.time:active("round") and t > 0 then
				self:_pause_round_timer(t)
			end

			self._spawn_time_left = math.max(t, 0) + self._spawn_timer
		end
	end
end

function BattleSpawning:_pause_round_timer(round_time)
	Managers.state.network:send_rpc_clients("rpc_synch_round_time", round_time, false)
	Managers.time:set_active("round", false)
end

function BattleSpawning:_unpause_round_timer(round_time)
	Managers.state.network:send_rpc_clients("rpc_synch_round_time", round_time, true)
	Managers.time:set_active("round", true)
end

function BattleSpawning:_are_teams_ready()
	local team_manager = Managers.state.team
	local red_team = team_manager:team_by_name("red")
	local white_team = team_manager:team_by_name("white")

	if not red_team or not white_team then
		return false
	end

	local white_ready = 0
	local red_ready = 0

	for _, player in pairs(red_team.members) do
		local state = player.spawn_data.state

		if state == "ghost_mode" then
			red_ready = red_ready + 1
		end
	end

	for _, player in pairs(white_team.members) do
		local state = player.spawn_data.state

		if state == "ghost_mode" then
			white_ready = white_ready + 1
		end
	end

	local min_players = self._minimum_players_per_team

	return min_players <= red_ready and min_players <= white_ready
end
