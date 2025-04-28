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
	house_of_lancaster_armor_set = function()
		return true
	end,
	house_of_york_armor_set = function()
		return true
	end,
	deluxe_edition = function()
		return true
	end,
	brian_blessed = function()
		return true
	end,
	full_game = function()
		return true
	end,
	coins_50k = function()
		return true
	end,
	coins_100k = function()
		return true
	end
}
