-- chunkname: @scripts/managers/game_mode/spawn_modes/pulse_spawning.lua

require("scripts/managers/game_mode/spawn_modes/spawning_base")

PulseSpawning = class(PulseSpawning, SpawningBase)

function PulseSpawning:init(settings, game_mode)
	PulseSpawning.super.init(self, settings, game_mode)

	self._round_started = false
end

function PulseSpawning:round_started()
	self._round_started = true

	local settings = self._settings
	local sides = Managers.state.team:sides()
	local spawn_settings = {}
	local round_time = Managers.time:time("round")
	local pulse_time = math.max(round_time + 10, 0)

	for side, team in pairs(sides) do
		local pulse_length = settings[side .. "_pulse_length"] or settings.pulse_length
		local pulse_offset = side == (settings.pulse_offset_for_side or "attackers") and (settings[side .. "_pulse_offset"] or settings.pulse_offset or pulse_length * 0.5) or 0

		spawn_settings[side] = {
			pulse_length = pulse_length,
			pulse_offset = pulse_offset,
			pulse_time = pulse_time
		}
	end

	self._spawn_settings = spawn_settings
end

function PulseSpawning:next_spawn_time(player)
	if not self._round_started then
		return math.huge
	end

	local side = player.team.side
	local spawn_settings = self._spawn_settings[side]

	if spawn_settings then
		return spawn_settings.pulse_time + spawn_settings.pulse_length
	else
		return math.huge
	end
end

function PulseSpawning:update()
	local t = Managers.time:time("round")

	for side, settings in pairs(self._spawn_settings) do
		if t > settings.pulse_time then
			settings.pulse_time = settings.pulse_time + settings.pulse_length + settings.pulse_offset
			settings.pulse_offset = 0
		end
	end
end
