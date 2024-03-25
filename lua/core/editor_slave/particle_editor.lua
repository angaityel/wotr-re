-- chunkname: @core/editor_slave/particle_editor.lua

function boot()
	Application.set_autoload_enabled(true)
	require("core/editor_slave/freeflight")
end

function class(klass, super)
	if not klass then
		klass = {}

		local meta = {}

		function meta:__call(...)
			local object = {}

			setmetatable(object, klass)

			if object.init then
				object:init(...)
			end

			return object
		end

		setmetatable(klass, meta)
	end

	if super then
		for k, v in pairs(super) do
			klass[k] = v
		end
	end

	klass.__index = klass

	return klass
end

TextDrawer = class(TextDrawer)

function TextDrawer:init(gui, font, material)
	self.gui, self.font, self.material = gui, font, material
	self.size = 20
	self.color = Color(255, 255, 255)
	self.pos = Vector2(0, 0)
	self.line_height = 30
	self.column_width = {
		100,
		100
	}
	self.flash = ""
end

function TextDrawer:row(...)
	local x = 0

	for i, t in ipairs({
		...
	}) do
		if i > 1 then
			x = x + self.column_width[i - 1]
		end

		Gui.text(self.gui, t, self.font, self.size, self.material, self.pos + Vector2(x, 0))
	end

	Vector3.set_y(self.pos, self.pos.y - self.line_height)
end

function TextDrawer:space(s)
	Vector3.set_y(self.pos, self.pos.y - s)
end

ParticleEditor = ParticleEditor or {}
EditorApi = ParticleEditor

function ParticleEditor:init()
	self.t = 0
	self.name = "__particle_editor_test"
	self.loaded_level = nil
	self.has_ruler = false
	self.clouds = {}
	self.totals = {}
	self.peak = {}
	self.options = {}
	self.mouse = {
		x = 0,
		y = 0
	}
	self.variables = {}
	self.camera_distance = nil
	self.emitter = {
		pattern = "stationary",
		height = 0,
		radius = 5,
		speed = 5,
		t = 0,
		position = Vector3Box(),
		rotation = QuaternionBox()
	}

	self:init_world()
	self:init_camera()
end

function ParticleEditor:init_world()
	self.world = Application.new_world()
	self.gui = World.create_screen_gui(self.world, "immediate", "material", "core/editor_slave/gui/gui")
	self.prototype_gui = World.create_world_gui(self.world, Matrix4x4.identity(), 1, 1, "immediate", "material", "core/editor_slave/gui/gui")
	self.ruler_gui = World.create_world_gui(self.world, Matrix4x4.identity(), 1, 1, "immediate", "material", "core/editor_slave/human")
	self.viewport = Application.create_viewport(self.world, "default")
	self.shading_environment = World.create_shading_environment(self.world)
	self.lines = World.create_line_object(self.world, false)
end

function ParticleEditor:init_camera()
	local camera_unit = World.spawn_unit(self.world, "core/units/camera")

	self.camera = Unit.camera(camera_unit, "camera")
	self.freeflight = FreeFlight(self.camera, camera_unit)

	self:set_camera_distance(10)
end

function ParticleEditor:set_camera_distance(d)
	if d == self.camera_distance then
		return
	end

	local camera_pos = Vector3(0, -d, 1)
	local camera_look = Vector3(0, 0, 1)
	local camera_dir = Vector3.normalize(camera_look - camera_pos)
	local camera_rot = Quaternion.look(camera_dir, Vector3(0, 0, 1))

	self.freeflight:set_state(camera_pos, camera_rot)

	self.camera_distance = d
end

function EditorApi:set_camera(pos, rot)
	self.freeflight:set_state(pos, rot)
end

function ParticleEditor:shutdown()
	self.camera_distance = nil

	Application.destroy_viewport(self.world, self.viewport)
	World.destroy_shading_environment(self.world, self.shading_environment)
	Application.release_world(self.world)
end

