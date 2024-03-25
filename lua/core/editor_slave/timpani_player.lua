-- chunkname: @core/editor_slave/timpani_player.lua

function boot()
	Application.set_autoload_enabled(true)
	require("core/editor_slave/freeflight")
	require("core/editor_slave/topdown")
end

keyboard = {}
mouse = {}
wheel = {}

function Keyboard.button(i)
	return keyboard[Keyboard.button_name(i)] or 0
end

function Mouse.axis(i)
	if Mouse.axis_name(i) == "mouse" then
		return Vector3(mouse.x or 0, mouse.y or 0, mouse.z or 0)
	end

	if Mouse.axis_name(i) == "wheel" then
		return Vector3(wheel.x or 0, wheel.y or 0, wheel.z or 0)
	end

	return Vector3(0, 0, 0)
end

TimpaniPlayer = TimpaniPlayer or {}

function TimpaniPlayer:init()
	self:init_world()
	self:init_camera()

	self.t = 0
	self.name = "__particle_editor_test"
	self.loaded_level = nil
	self.options = {}
	self.mouse = {
		x = 0,
		y = 0
	}
	self.variables = {}
	self.inited = true
	self.sound_source_type = "2d"
	self.frequency = 1
	self.radius = 5
	self.id = null
	self.parameters = {}
	self.active_parameters = {}
end

function TimpaniPlayer:init_world()
	self.world = Application.new_world()
	self.viewport = Application.create_viewport(self.world, "default")
	self.shading_environment = World.create_shading_environment(self.world)
	self.lines = World.create_line_object(self.world, false)
end

function TimpaniPlayer:init_camera()
	self.camera_unit = World.spawn_unit(self.world, "core/units/camera")
	self.camera = Unit.camera(self.camera_unit, "camera")

	local camera_pos = Vector3(0, 10, 1)
	local camera_look = Vector3(0, 0, 1)
	local camera_dir = Vector3.normalize(camera_look - camera_pos)

	Camera.set_local_position(self.camera, self.camera_unit, camera_pos)
	Camera.set_local_rotation(self.camera, self.camera_unit, Quaternion.look(camera_dir, Vector3(0, 0, 1)))

	self.controller = FreeFlight(self.camera, self.camera_unit)
end

function TimpaniPlayer:shutdown()
	Application.destroy_viewport(self.world, self.viewport)
	World.destroy_shading_environment(self.world, self.shading_environment)
	Application.release_world(self.world)
end

function TimpaniPlayer:reboot()
	self:shutdown()
	self:init_world()
	self:init_camera()

	self.loaded_level = nil
	self.t = 0
	self.id = nil
end

function TimpaniPlayer:load_level(level)
	if level == self.loaded_level then
		return
	end

	self:reboot()

	self.loaded_level = level
	level = World.load_level(self.world, level)

	Level.spawn_background(level)
	Level.trigger_level_loaded(level)

	if Level.has_data(level, "shading_environment") then
		World.set_shading_environment(self.world, self.shading_environment, Level.get_data(level, "shading_environment"))
	end
end

function TimpaniPlayer:render()
	ShadingEnvironment.blend(self.shading_environment, {
		"default",
		1
	})
	ShadingEnvironment.apply(self.shading_environment)
	Application.render_world(self.world, self.camera, self.viewport, self.shading_environment)
end

function TimpaniPlayer:event(name, parameters)
	local tw = World.timpani_world(self.world)

	if self.sound_source then
		self.id = tw:trigger_event(name, self.sound_source)
	else
		self.id = tw:trigger_event(name)
	end

	self.active_parameters = parameters

	self:update_parameters()
end

function TimpaniPlayer:sound(name, parameters)
	local tw = World.timpani_world(self.world)
	local id

	if self.sound_source then
		self.id = tw:trigger_sound(name, self.sound_source)
	else
		self.id = tw:trigger_sound(name)
	end

	self.active_parameters = parameters

	self:update_parameters()
end

function TimpaniPlayer:stop_all()
	local tw = World.timpani_world(self.world)

	tw:stop_all()
end

function TimpaniPlayer:set_environment(name)
	local tw = World.timpani_world(self.world)

	tw:set_environment(name)
