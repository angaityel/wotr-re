-- chunkname: @foundation/scripts/util/spline_curve.lua

require("foundation/scripts/util/bezier")
require("foundation/scripts/util/hermite")

SplineCurve = class(SplineCurve)

function SplineCurve:init(points, class_name, movement_class, name, ...)
	self._t = 0
	self._name = name

	local splines = {}
	local spline_class = rawget(_G, class_name)

	self._spline_class = spline_class

	self:_build_splines(splines, points, spline_class)

	self._splines = splines
	self._movement = rawget(_G, movement_class):new(self, splines, spline_class, ...)
end

function SplineCurve:splines()
	return self._splines
end

function SplineCurve:name()
	return self._name
end

function SplineCurve:_build_splines(splines, points, spline_class)
	local index = 1

	while index do
		local spline_points = {
			spline_class.spline_points(points, index)
		}

		for index, point in ipairs(spline_points) do
			spline_points[index] = Vector3Box(point)
		end

		splines[#splines + 1] = {
			points = spline_points
		}
		index = spline_class.next_index(points, index)
	end
end

function unpack_unbox(t, k)
	k = k or 1

	local var = t[k]

	if not var then
		return nil
	end

	return var:unbox(), unpack_unbox(t, k + 1)
end

function SplineCurve:draw(segments_per_spline, drawer, tangent_scale, color)
	local spline_class = self._spline_class

	for _, spline in ipairs(self._splines) do
		local points = spline.points

		spline_class.draw(segments_per_spline, drawer, tangent_scale, color, unpack_unbox(points))
	end
end

function SplineCurve:length(segments_per_spline)
	local spline_class = self._spline_class

	for _, spline in ipairs(self._splines) do
		local points = spline.points

		length = spline_class.length(segments_per_spline, unpack_unbox(points))
	end

	return length
end

function SplineCurve:movement()
	return self._movement
end

function SplineCurve:update(dt)
	self._movement:update(dt)
end

SplineMovementMetered = class(SplineMovementMetered)

function SplineMovementMetered:init(spline_curve, splines, spline_class)
	self._splines = splines
	self._spline_curve = spline_curve
	self._spline_class = spline_class
	self._speed = 0
	self._current_spline_index = 1
	self._t = 0

	self:_set_spline_lengths(splines, spline_class, 10)
end

function SplineMovementMetered:_set_spline_lengths(splines, spline_class, segments_per_spline)
	for index, spline in ipairs(splines) do
		local points = spline.points

		spline.length = spline_class.length(segments_per_spline, unpack_unbox(points))

		fassert(spline.length > 0, "[SplineMovementMetered] Spline %n in curve %s has length 0.", index, self._spline_curve:name())
	end
end

function SplineMovementMetered:draw(script_drawer, radius, color)
	local pos = self:current_position()

	script_drawer:sphere(pos, radius or 1, color)
end

function SplineMovementMetered:current_position()
	return self._spline_class.calc_point(self._t, unpack_unbox(self:_current_spline().points))
end

function SplineMovementMetered:_current_spline()
	return self._splines[self._current_spline_index]
end

function SplineMovementMetered:update(dt)
	Profiler.start("SplineMovementMetered:update(dt)")
	self:move(dt * self._speed)
	Profiler.stop()
end

function SplineMovementMetered:move(delta)
	local current_spline = self:_current_spline()
	local current_spline_length = current_spline.length
	local new_t = self._t + delta / current_spline_length

	if new_t > 1 and self._current_spline_index == #self._splines then
		self._t = 1

		return
	elseif new_t > 1 then
		self._current_spline_index = self._current_spline_index + 1
		self._t = 0

		local remainder = delta - (new_t - 1) * current_spline_length

		return self:move(remainder)
	elseif new_t < 0 and self._current_spline_index == 1 then
		self._t = 0

		return
	elseif new_t < 0 then
		self._current_spline_index = self._current_spline_index - 1
		self._t = 1

		local remainder = delta - new_t * current_spline_length

		return self:move(remainder)
	else
		self._t = new_t

		return
	end
end

SplineMovementHermiteInterpolatedMetered = class(SplineMovementHermiteInterpolatedMetered)

