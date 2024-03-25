-- chunkname: @scripts/unit_extensions/objectives/payload_base.lua

require("scripts/settings/payload_speed_settings")

PayloadBase = class(PayloadBase)

function PayloadBase:_init_movement_spline(world, unit)
	local spline_name = Unit.get_data(unit, "spline", "name")
	local spline_interval_indices = Unit.get_data(unit, "spline", "interval_indices")
	local spline_interval_configs = Unit.get_data(unit, "spline", "interval_configs")
	local level = LevelHelper:current_level(world)
	local spline_points = Level.spline(level, spline_name)
	local spline_curve = SplineCurve:new(spline_points, "Bezier", "SplineMovementHermiteInterpolatedMetered", spline_name, 10)

	self._spline_curve = spline_curve

	local splines = spline_curve:splines()

	self:_parse_settings(splines, spline_interval_indices, spline_interval_configs)
end

function PayloadBase:objective(side)
	if side == "attackers" then
		return "defend_cart", 1
	elseif side == "defenders" then
		return "attack_cart", 2
	else
		return ""
	end
end

function PayloadBase:_parse_next_config(configs, last_string_index)
	local start_index, end_index = string.find(configs, ":", last_string_index)

	if not start_index then
		return string.sub(configs, last_string_index)
	end

	local config_name = string.sub(configs, last_string_index, start_index - 1)
	local next_string_index = end_index + 1

	return config_name, next_string_index
end

function PayloadBase:level_index()
	return GameSession.game_object_field(self._game, self._id, "level_unit_index")
end

function PayloadBase:_parse_next_index(indices, last_string_index)
	local start_index, end_index = string.find(indices, ":", last_string_index)

	if not start_index then
		return tonumber(string.sub(indices, last_string_index))
	end

	local spline_index = string.sub(indices, last_string_index, start_index - 1)
	local next_string_index = end_index + 1

	return tonumber(spline_index), next_string_index
end

function PayloadBase:_parse_settings(splines, spline_interval_indices, spline_interval_configs)
	local current_config, next_config_index = self:_parse_next_config(spline_interval_configs, 1)
	local next_spline_start_index, next_spline_start_index_index = self:_parse_next_index(spline_interval_indices, 1)

	for index, spline in ipairs(splines) do
		if next_spline_start_index and next_spline_start_index <= index then
			current_config, next_config_index = self:_parse_next_config(spline_interval_configs, next_config_index)

			if next_spline_start_index_index then
				next_spline_start_index, next_spline_start_index_index = self:_parse_next_index(spline_interval_indices, next_spline_start_index_index)
			else
				next_spline_start_index = nil
			end
		end

		local speed_settings = PayloadSpeedSettings[current_config]

		fassert(speed_settings, "[PayloadBase] \"PayloadSpeedSettings.%s\" does not exist i lua config!", current_config)

		local metadata = {
			speed_settings = speed_settings
		}

		spline.metadata = metadata
	end
end
