-- chunkname: @foundation/scripts/managers/free_flight/free_flight_manager.lua

require("foundation/scripts/managers/free_flight/free_flight_controller_settings")
require("foundation/scripts/managers/free_flight/control_points")

FreeFlightManager = class(FreeFlightManager)

function FreeFlightManager:init()
	self.free_flight_button_index = Keyboard.button_index("f9")
	self.projection_mode = Keyboard.button_index("f7")
	self.frustum_freeze_toggle = Keyboard.button_index("left shift")
	self.speed_change_axis = Mouse.axis_index("wheel")
	self.look_axis = Mouse.axis_index("mouse")
	self.move_forward_index = Keyboard.button_index("w")
	self.move_back_index = Keyboard.button_index("s")
	self.move_left_index = Keyboard.button_index("a")
	self.move_right_index = Keyboard.button_index("d")
	self.move_up_index = Keyboard.button_index("e")
	self.move_down_index = Keyboard.button_index("q")
	self.mark_index = Keyboard.button_index("m")
	self.toggle_control_points = Keyboard.button_index("t")
	self.step_frame = Keyboard.button_index("up")
	self.play_pause = Keyboard.button_index("down")
	self.decrease_frame_step = Keyboard.button_index("left")
	self.increase_frame_step = Keyboard.button_index("right")
	self.free_flight_button_alias = "enter_free_flight"
	self.current_control_point = 1
	self._has_landscape = not not rawget(_G, "LandscapeDecoration")
	self.data = {}

	self:_setup_data(self.data)

	self._frames_to_step = 1
end

function FreeFlightManager:update(dt)
	self:_update_global(dt)

	for player_index = 1, Managers.player.MAX_PLAYERS do
		if Managers.player:player_exists(player_index) then
			local player = Managers.player:player(player_index)

			self:_update_player(dt, player, self.data[player_index])
		elseif self.data[player_index].active then
			self:_clear_free_flight(dt, self.data[player_index])
		end
	end
end

function FreeFlightManager:set_freeflight(set, player_index)
	local data = self.data[player_index]

	if player_index == "global" then
		if set then
			self:_enter_global_free_flight(data)
		else
			self:_exit_global_free_flight(data)
		end
	else
		local player = Managers.player:player(player_index)

		if set then
			self:_enter_free_flight(player, data)
		else
			self:_exit_free_flight(player, data)
		end
	end
end

function FreeFlightManager:_update_global(dt)
	local data = self.data.global
	local frustum_freeze_toggle = Keyboard.button(self.frustum_freeze_toggle) > 0.5
	local button_pressed = Keyboard.pressed(self.free_flight_button_index)

	if data.active and not Managers.world:has_world(data.viewport_world_name) then
		self:_clear_global_free_flight(data)
	elseif data.active and button_pressed and frustum_freeze_toggle then
		local world = Managers.world:world(data.viewport_world_name)

		self:_toggle_frustum_freeze(dt, data, world, ScriptWorld.global_free_flight_viewport(world), true)
	elseif data.active and button_pressed then
		self:_exit_global_free_flight(data)
	elseif button_pressed then
		self:_enter_global_free_flight(data)
	elseif data.active then
		self:_update_global_free_flight(dt, data)
	end
end

function FreeFlightManager:_exit_frustum_freeze(data, world, viewport, destroy_camera)
	World.set_frustum_inspector_camera(world, nil)

	local camera = data.frustum_freeze_camera
	local camera_unit = Camera.get_data(camera, "unit")

	if destroy_camera then
		World.destroy_unit(world, camera_unit)
	end

	data.frustum_freeze_camera = nil
end

function FreeFlightManager:_enter_frustum_freeze(data, world, viewport, create_new_camera)
	local camera
	local cam = ScriptViewport.camera(viewport)

	if create_new_camera then
		local camera_unit = World.spawn_unit(world, "core/units/camera")

		camera = Unit.camera(camera_unit, "camera")

		Camera.set_data(camera, "unit", camera_unit)

		local pose = Camera.local_pose(cam)

		Camera.set_local_pose(camera, camera_unit, pose)
	else
		camera = cam
	end

	data.frustum_freeze_camera = camera

	World.set_frustum_inspector_camera(world, camera)
end

function FreeFlightManager:_toggle_frustum_freeze(dt, data, world, viewport, global)
	if data.frustum_freeze_camera then
		self:_exit_frustum_freeze(data, world, viewport, global)
	else
		self:_enter_frustum_freeze(data, world, viewport, global)
	end
end

function FreeFlightManager:camera_pose(data)
	local world = Managers.world:world(data.viewport_world_name)
	local viewport = ScriptWorld.global_free_flight_viewport(world)
	local cam = data.frustum_freeze_camera or ScriptViewport.camera(viewport)
	local cm = Camera.local_pose(cam)

	return cm