function SplineMovementHermiteInterpolatedMetered:init(spline_curve, splines, spline_class, subdivisions)
	self._splines = splines
	self._spline_curve = spline_curve
	self._spline_class = spline_class
	self._speed = 0
	self._current_spline_index = 1
	self._t = 0
	self._current_subdivision_index = 1

	self:_build_subdivisions(subdivisions, splines, spline_class)
end

function SplineMovementHermiteInterpolatedMetered:_build_subdivisions(subdivisions, splines, spline_class)
	local first_point = spline_class.calc_point(0, unpack_unbox(splines[1].points))
	local points = {}

	points[0] = first_point

	for index, spline in ipairs(splines) do
		for sub_index = 1, subdivisions do
			local point = spline_class.calc_point(sub_index / subdivisions, unpack_unbox(spline.points))

			points[#points + 1] = point
		end
	end

	points[-1] = first_point
	points[#points + 1] = points[#points]

	for index, spline in ipairs(splines) do
		local subs = {}
		local point_index = (index - 1) * subdivisions

		spline.length = 0

		for sub_index = 1, subdivisions do
			local sub = {}
			local p0, p1, p2, p3 = points[point_index - 1], points[point_index], points[point_index + 1], points[point_index + 2]

			sub.points = {
				Vector3Box(p0),
				Vector3Box(p1),
				Vector3Box(p2),
				Vector3Box(p3)
			}

			local vectors, quaternions, matrices = Script.temp_count()

			sub.length = Hermite.length(10, p0, p1, p2, p3)

			Script.set_temp_count(vectors, quaternions, matrices)

			point_index = point_index + 1
			subs[#subs + 1] = sub
			spline.length = spline.length + sub.length
		end

		spline.subdivisions = subs
	end
end

function SplineMovementHermiteInterpolatedMetered:_set_spline_lengths(splines, spline_class, segments_per_spline)
	for index, spline in ipairs(splines) do
		local points = spline.points

		spline.length = spline_class.length(segments_per_spline, unpack_unbox(points))

		fassert(spline.length > 0, "[SplineMovementHermiteInterpolatedMetered] Spline %n in curve %s has length 0.", index, self._spline_curve:name())
	end
end

function SplineMovementHermiteInterpolatedMetered:draw(script_drawer, radius, color)
	local pos = self:current_position()

	script_drawer:sphere(pos, radius or 1, color)
end

function SplineMovementHermiteInterpolatedMetered:draw_subdivisions(script_drawer, color)
	for _, spline in ipairs(self._splines) do
		for _, subdivision in ipairs(spline.subdivisions) do
			Hermite.draw(10, script_drawer, Color(255, 0, 0), nil, unpack_unbox(subdivision.points))
		end
	end
end

function SplineMovementHermiteInterpolatedMetered:current_position()
	local current_subdivision = self:_current_spline_subdivision()

	return Hermite.calc_point(self._t, unpack_unbox(current_subdivision.points))
end

function SplineMovementHermiteInterpolatedMetered:current_tangent_direction()
	local current_subdivision = self:_current_spline_subdivision()

	return Hermite.calc_tangent(self._t, unpack_unbox(current_subdivision.points))
end

function SplineMovementHermiteInterpolatedMetered:_current_spline()
	return self._splines[self._current_spline_index]
end

function SplineMovementHermiteInterpolatedMetered:update(dt)
	local state = self:move(dt * self._speed)

	return state
end

function SplineMovementHermiteInterpolatedMetered:distance(from_index, from_subdiv, from_spline_t, to_index, to_subdiv, to_spline_t)
	local distance = 0
	local splines = self._splines
	local len1, len2, len3, len4, len5

	if to_index < from_index then
		local from_spline = splines[from_index]

		distance = distance - from_spline_t * from_spline.subdivisions[from_subdiv].length

		local from_subdivs = from_spline.subdivisions

		for i = 1, from_subdiv - 1 do
			distance = distance - from_subdivs[i].length
		end

		for i = to_index + 1, from_index - 1 do
			distance = distance - splines[i].length
		end

		local to_spline = splines[to_index]
		local to_subdivs = to_spline.subdivisions

		for i = to_subdiv + 1, #to_subdivs do
			distance = distance - to_subdivs[i].length
		end

		distance = distance - (1 - to_spline_t) * to_subdivs[to_subdiv].length
	elseif from_index < to_index then
		local from_spline = splines[from_index]
		local from_subdivs = from_spline.subdivisions

		distance = distance + (1 - from_spline_t) * from_subdivs[from_subdiv].length

		for i = from_subdiv + 1, #from_subdivs do
			distance = distance + from_subdivs[i].length
		end

		for i = from_index + 1, to_index - 1 do
			distance = distance + splines[i].length
		end

		local to_spline = splines[to_index]
		local to_subdivs = to_spline.subdivisions

		for i = 1, to_subdiv - 1 do
			distance = distance + to_subdivs[i].length
		end

		distance = distance + to_spline_t * to_subdivs[to_subdiv].length
	elseif from_index == to_index and from_subdiv < to_subdiv then
		local subdivs = splines[from_index].subdivisions

		distance = distance + (1 - from_spline_t) * subdivs[from_subdiv].length

		for i = from_subdiv + 1, to_subdiv - 1 do
			distance = distance + subdivs[i].length
		end

		distance = distance + to_spline_t * subdivs[to_subdiv].length
	elseif from_index == to_index and to_subdiv < from_subdiv then
		local subdivs = splines[from_index].subdivisions

		distance = distance - from_spline_t * subdivs[from_subdiv].length

		for i = to_subdiv + 1, from_subdiv - 1 do
			distance = distance - subdivs[i].length
		end

		distance = distance - (1 - to_spline_t) * subdivs[to_subdiv].length
	else
		distance = (to_spline_t - from_spline_t) * splines[from_index].subdivisions[from_subdiv].length
	end

	return distance
end

function SplineMovementHermiteInterpolatedMetered:set_speed(speed)
	self._speed = speed
end

function SplineMovementHermiteInterpolatedMetered:speed()
	return self._speed
end

function SplineMovementHermiteInterpolatedMetered:_current_spline_subdivision()
	return self:_current_spline().subdivisions[self._current_subdivision_index]
end

function SplineMovementHermiteInterpolatedMetered:move(delta)
	local current_spline = self:_current_spline()
	local current_subdivision = self:_current_spline_subdivision()
	local current_subdivision_length = current_subdivision.length
	local new_t = self._t + delta / current_subdivision_length

	if new_t > 1 and self._current_spline_index == #self._splines and self._current_subdivision_index == #current_spline.subdivisions then
		self._t = 1

		return "end"
	elseif new_t > 1 then
		self._current_subdivision_index = self._current_subdivision_index + 1

		if self._current_subdivision_index > #current_spline.subdivisions then
			self._current_subdivision_index = 1
			self._current_spline_index = self._current_spline_index + 1
		end

		self._t = 0

		local remainder = delta - (new_t - 1) * current_subdivision_length

		return self:move(remainder)
	elseif new_t < 0 and self._current_spline_index == 1 and self._current_subdivision_index == 1 then
		self._t = 0

		return "start"
	elseif new_t < 0 then
		self._current_subdivision_index = self._current_subdivision_index - 1

		if self._current_subdivision_index == 0 then
			self._current_spline_index = self._current_spline_index - 1
			self._current_subdivision_index = #self:_current_spline().subdivisions
		end

		self._t = 1

		local remainder = delta - new_t * current_subdivision_length

		return self:move(remainder)
	else
		self._t = new_t

		return "moving"
	end
end

function SplineMovementHermiteInterpolatedMetered:set_spline_index(spline_index, subdivision_index, t)
	self._current_spline_index = spline_index
	self._current_subdivision_index = subdivision_index
	self._t = t
end

function SplineMovementHermiteInterpolatedMetered:current_spline_index()
	return self._current_spline_index
end

function SplineMovementHermiteInterpolatedMetered:current_subdivision_index()
	return self._current_subdivision_index
end

function SplineMovementHermiteInterpolatedMetered:current_t()
	return self._t
end
