-- chunkname: @core/editor_slave/animation_editor.lua

function boot()
	Application.set_autoload_enabled(true)
	require("core/editor_slave/freeflight")
end

AnimationEditor = AnimationEditor or {}
EditorApi = AnimationEditor

function AnimationEditor:init()
	self.root_driving = "ignore"
	self.world = Application.new_world()
	self.viewport = Application.create_viewport(self.world, "default")
	self.shading_environment = World.create_shading_environment(self.world)
	self.gui = World.create_screen_gui(self.world, "immediate", "material", "core/editor_slave/gui/gui")
	self.prototype_gui = World.create_world_gui(self.world, Matrix4x4.identity(), 1, 1, "immediate", "material", "core/editor_slave/gui/gui")

	local camera_unit = World.spawn_unit(self.world, "core/units/camera")

	self.camera = Unit.camera(camera_unit, "camera")

	local camera_pos = Vector3(0, -3, 2)
	local camera_look = Vector3(0, 0, 0.5)
	local camera_dir = Vector3.normalize(camera_look - camera_pos)

	Camera.set_local_position(self.camera, camera_unit, Vector3(0, -3, 2))
	Camera.set_local_rotation(self.camera, camera_unit, Quaternion.look(camera_dir, Vector3(0, 0, 1)))

	self.freeflight = FreeFlight(self.camera, camera_unit)

	self.freeflight:load_data()

	self.lines = World.create_line_object(self.world, false)
	self.skeleton = World.create_line_object(self.world, true)
	self.options = {}
	self.mouse = {
		x = 0,
		y = 0
	}
	self.animation = nil
	self.constraint_targets = {}
end

function EditorApi:set_camera(pos, rot)
	self.freeflight:set_state(pos, rot)
end

function AnimationEditor:set_root_driving(driving)
	self.root_driving = driving
end

function AnimationEditor:load_level(level)
	local level = World.load_level(self.world, level)

	Level.spawn_background(level)
	Level.trigger_level_loaded(level)

	if Level.has_data(level, "shading_environment") then
		World.set_shading_environment(self.world, self.shading_environment, Level.get_data(level, "shading_environment"))
	end
end

function AnimationEditor:shutdown()
	Application.destroy_viewport(self.world, self.viewport)
	World.destroy_shading_environment(self.world, self.shading_environment)
	Application.release_world(self.world)
end

function AnimationEditor:spawn(unit)
	if self.unit then
		self:unspawn()
	end

	self.unit = World.spawn_unit(self.world, unit, Vector3(0, 0, 0))

	Unit.set_animation_logging(self.unit, true)
end

function AnimationEditor:unspawn()
	World.destroy_unit(self.world, self.unit)

	self.unit = nil
end

function AnimationEditor:view_machine(unit, machine)
	self:spawn(unit)

	if machine then
		Unit.set_animation_state_machine(self.unit, machine)
		Unit.set_animation_logging(self.unit, true)

		self.animation = nil
		self.constraint_targets = {}
	end
end

function AnimationEditor:view_animation(unit, animation, loop)
	if loop == nil then
		loop = true
	end

	self:spawn(unit)
	Unit.disable_animation_state_machine(self.unit)

	self.id = Unit.crossfade_animation(self.unit, animation, 0, 0, loop)
	self.offset_id = nil

	Unit.set_animation_root_mode(self.unit, self.root_driving)

	self.animation = animation
	self.constraint_targets = {}
end

function AnimationEditor:view_offset_animation(unit, animation, offset)
	self:view_animation(unit, animation)

	self.offset_id = Unit.crossfade_animation(self.unit, offset, 1, 0, true, "offset")
	self.animation = animation
	self.constraint_targets = {}
end

function AnimationEditor:animation_event(name)
	if self.animation then
		return
	end

	Unit.animation_event(self.unit, name)
end

function AnimationEditor:set_variable(name, value)
	if self.animation then
		return
	end

	local i = Unit.animation_find_variable(self.unit, name)

	Unit.animation_set_variable(self.unit, i, value)
end

function AnimationEditor:set_constraint_target(name, value)
	self.constraint_targets[name] = Vector3Box(value)

	if self.animation then
		return
	end

	local i = Unit.animation_find_constraint_target(self.unit, name)

	Unit.animation_set_constraint_target(self.unit, i, value)
end

function AnimationEditor:set_animation_time(t)
	if t < 0 then
		t = 0
	end

	Unit.crossfade_animation_set_speed(self.unit, self.id, 0)
	Unit.crossfade_animation_set_time(self.unit, self.id, t)

	if self.offset_id then
		Unit.crossfade_animation_set_speed(self.unit, self.offset_id, 0)
		Unit.crossfade_animation_set_time(self.unit, self.offset_id, t)
	end
end

function AnimationEditor:play(speed)
	Unit.crossfade_animation_set_speed(self.unit, self.id, speed)

	if self.offset_id then
		Unit.crossfade_animation_set_speed(self.unit, self.offset_id, speed)
	end
