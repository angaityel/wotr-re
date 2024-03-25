-- chunkname: @scripts/managers/camera/transitions/camera_transition_rotation_lerp.lua

require("scripts/managers/camera/transitions/camera_transition_base")

CameraTransitionRotationLerp = class(CameraTransitionRotationLerp, CameraTransitionBase)

function CameraTransitionRotationLerp:init(node_1, node_2, duration, speed, settings)
	CameraTransitionBase.init(self, node_1, node_2, duration, speed, settings)

	self._freeze_node_1 = settings.freeze_start_node

	if self._freeze_node_1 then
		local node_1_rot = node_1:rotation()

		self._node_1_rot_table = QuaternionBox(node_1_rot)
	end
end

function CameraTransitionRotationLerp:update(dt, rotation)
	CameraTransitionBase.update(self, dt)

	local node_1_rot = self._freeze_node_1 and self._node_1_rot_table:unbox() or rotation
	local node_2_rot = self._node_2:rotation()
	local duration = self._duration
	local t = self._time / self._duration
	local done = t >= 1
	local rot = Quaternion.lerp(node_1_rot, node_2_rot, math.min(t, 1))

	return rot, done
end
