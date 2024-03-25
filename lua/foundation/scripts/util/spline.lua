-- chunkname: @foundation/scripts/util/spline.lua

Spline = class(Spline)

function Spline:calc_point(t)
	local t2 = t * t
	local t3 = t2 * t
	local two_t3 = t3 + t3
	local two_t2 = t2 + t2
	local three_t2 = two_t2 + t2
	local h1 = two_t3 - three_t2 + 1
	local h2 = three_t2 - two_t3
	local h3 = t3 - two_t2 + t
	local h4 = t3 - t2
	local res = Vector3.from_table(self._P1) * h1

	res = res + Vector3.from_table(self._P2) * h2
	res = res + Vector3.from_table(self._T1) * h3
	res = res + Vector3.from_table(self._T2) * h4

	return res
end

function Spline:calc_tangent(t)
	local t2 = t * t
	local dh1 = 6 * t2 - 6 * t
	local dh2 = 6 * t - 6 * t2
	local dh3 = 3 * t2 - 4 * t + 1
	local dh4 = 3 * t2 - 2 * t
	local res = Vector3.from_table(self._P1) * dh1 + Vector3.from_table(self._P2) * dh2 + Vector3.from_table(self._T1) * dh3 + Vector3.from_table(self._T2) * dh4

	return res
end

function Spline:set_points(points)
	local p1 = Vector3.from_table(points[1])
	local p2 = Vector3.from_table(points[2])
	local p3 = Vector3.from_table(points[3])
	local p4 = Vector3.from_table(points[4])
	local length = Vector3.length(p2 - p3)
	local temp = Vector3.normalize(p3 - p1)

	temp = temp * length
	self._T1 = Vector3.as_table(temp)
	temp = Vector3.normalize(p4 - p2)
	temp = temp * length
	self._T2 = Vector3.as_table(temp)
	self._P1 = table.clone(Vector3.as_table(points[2]))
	self._P2 = table.clone(Vector3.as_table(points[3]))
end

function Spline:draw(drawer, segments)
	segments = segments or 20

	local segment_increment = 1 / segments
	local t = 0
	local point_a = self:calc_point(t)

	while t < 1 do
		t = t + segment_increment

		local point_b = self:calc_point(t)

		drawer:line(point_a, point_b)

		point_a = point_b
	end
end

function Spline:length(segments)
	local length = 0
	local last_point = Vector3.from_table(self._P1)

	for fraction = 1, segments do
		local point = self:calc_point(fraction / segments)

		length = length + Vector3.length(point - last_point)
		last_point = point
	end

	return length
end

function Spline:tangent(t, segment_size)
	segment_size = segment_size or 0.01

	local min_t = math.max(t - segment_size, 0)
	local max_t = math.min(t + segment_size, 1)
	local min_v = self:calc_point(min_t)
	local max_v = self:calc_point(max_t)

	return Vector3.normalize(max_v - min_v)
end

function Spline:set_points_manual_tangents(t1, t2, p1, p2)
	self._T1 = t1 and Vector3.as_table(t1) or self._T1
	self._T2 = t2 and Vector3.as_table(t2) or self._T2
	self._P1 = p1 and Vector3.as_table(p1) or self._P1
	self._P2 = p2 and Vector3.as_table(p2) or self._P2
end

function Spline:set_points_with_rotation_tangents(points, rotation_t1, rotation_t2)
	self._P1 = table.clone(Vector3.as_table(points[1]))
	self._P2 = table.clone(Vector3.as_table(points[2]))

	local length = Vector3.length(Vector3.from_table(points[1]) - Vector3.from_table(points[2]))

	self._T1 = Vector3.as_table(Vector3.from_table(rotation_t1) * length)
	self._T2 = Vector3.as_table(Vector3.from_table(rotation_t2) * length)
end

function Spline:set_points_manual_start_tangent(t1, p2, p3, p4)
	local length = Vector3.length(p2 - p3)

	self._T1 = Vector3.as_table(t1 * length)
	self._T2 = Vector3.as_table(Vector3.normalize(p4 - p2) * length)
	self._P1 = Vector3.as_table(p2)
	self._P2 = Vector3.as_table(p3)
end

function Spline:set_points_manual_end_tangent(p1, p2, p3, t2)
	local length = Vector3.length(p2 - p3)

	self._T1 = Vector3.as_table(Vector3.normalize(p3 - p1) * length)
	self._T2 = Vector3.as_table(t2 * length)
	self._P1 = Vector3.as_table(p2)
	self._P2 = Vector3.as_table(p3)
end

function Spline:debug_print()
	return
end

function Spline:p1()
	return self._P1
end

function Spline:p2()
	return self._P2
end

function Spline:t1()
	return self._T1
end

function Spline:t2()
	return self._T2
end