end

function TimpaniPlayer:set_parameter(name, value)
	self.parameters[name] = value

	self:update_parameters()
end

function TimpaniPlayer:update_parameters()
	if not self.id then
		return
	end

	local tw = World.timpani_world(self.world)

	for k, v in pairs(self.parameters) do
		if self.active_parameters[k] then
			tw:set_parameter(self.id, k, v)
		end
	end
end

local function pressed(key)
	return Keyboard.pressed(Keyboard.button_index(key))
end

function TimpaniPlayer:update(dt)
	self.t = self.t + dt

	World.update(self.world, dt)
	self.controller:update(dt)
	self:update_sound_source(dt)

	local tw = self.world:timpani_world()

	if self.listener_type == "first_person" then
		tw:set_listener(0, self.controller:pose())
		tw:set_listener_mode(0, TimpaniWorld.LISTENER_3D)
	elseif self.listener_type == "top_down" then
		local t = Matrix4x4.translation(self.controller:pose())

		t.z = 0

		local m = Matrix4x4.identity()

		Matrix4x4.set_translation(m, t)
		tw:set_listener(0, m)
		tw:set_listener_mode(0, TimpaniWorld.LISTENER_2D)
		tw:set_listener_size(0, self.controller:listener_size())
	end

	tw:set_listeners(0)
	LineObject.dispatch(self.world, self.lines)
	LineObject.reset(self.lines)

	mouse = {}
	wheel = {}
end

function TimpaniPlayer:set_source(type)
	self.sound_source_type = type

	if type == "2d" and self.sound_source then
		World.destroy_unit(self.world, self.sound_source)

		self.sound_source = nil
	end

	if type ~= "2d" and not self.sound_source then
		self.sound_source = World.spawn_unit(self.world, "core/editor_slave/units/sound_source_icon/sound_source_icon", Vector3(0, 0, 1))
	end
end

function TimpaniPlayer:set_listener(type)
	self.listener_type = type

	if type == "first_person" then
		local camera_pos = Vector3(0, 10, 1)
		local camera_look = Vector3(0, 0, 1)
		local camera_dir = Vector3.normalize(camera_look - camera_pos)

		Camera.set_local_position(self.camera, self.camera_unit, camera_pos)
		Camera.set_local_rotation(self.camera, self.camera_unit, Quaternion.look(camera_dir, Vector3(0, 0, 1)))

		self.controller = FreeFlight(self.camera, self.camera_unit)
	end

	if type == "top_down" then
		local camera_pos = Vector3(0, 0, 10)
		local camera_look = Vector3(0, 0, 0)
		local camera_dir = Vector3.normalize(camera_look - camera_pos)

		Camera.set_local_position(self.camera, self.camera_unit, camera_pos)
		Camera.set_local_rotation(self.camera, self.camera_unit, Quaternion.look(camera_dir, Vector3(0, 0, 1)))

		self.controller = TopDown(self.camera, self.camera_unit)
	end
end

function TimpaniPlayer:update_sound_source(dt)
	if not self.sound_source then
		return
	end

	local m = self.sound_source_type
	local pos = Vector3(0, 0, 1)
	local rot = Quaternion.identity()
	local a = self.t * self.frequency
	local r = self.radius
	local s = math.sin(a)
	local c = math.cos(a)

	if m == "stationary" then
		pos = Vector3(0, 0, 1)
	elseif m == "sinus" then
		pos = Vector3(s * r, 0, 1)
	elseif m == "circle" then
		pos = Vector3(c * r, s * r, 1)
		rot = Quaternion.look(Vector3(0, 0, 1) - pos, Vector3(0, 0, 1))
	end

	Unit.set_local_position(self.sound_source, 0, pos)
	Unit.set_local_rotation(self.sound_source, 0, rot)
end

function init()
	boot()
end

function shutdown()
	if TimpaniPlayer.inited then
		TimpaniPlayer:shutdown()
	end
end

function update(dt)
	if TimpaniPlayer.inited then
		TimpaniPlayer:update(dt)
	end
end

function render()
	if TimpaniPlayer.inited then
		TimpaniPlayer:render(dt)
	end
end
