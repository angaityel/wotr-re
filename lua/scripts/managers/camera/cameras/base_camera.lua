-- chunkname: @scripts/managers/camera/cameras/base_camera.lua

BaseCamera = class(BaseCamera)

function BaseCamera:init(root_node)
	self._root_node = root_node
	self._children = {}
	self._name = ""
	self._root_unit = nil
	self._root_object = nil
	self._root_position = Vector3Box()
	self._root_rotation = QuaternionBox()
	self._position = nil
	self._rotation = nil
	self._vertical_fov = nil
	self._near_range = nil
	self._far_range = nil
	self._pitch_offset = nil
	self._active = 0
	self._active_children = 0
end

function BaseCamera:parse_parameters(camera_settings, parent_node)
	if camera_settings.name then
		self._name = camera_settings.name
	end

	self._fade_to_black = camera_settings.fade_to_black
	self._vertical_fov = camera_settings.vertical_fov and camera_settings.vertical_fov * math.pi / 180
	self._near_range = camera_settings.near_range or parent_node:near_range()
	self._far_range = camera_settings.far_range or parent_node:far_range()
	self._pitch_min = camera_settings.pitch_min and camera_settings.pitch_min * math.pi / 180 or parent_node:pitch_min()
	self._pitch_max = camera_settings.pitch_max and camera_settings.pitch_max * math.pi / 180 or parent_node:pitch_max()
	self._pitch_speed = camera_settings.pitch_speed and camera_settings.pitch_speed * math.pi / 180 or parent_node:pitch_speed()
	self._yaw_speed = camera_settings.yaw_speed and camera_settings.yaw_speed * math.pi / 180 or parent_node:yaw_speed()
	self._pitch_offset = camera_settings.pitch_offset and camera_settings.pitch_offset * math.pi / 180 or parent_node:pitch_offset()
	self._safe_position_offset = camera_settings.safe_position_offset or parent_node:safe_position_offset()
	self._tree_transitions = camera_settings.tree_transitions or parent_node:tree_transitions()
	self._node_transitions = camera_settings.node_transitions or parent_node:node_transitions()

	if camera_settings.dof_near_blur and camera_settings.dof_near_focus then
		self._environment_params = self._environment_params or {}
		self._environment_params.dof_near_blur = camera_settings.dof_near_blur
		self._environment_params.dof_near_focus = camera_settings.dof_near_focus
	end

	if camera_settings.dof_far_blur and camera_settings.dof_far_focus then
		self._environment_params = self._environment_params or {}
		self._environment_params.dof_far_blur = camera_settings.dof_far_blur
		self._environment_params.dof_far_focus = camera_settings.dof_far_focus
	end

	if camera_settings.dof_amount then
		self._environment_params.dof_amount = camera_settings.dof_amount
	end

	self._yaw_origin = camera_settings.yaw_origin and camera_settings.yaw_origin * math.pi / 180
	self._pitch_origin = camera_settings.pitch_origin and camera_settings.pitch_origin * math.pi / 180
	self._constraint_function = camera_settings.constraint or parent_node:constraint_function()
end

function BaseCamera:constraint_function()
	return self._constraint_function
end

function BaseCamera:node_transitions()
	return self._node_transitions
end

function BaseCamera:tree_transitions()
	return self._tree_transitions
end

function BaseCamera:safe_position_offset()
	return self._safe_position_offset
end

function BaseCamera:pitch_offset()
	return self._pitch_offset
end

function BaseCamera:pitch_speed()
	return self._pitch_speed
end

function BaseCamera:yaw_speed()
	return self._yaw_speed
end

function BaseCamera:pitch_min()
	return self._pitch_min
end

function BaseCamera:pitch_max()
	return self._pitch_max
end

function BaseCamera:name()
	return self._name
end

function BaseCamera:position()
	return self._position
end

function BaseCamera:rotation()
	return self._rotation
end

function BaseCamera:vertical_fov()
	return self._vertical_fov or self._parent_node:vertical_fov()
end

function BaseCamera:fade_to_black()
	return self._fade_to_black or self._parent_node:fade_to_black()
end

function BaseCamera:shading_environment()
	return self._environment_params or self._parent_node and self._parent_node:shading_environment()
end

function BaseCamera:near_range()
	return self._near_range
end

function BaseCamera:far_range()
	return self._far_range
end

function BaseCamera:parent_node()
	return self._parent_node
end

function BaseCamera:root_node()
	return self._root_node
end

function BaseCamera:set_parent_node(parent)
	self._parent_node = parent
end

function BaseCamera:add_child_node(node)
	self._children[#self._children + 1] = node

	node:set_parent_node(self)
end

function BaseCamera:set_active(active)
	local old_active = self:active()

	if active then
		self._active = self._active + 1
	else
		self._active = self._active - 1
	end

	local new_active = self:active()

	if self._parent_node and old_active ~= new_active then
		self._parent_node:set_active_child(new_active)
	end
end

function BaseCamera:active()
	return self._active > 0 or self._active_children > 0
end

function BaseCamera:set_active_child(active)
	local old_active = self:active()

	if active then
		self._active_children = self._active_children + 1
	else
		self._active_children = self._active_children - 1
	end

	local new_active = self:active()

	if self._parent_node and old_active ~= new_active then
		self._parent_node:set_active_child(new_active)
	end
end

function BaseCamera:set_root_unit(unit, object_name)
	self._root_unit = unit
	object_name = object_name or self._object_name
	self._root_object = Unit.node(unit, object_name)

	for _, child in ipairs(self._children) do
		child:set_root_unit(unit, object_name)
	end
end

function BaseCamera:root_unit()
	return self._root_unit, self._object_name
end

function BaseCamera:set_root_position(position)
	self._root_position:store(position)

	for _, child in ipairs(self._children) do
		child:set_root_position(position)
	end
end

function BaseCamera:set_root_rotation(rotation)
	self._root_rotation:store(rotation)

	for _, child in ipairs(self._children) do
		child:set_root_rotation(rotation)
	end
end

function BaseCamera:set_root_vertical_fov(vertical_fov)
	self._vertical_fov = vertical_fov

	for _, child in ipairs(self._children) do
		child:set_root_vertical_fov(vertical_fov)
	end
end

function BaseCamera:update(dt, position, rotation, data)
	self._position = position
	self._rotation = rotation

	if script_data.camera_debug then
		self:_debug_draw()
	end

	for _, child in ipairs(self._children) do
		if child:active() then
			child:update(dt, position, rotation, data)
		end
	end
end

function BaseCamera:destroy()
	for _, child in ipairs(self._children) do
		child:destroy()
	end

	self._children = {}
	self._parent_node = nil
end

function BaseCamera:_debug_draw()
	local parent_pos = self._parent_node and self._parent_node:position()
	local pos = self._position
	local rot = self._rotation
	local drawer = Managers.state.debug:drawer({
		name = "CAMERA_DEBUG_DRAW" .. self:name()
	})

	drawer:reset()

	if parent_pos then
		drawer:vector(parent_pos, pos - parent_pos, Color(70, 255, 255, 255))
	end

	drawer:quaternion(pos, rot)
end
