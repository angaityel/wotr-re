-- chunkname: @scripts/settings/dlc_settings.lua

local function app_id_check(app_id)
	if rawget(_G, "Steam") then
		return function()
			return Steam.is_installed(app_id)
		end
	else
		return function()
			return false
		end
	end
end

DLCSettings = {
	house_of_lancaster_armor_set = app_id_check(218841),
	house_of_york_armor_set = app_id_check(218842),
	deluxe_edition = app_id_check(218843),
	brian_blessed = app_id_check(218844),
	full_game = app_id_check(230940),
	coins_50k = app_id_check(242070),
	coins_100k = app_id_check(242090)
}
