-- chunkname: @scripts/unit_extensions/cutscene_camera/cutscene_camera.lua

CutsceneCamera = class(CutsceneCamera)
CutsceneCamera.SYSTEM = "cutscene_system"

function CutsceneCamera:init(world, unit)
	self._level = LevelHelper:current_level(world)
	self._unit = unit
	self._name = Unit.get_data(unit, "camera_name")
	self._hold_time = tonumber(Unit.get_data(unit, "hold_time"))
	self._transition_time = tonumber(Unit.get_data(unit, "transition_time"))
	self._vertical_fov = math.degrees_to_radians(tonumber(Unit.get_data(unit, "vertical_fov")))
	self._start_event = Unit.get_data(unit, "start_event")
end

function CutsceneCamera:finalize(cameras)
	local next_camera_name = Unit.get_data(self._unit, "next_camera")

	if next_camera_name and next_camera_name ~= "" then
		fassert(cameras[next_camera_name], "Next camera %q doesn't exist", next_camera_name)

		self._next_camera = cameras[next_camera_name]
	end
end

function CutsceneCamera:update(dt, t)
	if t < self._start_time then
		self:_update_transition(0, self)

		return false
	else
		local transition_time = self._end_time - self._start_time

		if transition_time <= 0.001 then
			self:_update_transition(1, self._next_camera and self._next_camera or self)

			return true
		else
			local progress = math.clamp((t - self._start_time) / transition_time, 0, 1)
			local smoothed_progress = (3 - 2 * progress) * progress^2

			self:_update_transition(smoothed_progress, self._next_camera and self._next_camera or self)

			return progress == 1
		end
	end
end

function CutsceneCamera:_update_transition(progress, camera)
	local camera_manager = Managers.state.camera
	local lerped_pose = Matrix4x4.lerp(self:pose(), camera:pose(), progress)

	camera_manager:set_node_tree_root_position("player_1", "cutscene", Matrix4x4.translation(lerped_pose))
	camera_manager:set_node_tree_root_rotation("player_1", "cutscene", Matrix4x4.rotation(lerped_pose))

	local lerped_vertical_fov = math.lerp(self._vertical_fov, camera:vertical_fov(), progress)

	camera_manager:set_node_tree_root_vertical_fov("player_1", "cutscene", lerped_vertical_fov)
	camera_manager:set_camera_node("player_1", "cutscene", "root_node")
end

function CutsceneCamera:next_camera()
	return self._next_camera
end

function CutsceneCamera:activate()
	self._start_time = Managers.time:time("game") + self._hold_time
	self._end_time = self._start_time + (self._next_camera and self._transition_time or 0)

	Level.trigger_event(self._level, self._start_event)
end

function CutsceneCamera:deactivate()
	return
end

function CutsceneCamera:name()
	return self._name
end

function CutsceneCamera:pose()
	return Unit.world_pose(self._unit, 0)
end

function CutsceneCamera:vertical_fov()
	return self._vertical_fov
end

function CutsceneCamera:destroy()
	return
end
