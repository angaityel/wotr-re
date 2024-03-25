-- chunkname: @foundation/scripts/input/input_filters.lua

InputFilterClasses = InputFilterClasses or {}
FilterVirtualAxis = class(FilterVirtualAxis)

function FilterVirtualAxis:init(params, controller)
	self._controller = controller
	self._params = params
	self._scale = params.scale or 1
end

function FilterVirtualAxis:evaluate(source)
	local scale = self._scale
	local x, y, z = 0, 0, 0

	if self._params.pos_z and self._params.neg_z then
		z = scale * (source:get(self._params.pos_z) - source:get(self._params.neg_z))
	end

	if self._params.pos_x and self._params.neg_x then
		x = scale * (source:get(self._params.pos_x) - source:get(self._params.neg_x))
	end

	if self._params.pos_y and self._params.neg_y then
		y = scale * (source:get(self._params.pos_y) - source:get(self._params.neg_y))
	end

	return Vector3(x, y, z)
end

InputFilterClasses.FilterVirtualAxis = FilterVirtualAxis
FilterInvertAxisY = class(FilterInvertAxisY)

function FilterInvertAxisY:init(params, controller)
	self._controller = controller
	self._params = params
	self._scale = params.scale or 1
end

function FilterInvertAxisY:evaluate(source)
	local axis = source:get(self._params.axis)

	return Vector3(axis.x, -axis.y, 0) * self._scale
end

InputFilterClasses.FilterInvertAxisY = FilterInvertAxisY
FilterAxisScale = class(FilterAxisScale)

function FilterAxisScale:init(params, controller)
	self._controller = controller
	self._params = params

	fassert(params.scale, "no scale defined!")

	self._scale = params.scale
end

function FilterAxisScale:evaluate(source)
	local axis = source:get(self._params.axis)

	return Vector3(axis.x, axis.y, 0) * self._scale
end

InputFilterClasses.FilterAxisScale = FilterAxisScale
FilterAxisScaleDt = class(FilterAxisScaleDt)

function FilterAxisScaleDt:init(params, controller)
	self._controller = controller
	self._params = params
	self._scale = params.scale
	self._scale_x = params.scale_x or params.scale
	self._scale_y = params.scale_y or params.scale
end

function FilterAxisScaleDt:evaluate(source)
	return self._update_value
end

function FilterAxisScaleDt:update(source, dt)
	local axis = source:get(self._params.axis)

	self._update_value = Vector3(axis.x * self._scale_x, axis.y * self._scale_y, 0) * dt
end

InputFilterClasses.FilterAxisScaleDt = FilterAxisScaleDt
FilterAxisScaleTimeRampDt = class(FilterAxisScaleTimeRampDt)

function FilterAxisScaleTimeRampDt:init(params, controller)
	self._controller = controller
	self._params = params
	self._scale_x = params.scale_x
	self._scale_y = params.scale_y
	self._ramp_threshold = params.ramp_threshold
	self._time_threshold = params.time_threshold
	self._max_ramp = params.max_ramp
	self._max_time = params.max_time
	self._ramp_time = 0
end

function FilterAxisScaleTimeRampDt:evaluate(source)
	return self._update_value
end

function FilterAxisScaleTimeRampDt:update(source, dt)
	local scale_x = self._scale_x
	local scale_y = self._scale_y
	local axis = source:get(self._params.axis)

	if math.abs(axis.x) > self._ramp_threshold or math.abs(axis.y) > self._ramp_threshold then
		if self._timer then
			self._timer = self._timer - dt

			if self._timer <= 0 then
				self._ramp_time = math.clamp(self._ramp_time + dt, 0, self._max_time)

				local ramping = self._ramp_time / self._max_time * self._max_ramp

				self._update_value = Vector3(axis.x^3 * scale_x, axis.y * scale_y, 0) * dt * (1 + ramping)

				return
			end
		else
			self._timer = self._time_threshold
			self._ramp_time = 0
		end
	else
		self._timer = nil
		self._ramp_time = 0
	end

	self._update_value = Vector3(axis.x * scale_x, axis.y * scale_y, 0) * dt
