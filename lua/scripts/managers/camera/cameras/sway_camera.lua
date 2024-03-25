-- chunkname: @scripts/managers/camera/cameras/sway_camera.lua

require("scripts/managers/camera/cameras/base_camera")

SwayCamera = class(SwayCamera, BaseCamera)

function SwayCamera:init(root_node)
	BaseCamera.init(self, root_node)
end

function SwayCamera:parse_parameters(camera_settings, parent_node)
	BaseCamera.parse_parameters(self, camera_settings, parent_node)
end

function SwayCamera:update(dt, position, rotation, data)
	local new_rot = data.final_rotation:unbox()
	local final_rot = Quaternion.multiply(rotation, new_rot)

	BaseCamera.update(self, dt, position, final_rot, data)
end
