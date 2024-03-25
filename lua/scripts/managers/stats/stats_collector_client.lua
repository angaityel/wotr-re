-- chunkname: @scripts/managers/stats/stats_collector_client.lua

StatsCollectorClient = class(StatsCollectorClient)

function StatsCollectorClient:weapon_missed(player, gear_name)
	if Managers.state.network:game() then
		Managers.state.network:send_rpc_server("rpc_stat_weapon_missed", player.game_object_id, NetworkLookup.gear_names[gear_name])
	end
end

function StatsCollectorClient:player_revived(revivee, reviver)
	return
end