end

InputFilterClasses.FilterAxisScaleTimeRampDt = FilterAxisScaleTimeRampDt
FilterAxisScaleRampDt = class(FilterAxisScaleRampDt)

local RAISED = 5
local HIGHER_ORDER_THRESHOLD = 0.8
local HIGHER_ORDER_THRESHOLD_HIGH = HIGHER_ORDER_THRESHOLD^RAISED
local HIGHER_ORDER_THRESHOLD_DIVIDED = HIGHER_ORDER_THRESHOLD_HIGH / HIGHER_ORDER_THRESHOLD
local MIN_MOVE = 0.03
local TIME_ACC_START_THRESHOLD = 0.95
local TIME_ACC_START = 0.2
local TIME_ACC_MAX_TIME_FACTOR = 3

function FilterAxisScaleRampDt:init(params, controller)
	self._controller = controller
	self._params = params

	fassert(params.scale_x, "no scale_x defined!")
	fassert(params.scale_y, "no scale_y defined!")

	self._scale_x = params.scale_x
	self._scale_y = params.scale_y
	self._hi_scale_x = params.hi_scale_x
	self._min_move = params.min_move or MIN_MOVE
	self._time_acc_multiplier = params.time_acc_multiplier
end

function FilterAxisScaleRampDt:evaluate(source)
	return self._update_value
end

function FilterAxisScaleRampDt:update(source, dt)
	local axis = source:get(self._params.axis)
	local x, y
	local scale_x = self._scale_x
	local scale_y = self._scale_y

	if self._params.type == "look" then
		scale_x = 1
		self._hi_scale_x = nil
	else
		scale_x = 0.1
		self._hi_scale_x = 0.1
		self._time_acc_multiplier = 1.8
	end

	local x_abs = math.abs(axis.x)

	if x_abs > HIGHER_ORDER_THRESHOLD then
		x = x_abs^RAISED

		if self._hi_scale_x then
			local norm_mult = (x_abs - HIGHER_ORDER_THRESHOLD) / (1 - HIGHER_ORDER_THRESHOLD)

			scale_x = self._scale_x + self._hi_scale_x * norm_mult
		end
	elseif x_abs > MIN_MOVE then
		x = self._min_move + x_abs * HIGHER_ORDER_THRESHOLD_DIVIDED
	else
		x = 0
	end

	if axis.x < 0 then
		x = -x
	end

	local y_abs = math.abs(axis.y)

	if y_abs > HIGHER_ORDER_THRESHOLD then
		y = y_abs^RAISED
	elseif y_abs > 0.01 then
		y = self._min_move + y_abs * HIGHER_ORDER_THRESHOLD_DIVIDED
	else
		y = 0
	end

	if axis.y < 0 then
		y = -y
	end

	if self._time_acc_multiplier then
		local len = Vector3.length(axis)

		if len > TIME_ACC_START_THRESHOLD and not self._acc_timer then
			self._acc_timer = 0
		elseif len > TIME_ACC_START_THRESHOLD then
			self._acc_timer = self._acc_timer + dt

			local multiplier = 1 + self._time_acc_multiplier * math.clamp((self._acc_timer - TIME_ACC_START) * TIME_ACC_MAX_TIME_FACTOR, 0, 1)

			x = x * multiplier
			y = y * multiplier
		else
			self._acc_timer = nil
		end
	end

	self._update_value = Vector3(x * scale_x, y * scale_y, 0) * dt
end

InputFilterClasses.FilterAxisScaleRampDt = FilterAxisScaleRampDt
FilterNumberToBoolean = class(FilterNumberToBoolean)

function FilterNumberToBoolean:init(params, controller)
	self._controller = controller
	self._params = params
end

function FilterNumberToBoolean:evaluate(source)
	if source:get(self._params.number) > 0 then
		return true
	else
		return false
	end
end

InputFilterClasses.FilterNumberToBoolean = FilterNumberToBoolean
FilterAlias = class(FilterAlias)

function FilterAlias:init(params, controller)
	self.alias_name = params.name
end

