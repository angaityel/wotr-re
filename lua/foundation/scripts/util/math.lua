-- chunkname: @foundation/scripts/util/math.lua

function math.degrees_to_radians(degrees)
	return degrees * 0.0174532925
end

function math.radians_to_degrees(radians)
	return radians * 57.2957795
end

function math.sign(x)
	if x > 0 then
		return 1
	elseif x < 0 then
		return -1
	else
		return 0
	end
end

function math.clamp(value, min, max)
	if max < value then
		return max
	elseif value < min then
		return min
	else
		return value
	end
end

function math.lerp(a, b, p)
	return a * (1 - p) + b * p
end

function math.angle_lerp(a, b, p)
	return a + (((b - a) % 360 + 540) % 360 - 180) * p
end

function math.radian_lerp(a, b, p)
	a = math.radians_to_degrees(a)
	b = math.radians_to_degrees(b)

	return math.degrees_to_radians(math.angle_lerp(a, b, p))
end

function math.sirp(a, b, t)
	local p = 0.5 + 0.5 * math.cos((1 + t) * math.pi)

	return math.lerp(a, b, p)
end

function math.auto_lerp(index_1, index_2, val_1, val_2, val)
	local t = (val - index_1) / (index_2 - index_1)

	return math.lerp(val_1, val_2, t)
end

function math.round(value, precision)
	local mul = 10^(precision or 0)

	return math.floor(value * mul + 0.5) / mul
end

function math.smoothstep(value, min, max)
	local x = math.clamp((value - min) / (max - min), 0, 1)

	return x^3 * (x * (x * 6 - 15) + 10)
end

function Math.random_range(min, max)
	return min + Math.random() * (max - min)
end

math.half_pi = math.pi * 0.5
Geometry = Geometry or {}

function Geometry.is_point_inside_triangle(point_on_plane, tri_a, tri_b, tri_c)
	local pa = tri_a - point_on_plane
	local pb = tri_b - point_on_plane
	local pc = tri_c - point_on_plane
	local pab_n = Vector3.cross(pa, pb)
	local pbc_n = Vector3.cross(pb, pc)

	if Vector3.dot(pab_n, pbc_n) < 0 then
		return false
	end

	local pca_n = Vector3.cross(pc, pa)
	local best_normal = Vector3.dot(pab_n, pab_n) > Vector3.dot(pbc_n, pbc_n) and pab_n or pbc_n
	local dot_product = Vector3.dot(best_normal, pca_n)

	if dot_product < 0 then
		return false
	elseif dot_product > 0 then
		return true
	else
		local min_p = Vector3.min(pa, Vector3.min(pb, pc))
		local max_p = Vector3.max(pa, Vector3.max(pb, pc))

		return min_p.x <= 0 and min_p.y <= 0 and min_p.z <= 0 and max_p.x >= 0 and max_p.y >= 0 and max_p.z >= 0
	end
end

Intersect = Intersect or {}

function Intersect.ray_line(ray_from, ray_direction, line_point_a, line_point_b)
	local distance_along_ray, normalized_distance_along_line = Intersect.line_line(ray_from, ray_from + ray_direction, line_point_a, line_point_b)

	if distance_along_ray == nil then
		return nil, nil
	elseif distance_along_ray < 0 then
		return nil, nil
	else
		return distance_along_ray, normalized_distance_along_line
	end
end

function Intersect.line_line(line_a_pt1, line_a_pt2, line_b_pt1, line_b_pt2)
	local line_a_vector = line_a_pt2 - line_a_pt1
	local line_b_vector = line_b_pt2 - line_b_pt1
	local a = Vector3.dot(line_a_vector, line_a_vector)
	local e = Vector3.dot(line_b_vector, line_b_vector)
	local b = Vector3.dot(line_a_vector, line_b_vector)
	local d = a * e - b * b

	if d < 0.001 then
		return nil, nil
	end

	local r = line_a_pt1 - line_b_pt1
	local c = Vector3.dot(line_a_vector, r)
	local f = Vector3.dot(line_b_vector, r)
	local normalized_distance_along_line_a = (b * f - c * e) / d
	local normalized_distance_along_line_b = (a * f - b * c) / d

	return normalized_distance_along_line_a, normalized_distance_along_line_b
end

function Intersect.ray_segment(ray_from, ray_direction, segment_start, segment_end)
	local distance_along_ray, normalized_distance_along_line = Intersect.ray_line(ray_from, ray_direction, segment_start, segment_end)
	local is_line_parallel_to_or_behind_ray = distance_along_ray == nil

	if is_line_parallel_to_or_behind_ray then
		return nil
	end

	local is_intersection_inside_segment = normalized_distance_along_line >= 0 and normalized_distance_along_line <= 1

	if is_intersection_inside_segment then
		return distance_along_ray, normalized_distance_along_line
	else
		return nil, nil
	end
end
