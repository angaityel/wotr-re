-- chunkname: @scripts/managers/debug/debug_drawer.lua

DebugDrawer = class(DebugDrawer)

function DebugDrawer:init(line_object, mode)
	self._line_object = line_object
	self._mode = mode
end

function DebugDrawer:reset()
	LineObject.reset(self._line_object)
end

function DebugDrawer:line(from, to, color)
	color = color or Color(255, 255, 255)

	LineObject.add_line(self._line_object, color, from, to)
end

function DebugDrawer:sphere(center, radius, color)
	color = color or Color(255, 255, 255)

	LineObject.add_sphere(self._line_object, color, center, radius)
end

function DebugDrawer:box_sweep(pose, extents, movement_vector, color1, color2)
	color1 = color1 or Color(255, 255, 255)
	color2 = color2 or Color(255, 0, 0)

	local rot = Matrix4x4.rotation(pose)
	local pos = Matrix4x4.translation(pose)
	local box2_pose = Matrix4x4.from_quaternion_position(rot, pos + movement_vector)

	self:box(pose, extents, color1)
	self:box(box2_pose, extents, color1)

	local x_vect = Matrix4x4.right(pose)
	local y_vect = Matrix4x4.forward(pose)
	local z_vect = Matrix4x4.up(pose)
	local x_positive = x_vect * extents.x
	local x_negative = -x_vect * extents.x
	local y_positive = y_vect * extents.y
	local y_negative = -y_vect * extents.y
	local z_positive = z_vect * extents.z
	local z_negative = -z_vect * extents.z
	local box1corner1 = pos + x_positive + y_positive + z_positive
	local box1corner2 = pos + x_negative + y_positive + z_positive
	local box1corner3 = pos + x_negative + y_negative + z_positive
	local box1corner4 = pos + x_positive + y_negative + z_positive
	local box1corner5 = pos + x_positive + y_positive + z_negative
	local box1corner6 = pos + x_negative + y_positive + z_negative
	local box1corner7 = pos + x_negative + y_negative + z_negative
	local box1corner8 = pos + x_positive + y_negative + z_negative

	self:line(box1corner1, box1corner1 + movement_vector, color2)
	self:line(box1corner2, box1corner2 + movement_vector, color2)
	self:line(box1corner3, box1corner3 + movement_vector, color2)
	self:line(box1corner4, box1corner4 + movement_vector, color2)
	self:line(box1corner5, box1corner5 + movement_vector, color2)
	self:line(box1corner6, box1corner6 + movement_vector, color2)
	self:line(box1corner7, box1corner7 + movement_vector, color2)
	self:line(box1corner8, box1corner8 + movement_vector, color2)
end

function DebugDrawer:capsule(from, to, radius, color)
	color = color or Color(255, 255, 255)

	LineObject.add_capsule(self._line_object, color, from, to, radius)
end

function DebugDrawer:actor(actor, color, camera_pose)
	color = color or Color(255, 255, 255)

	Actor.debug_draw(actor, self._line_object, color, camera_pose)
end

function DebugDrawer:box(pose, extents, color)
	color = color or Color(255, 255, 255)

	LineObject.add_box(self._line_object, color, pose, extents)
end

function DebugDrawer:vector(position, vector, color)
	color = color or Color(255, 255, 255)

	local length = Vector3.length(vector)
	local normalized = Vector3.normalize(vector)
	local tip_scale = 0.2
	local tip_length = length * tip_scale
	local tip_width = length * tip_scale / 2
	local tip = position + vector
	local x, y = Vector3.make_axes(normalized)
	local aux = tip - normalized * tip_length

	self:line(position, tip, color)
	self:line(tip, aux - x * tip_width, color)
	self:line(tip, aux + x * tip_width, color)
	self:line(tip, aux - y * tip_width, color)
	self:line(tip, aux + y * tip_width, color)
end

function DebugDrawer:quaternion(position, quaternion, scale)
	scale = scale or 1

	self:vector(position, scale * Quaternion.right(quaternion), Color(255, 0, 0))
	self:vector(position, scale * Quaternion.forward(quaternion), Color(0, 255, 0))
	self:vector(position, scale * Quaternion.up(quaternion), Color(0, 0, 255))
end

function DebugDrawer:matrix4x4(matrix, scale)
	scale = scale or 1

	local position = Matrix4x4.translation(matrix)

	self:sphere(position, scale * 0.25)

	local rotation = Matrix4x4.rotation(matrix)

	self:quaternion(position, rotation, scale)
end

function DebugDrawer:unit(unit, color)
	color = color or Color(255, 255, 255)

	local box_pose, box_extents = Unit.box(unit)

	self:box(box_pose, box_extents, color)

	local position = Unit.world_position(unit, 0)

	position.z = position.z + box_extents.z

	local rotation = Unit.world_rotation(unit, 0)

	self:quaternion(position, rotation)
end

function DebugDrawer:navigation_mesh_search(mesh)
	NavigationMesh.visualize_last_search(mesh, self._line_object)
end

function DebugDrawer:update(world)
	LineObject.dispatch(world, self._line_object)

	if self._mode == "immediate" then
		self:reset()
	end
end