function FilterAlias:evaluate(source)
	return source:get(self.alias_name)
end

InputFilterClasses.FilterAlias = FilterAlias
FilterAxisNonZero = class(FilterAxisNonZero)

function FilterAxisNonZero:init(params, controller)
	self._params = params
end

function FilterAxisNonZero:evaluate(source)
	local axis = source:get(self._params.axis)

	if axis.x ~= 0 or axis.y ~= 0 then
		return true
	end

	return false
end

InputFilterClasses.FilterAxisNonZero = FilterAxisNonZero
FilterOr = class(FilterOr)

function FilterOr:init(params, controller)
	fassert(next(params), "FilterOr needs at least one input")

	self._controller = controller
	self._params = params
end

function FilterOr:evaluate(source)
	for _, input in pairs(self._params) do
		if source:get(input) then
			return true
		end
	end
end

InputFilterClasses.FilterOr = FilterOr
FilterOrAxis = class(FilterOrAxis)

function FilterOrAxis:init(params, controller)
	fassert(next(params), "FilterOrAxis needs at least one input")

	self._controller = controller
	self._params = params
	self._axis_threshold = 0.01
end

function FilterOrAxis:evaluate(source)
	for _, input in pairs(self._params) do
		local axis = source:get(input)
		local axis_threshold = self._axis_threshold

		if axis_threshold < math.abs(axis.x) or axis_threshold < math.abs(axis.y) or axis_threshold < math.abs(axis.z) then
			return axis
		end
	end

	return Vector3(0, 0, 0)
end

InputFilterClasses.FilterOrAxis = FilterOrAxis
FilterDoubleTap = class(FilterDoubleTap)
InputFilterClasses.FilterDoubleTap = FilterDoubleTap

function FilterDoubleTap:init(params, controller)
	self._since_last_input = math.huge
	self._duration = params.duration
	self._pressed = params.pressed
	self._double_tap = false
end

function FilterDoubleTap:update(source, dt)
	self._double_tap = false

	local tap = source:get(self._pressed)

	if tap and self._since_last_input < self._duration then
		self._double_tap = true
		self._since_last_input = math.huge
	elseif tap and self._since_last_input then
		self._since_last_input = 0
	else
		self._since_last_input = self._since_last_input + dt
	end
end

function FilterDoubleTap:evaluate()
	return self._double_tap
end

FilterControllerMenuMovement = class(FilterControllerMenuMovement)

function FilterControllerMenuMovement:init(params, controller)
	fassert(next(params), "FilterControllerMenuMovement needs at least one input")

	self._controller = controller
	self._params = params
	self._input_timer = 0.5
end

function FilterControllerMenuMovement:evaluate(source)
	for _, input in pairs(self._params) do
		if self._input_timer <= 0 and source:get(input) > 0 then
			self._input_timer = 0.2

			return true
		elseif source:get(input) == 0 then
			self._input_timer = 0
		end
	end
end

function FilterControllerMenuMovement:update(source, dt)
	self._input_timer = self._input_timer - dt
end

InputFilterClasses.FilterControllerMenuMovement = FilterControllerMenuMovement
FilterCursorCompensator = class(FilterCursorCompensator)

function FilterCursorCompensator:init(params, controller)
	fassert(next(params), "FilterCursorCompensator needs at least one input")

	self._controller = controller
	self._params = params
end

function FilterCursorCompensator:evaluate(source)
	for _, input in pairs(self._params) do
		if GameSettingsDevelopment.cursor_fix then
			local w, h = Gui.resolution()
			local screen_res = Application.user_setting("screen_resolution")
			local saved_x, saved_y

			if screen_res then
				saved_x = screen_res[1]
				saved_y = screen_res[2]
			else
				saved_x = 0
				saved_y = 0
			end

			if w ~= saved_x or h ~= saved_y then
				Application.set_user_setting("screen_resolution", {
					w,
					h
				})
				Application.save_user_settings()
				Application.apply_user_settings()
			end
		end

		return source:get(input)
	end
end

InputFilterClasses.FilterCursorCompensator = FilterCursorCompensator
