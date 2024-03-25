-- chunkname: @scripts/helpers/effect_helper.lua

require("scripts/settings/material_effect_mappings")

EffectHelper = EffectHelper or {}
EffectHelper.temporary_material_drawer_mapping = {}

function EffectHelper.play_surface_material_effects(effect_name, world, unit, position, rotation, normal)
	local effect_settings = MaterialEffectMappings[effect_name]
	local decal_settings = effect_settings.decal and effect_settings.decal.settings

	if decal_settings then
		local projector_rotation = Quaternion.look(-normal, Quaternion.up(rotation))
		local projector_depth_offset = decal_settings.depth_offset and Quaternion.forward(rotation) * decal_settings.depth_offset or Vector3(0, 0, 0)
		local projection_position = position + projector_depth_offset
		local projector_space = Matrix4x4.from_quaternion_position(projector_rotation, projection_position)
		local projector_extents = Vector3(decal_settings.width, decal_settings.depth, decal_settings.height)
		local id

		if decal_settings.override then
			id = Unit.project_decal(unit, projector_space, projector_extents, decal_settings.override)
		else
			local material_drawer_mapping = EffectHelper.create_surface_material_drawer_mapping(effect_name)

			id = Unit.project_decal(unit, projector_space, projector_extents, "surface_material", material_drawer_mapping)
		end

		if script_data.debug_material_effects then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "DEBUG_DRAW_IMPACT_DECAL_HIT"
			})
			local drawer_space = Matrix4x4.from_quaternion_position(projector_rotation, projection_position + Quaternion.forward(projector_rotation) * decal_settings.depth / 2)
			local drawer_extents = Vector3(decal_settings.width / 2, decal_settings.depth / 2, decal_settings.height / 2)

			drawer:box(drawer_space, drawer_extents, Color(50, 0, 255, 0))
		end
	end

	local query_forward = Quaternion.forward(rotation)
	local query_vector = query_forward * MaterialEffectSettings.material_query_depth
	local query_start_position = position - query_vector / 2
	local query_end_position = position + query_vector / 2
	local material_ids = Unit.query_material(unit, query_start_position, query_end_position, {
		"surface_material"
	})
	local material

	if not material_ids or not material_ids[1] then
		material = DefaultSurfaceMaterial
	else
		material = MaterialIDToName.surface_material[material_ids[1]]

		if not material and script_data.debug_material_effects then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "DEBUG_DRAW_IMPACT_DECAL_HIT"
			})

			drawer:vector(query_start_position, query_vector, Color(255, 255, 0, 0))
		elseif script_data.debug_material_effects then
			table.dump(material_ids)
		end
	end

	if script_data.debug_material_effects and material then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "DEBUG_DRAW_IMPACT_DECAL_HIT"
		})

		drawer:vector(query_start_position, query_vector, Color(255, 0, 255, 0))
		Managers.state.debug_text:output_world_text(material, 0.1, query_start_position, 30, "material_text", Vector3(0, 255, 0))
	end

	local sound = effect_settings.sound and effect_settings.sound[material]

	if sound then
		local timpani_world = World.timpani_world(world)
		local event_id = TimpaniWorld.trigger_event(timpani_world, sound.event, position)

		if event_id and sound.parameters then
			for parameter_name, parameter_value in pairs(sound.parameters) do
				TimpaniWorld.set_parameter(timpani_world, event_id, parameter_name, parameter_value)
			end
		end
	end

	local particles = effect_settings.particles and effect_settings.particles[material]

	if particles then
		local normal_rotation = Quaternion.look(normal, Vector3.up())

		World.create_particles(world, particles, position, normal_rotation)
	end
end

function EffectHelper.remote_play_surface_material_effects(effect_name, world, unit, position, rotation, normal)
	local network_manager = Managers.state.network
	local level = LevelHelper:current_level(world)
	local unit_level_index = Level.unit_index(level, unit)
	local unit_game_object_id = network_manager:unit_game_object_id(unit)
	local effect_name_id = NetworkLookup.surface_material_effects[effect_name]

	if unit_game_object_id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_surface_mtr_fx", effect_name_id, unit_game_object_id, position, rotation, Vector3.normalize(normal))
		else
			network_manager:send_rpc_server("rpc_surface_mtr_fx", effect_name_id, unit_game_object_id, position, rotation, Vector3.normalize(normal))
		end
	elseif unit_level_index then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_surface_mtr_fx_lvl_unit", effect_name_id, unit_level_index, position, rotation, Vector3.normalize(normal))
		else
			network_manager:send_rpc_server("rpc_surface_mtr_fx_lvl_unit", effect_name_id, unit_level_index, position, rotation, Vector3.normalize(normal))
		end
	end
end

function EffectHelper.create_surface_material_drawer_mapping(effect_name)
	local material_drawer_mapping = MaterialEffectMappings[effect_name].decal.material_drawer_mapping

	for _, material in ipairs(MaterialEffectSettings.material_contexts.surface_material) do
		local drawer

		if type(material_drawer_mapping[material]) == "string" then
			drawer = material_drawer_mapping[material]
		elseif type(material_drawer_mapping[material]) == "table" then
			local num_drawers = #material_drawer_mapping[material]
			local drawer_num = math.random(1, num_drawers)

			drawer = material_drawer_mapping[material][drawer_num]
		else
			drawer = nil
		end

		EffectHelper.temporary_material_drawer_mapping[material] = drawer
	end

	return EffectHelper.temporary_material_drawer_mapping
end

function EffectHelper.flow_cb_play_footstep_surface_material_effects(effect_name, unit, object, foot_direction)
	local foot_node_index = Unit.node(unit, object)
	local raycast_position = Unit.world_position(unit, foot_node_index)
	local raycast_direction = Vector3(0, 0, -1)
	local raycast_range = MaterialEffectSettings.footstep_raycast_max_range
	local world = Managers.world:world("level_world")
	local physics_world = World.physics_world(world)
	local hit_cb = callback(EffectHelper, "footstep_raycast_result", effect_name, foot_direction)

	PhysicsWorld.make_raycast(physics_world, hit_cb, "closest", "types", "statics"):cast(raycast_position + Vector3(0, 0, 0.05), raycast_direction, raycast_range, world)
end

function EffectHelper:footstep_raycast_result(effect_name, foot_direction, hit, position, distance, normal, actor)
	if hit then
		local hit_unit = Actor.unit(actor)
		local world = Managers.world:world("level_world")
		local rotation = Quaternion.look(Vector3(0, 0, -1), foot_direction)

		EffectHelper.play_surface_material_effects(effect_name, world, hit_unit, position, rotation, normal)
	end
end
