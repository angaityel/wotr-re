-- chunkname: @scripts/managers/camera/cameras/object_link_camera.lua

require("scripts/managers/camera/cameras/base_camera")

ObjectLinkCamera = class(ObjectLinkCamera, BaseCamera)

function ObjectLinkCamera:init(root_node)
	BaseCamera.init(self, root_node)

	self._curve_params = {}
end

function ObjectLinkCamera:parse_parameters(camera_settings, parent_node)
	ObjectLinkCamera.super.parse_parameters(self, camera_settings, parent_node)

	self._object_name = camera_settings.root_object_name
	self._curve_data_parameter_name = camera_settings.animation_curve_parameter_name
end

function ObjectLinkCamera:update(dt, position, rotation, data)
	local new_position, new_rotation
	local root_unit = self._root_unit
	local root_object = Unit.node(root_unit, self._object_name)

	new_position = Unit.world_position(root_unit, root_object)
	new_rotation = Unit.world_rotation(root_unit, root_object)

	local curve_data = data[self._curve_data_parameter_name]

	table.clear(self._curve_params)

	if curve_data then
		self._environment_params = self._environment_params or {}

		table.clear(self._environment_params)

		for _, param in ipairs(curve_data.camera_parameters) do
			local param_value = AnimationCurves.sample(curve_data.resource, self._object_name, param, curve_data.t, curve_data.use_step_sampling)

			self._curve_params[param] = param_value
		end

		for _, param in pairs(curve_data.environment_parameters) do
			self._environment_params[param] = AnimationCurves.sample(curve_data.resource, self._object_name, param, curve_data.t, curve_data.use_step_sampling)
		end
	else
		self._environment_params = nil
	end

	BaseCamera.update(self, dt, new_position, new_rotation, data)
end

function ObjectLinkCamera:near_range()
	local near_clip = self._curve_params.near_clip

	return near_clip or ObjectLinkCamera.super.near_range(self)
end

function ObjectLinkCamera:far_range()
	local far_clip = self._curve_params.far_clip

	return far_clip or ObjectLinkCamera.super.far_range(self)
end

function ObjectLinkCamera:fade_to_black()
	return self._curve_params.fade_to_black or ObjectLinkCamera.super.fade_to_black(self)
end

function ObjectLinkCamera:vertical_fov()
	local yfov = self._curve_params.yfov

	return yfov and yfov * (math.pi / 180) or ObjectLinkCamera.super.vertical_fov(self)
end