function ParticleEditor:reboot()
	self:shutdown()
	self:init_world()
	self:init_camera()

	self.loaded_level = nil
	self.t = 0
	self.id = nil
end

function ParticleEditor:load_level(level)
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

function ParticleEditor:render()
	ShadingEnvironment.blend(self.shading_environment, {
		"default",
		1
	})
	ShadingEnvironment.apply(self.shading_environment)
	Application.render_world(self.world, self.camera, self.viewport, self.shading_environment)
end

function ParticleEditor:stop()
	if self.id then
		self.world:destroy_particles(self.id)

		self.id = nil
	end
end

function ParticleEditor:test()
	self:stop()

	self.id = self.world:create_particles(self.name, self.emitter.position:unbox(), self.emitter.rotation:unbox())

	self.world:advance_particles_time(self.id, self.t)

	self.peak = {}
end

function ParticleEditor:respawn()
	self.t = 0

	self.world:destroy_particles(self.id)

	self.id = self.world:create_particles(self.name, self.emitter.position:unbox(), self.emitter.rotation:unbox())

	for i, v in ipairs(self.variables) do
		World.set_particles_variable(self.world, self.id, i - 1, Vector3(v.x, v.y, v.z))
	end
end

function ParticleEditor:set_paused(paused)
	self.paused = paused
end

function ParticleEditor:scrub(t)
	if t < self.t then
		self:respawn()
	end

	self.world:advance_particles_time(self.id, t - self.t)
end

function ParticleEditor:update_emitter(dt)
	local e = self.emitter
	local pos = Vector3(0, 0, e.height)
	local rot = Quaternion.identity()

	e.t = e.t + dt * e.speed / e.radius

	local p = self.emitter.pattern

	if p == "sinus" then
		pos.x = pos.x + math.sin(e.t) * e.radius
	elseif p == "circle" then
		pos.x = pos.x + math.sin(e.t) * e.radius
		pos.y = pos.y + math.cos(e.t) * e.radius
	elseif p == "rotating" then
		local axis = Vector3(0, 0, 0)

		axis.x = axis.x + math.sin(e.t)
		axis.y = axis.y + math.cos(e.t)
		rot = Quaternion.axis_angle(axis, math.pi / 2)
	end

	e.position:store(pos)
	e.rotation:store(rot)

	if self.id then
		self.world:move_particles(self.id, e.position:unbox(), e.rotation:unbox())
	end
end

function ParticleEditor:update(dt)
	self:update_emitter(dt)
	self.freeflight:update(dt)

	local space = Keyboard.button_index("space")

	if Keyboard.pressed(space) then
		Window.set_mouse_focus(not Window.mouse_focus())
	end

	local editor_keys = {
		"f5",
		"f7",
		"f9"
	}

	for i, key in ipairs(editor_keys) do
		if Keyboard.pressed(Keyboard.button_index(key)) then
			Application.console_send({
				type = "keyboard",
				key = key
			})
		end
	end

	if self.paused then
		dt = 0
	end

	World.update(self.world, dt)

	if self.options.show_stats then
		self:draw_stats()
	end

	if self.options.show_ruler then
		self:draw_ruler()
	end

	if self.options.show_variables then
		self:draw_variables()
	end

	if self.flash then
		self:draw_flash()
	end

	if self.drag then
		self:do_drag()
	end

	LineObject.dispatch(self.world, self.lines)
	LineObject.reset(self.lines)
end

function ParticleEditor:draw_ruler()
	Gui.bitmap(self.ruler_gui, "human", Vector2(0, 0), Vector2(1.54, 2))
	Gui.rect(self.ruler_gui, Vector2(-3, 0), Vector2(0.1, 5), Color(255, 255, 255))

	for y = 1, 4 do
		Gui.rect(self.ruler_gui, Vector2(-3, y), Vector2(0.1, 0.02), Color(255, 0, 0))
	end

	for y = 0.1, 4.9, 0.1 do
		Gui.rect(self.ruler_gui, Vector2(-3, y), Vector2(0.05, 0.01), Color(0, 0, 0))
	end
