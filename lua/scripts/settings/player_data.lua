-- chunkname: @scripts/settings/player_data.lua

function populate_player_data_from_save(save_data)
	if save_data.player_data then
		PlayerData = save_data.player_data
	else
		save_data.player_data = PlayerData
	end
end

PlayerData = {
	sp_level_progression_id = 1
}
