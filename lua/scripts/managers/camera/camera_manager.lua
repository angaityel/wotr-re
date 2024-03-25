-- chunkname: @scripts/managers/camera/camera_manager.lua

require("scripts/settings/camera_transition_templates")
require("scripts/settings/camera_settings")
require("scripts/settings/camera_effect_settings")
require("scripts/managers/camera/transitions/camera_transition_generic")
require("scripts/managers/camera/transitions/camera_transition_fov_linear")
require("scripts/managers/camera/transitions/camera_transition_position_linear")
require("scripts/managers/camera/transitions/camera_transition_rotation_lerp")
require("scripts/managers/camera/cameras/base_camera")
require("scripts/managers/camera/cameras/root_camera")
require("scripts/managers/camera/cameras/transform_camera")
require("scripts/managers/camera/cameras/scalable_transform_camera")
require("scripts/managers/camera/cameras/rotation_camera")
require("scripts/managers/camera/cameras/blend_camera")
require("scripts/managers/camera/cameras/aim_camera")
require("scripts/managers/camera/cameras/sway_camera")
require("scripts/managers/camera/cameras/object_link_camera")

CameraManager = class(CameraManager)
CameraManager.NODE_PROPERTY_MAP = {
	"position",
	"rotation",
	"vertical_fov",
	"near_range",
	"far_range",
	"yaw_speed",
	"pitch_speed",
	"shading_environment",
	"fade_to_black",
	"pitch_offset"
}
CameraManager.AIM_RAYCAST_LENGTH = 1000

function CameraManager:init(world)
	self._world = world
	self._node_trees = {}
	self._current_trees = {}
	self._camera_nodes = {}
	self._landscape_decoration_observers = {}
	self._scatter_system_observers = {}
	self._aim_raycast = {}
	self._aim_raycast_position = {}
	self._variables = {}
	self._sequence_event_settings = {
		time_to_recover = 0,
		end_time = 0,
		start_time = 0
	}
	self._shake_event_settings = {}
	self._level_particle_effect_ids = {}
	self._level_screen_effect_ids = {}
	self._environment = "default"
	self._frozen = false
	self._frame = 0
	self._shadow_lights = {}
	self._shadow_lights_active = false
	self._shadow_lights_max_active = 1
	self._shadow_lights_viewport = nil
end

function CameraManager:set_shadow_lights(active, max, viewport)
	self._shadow_lights_active = active
	self._shadow_lights_max_active = max

	if not active then
		for _, shadow_light in ipairs(self._shadow_lights) do
			self:_set_shadow_light(shadow_light.unit, false)
		end
	end
end

function CameraManager:register_shadow_lights(set)
	local level = LevelHelper:current_level(self._world)

	for _, index in pairs(set.units) do
		local unit = Level.unit_by_index(level, index)

		self._shadow_lights[#self._shadow_lights + 1] = {
			distance = 0,
			unit = unit
		}

		self:_set_shadow_light(unit, false)
	end
end

function CameraManager:_set_shadow_light(unit, active)
	for i = 1, Unit.num_lights(unit) do
		local light = Unit.light(unit, i - 1)

		Light.set_casts_shadows(light, active)
	end
end

function CameraManager:_update_shadow_lights(dt, viewport)
	if self._shadow_lights_active and viewport == self._shadow_lights_viewport then
		local lights = self._shadow_lights
		local camera_pos = self:camera_position(viewport)

		for _, light in ipairs(lights) do
			local unit = light.unit

			self:_set_shadow_light(unit, false)

			light.distance = Vector3.length(Unit.world_position(unit, 0) - self:camera_position(viewport))
		end

		table.sort(lights, function(light1, light2)
			return light1.distance < light2.distance
		end)

		for i = 1, self._shadow_lights_max_active + 1 do
			self:_set_shadow_light(lights[i].unit, true)
		end
	end
end

function CameraManager:add_viewport(viewport_name, position, rotation)
	self._landscape_decoration_observers[viewport_name] = LandscapeDecoration.create_observer(self._world, position)
	self._scatter_system_observers[viewport_name] = ScatterSystem.make_observer(World.scatter_system(self._world), position, rotation)
	self._node_trees[viewport_name] = {}
	self._variables[viewport_name] = {}
	self._camera_nodes[viewport_name] = {}
	self._shadow_lights_viewport = viewport_name