end

function ParticleEditor:draw_stats()
	local w, h = Application.resolution()
	local td = TextDrawer(self.gui, "core/editor_slave/gui/arial", "arial")

	td.pos = Vector2(20, h - 20)
	td.column_width[1] = 120
	td.column_width[2] = 80
	td.column_width[3] = 80

	local n = 1

	if self.id then
		for i, name in ipairs(self.clouds) do
			local count = World.num_particles(self.world, self.id, i - 1)

			if not self.peak[i] or count > self.peak[i] then
				self.peak[i] = count
			end

			td:row(name, count, self.peak[i], self.totals[i])
		end
	end

	td:space(10)
	td:row("Total", World.num_particles(self.world))
end

function ParticleEditor:draw_flash()
	local size = 50
	local min, max = Gui.text_extents(self.gui, self.flash, "core/editor_slave/gui/arial_df", size)
	local w, h = Application.resolution()
	local x = w / 2 - (min.x + max.x) / 2
	local y = h / 2 - (min.z + max.z) / 2
	local alpha = 255
	local m = 10

	Gui.rect(self.gui, Vector3(x + min.x - m, y + min.z - m, -1), Vector3(max.x - min.x + 2 * m, max.z - min.z + 2 * m, 0), Color(alpha / 4, 0, 0, 0))
	Gui.text(self.gui, self.flash, "core/editor_slave/gui/arial_df", size, "arial_df", Vector3(x, y, 0), Color(alpha, 255, 255, 255))
end

function ParticleEditor:draw_box(tm, radius, color)
	local p = Matrix4x4.translation(tm)

	for y = 0, 2 do
		local i = 2 * y + 1
		local x = (y + 2) % 3 + 1
		local z = (y + 1) % 3 + 1
		local y = y + 1
		local m = Matrix4x4.identity()

		Matrix4x4.set_x(m, Matrix4x4.axis(tm, x))
		Matrix4x4.set_y(m, Matrix4x4.axis(tm, y))
		Matrix4x4.set_z(m, Matrix4x4.axis(tm, z))

		local r = Vector3(Vector3.element(radius, x), Vector3.element(radius, y), Vector3.element(radius, z))
		local size = Vector3(r.x * 2, r.z * 2, 0)

		Matrix4x4.set_translation(m, p + Matrix4x4.transform_without_translation(m, Vector3(-r.x, -r.y, -r.z)))
		Gui.bitmap_3d(self.prototype_gui, "prototype", m, Vector3(0, 0, 0), 0, size, color)
		Matrix4x4.set_x(m, -Matrix4x4.x(m))
		Matrix4x4.set_y(m, -Matrix4x4.y(m))
		Matrix4x4.set_translation(m, p + Matrix4x4.transform_without_translation(m, Vector3(-r.x, -r.y, -r.z)))
		Gui.bitmap_3d(self.prototype_gui, "prototype", m, Vector3(0, 0, 0), 0, size, color)
	end
end

function ParticleEditor:mouse_ray()
	local cam = Camera.screen_to_world(self.camera, Vector3(self.mouse.x, 0, self.mouse.y))
	local dir = Camera.screen_to_world(self.camera, Vector3(self.mouse.x, 1, self.mouse.y)) - cam

	dir = Vector3.normalize(dir)

	return cam, dir
end

function ParticleEditor:pick_variable()
	local cam, dir = self:mouse_ray()

	for i, var in ipairs(self.variables or {}) do
		local tm = Matrix4x4.from_translation(Vector3(var.x, var.y, var.z))
		local inter = Math.ray_box_intersection(cam, dir, tm, Vector3(0.1, 0.1, 0.1))

		if inter > 0 then
			var.i = i

			return var
		end
	end

	return nil
end