end

function FreeFlightManager:set_pause_on_enter_freeflight(set)
	self._pause_on_enter_freeflight = set
end

function FreeFlightManager:paused()
	return self._paused
end

function FreeFlightManager:_pause_game(set)
	self._paused = set

	local data = Managers.free_flight.data.global
	local world = Managers.world:world(data.viewport_world_name)

	if set then
		ScriptWorld.pause(world)
	else
		ScriptWorld.unpause(world)
	end
end

function FreeFlightManager:_update_global_free_flight(dt, data)
	local world = Managers.world:world(data.viewport_world_name)
	local viewport = ScriptWorld.global_free_flight_viewport(world)
	local cam = data.frustum_freeze_camera or ScriptViewport.camera(viewport)
	local projection_mode_swap = Keyboard.pressed(self.projection_mode)

	if projection_mode_swap and data.projection_type == Camera.PERSPECTIVE then
		data.projection_type = Camera.ORTHOGRAPHIC
	elseif projection_mode_swap and data.projection_type == Camera.ORTHOGRAPHIC then
		data.projection_type = Camera.PERSPECTIVE
	end

	Camera.set_projection_type(cam, data.projection_type)

	local translation_change_speed = data.translation_speed * 0.1
	local speed_change = Vector3.y(Mouse.axis(self.speed_change_axis))

	data.translation_speed = data.translation_speed + speed_change * translation_change_speed

	if data.translation_speed < 0.001 then
		data.translation_speed = 0.001
	end

	local cm = Camera.local_pose(cam)
	local trans = Matrix4x4.translation(cm)
	local mouse = Mouse.axis(self.look_axis)

	if data.projection_type == Camera.ORTHOGRAPHIC then
		local ortho_data = data.orthographic_data

		ortho_data.yaw = (ortho_data.yaw or 0) - Vector3.x(mouse) * data.rotation_speed

		local q1 = Quaternion(Vector3(0, 0, 1), ortho_data.yaw)
		local q2 = Quaternion(Vector3.right(), -math.half_pi)
		local q = Quaternion.multiply(q1, q2)
		local x_trans = (Keyboard.button(self.move_right_index) - Keyboard.button(self.move_left_index)) * dt * 250
		local y_trans = (Keyboard.button(self.move_forward_index) - Keyboard.button(self.move_back_index)) * dt * 250
		local pos = trans + Quaternion.up(q) * y_trans + Quaternion.right(q) * x_trans

		cm = Matrix4x4.from_quaternion_position(q, pos)

		local size = ortho_data.size

		size = size - speed_change * (size * dt)
		ortho_data.size = size

		Camera.set_orthographic_view(cam, -size, size, -size, size)
	else
		Matrix4x4.set_translation(cm, Vector3(0, 0, 0))

		local q1 = Quaternion(Vector3(0, 0, 1), -Vector3.x(mouse) * data.rotation_speed)
		local q2 = Quaternion(Matrix4x4.x(cm), -Vector3.y(mouse) * data.rotation_speed)
		local q = Quaternion.multiply(q1, q2)

		cm = Matrix4x4.multiply(cm, Matrix4x4.from_quaternion(q))

		local x_trans = Keyboard.button(self.move_right_index) - Keyboard.button(self.move_left_index)
		local y_trans = Keyboard.button(self.move_forward_index) - Keyboard.button(self.move_back_index)
		local z_trans = Keyboard.button(self.move_up_index) - Keyboard.button(self.move_down_index)
		local offset = Matrix4x4.transform(cm, Vector3(x_trans, y_trans, z_trans) * data.translation_speed)

		trans = Vector3.add(trans, offset)

		Matrix4x4.set_translation(cm, trans)
	end

	if self._frames_until_pause then
		self._frames_until_pause = self._frames_until_pause - 1

		if self._frames_until_pause <= 0 then
			self._frames_until_pause = nil

			self:_pause_game(true)
		end
	elseif Keyboard.pressed(self.step_frame) then
		self:_pause_game(false)

		self._frames_until_pause = self._frames_to_step
	end

	if Keyboard.pressed(self.play_pause) then
		self:_pause_game(not self._paused)
	end

	if Keyboard.pressed(self.decrease_frame_step) then
		self._frames_to_step = self._frames_to_step > 1 and self._frames_to_step - 1 or 1

		print("Frame step:", self._frames_to_step)
	elseif Keyboard.pressed(self.increase_frame_step) then
		self._frames_to_step = self._frames_to_step + 1

		print("Frame step:", self._frames_to_step)
	end

	local rot = Matrix4x4.rotation(cm)
	local timpani_world = World.timpani_world(world)

	TimpaniWorld.set_listener(timpani_world, 0, cm)

	if self._has_landscape then
		LandscapeDecoration.move_observer(world, data.landscape_decoration_observer, trans)
	end

	ScatterSystem.move_observer(World.scatter_system(world), data.scatter_system_observer, trans, rot)

	if Keyboard.pressed(self.mark_index) then
		print("Camera at: " .. tostring(cm))
	end

	if Keyboard.pressed(self.toggle_control_points) then
		cm = FreeFlightControlPoints[self.current_control_point]:unbox()
		self.current_control_point = self.current_control_point % #FreeFlightControlPoints + 1

		print("Control Point: " .. tostring(self.current_control_point))
	end

	ScriptCamera.set_local_pose(cam, cm)