end

function CameraManager:create_viewport(viewport_name, position, rotation)
	ScriptWorld.create_viewport(self._world, viewport_name, "default", 1, position, rotation)
	self:add_viewport(viewport_name, position, rotation)
end

function CameraManager:destroy_viewport(viewport_name)
	LandscapeDecoration.destroy_observer(self._world, self._landscape_decoration_observers[viewport_name])
	ScatterSystem.destroy_observer(World.scatter_system(self._world), self._scatter_system_observers[viewport_name])

	self._landscape_decoration_observers[viewport_name] = nil
	self._scatter_system_observers[viewport_name] = nil
	self._node_trees[viewport_name] = nil
	self._variables[viewport_name] = nil
	self._camera_nodes[viewport_name] = nil
end

function CameraManager:load_node_tree(viewport_name, tree_id, tree_name)
	local tree_settings = CameraSettings[tree_name]
	local node_table = {}
	local root_node = self:_setup_child_nodes(node_table, viewport_name, tree_id, nil, tree_settings)
	local tree_table = {
		root_node = root_node,
		nodes = node_table
	}

	self._node_trees[viewport_name][tree_id] = tree_table
end

function CameraManager:node_tree_loaded(viewport_name, tree_id)
	if self._node_trees[viewport_name] and self._node_trees[viewport_name][tree_id] then
		return true
	end

	return false
end

function CameraManager:debug_reload_tree(viewport_name, tree_id, tree_name, node, unit)
	self:load_node_tree(viewport_name, tree_id, tree_name)
	self:set_node_tree_root_unit(viewport_name, tree_name, unit)
	self:set_camera_node(viewport_name, tree_name, node)
end

function CameraManager:set_node_tree_root_unit(viewport_name, tree_id, unit, object, preserve_aim_yaw)
	self._node_trees[viewport_name][tree_id].root_node:set_root_unit(unit, object, preserve_aim_yaw)
end

function CameraManager:current_node_tree_root_unit(viewport_name)
	local tree_id = self._current_trees[viewport_name]

	return self._node_trees[viewport_name][tree_id].root_node:root_unit()
end

function CameraManager:set_node_tree_root_position(viewport_name, tree_id, position)
	self._node_trees[viewport_name][tree_id].root_node:set_root_position(position)
end

function CameraManager:set_node_tree_root_rotation(viewport_name, tree_id, rotation)
	self._node_trees[viewport_name][tree_id].root_node:set_root_rotation(rotation)
end

function CameraManager:set_node_tree_root_vertical_fov(viewport_name, tree_id, vertical_fov)
	self._node_trees[viewport_name][tree_id].root_node:set_root_vertical_fov(vertical_fov)
end

function CameraManager:current_camera_node(viewport_name)
	return self._camera_nodes[viewport_name][#self._camera_nodes[viewport_name]].node:name()
end

function CameraManager:shading_callback(world, shading_env)
	if self._world == world then
		local shading_env_settings = self._shading_environment

		if shading_env_settings.dof_near_focus and shading_env_settings.dof_near_blur then
			local nf = shading_env_settings.dof_near_focus
			local nb = shading_env_settings.dof_near_blur

			ShadingEnvironment.set_vector2(shading_env, "dof_near_setting", Vector3(nf, nf - nb, 0))
		end

		if shading_env_settings.dof_far_focus and shading_env_settings.dof_far_blur then
			local ff = shading_env_settings.dof_far_focus
			local fb = shading_env_settings.dof_far_blur

			ShadingEnvironment.set_vector2(shading_env, "dof_far_setting", Vector3(ff, fb - ff, 0))
		end

		if shading_env_settings.dof_amount then
			local amount = shading_env_settings.dof_amount

			ShadingEnvironment.set_scalar(shading_env, "dof_amount", amount)
		end

		if self._frame == 0 then
			self._frame = 1

			ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 1)
		elseif self._frame == 1 then
			self._frame = 2

			ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 0)
		end

		local gamma = Application.user_setting("gamma") or 1

		ShadingEnvironment.set_scalar(shading_env, "exposure", ShadingEnvironment.scalar(shading_env, "exposure") * gamma)

		if Application.user_setting("render_settings", "particles_receive_shadows") then
			local last_slice_idx = ShadingEnvironment.array_elements(shading_env, "shadow_slice_depth_ranges") - 1
			local last_slice_depths = ShadingEnvironment.array_vector2(shading_env, "shadow_slice_depth_ranges", last_slice_idx)

			last_slice_depths.x = 0

			ShadingEnvironment.set_array_vector2(shading_env, "shadow_slice_depth_ranges", last_slice_idx, last_slice_depths)
		end
	end
