-- chunkname: @scripts/managers/stats/stats_collection.lua

StatsCollection = class(StatsCollection)
StatsCollection.CALLBACK_CONDITIONS = {
	["="] = function(value, comp_value)
		return value == comp_value
	end,
	["~="] = function(value, comp_value)
		return value ~= comp_value
	end,
	["<"] = function(value, comp_value)
		return value < comp_value
	end,
	["<="] = function(value, comp_value)
		return value <= comp_value
	end,
	[">"] = function(value, comp_value)
		return comp_value < value
	end,
	[">="] = function(value, comp_value)
		return comp_value <= value
	end
}

function StatsCollection:init(stats)
	if stats then
		for context_name, context in pairs(stats) do
			for state_name, stat_props in pairs(context) do
				if stat_props.callbacks then
					table.clear(stat_props.callbacks)
				end
			end
		end

		self._stats = stats
	else
		self._stats = {}
	end
end

function StatsCollection:create_context(context, stats)
	fassert(self._stats[context] == nil, "Context %q already exists", context)

	self._stats[context] = {}

	local derived_stats = {}

	for stat_name, stat_props in pairs(table.clone(stats)) do
		if stat_props.type == "compound" then
			self._stats[context][stat_name] = stat_props
		elseif stat_props.type == "derived" then
			stat_props.callbacks = {}
			stat_props.dependents = {}
			self._stats[context][stat_name] = stat_props
			derived_stats[stat_name] = stat_props
		else
			stat_props.callbacks = {}
			stat_props.dependents = {}
			stat_props.internal = stat_props.value

			function stat_props.value()
				return stat_props.internal
			end

			self._stats[context][stat_name] = stat_props
		end
	end

	for stat_name, stat in pairs(derived_stats) do
		for _, dependency in pairs(stat.dependencies or {}) do
			fassert(self._stats[context][dependency], "Dependent stat %q not found in context %q for derived stat %q", dependency, context, stat_name)
			table.insert(self._stats[context][dependency].dependents, stat_name)
		end
	end
end

function StatsCollection:remove_context(context)
	fassert(self._stats[context] ~= nil, "Context %q doesn't exist", context)

	self._stats[context] = nil
end

function StatsCollection:has_context(context)
	return self._stats[context] ~= nil
end

function StatsCollection:reload_loading_context()
	return self._stats
end

function StatsCollection:register_callback(context, stat_name, condition, value, callback)
	local stat = self:_verify_context_stat(context, stat_name)
	local callback_info = {
		condition = StatsCollection.CALLBACK_CONDITIONS[condition] or condition,
		condition_value = value,
		callback = callback
	}
	local callback_id = #stat.callbacks + 1

	stat.callbacks[callback_id] = callback_info

	return callback_id
end

function StatsCollection:unregister_callback(context, stat_name, callback_id)
	local stat = self:_verify_context_stat(context, stat_name)

	stat.callbacks[callback_id] = nil
end

function StatsCollection:raw_set(context, stat_name, ...)
	self:_set(false, context, stat_name, ...)
end

function StatsCollection:set(context, stat_name, ...)
	self:_set(true, context, stat_name, ...)
end

function StatsCollection:_set(eval_callbacks, context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	fassert(stat.type ~= "derived", "Can't set derived stat %q in context %q", stat_name, context)

	if stat.type == "compound" then
		fassert(stat.set, "No 'set' function defined for compound stat %q in context %q", stat_name, context)
		stat:set(...)
	else
		fassert(stat.type ~= "derived", "Can't set derived stat %q in context %q", stat_name, context)

		stat.internal = ...

		if eval_callbacks then
			self:_eval_callbacks(context, stat_name)
		end
	end
end

function StatsCollection:get(context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	if stat.type == "compound" then
		return ... == nil and stat or stat:value(...)
	else
		return stat.value(self._stats[context])
	end
end

function StatsCollection:increment(context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	if stat.type == "compound" then
		fassert(stat.increment, "No 'increment' function defined for compound stat %q in context %q", stat_name, context)
		stat:increment(...)
	else
		fassert(stat.type ~= "derived", "Can't increment derived stat %q in context %q", stat_name, context)

		stat.internal = stat.internal + ...

		self:_eval_callbacks(context, stat_name)
	end
end

function StatsCollection:decrement(context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	if stat.type == "compound" then
		fassert(stat.decrement, "No 'decrement' function defined for compound stat %q in context %q", stat_name, context)
		stat:decrement(...)
	else
		fassert(stat.type ~= "derived", "Can't decrement derived stat %q in context %q", stat_name, context)

		stat.internal = stat.internal - ...

		self:_eval_callbacks(context, stat_name)
	end
end

function StatsCollection:min(context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	if stat.type == "compound" then
		fassert(stat.min("No 'min' function defined for compound stat %q in context %q"), stat_name, context)
		stat:min(...)
	else
		fassert(stat.type ~= "derived", "Can't set min value for derived stat %q in context %q", stat_name, context)

		stat.internal = math.min(stat.internal, ...)

		self:_eval_callbacks(context, stat_name)
	end
end

function StatsCollection:max(context, stat_name, ...)
	local stat = self:_verify_context_stat(context, stat_name)

	if stat.type == "compound" then
		fassert(stat.max, "No 'max' function defined for compound stat %q in context %q", stat_name, context)
		stat:max(...)
	else
		fassert(stat.type ~= "derived", "Can't set max value for derived stat %q in context %q", stat_name, context)

		stat.internal = math.max(stat.internal, ...)

		self:_eval_callbacks(context, stat_name)
	end
end

function StatsCollection:_eval_callbacks(context, stat_name)
	local stat = self._stats[context][stat_name]
	local stat_value = self:get(context, stat_name)

	if stat.callbacks then
		for _, callback in pairs(stat.callbacks) do
			if callback.condition(stat_value, callback.condition_value) then
				callback.callback(stat_value)
			end
		end
	end

	if stat.dependents then
		for _, dependent in pairs(stat.dependents) do
			self:_eval_callbacks(context, dependent)
		end
	end
end

function StatsCollection:trigger(context, stat_name, value)
	local stat = self:_verify_context_stat(context, stat_name)

	self:_trigger_callbacks(context, stat_name, value)
end

function StatsCollection:_trigger_callbacks(context, stat_name, value)
	local stat = self._stats[context][stat_name]

	if stat.callbacks then
		for _, callback in pairs(stat.callbacks) do
			if callback.condition(value, callback.condition_value) then
				callback.callback(value)
			end
		end
	end

	if stat.dependents then
		for _, dependent in pairs(stat.dependents) do
			self:_trigger_callbacks(context, dependent, value)
		end
	end
end

function StatsCollection:_verify_context_stat(context, stat_name)
	fassert(self._stats[context], "Context %q doesn't exist", context)

	local stat = self._stats[context][stat_name]

	fassert(stat, "Stat %q doesn't exist in context %q", stat_name, context)

	return stat
end
