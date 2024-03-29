﻿-- chunkname: @scripts/managers/camera/cameras/rotation_camera.lua

require("scripts/managers/camera/cameras/base_camera")

RotationCamera = class(RotationCamera, BaseCamera)

function RotationCamera:init(...)
	RotationCamera.super.init(self, ...)

	self._offset_pitch = 0
	self._offset_yaw = 0
end

local INV_180 = 0.005555555555555556

function RotationCamera:parse_parameters(camera_settings, parent_node)
	BaseCamera.parse_parameters(self, camera_settings, parent_node)

	if camera_settings.offset_pitch then
		self._offset_pitch = math.pi * camera_settings.offset_pitch * INV_180
	end

	if camera_settings.offset_yaw then
		self._offset_yaw = math.pi * camera_settings.offset_yaw * INV_180
	end
end

function RotationCamera:update(dt, position, rotation, data)
	local offset_yaw_rot = Quaternion(Vector3.up(), self._offset_yaw)
	local offset_pitch_rot = Quaternion(Vector3.right(), self._offset_pitch)
	local new_rot = Quaternion.multiply(Quaternion.multiply(rotation, offset_pitch_rot), offset_yaw_rot)

	BaseCamera.update(self, dt, position, new_rot, data)
end