end

function CameraManager:change_environment(name, time)
	if time == 0 then
		World.set_data(self._world, "shading_settings", {
			name,
			1
		})

		self._environment_transitions = nil
		self._environment = name
	else
		self._environment_transitions = {
			value = 0,
			last_environment = self._environment,
			speed = 1 / time,
			transitions = self._environment_transitions
		}
		self._environment = name
	end
end

function CameraManager:_update_environment_transitions(dt)
	local shading_settings = {
		self._environment
	}
	local next_transition = self._environment_transitions

	if next_transition then
		next_transition.value = next_transition.value + next_transition.speed * dt

		if next_transition.value >= 1 then
			self._environment_transitions = nil
			shading_settings[#shading_settings + 1] = 1
		else
			shading_settings[#shading_settings + 1] = next_transition.value
			shading_settings[#shading_settings + 1] = self._environment_transitions.last_environment

			self:_apply_environment_transitions(dt, next_transition, shading_settings, 1 - next_transition.value)
		end
	else
		shading_settings[#shading_settings + 1] = 1
	end

	World.set_data(self._world, "shading_settings", shading_settings)
end

function CameraManager:_apply_environment_transitions(dt, transition, shading_settings, weight)
	local next_transition = transition.transitions

	if next_transition then
		table.dump(next_transition)

		next_transition.value = next_transition.value + next_transition.speed * dt

		if next_transition.value >= 1 then
			transition.transitions = nil
			shading_settings[#shading_settings + 1] = weight
		else
			shading_settings[#shading_settings + 1] = weight * next_transition.value
			shading_settings[#shading_settings + 1] = transition.last_environment

			return self:_apply_environment_transitions(dt, next_transition, shading_settings, weight * (1 - next_transition.value))
		end
	else
		shading_settings[#shading_settings + 1] = weight
	end
end

function CameraManager:_update_level_particle_effects(viewport_name)
	for id, _ in pairs(self._level_particle_effect_ids) do
		World.move_particles(self._world, id, self:camera_position(viewport_name))
	end
end

function CameraManager:set_camera_node(viewport_name, tree_id, node_name)
	if script_data.camera_debug or script_data.camera_node_debug then
		print("CameraManager:set_camera_node( viewport_name= ", viewport_name, " tree_id=", tree_id, " node_name= ", node_name)
	end

	local old_tree_id = self._current_trees[viewport_name]

	self._current_trees[viewport_name] = tree_id

	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = camera_nodes[#camera_nodes]
	local tree = self._node_trees[viewport_name][tree_id]
	local next_node = {
		node = tree.nodes[node_name]
	}

	if current_node then
		local transition_template

		if old_tree_id ~= tree_id then
			local tree_transitions = current_node.node:tree_transitions()

			transition_template = tree_transitions[tree_id] or tree_transitions.default
		else
			local node_transitions = current_node.node:node_transitions()

			transition_template = node_transitions[next_node.node:name()] or node_transitions.default
		end

		if transition_template then
			self:_add_transition(viewport_name, current_node, next_node, transition_template)

			if transition_template.inherit_aim_rotation and old_tree_id ~= tree_id then
				local old_root = self._node_trees[viewport_name][old_tree_id].root_node
				local old_pitch = old_root:aim_pitch()
				local old_yaw = old_root:aim_yaw()

				tree.root_node:set_aim_pitch(old_pitch)
				tree.root_node:set_aim_yaw(old_yaw)
			end
		else
			next_node.transition = {}

			self:_remove_camera_node(camera_nodes, #camera_nodes)
		end
	else
		next_node.transition = {}
	end

	next_node.node:set_active(true)

	camera_nodes[#camera_nodes + 1] = next_node
end

function CameraManager:set_frozen(frozen)
	self._frozen = frozen
end

function CameraManager:_remove_camera_node(camera_nodes, index)
	for i = 1, index do
		local node_table = table.remove(camera_nodes, 1)

		node_table.node:set_active(false)
	end
end

function CameraManager:camera_position(viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_position(camera)
end

function CameraManager:camera_rotation(viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_rotation(camera)
end

function CameraManager:camera_pose(viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_pose(camera)
end

function CameraManager:fov(viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.vertical_fov(camera)
end

function CameraManager:aim_raycast_position(viewport_name)
	local position = self._aim_raycast_position[viewport_name]

	if position then
		return position:unbox()
	end
end

function CameraManager:aim_rotation(viewport_name)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self:_current_node(camera_nodes)
	local root_node = current_node:root_node()
	local aim_pitch = root_node:aim_pitch()
	local aim_yaw = root_node:aim_yaw()
	local rotation_pitch = Quaternion(Vector3(1, 0, 0), aim_pitch)
	local rotation_yaw = Quaternion(Vector3(0, 0, 1), aim_yaw)
	local aim_rotation = Quaternion.multiply(rotation_yaw, rotation_pitch)
	local pitch_offset = self._variables[viewport_name].pitch_offset

	if pitch_offset then
		local offset_aim_rotation = Quaternion.multiply(aim_rotation, Quaternion(Vector3(1, 0, 0), pitch_offset))

		return offset_aim_rotation
	else
		return aim_rotation
	end
end

function CameraManager:add_aim_raycast(world, viewport_name)
	local function aim_raycast_result(hit, pos, distance, normal, actor)
		self:aim_raycast_result(hit, pos, distance, normal, actor, viewport_name)
	end

	local physics_world = World.physics_world(world)
	local raycast = PhysicsWorld.make_raycast(physics_world, aim_raycast_result, "closest", "collision_filter", "ray_projectile")

	self._aim_raycast[viewport_name] = raycast
end

function CameraManager:remove_aim_raycast(viewport_name)
	self._aim_raycast[viewport_name] = nil
end

function CameraManager:_setup_child_nodes(node_table, viewport_name, tree_id, parent_node, settings, root_node)
	local node_settings = settings._node
	local node = self:_setup_node(node_settings, parent_node, root_node)

	root_node = root_node or node
	node_table[node:name()] = node

	for key, child_settings in pairs(settings) do
		if key ~= "_node" then
			self:_setup_child_nodes(node_table, viewport_name, tree_id, node, child_settings, root_node)
		end
	end

	return node
end

function CameraManager:_setup_node(node_settings, parent_node, root_node)
	local node_class = rawget(_G, node_settings.class)
	local node = node_class:new(root_node)

	node:parse_parameters(node_settings, parent_node)

	if parent_node then
		parent_node:add_child_node(node)
	end

	return node
end

function CameraManager:update(dt, viewport_name)
	self:_update_shadow_lights(dt, viewport_name)

	local node_trees = self._node_trees[viewport_name]
	local data = self._variables[viewport_name]
	local current_tree = self._node_trees[viewport_name][self._current_trees[viewport_name]]
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self:_current_node(camera_nodes)

	current_tree.root_node:update_pitch_yaw(dt, data, current_node, viewport_name)

	local yaw = current_tree.root_node:aim_yaw()
	local pitch = current_tree.root_node:aim_pitch()

	for tree_id, tree in pairs(node_trees) do
		if tree ~= current_tree then
			tree.root_node:set_aim_pitch(pitch)
			tree.root_node:set_aim_yaw(yaw)
		end
	end

	self:_update_environment_transitions(dt)
	self:_update_level_particle_effects(viewport_name)
end

function CameraManager:set_pitch_yaw(viewport_name, pitch, yaw)
	local node_trees = self._node_trees[viewport_name]

	for tree_id, tree in pairs(node_trees) do
		tree.root_node:set_aim_pitch(pitch)
		tree.root_node:set_aim_yaw(yaw)
	end
end

function CameraManager:set_variable(viewport_name, field, value)
	self._variables[viewport_name][field] = value
end

function CameraManager:variable(viewport_name, field)
	return self._variables[viewport_name][field]
end

function CameraManager:post_update(dt, viewport_name)
	if self._frozen then
		return
	end

	local node_trees = self._node_trees[viewport_name]
	local data = self._variables[viewport_name]

	for tree_id, tree in pairs(node_trees) do
		self:_update_nodes(dt, viewport_name, tree_id, data)
	end

	self:_update_camera(dt, viewport_name)
	self:_update_sound_listener(viewport_name)
	self:_update_aim_raycast_position(viewport_name)
end

local SWEEP_EPSILON = 0.001

function CameraManager:_smooth_camera_collision(camera_position, safe_position, smooth_radius, near_radius)
	local physics_world = World.physics_world(self._world)
	local cast_from = safe_position
	local cast_to = camera_position
	local dir = Vector3.normalize(cast_to - cast_from)
	local len = Vector3.length(cast_to - cast_from)
	local cast_distance = len
	local cast_radius = smooth_radius
	local drawer

	if script_data.camera_debug then
		drawer = Managers.state.debug:drawer({
			name = "Intersection"
		})

		drawer:reset()
	end

	while true do
		if cast_distance < SWEEP_EPSILON then
			return cast_from
		end

		self._hits = PhysicsWorld.linear_sphere_sweep(physics_world, cast_from, cast_to, cast_radius, 1, "types", "statics", "collision_filter", "camera_sweep")

		local last_pos = cast_from
		local hits = self._hits
		local hit

		if hits and #hits > 0 then
			for _, k in ipairs(hits) do
				local dir = Vector3.normalize(k.position - last_pos)
				local length = Vector3.length(last_pos - k.position)

				if script_data.camera_debug then
					drawer:vector(last_pos, k.position - last_pos, Color(0, 255, 0))
					drawer:sphere(k.position, 0.1, Color(0, 255, 0))
				end

				last_pos = k.position
			end

			hit = hits[1]

			local x = Vector3.dot(dir, hit.position - cast_from)
			local y = Vector3.length(hit.position - cast_from - x * dir)
			local cd

			if y < near_radius then
				cd = x
			else
				cd = x + (y - near_radius) / (smooth_radius - near_radius) * (len - x)
			end

			if cd < cast_distance then
				cast_distance = cd
				cast_to = cast_from + dir * cast_distance
			end

			if cast_radius - y < 0.05 then
				cast_radius = cast_radius - 0.05
			else
				cast_radius = y
			end
		else
			if script_data.camera_debug then
				drawer:sphere(cast_to, 0.2, Color(0, 0, 255))
			end

			return cast_to
		end
	end
end

function CameraManager:_update_aim_raycast_position(viewport_name)
	local aim_raycast = self._aim_raycast[viewport_name]

	if aim_raycast then
		local camera_position = self:camera_position(viewport_name)
		local camera_rotation = self:camera_rotation(viewport_name)

		aim_raycast:cast(camera_position, Quaternion.forward(camera_rotation), self.AIM_RAYCAST_LENGTH)
	end
end

function CameraManager:aim_raycast_result(hit, pos, distance, normal, actor, viewport_name)
	if hit then
		self._aim_raycast_position[viewport_name] = self._aim_raycast_position[viewport_name] or Vector3Box()

		self._aim_raycast_position[viewport_name]:store(pos)
	else
		self:_set_default_aim_position(viewport_name)
	end
end

function CameraManager:_set_default_aim_position(viewport_name)
	local camera_position = self:camera_position(viewport_name)
	local camera_rotation = self:camera_rotation(viewport_name)
	local position = camera_position + Quaternion.forward(camera_rotation) * self.AIM_RAYCAST_LENGTH

	self._aim_raycast_position[viewport_name] = self._aim_raycast_position[viewport_name] or Vector3Box()

	self._aim_raycast_position[viewport_name]:store(position)
end

function CameraManager:_update_nodes(dt, viewport_name, tree_id, data)
	local tree = self._node_trees[viewport_name][tree_id]
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self:_current_node(camera_nodes)

	tree.root_node:update(dt, data, current_node:pitch_speed(), current_node:yaw_speed())
end

function CameraManager:_current_node(camera_nodes)
	return camera_nodes[#camera_nodes].node
end

function CameraManager:camera_effect_sequence_event(event, start_time)
	local sequence_event_settings = self._sequence_event_settings
	local previous_values

	if sequence_event_settings.event then
		previous_values = sequence_event_settings.current_values
	end

	sequence_event_settings.start_time = start_time
	sequence_event_settings.event = CameraEffectSettings.sequence[event]
	sequence_event_settings.transition_function = CameraEffectSettings.transition_functions.lerp

	local duration = 0

	for modifier_type, modifiers in pairs(sequence_event_settings.event.values) do
		for index, settings in ipairs(modifiers) do
			if duration < settings.time_stamp then
				duration = settings.time_stamp
			end
		end
	end

	sequence_event_settings.end_time = start_time + duration

	if previous_values then
		local time_to_recover = sequence_event_settings.event.time_to_recuperate_to / 100 * duration

		sequence_event_settings.time_to_recover = time_to_recover
		sequence_event_settings.recovery_values = self:_calculate_sequence_event_values_normal(sequence_event_settings.event.values, time_to_recover)
		sequence_event_settings.previous_values = previous_values
	end
end

function CameraManager:camera_effect_shake_event(event, start_time)
	local data = {}
	local event = CameraEffectSettings.shake[event]
	local duration = event.duration

	data.event = event
	data.start_time = start_time
	data.end_time = duration and start_time + duration
	data.seed = event.seed or Math.random(1, 100)
	self._shake_event_settings[data] = true

	return data
end

function CameraManager:stop_camera_effect_shake_event(id)
	self._shake_event_settings[id] = nil
end

function CameraManager:_update_camera(dt, viewport_name)
	local t = Managers.time:time("game")
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self:_current_node(camera_nodes)
	local camera_data = self:_update_transition(viewport_name, camera_nodes, dt)

	if self._sequence_event_settings.event then
		camera_data = self:_apply_sequence_event(table.clone(camera_data), t)
	end

	for settings, _ in pairs(self._shake_event_settings) do
		camera_data = self:_apply_shake_event(settings, table.clone(camera_data), t)
	end

	self:_update_camera_properties(camera, current_node, camera_data, viewport_name)
	ScriptCamera.force_update(self._world, camera)
end

function CameraManager:_apply_sequence_event(current_data, t)
	local sequence_event_settings = self._sequence_event_settings
	local new_values

	if t < sequence_event_settings.time_to_recover + sequence_event_settings.start_time then
		new_values = self:_calculate_sequence_event_values_recovery(t)
	else
		local total_progress = t - sequence_event_settings.start_time
		local event_values = sequence_event_settings.event.values

		new_values = self:_calculate_sequence_event_values_normal(event_values, total_progress)
	end

	local new_data = current_data

	new_data.position = self:_calculate_sequence_event_position(current_data, new_values)
	new_data.rotation = self:_calculate_sequence_event_rotation(current_data, new_values)
	sequence_event_settings.current_values = new_values

	if t >= self._sequence_event_settings.end_time then
		sequence_event_settings.start_time = 0
		sequence_event_settings.end_time = 0
		sequence_event_settings.event = nil
		sequence_event_settings.current_values = nil
		sequence_event_settings.time_to_recover = 0
		sequence_event_settings.recovery_values = nil
		sequence_event_settings.transition_function = nil
	end

	return new_data
end

function CameraManager:_calculate_sequence_event_values_recovery(t)
	local new_values = {
		yaw = 0,
		z = 0,
		roll = 0,
		y = 0,
		pitch = 0,
		x = 0
	}
	local starting_values = self._sequence_event_settings.previous_values
	local recovery_values = self._sequence_event_settings.recovery_values
	local progress = (t - self._sequence_event_settings.start_time) / self._sequence_event_settings.time_to_recover

	for modifier, value in pairs(starting_values) do
		new_values[modifier] = math.lerp(value, recovery_values[modifier], progress)
	end

	return new_values
end

function CameraManager:_calculate_sequence_event_values_normal(event_values, total_progress)
	local new_values = {
		yaw = 0,
		z = 0,
		roll = 0,
		y = 0,
		pitch = 0,
		x = 0
	}

	for modifier_type, modifiers in pairs(event_values) do
		for index, settings in ipairs(modifiers) do
			if total_progress < settings.time_stamp then
				local next_settings = settings
				local current_settings = modifiers[index - 1] or CameraEffectSettings.empty_modifier_settings
				local progress = total_progress - current_settings.time_stamp
				local lerp_progress = progress / (next_settings.time_stamp - current_settings.time_stamp)

				new_values[modifier_type] = self._sequence_event_settings.transition_function(current_settings.value, next_settings.value, lerp_progress)

				break
			end
		end
	end

	return new_values
end

function CameraManager:_calculate_sequence_event_position(current_data, new_values)
	local current_pos = current_data.position
	local current_rot = current_data.rotation
	local x = new_values.x * Quaternion.right(current_rot)
	local y = new_values.y * Quaternion.forward(current_rot)
	local z = Vector3(0, 0, new_values.z)

	return current_pos + x + y + z
end

function CameraManager:_calculate_sequence_event_rotation(current_data, new_values)
	local current_rot = current_data.rotation
	local deg_to_rad = math.pi / 180
	local yaw_offset = Quaternion(Vector3.up(), new_values.yaw * deg_to_rad)
	local pitch_offset = Quaternion(Vector3.right(), new_values.pitch * deg_to_rad)
	local roll_offset = Quaternion(Vector3.forward(), new_values.roll * deg_to_rad)
	local total_offset = Quaternion.multiply(Quaternion.multiply(yaw_offset, pitch_offset), roll_offset)

	return Quaternion.multiply(current_rot, total_offset)
end

function CameraManager:_apply_shake_event(settings, current_data, t)
	local shake_event_settings = self._shake_event_settings
	local pitch_noise_value = self:_calculate_perlin_value(t - settings.start_time, settings)
	local yaw_noise_value = self:_calculate_perlin_value(t - settings.start_time + 10, settings)
	local new_data = current_data
	local current_rot = current_data.rotation
	local deg_to_rad = math.pi / 180
	local yaw_offset = Quaternion(Vector3.up(), yaw_noise_value * deg_to_rad)
	local pitch_offset = Quaternion(Vector3.right(), pitch_noise_value * deg_to_rad)
	local total_offset = Quaternion.multiply(yaw_offset, pitch_offset)

	new_data.rotation = Quaternion.multiply(current_rot, total_offset)

	if settings.end_time and t >= settings.end_time then
		self._shake_event_settings[settings] = nil
	end

	return new_data
end

function CameraManager:_calculate_perlin_value(x, settings)
	local total = 0
	local event_settings = settings.event
	local persistance = event_settings.persistance
	local number_of_octaves = event_settings.octaves

	for i = 0, number_of_octaves do
		local frequency = 2^i
		local amplitude = persistance^i

		total = total + self:_interpolated_noise(x * frequency, settings) * amplitude
	end

	local amplitude_multiplier = event_settings.amplitude or 1

	total = total * amplitude_multiplier

	return total
end

function CameraManager:_interpolated_noise(x, settings)
	local x_floored = math.floor(x)
	local remainder = x - x_floored
	local v1 = self:_smoothed_noise(x_floored, settings)
	local v2 = self:_smoothed_noise(x_floored + 1, settings)

	return math.lerp(v1, v2, remainder)
end

function CameraManager:_smoothed_noise(x, settings)
	return self:_noise(x, settings) / 2 + self:_noise(x - 1, settings) / 4 + self:_noise(x + 1, settings) / 4
end

function CameraManager:_noise(x, settings)
	local next_seed, _ = Math.next_random(x + settings.seed)
	local _, value = Math.next_random(next_seed)

	return value * 2 - 1
end

function CameraManager:apply_level_particle_effects(effects, viewport_name)
	for _, effect in ipairs(effects) do
		local world = self._world
		local effect_id = World.create_particles(world, effect, self:camera_position(viewport_name))

		self._level_particle_effect_ids[effect_id] = true
	end
end

function CameraManager:apply_level_screen_effects(effects, viewport_name)
	for _, effect in ipairs(effects) do
		local world = self._world
		local effect_id = World.create_particles(world, effect, Vector3(0, 0, 0))

		self._level_screen_effect_ids[effect_id] = true
	end
end

function CameraManager:_update_camera_properties(camera, current_node, camera_data, viewport_name)
	if camera_data.position then
		local root_unit, root_object = current_node:root_unit()
		local pos = camera_data.position

		if root_unit and Unit.alive(root_unit) then
			local safe_position_offset = current_node:safe_position_offset()
			local safe_pos = Unit.world_position(root_unit, root_object and Unit.node(root_unit, root_object) or 0) + safe_position_offset:unbox()

			pos = self:_smooth_camera_collision(camera_data.position, safe_pos, 0.35, 0.1)
		end

		ScriptCamera.set_local_position(camera, pos)
		LandscapeDecoration.move_observer(self._world, self._landscape_decoration_observers[viewport_name], pos)
		ScatterSystem.move_observer(World.scatter_system(self._world), self._scatter_system_observers[viewport_name], pos, camera_data.rotation)
	end

	if camera_data.yaw_speed then
		self._variables[viewport_name].yaw_speed = camera_data.yaw_speed
	end

	if camera_data.pitch_offset then
		self._variables[viewport_name].pitch_offset = camera_data.pitch_offset
	end

	if camera_data.pitch_speed then
		self._variables[viewport_name].pitch_speed = camera_data.pitch_speed
	end

	if camera_data.rotation then
		ScriptCamera.set_local_rotation(camera, camera_data.rotation)
	end

	if script_data.fov_override then
		Camera.set_vertical_fov(camera, math.pi * script_data.fov_override / 180)
	elseif camera_data.vertical_fov then
		Camera.set_vertical_fov(camera, camera_data.vertical_fov)
	end

	if camera_data.near_range then
		Camera.set_near_range(camera, camera_data.near_range)
	end

	if camera_data.far_range then
		Camera.set_far_range(camera, camera_data.far_range)
	end

	if camera_data.fade_to_black then
		self._variables[viewport_name].fade_to_black = camera_data.fade_to_black
	end

	self._shading_environment = camera_data.shading_environment
end

function CameraManager:_update_sound_listener(viewport_name)
	local world = self._world
	local viewport = ScriptWorld.viewport(world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local pose = Camera.world_pose(camera)
	local timpani_world = World.timpani_world(world)

	TimpaniWorld.set_listener(timpani_world, 0, pose)
end

function CameraManager:_add_transition(viewport_name, from_node, to_node, transition_template)
	local transition = {}

	for _, property in ipairs(self.NODE_PROPERTY_MAP) do
		local settings = transition_template[property]

		if settings then
			local duration = settings.duration
			local speed = settings.speed
			local transition_class = rawget(_G, settings.class)
			local instance = transition_class:new(from_node.node, to_node.node, duration, speed, settings)

			transition[property] = instance
		end
	end

	to_node.transition = transition
end

function CameraManager:_update_transition(viewport_name, nodes, dt)
	local values = {}
	local value

	for _, property in ipairs(self.NODE_PROPERTY_MAP) do
		for _, node_table in ipairs(nodes) do
			local transition = node_table.transition
			local transition_class = transition[property]

			if transition_class then
				local done

				value, done = transition_class:update(dt, value)

				if done then
					transition[property] = nil
				end
			else
				value = node_table.node[property](node_table.node)
			end
		end

		values[property] = value
		value = nil
	end

	local remove_from_index

	for index, node_table in ipairs(nodes) do
		if not next(node_table.transition) then
			remove_from_index = index - 1
		end
	end

	if remove_from_index and remove_from_index > 0 then
		self:_remove_camera_node(nodes, remove_from_index)
	end

	return values
end
