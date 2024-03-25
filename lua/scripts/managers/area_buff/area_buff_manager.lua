-- chunkname: @scripts/managers/area_buff/area_buff_manager.lua

AreaBuffManager = class(AreaBuffManager)

function AreaBuffManager:init(world)
	self._world = world
	self._buff_sources = {}
	self._eligible_targets = {}
end

function AreaBuffManager:update(dt, t)
	local eligible_targets = self._eligible_targets
	local buff_sources = self._buff_sources
	local round_t = Managers.time:time("round")

	for source_name, source in pairs(buff_sources) do
		source.level = source.end_time > round_t + AreaBuffSettings.FADE_TIME and source.level_calculation_function(source_name) or source.fade_level
		source.fade_level = source.level

		local current_eligible_targets = source.eligible_targets
		local new_eligible_targets = source.eligible_targets_function()
		local buff_type = source.buff_type

		for _, unit in ipairs(new_eligible_targets) do
			eligible_targets[unit] = eligible_targets[unit] or {}
			eligible_targets[unit][buff_type] = eligible_targets[unit][buff_type] or {}

			if not eligible_targets[unit][buff_type][source_name] then
				eligible_targets[unit][buff_type][source_name] = 0
			end

			current_eligible_targets[unit] = true
		end

		for eligible_target, _ in pairs(current_eligible_targets) do
			local exists_in_eligible_targets = false

			for _, unit in ipairs(new_eligible_targets) do
				if unit == eligible_target then
					exists_in_eligible_targets = true
				end
			end

			if not exists_in_eligible_targets then
				current_eligible_targets[eligible_target] = nil

				if eligible_target == source.owning_unit then
					self:_remove_source(source_name)

					break
				else
					self:_clear_eligible_target(eligible_target, buff_type, source_name)
				end
			end
		end

		if round_t >= source.end_time then
			self:_remove_source(source_name)
		end
	end

	for eligible_target, buffs in pairs(eligible_targets) do
		local area_buff_ext = ScriptUnit.extension(eligible_target, "area_buff_system")

		for buff_type, sources in pairs(buffs) do
			local best_level, best_end_time = 0, 0

			for source_name, end_time in pairs(sources) do
				local area_buff = buff_sources[source_name]
				local directly_affected_targets = buff_sources[source_name].directly_affected_targets

				if AreaBuffHelper:unit_in_buff_area(eligible_target, area_buff.owning_unit, area_buff.shape, area_buff.radius) and (not (area_buff.end_time < round_t + AreaBuffSettings.FADE_TIME) or not not directly_affected_targets[eligible_target]) then
					sources[source_name] = area_buff.end_time
					directly_affected_targets[eligible_target] = true
				else
					sources[source_name] = math.min(end_time, round_t + AreaBuffSettings.FADE_TIME)
					directly_affected_targets[eligible_target] = nil
				end

				if round_t < sources[source_name] then
					if best_level < area_buff.level then
						best_level = area_buff.level
						best_end_time = sources[source_name]
					elseif area_buff.level == best_level and best_end_time < sources[source_name] then
						best_level = area_buff.level
						best_end_time = sources[source_name]
					end
				end
			end

			area_buff_ext:set_end_time(buff_type, best_end_time)
			area_buff_ext:set_buff_level(buff_type, best_level)
		end
	end
end

function AreaBuffManager:_remove_source(source_name)
	local eligible_targets = self._eligible_targets
	local buff_sources = self._buff_sources

	for eligible_target, buffs in pairs(eligible_targets) do
		for buff_type, sources in pairs(buffs) do
			self:_clear_eligible_target(eligible_target, buff_type, source_name)
		end
	end

	buff_sources[source_name] = nil
end

function AreaBuffManager:create_area_buff(unit, buff_type, level_calculation_function, eligible_targets_function, duration, shape, radius, source_name)
	local buff_sources = self._buff_sources

	buff_sources[source_name] = buff_sources[source_name] or {}
	buff_sources[source_name].owning_unit = unit
	buff_sources[source_name].level_calculation_function = level_calculation_function
	buff_sources[source_name].level = 0
	buff_sources[source_name].fade_level = 0
	buff_sources[source_name].eligible_targets_function = eligible_targets_function
	buff_sources[source_name].eligible_targets = {}
	buff_sources[source_name].directly_affected_targets = {}
	buff_sources[source_name].buff_type = buff_type
	buff_sources[source_name].end_time = duration + Managers.time:time("round") + AreaBuffSettings.FADE_TIME
	buff_sources[source_name].shape = shape
	buff_sources[source_name].radius = radius
end

function AreaBuffManager:affected_targets(source_name)
	return self._buff_sources[source_name].directly_affected_targets
end

function AreaBuffManager:_clear_eligible_target(eligible_target, buff_type, source_name)
	local eligible_targets = self._eligible_targets
	local t1 = self._buff_sources[source_name]

	if t1 == nil then
		print("--- [QF] AREA BUFF CRASH ---------------------")
		print("Level 1")
		print("Source name: ", source_name)
		table.dump(self._buff_sources, "Buff sources", 4)
		print("----------------------------------------------")

		return
	end

	local t2 = t1.directly_affected_targets

	if t2 == nil then
		print("--- [QF] AREA BUFF CRASH ---------------------")
		print("Level 2")
		print("Source name: ", source_name)
		table.dump(self._buff_sources, "Buff sources", 4)
		print("----------------------------------------------")

		return
	end

	self._buff_sources[source_name].directly_affected_targets[eligible_target] = nil
	eligible_targets[eligible_target][buff_type][source_name] = nil

	if table.size(eligible_targets[eligible_target][buff_type]) == 0 then
		eligible_targets[eligible_target][buff_type] = nil
	end

	if table.size(eligible_targets[eligible_target]) == 0 then
		eligible_targets[eligible_target] = nil
	end

	if Unit.alive(eligible_target) then
		local area_buff_ext = ScriptUnit.extension(eligible_target, "area_buff_system")

		area_buff_ext:set_end_time(buff_type, 0)
		area_buff_ext:set_buff_level(buff_type, 0)
	end
end

function AreaBuffManager:destroy()
	return
end
