-- chunkname: @scripts/managers/save/save_data.win32.lua

local steam = rawget(_G, "Steam")
local branch_name = steam and steam.branch_name()

if branch_name and branch_name ~= "public" then
	SaveFileName = "save_data_" .. tostring(branch_name)
else
	SaveFileName = "save_data"
end

SaveData = SaveData or {
	profiles_version = 11,
	controls_version = 1,
	version = 1002
}

function populate_save_data(save_data)
	if SaveData.version == save_data.version then
		if SaveData.profiles_version ~= save_data.profiles_version then
			save_data.profiles = nil

			print("Wrong profiles_version for save file, saved: ", save_data.profiles_version, " current: ", SaveData.profiles_version)

			save_data.profiles_version = SaveData.profiles_version
		end

		if SaveData.controls_version ~= save_data.controls_version then
			save_data.controls = nil

			print("Wrong controls_version for save file, saved: ", save_data.controls_version, " current: ", SaveData.controls_version)

			save_data.controls_version = SaveData.controls_version
		end

		if SaveData.player_coat_of_arms_version ~= save_data.player_coat_of_arms_version then
			save_data.player_coat_of_arms = nil

			print("Wrong player_coat_of_arms for save file, saved: ", save_data.player_coat_of_arms_version, " current: ", SaveData.player_coat_of_arms_version)

			save_data.player_coat_of_arms_version = SaveData.player_coat_of_arms_version
		end

		if SaveData.player_data_version ~= save_data.player_data_version then
			save_data.player_data = nil

			print("Wrong player_data_version for save file, saved: ", save_data.player_data_version, " current: ", SaveData.player_data_version)

			save_data.player_data_version = SaveData.player_data_version
		end

		populate_player_profiles_from_save(save_data)
		populate_player_controls_from_save(save_data)
		populate_player_coat_of_arms_from_save(save_data)
		populate_player_data_from_save(save_data)

		SaveData = save_data
	else
		print("Wrong version for save file, saved: ", save_data.version, " current: ", SaveData.version)
	end
end