end

function FreeFlightManager:_enter_global_free_flight(data)
	local world = Application.main_world()

	if not world then
		return
	end

	local viewport = ScriptWorld.create_global_free_flight_viewport(world, "default")

	if not viewport then
		return
	end

	data.active = true
	data.viewport_world_name = ScriptWorld.name(world)

	local cam = ScriptViewport.camera(viewport)
	local tm = Camera.local_pose(cam)
	local position = Matrix4x4.translation(tm)
	local rotation = Matrix4x4.rotation(tm)

	if self._has_landscape then
		data.landscape_decoration_observer = LandscapeDecoration.create_observer(world, position)
	end

	data.scatter_system_observer = ScatterSystem.make_observer(World.scatter_system(world), position, rotation)

	if self._pause_on_enter_freeflight then
		self:_pause_game(true)
	end
end

function FreeFlightManager:_exit_global_free_flight(data)
	local world = Managers.world:world(data.viewport_world_name)

	if data.frustum_freeze_camera then
		self:_exit_frustum_freeze(data, world, ScriptWorld.global_free_flight_viewport(world), true)
	end

	local world_name = data.viewport_world_name

	if self._has_landscape then
		LandscapeDecoration.destroy_observer(world, data.landscape_decoration_observer)
	end

	ScatterSystem.destroy_observer(World.scatter_system(world), data.scatter_system_observer)

	if self._paused then
		self:_pause_game(false)
	end

	data.active = false
	data.viewport_world_name = nil

	ScriptWorld.destroy_global_free_flight_viewport(Managers.world:world(world_name))
end

function FreeFlightManager:_clear_global_free_flight(data)
	data.active = false
	data.viewport_world_name = nil
end

function FreeFlightManager:_update_player(dt, player, data)
	local frustum_freeze_toggle = Keyboard.button(self.frustum_freeze_toggle) > 0.5
	local input_source = player.input_source
	local free_flight_alias = self.free_flight_button_alias
	local free_flight_pressed = input_source and input_source:has(free_flight_alias) and player.input_source:get(free_flight_alias)

	if data.active and not Managers.world:has_world(data.viewport_world_name) then
		self:_clear_free_flight(data)
	elseif free_flight_pressed and data.active and frustum_freeze_toggle then
		local world = Managers.world:world(data.viewport_world_name)

		self:_toggle_frustum_freeze(dt, data, world, ScriptWorld.viewport(world, data.viewport_name))
	elseif free_flight_pressed and data.active then
		self:_exit_free_flight(player, data)
	elseif free_flight_pressed then
		self:_enter_free_flight(player, data)
	elseif data.active and not self.data.global.active then
		self:_update_free_flight(dt, player, data)
	end
end

function FreeFlightManager:_clear_free_flight(dt, data)
	data.active = false
	data.viewport_world_name = nil
	data.viewport_name = nil
end

function FreeFlightManager:_setup_data(data)
	data.global = {
		translation_speed = 0.05,
		mode = "paused",
		active = false,
		rotation_speed = 0.003,
		projection_type = Camera.PERSPECTIVE,
		orthographic_data = {
			size = 100
		}
	}

	for i = 1, PlayerManager.MAX_PLAYERS do
		data[i] = {
			current_translation_max_speed = 10,
			mode = "paused",
			active = false,
			rotation_speed = 0.003,
			rotation_accumulation = Vector3Box(),
			current_translation_speed = Vector3Box()
		}
	end
end

