-- chunkname: @scripts/managers/admin/speed_hack_detector.lua

SpeedHackDetector = class(SpeedHackDetector)

local DIFF_THRESHOLD = 10

function SpeedHackDetector:init(settings)
	if settings then
		self._enabled = T(settings.enable, true)
	else
		self._enabled = true
	end

	self._tagged_players = {}
end

function SpeedHackDetector:setup()
	if self._enabled then
		Managers.state.event:register(self, "check_speedhack", "event_check_speedhack")
	end
end

function SpeedHackDetector:event_check_speedhack(player, round_time)
	local server_round_time = Managers.time:time("round")
	local round_time_diff = math.abs(server_round_time - round_time)

	if round_time_diff >= DIFF_THRESHOLD and self._tagged_players[player] == nil then
		cprintf("Tagging player %q because of suspected speedhack.", player:name())
		RPC.rpc_tag_speedhack(player:network_id())

		self._tagged_players[player] = true
	end
end
