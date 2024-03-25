-- chunkname: @scripts/managers/camera/transitions/camera_transition_fov_linear.lua

require("scripts/managers/camera/transitions/camera_transition_base")

CameraTransitionFOVLinear = class(CameraTransitionFOVLinear, CameraTransitionBase)

function CameraTransitionFOVLinear:init(node_1, node_2, duration, speed)
	CameraTransitionBase.init(self, node_1, node_2, duration, speed)
end

function CameraTransitionFOVLinear:update(dt, fov)
	CameraTransitionBase.update(self, dt)

	local node_1_fov = fov
	local node_2_fov = self._node_2:vertical_fov()
	local duration = self._duration
	local speed = self._speed
	local fov_diff = node_2_fov - node_1_fov
	local fov_delta

	if duration then
		fov_delta = fov_diff / duration
	else
		fov_delta = speed
	end

	local fov = node_1_fov + self._time * fov_delta
	local done = node_1_fov < node_2_fov and node_2_fov <= fov or node_2_fov < node_1_fov and fov <= node_2_fov or node_1_fov == node_2_fov

	if done then
		fov = node_2_fov
	end

	return fov, done
end