function ParticleEditor:draw_variables()
	local cam, dir = self:mouse_ray()
	local highlight = self:pick_variable()

	if self.drag and self.drag.variable then
		highlight = self.drag.variable
	end

	for i, var in ipairs(self.variables or {}) do
		local tm = Matrix4x4.from_translation(Vector3(var.x, var.y, var.z))
		local box_color, text_color

		if var == highlight then
			box_color = Color(255, 255, 0)
			text_color = box_color
		else
			box_color = Color(255, 255, 255)
			text_color = box_color
		end

		self:draw_box(tm, Vector3(0.05, 0.05, 0.05), box_color)

		local p = Camera.world_to_screen(self.camera, Matrix4x4.translation(tm))
		local size = 24
		local min, max = Gui.text_extents(self.gui, var.name, "core/editor_slave/gui/arial_df", size)
		local x = (min.x + max.x) / 2
		local y = (min.z + max.z) / 2

		Gui.text(self.gui, var.name, "core/editor_slave/gui/arial_df", size, "arial_df", Vector3(p.x - max.x / 2, p.z - max.z / 2 - size, 0), text_color)
	end
end

function ParticleEditor:mouse_down()
	if self.options.show_variables then
		local target = self:pick_variable()

		if target then
			self.drag = {
				variable = target,
				start = {
					x = self.mouse.x,
					y = self.mouse.y
				},
				pos = {
					x = target.x,
					y = target.y,
					z = target.z
				}
			}
		end
	end
end

function ParticleEditor:mouse_up()
	self.drag = nil
end

function ParticleEditor:drag_pos(start_pos, cam_delta, lock)
	local cam = self.camera
	local x = Vector3(1, 0, 0)
	local y = Vector3(0, 1, 0)
	local z = Vector3(0, 0, 1)

	local function camera_vector(axis)
		return Camera.world_to_screen(cam, start_pos + axis) - Camera.world_to_screen(cam, start_pos - axis)
	end

	local cam_x = camera_vector(x)
	local cam_y = camera_vector(y)
	local cam_z = camera_vector(z)
	local size_x = math.abs(Vector3.dot(cam_x, cam_delta))
	local size_y = math.abs(Vector3.dot(cam_y, cam_delta))
	local size_z = math.abs(Vector3.dot(cam_z, cam_delta))
	local c, r = self:mouse_ray()
	local p = start_pos
	local n = z
	local axis = "xy"

	if size_x < size_z and size_y < size_z then
		axis = "z"
	end

	if lock then
		axis = lock
	elseif Vector3.length(cam_delta) > 10 then
		lock = axis
	end

	if axis == "z" then
		local a = Vector3.dot(r, n)
		local b = Vector3.dot(p - c, r * a - n) / (1 - a * a)

		return p + n * b, lock
	else
		local t = Vector3.dot(p - c, n) / Vector3.dot(r, n)

		return c + r * t, lock
	end
end

function ParticleEditor:do_drag()
	local cam_delta = Vector3(self.mouse.x - self.drag.start.x, 0, self.mouse.y - self.drag.start.y)
	local pos = Vector3(self.drag.pos.x, self.drag.pos.y, self.drag.pos.z)

	pos, self.drag.lock = self:drag_pos(pos, cam_delta, self.drag.lock)

	LineObject.add_line(self.lines, Color(255, 0, 0), pos, pos - Vector3(0, 0, 100))

	self.drag.variable.x = pos.x
	self.drag.variable.y = pos.y
	self.drag.variable.z = pos.z

	if self.id then
		World.set_particles_variable(self.world, self.id, self.drag.variable.i - 1, Vector3(pos.x, pos.y, pos.z))
	end
end

function init()
	boot()
	ParticleEditor:init()
end

function shutdown()
	ParticleEditor:shutdown()
end

function update(dt)
	ParticleEditor:update(dt)
end

function render()
	ParticleEditor:render(dt)
end

function focus()
	if Window then
		Window.set_focus()
	end
end