end

function AnimationEditor:render()
	ShadingEnvironment.blend(self.shading_environment, {
		"default",
		1
	})
	ShadingEnvironment.apply(self.shading_environment)
	Application.render_world(self.world, self.camera, self.viewport, self.shading_environment)
end

function AnimationEditor:draw_selected_node(unit, node, lines)
	local w = Unit.world_pose(unit, node)

	LineObject.add_axes(lines, w, 0.3)
end

function AnimationEditor:update(dt)
	if dt > 0.03333333333333333 then
		dt = 0.03333333333333333
	end

	local speed = self.speed or 1

	World.update(self.world, dt * speed)

	if self.unit then
		if self.last_pos then
			local pos = Unit.world_position(self.unit, 0)
			local delta = pos - Vector3(self.last_pos.x, self.last_pos.y, self.last_pos.z)

			if Vector3.length(delta) > 0 then
				self.freeflight:translate(delta)
			end
		end

		local v = Unit.world_position(self.unit, 0)

		self.last_pos = {
			x = v.x,
			y = v.y,
			z = v.z
		}
	end

	self.freeflight:update(dt * speed)
	self.world:timpani_world():set_listener(0, self.freeflight:pose())
	self.world:timpani_world():set_listeners(0)
	World.update_unit(self.world, self.freeflight.unit)

	local space = Keyboard.button_index("space")

	if Keyboard.pressed(space) then
		if not Window.mouse_focus() then
			Window.set_focus()
			Window.set_mouse_focus(true)
		else
			Window.set_mouse_focus(false)
		end
	end

	self.freeflight:save_data()

	if self.unit and self.draw_node then
		local i = Unit.node(self.unit, self.draw_node)

		if i >= 0 then
			self:draw_selected_node(self.unit, i, self.lines)
		end
	end

	self:draw_flash_text(dt)

	if self.options.draw_skeleton then
		self:draw_skeleton()
	end

	if self.options.draw_constraint_targets then
		self:draw_constraint_targets()
	end

	if self.drag then
		self:do_drag()
	end

	local text = self.animation or "State Machine"
	local w, h = Application.resolution()
	local size = w / 30
	local min, max = Gui.text_extents(self.gui, text, "core/editor_slave/gui/arial_df", size)
	local x = w / 2 - (min.x + max.x) / 2
	local y = 10

	Gui.text(self.gui, text, "core/editor_slave/gui/arial_df", size, "arial_df", Vector3(x, y, 0), Color(255, 255, 255))
	LineObject.dispatch(self.world, self.lines)
	LineObject.reset(self.lines)
	LineObject.dispatch(self.world, self.skeleton)
	LineObject.reset(self.skeleton)
end

function AnimationEditor:draw_flash_text(dt)
	local full_time = self.flash_full_time or 0
	local fade_time = self.flash_fade_time or 0

	if self.flash_text and self.flash_age < full_time + fade_time then
		self.flash_age = self.flash_age + dt

		local size = 50
		local min, max = Gui.text_extents(self.gui, self.flash_text, "core/editor_slave/gui/arial_df", size)
		local w, h = Application.resolution()
		local x = w / 2 - (min.x + max.x) / 2
		local y = h / 2 - (min.z + max.z) / 2
		local alpha = 255

		if self.flash_age > full_time + fade_time then
			alpha = 0
			self.flash_text = ""
		elseif full_time < self.flash_age then
			alpha = 255 - 255 * (self.flash_age - full_time) / fade_time
		end

		local m = 10

		Gui.text(self.gui, self.flash_text, "core/editor_slave/gui/arial_df", size, "arial_df", Vector3(x, y, 0), Color(alpha, 255, 255, 255))
	end
end

function AnimationEditor:draw_skeleton()
	if not self.unit then
		return
	end

	local bones = Unit.bones(self.unit)

	for _, bone in ipairs(bones) do
		local i = Unit.node(self.unit, bone)
		local parent = Unit.scene_graph_parent(self.unit, i)

		if parent then
			local from = Unit.world_position(self.unit, parent)
			local to = Unit.world_position(self.unit, i)
			local r = Vector3.distance(from, to) / 10

			if r > 0.1 then
				r = 0.1
			end

			local color = Color(100, 100, 255)

			if bone == self.draw_node then
				color = Color(255, 255, 0)
			end

			LineObject.add_cone(self.skeleton, color, to, from, r, 20, 5)
		end
	end
end