function FreeFlightManager:_enter_free_flight(player, data)
	local world_name = player.viewport_world_name
	local viewport_name = player.viewport_name
	local world = Managers.world:world(world_name)

	data.active = true
	data.viewport_name = player.viewport_name
	data.viewport_world_name = world_name

	if not data.input_source then
		local input = Managers.input
		local slot_mapping = "keyboard_mouse"

		if Application.platform() == "x360" then
			slot_mapping = "pad360"
		elseif Application.platform() == "ps3" then
			slot_mapping = "padps3"
		end

		data.input_source = input:map_slot(player.input_slot, FreeFlightControllerSettings, slot_mapping)
	end

	local viewport = ScriptWorld.create_free_flight_viewport(world, viewport_name, "default")
	local cam = ScriptViewport.camera(viewport)
	local tm = Camera.local_pose(cam)
	local position = Matrix4x4.translation(tm)
	local rotation = Matrix4x4.rotation(tm)

	if self._has_landscape then
		data.landscape_decoration_observer = LandscapeDecoration.create_observer(world, position)
	end

	data.scatter_system_observer = ScatterSystem.make_observer(World.scatter_system(world), position, rotation)
end

function FreeFlightManager:_exit_free_flight(player, data)
	local world = Managers.world:world(data.viewport_world_name)

	if data.frustum_freeze_camera then
		self:_exit_frustum_freeze(data, world, ScriptWorld.viewport(world, data.viewport_name))
	end

	local viewport_name = data.viewport_name

	data.active = false
	data.viewport_name = nil
	data.viewport_world_name = nil

	if self._has_landscape then
		LandscapeDecoration.destroy_observer(world, data.landscape_decoration_observer)
	end

	ScatterSystem.destroy_observer(World.scatter_system(world), data.scatter_system_observer)

	data.landscape_decoration_observer = nil
	data.scatter_system_observer = nil

	ScriptWorld.destroy_free_flight_viewport(world, viewport_name)
end

function FreeFlightManager:active(player_index)
	return self.data[player_index].active
end

function FreeFlightManager:mode(player_index)
	return self.data[player_index].mode
end

function FreeFlightManager:_update_free_flight(dt, player, data)
	local world = Managers.world:world(data.viewport_world_name)
	local viewport = ScriptWorld.free_flight_viewport(world, data.viewport_name)
	local cam = data.frustum_freeze_camera or ScriptViewport.camera(viewport)
	local input = data.input_source
	local translation_change_speed = data.current_translation_max_speed * 0.1
	local speed_change = Vector3.y(input:get("speed_change"))

	data.current_translation_max_speed = math.max(data.current_translation_max_speed + speed_change * translation_change_speed, 0.01)

	local cm = Camera.local_pose(cam)
	local trans = Matrix4x4.translation(cm)

	Matrix4x4.set_translation(cm, Vector3(0, 0, 0))

	local mouse = input:get("look")
	local rotation_accumulation = data.rotation_accumulation:unbox() + mouse
	local rotation = rotation_accumulation * math.min(dt, 1) * (player.free_flight_movement_filter_speed or 15)

	data.rotation_accumulation:store(rotation_accumulation - rotation)

	local q1 = Quaternion(Vector3(0, 0, 1), -Vector3.x(rotation) * data.rotation_speed)
	local q2 = Quaternion(Matrix4x4.x(cm), -Vector3.y(rotation) * data.rotation_speed)
	local q = Quaternion.multiply(q1, q2)

	cm = Matrix4x4.multiply(cm, Matrix4x4.from_quaternion(q))

	local acceleration = (player.free_flight_acceleration_factor or 5) * data.current_translation_max_speed
	local wanted_speed = input:get("move") * data.current_translation_max_speed
	local current_speed = data.current_translation_speed:unbox()
	local speed_difference = wanted_speed - current_speed
	local speed_distance = Vector3.length(speed_difference)
	local speed_difference_direction = Vector3.normalize(speed_difference)
	local new_speed = current_speed + speed_difference_direction * math.min(speed_distance, acceleration * dt)

	data.current_translation_speed:store(new_speed)

	local rot = Matrix4x4.rotation(cm)
	local offset = (Quaternion.forward(rot) * new_speed.y + Quaternion.right(rot) * new_speed.x + Quaternion.up(rot) * new_speed.z) * dt

	trans = Vector3.add(trans, offset)

	Matrix4x4.set_translation(cm, trans)
	ScriptCamera.set_local_pose(cam, cm)

	local timpani_world = World.timpani_world(world)

	TimpaniWorld.set_listener(timpani_world, 0, cm)

	if self._has_landscape then
		LandscapeDecoration.move_observer(world, data.landscape_decoration_observer, trans)
	end

	ScatterSystem.move_observer(World.scatter_system(world), data.scatter_system_observer, trans, rot)

	if input:get("set_drop_position") and player.camera_follow_unit then
		local pos = Camera.local_position(cam)

		Unit.set_local_position(player.camera_follow_unit, 0, pos)

		local mover = Unit.mover(player.camera_follow_unit)

		if mover then
			Mover.set_position(mover, pos)
		end
	end
end
