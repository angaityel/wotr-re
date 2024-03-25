-- chunkname: @foundation/scripts/managers/time/time_manager.lua

require("foundation/scripts/managers/time/timer")

TimeManager = class(TimeManager)

function TimeManager:init()
	self._timers = {
		main = Timer:new("main", nil)
	}
	self._dt_stack = {}
	self._dt_stack_max_size = 10
	self._dt_stack_index = 0
	self._mean_dt = 0
end

function TimeManager:register_timer(name, parent_name, start_time)
	local timers = self._timers

	fassert(timers[name] == nil, "[TimeManager] Tried to add already registered timer %q", name)
	fassert(timers[parent_name], "[TimeManager] Not allowed to add timer with unregistered parent %q", parent_name)

	local parent_timer = timers[parent_name]
	local new_timer = Timer:new(name, parent_timer, start_time)

	parent_timer:add_child(new_timer)

	timers[name] = new_timer
end

function TimeManager:unregister_timer(name)
	local timer = self._timers[name]

	fassert(timer, "[TimeManager] Tried to remove unregistered timer %q", name)
	fassert(table.size(timer:children()) == 0, "[TimeManager] Not allowed to remove timer %q with children", name)

	local parent = timer:parent()

	if parent then
		parent:remove_child(timer)
	end

	timer:destroy()

	self._timers[name] = nil
end

function TimeManager:has_timer(name)
	return self._timers[name] and true or false
end

function TimeManager:update(dt)
	local main_timer = self._timers.main

	if main_timer:active() then
		main_timer:update(dt, 1)
	end

	self:_update_mean_dt(dt)
end

function TimeManager:_update_mean_dt(dt)
	local dt_stack = self._dt_stack

	self._dt_stack_index = self._dt_stack_index % self._dt_stack_max_size + 1
	dt_stack[self._dt_stack_index] = dt

	local dt_sum = 0

	for i, dt in ipairs(dt_stack) do
		dt_sum = dt_sum + dt
	end

	self._mean_dt = dt_sum / #dt_stack
end

function TimeManager:mean_dt()
	return self._mean_dt
end

function TimeManager:set_time(name, time)
	self._timers[name]:set_time(time)
end

function TimeManager:time(name)
	if self._timers[name] then
		return self._timers[name]:time()
	end
end

function TimeManager:active(name)
	return self._timers[name]:active()
end

function TimeManager:set_active(name, active)
	self._timers[name]:set_active(active)
end

function TimeManager:set_local_scale(name, scale)
	fassert(name ~= "main", "[TimeManager] Not allowed to set scale in main timer")
	self._timers[name]:set_local_scale(scale)
end

function TimeManager:local_scale(name)
	return self._timers[name]:local_scale()
end

function TimeManager:global_scale(name)
	return self._timers[name]:global_scale()
end

function TimeManager:destroy()
	for name, timer in pairs(self._timers) do
		timer:destroy()
	end

	self._timers = nil
end