function AnimationEditor:pick_bone()
	if not self.unit then
		return
	end

	local cam, dir = self:mouse_ray()
	local hitbone
	local hitbonesize = 0
	local bones = Unit.bones(self.unit)

	for _, bone in ipairs(bones) do
		local i = Unit.node(self.unit, bone)
		local parent = Unit.scene_graph_parent(self.unit, i)

		if parent then
			local from = Unit.world_position(self.unit, parent)
			local to = Unit.world_position(self.unit, i)
			local t = (from + to) / 2
			local z = Vector3.normalize(to - t)
			local x, y = Vector3.make_axes(z)
			local tm = Matrix4x4.from_axes(x, y, z, t)
			local size = Vector3.distance(from, to)
			local r = Vector3(size / 20, size / 20, size / 2)
			local inter = Math.ray_box_intersection(cam, dir, tm, r)

			if inter > 0 and (hitbone == nil or size < hitbonesize) then
				hitbone = bone
				hitbonesize = size
			end
		end
	end

	return hitbone
end

function AnimationEditor:draw_box(tm, radius, color)
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

function AnimationEditor:mouse_ray()
	local cam = Camera.screen_to_world(self.camera, Vector3(self.mouse.x, 0, self.mouse.y))
	local dir = Camera.screen_to_world(self.camera, Vector3(self.mouse.x, 1, self.mouse.y)) - cam

	dir = Vector3.normalize(dir)

	return cam, dir
end

function AnimationEditor:pick_constraint_target()
	local cam, dir = self:mouse_ray()

	for target, pos in pairs(self.constraint_targets) do
		local tm = Matrix4x4.from_translation(pos:unbox())
		local inter = Math.ray_box_intersection(cam, dir, tm, Vector3(0.1, 0.1, 0.1))

		if inter > 0 then
			return target
		end
	end

	return nil
end

function AnimationEditor:draw_constraint_targets()
	local cam, dir = self:mouse_ray()
	local highlight = self:pick_constraint_target()

	if self.drag and self.drag.constraint_target then
		highlight = self.drag.constraint_target
	end

	for target, pos in pairs(self.constraint_targets) do
		local tm = Matrix4x4.from_translation(pos:unbox())
		local box_color, text_color

		if target == highlight then
			box_color = Color(255, 255, 0)
			text_color = box_color
		else
			box_color = Color(255, 255, 255)
			text_color = box_color
		end

		self:draw_box(tm, Vector3(0.05, 0.05, 0.05), box_color)

		local p = Camera.world_to_screen(self.camera, Matrix4x4.translation(tm))
		local size = 24
		local min, max = Gui.text_extents(self.gui, target, "core/editor_slave/gui/arial_df", size)
		local x = (min.x + max.x) / 2
		local y = (min.z + max.z) / 2

		Gui.text(self.gui, target, "core/editor_slave/gui/arial_df", size, "arial_df", Vector3(p.x - max.x / 2, p.z - max.z / 2 - size, 0), text_color)
	end
end

function AnimationEditor:mouse_down()
	if self.options.draw_constraint_targets then
		local target = self:pick_constraint_target()

		if target then
			local pos = self.constraint_targets[target]:unbox()

			self.drag = {
				constraint_target = target,
				start = {
					x = self.mouse.x,
					y = self.mouse.y
				},
				pos = {
					x = pos.x,
					y = pos.y,
					z = pos.z
				}
			}
		end
	end

	if self.options.draw_skeleton then
		self.draw_node = self:pick_bone()

		if self.draw_node then
			self:flash(self.draw_node, 2)
		end
	end
end

function AnimationEditor:mouse_up()
	self.drag = nil
end

function AnimationEditor:drag_pos(start_pos, cam_delta, lock)
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

function AnimationEditor:do_drag()
	local cam_delta = Vector3(self.mouse.x - self.drag.start.x, 0, self.mouse.y - self.drag.start.y)
	local pos = Vector3(self.drag.pos.x, self.drag.pos.y, self.drag.pos.z)

	pos, self.drag.lock = self:drag_pos(pos, cam_delta, self.drag.lock)

	LineObject.add_line(self.lines, Color(255, 0, 0), pos, pos - Vector3(0, 0, 100))
	self.constraint_targets[self.drag.constraint_target]:store(pos)

	if not self.animation then
		local i = Unit.animation_find_constraint_target(self.unit, self.drag.constraint_target)

		Unit.animation_set_constraint_target(self.unit, i, pos)
	end

	Application.console_send({
		type = "move_constraint_target",
		target = self.drag.constraint_target,
		position = pos
	})
end

function AnimationEditor:activated(dt)
	if Window then
		Window.set_focus()
	end
end

function AnimationEditor:focus()
	if Window then
		Window.set_focus()
		Window.set_mouse_focus(true)
	end
end

function AnimationEditor:reset_to_origin()
	if self.unit then
		Unit.set_local_position(self.unit, 0, Vector3(0, 0, 0))
	end
end

function AnimationEditor:flash(s, full_time, fade_time)
	self.flash_text = s
	self.flash_age = 0
	self.flash_full_time = full_time or 0
	self.flash_fade_time = fade_time or 0.2
end

function init()
	boot()
	AnimationEditor:init()
end

function shutdown()
	AnimationEditor:shutdown()
end

function update(dt)
	AnimationEditor:update(dt)
end

function render()
	AnimationEditor:render()
end
