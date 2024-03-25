-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_executing.lua

require("scripts/unit_extensions/human/base/states/human_executing")

ExecutionHelper = ExecutionHelper or {}

function ExecutionHelper.pick_execution(attacker_unit, victim_unit, wielded_slots)
	local shield_slot = wielded_slots.shield
	local one_handed_slot = wielded_slots.one_handed_weapon
	local two_handed_slot = wielded_slots.two_handed_weapon
	local dagger_slot = wielded_slots.dagger

	if shield_slot then
		if shield_slot.gear:settings().small_shield then
			return "dagger_fallback"
		end

		return "shield"
	elseif two_handed_slot then
		if two_handed_slot.gear:settings().gear_type == "two_handed_axe" then
			return "two_handed_axe"
		elseif two_handed_slot.gear:settings().gear_type == "two_handed_sword" then
			return "sword_omni"
		end
	elseif one_handed_slot and one_handed_slot.gear:settings().gear_type == "one_handed_sword" then
		return "sword_omni"
	elseif wielded_slots.dagger then
		return "dagger"
	end

	return "dagger_fallback"
end

function ExecutionHelper.play_execution_attacker_anims(attacker_unit, victim_unit, execution_definition)
	Unit.animation_event(attacker_unit, execution_definition.attacker_anim_event)
	Unit.set_data(attacker_unit, "execution_events", execution_definition.attacker_events)
	Unit.set_data(attacker_unit, "execution_victim", victim_unit)
end

function ExecutionHelper.play_execution_victim_anims(victim_unit, attacker_unit, execution_definition)
	Unit.animation_event(victim_unit, execution_definition.victim_anim_event)
	Unit.set_data(victim_unit, "execution_events", execution_definition.victim_events)
	Unit.set_data(victim_unit, "execution_attacker", attacker_unit)
end

function ExecutionHelper.play_execution_abort_anim(victim_unit)
	Unit.animation_event(victim_unit, "execute_victim_interrupt")
	Unit.set_data(victim_unit, "execution_events", nil)
end

function ExecutionHelper.attacker_event(attacker_unit, event_name)
	local events = Unit.get_data(attacker_unit, "execution_events")

	if not events then
		return
	end

	local event = events[event_name]

	if not event then
		return
	end

	local victim_unit = Unit.get_data(attacker_unit, "execution_victim")

	if not Unit.alive(victim_unit) then
		return
	end

	if event then
		ExecutionHelper.play_effects(attacker_unit, victim_unit, event, event_name)
	end
end

function ExecutionHelper.victim_event(victim_unit, event_name)
	local events = Unit.get_data(victim_unit, "execution_events")

	if not events then
		return
	end

	local event = events[event_name]

	if not event then
		return
	end

	if event then
		ExecutionHelper.play_effects(victim_unit, victim_unit, event, event_name)
	end
end

function ExecutionHelper.play_effects(effect_unit, armour_unit, event, event_name)
	local body_armour_type = Unit.get_data(armour_unit, "armour_type")
	local helmet_armour_type = Unit.get_data(armour_unit, "helmet_armour_type")
	local world = Managers.world:world("level_world")

	for effect_number, effect in ipairs(event) do
		local effect_type = effect.type

		fassert(effect_type, "Missing effect type in effect number %i in event %s in execution", effect_number, event_name)

		local armour_type = effect.armour_location == "head" and helmet_armour_type or body_armour_type

		if effect_type == "particle" then
			local particle_names = effect.particle_name
			local particle = particle_names[armour_type] or particle_names.default

			if particle then
				local rotation_offset = effect.offset_rotation and effect.offset_rotation:unbox() or Quaternion.identity()
				local position_offset = effect.offset_position and effect.offset_position:unbox() or Vector3.zero()

				if script_data.execution_debug then
					print("[ExecutionHelper.play_effects()] Playing particle ", particle, " on unit ", effect_unit, " and node ", effect.node)
				end

				ScriptWorld.create_particles_linked(world, particle, effect_unit, Unit.node(effect_unit, effect.node), "stop", Matrix4x4.from_quaternion_position(rotation_offset, position_offset))
			end
		elseif effect_type == "sound" then
			local event = effect.event
			local timpani_world = World.timpani_world(world)

			if script_data.execution_debug then
				print("[ExecutionHelper.play_effects()] Playing sound event ", event, " on unit ", effect_unit, " and node ", effect.node)
			end

			local event_id = TimpaniWorld.trigger_event(timpani_world, event, Unit.world_position(effect_unit, Unit.node(effect_unit, effect.node)))

			if event_id then
				local armour_type_short = string.sub(armour_type, 8)

				TimpaniWorld.set_parameter(timpani_world, event_id, "armour_type", armour_type_short)

				if effect.voice then
					local voice = ScriptUnit.extension(effect_unit, "locomotion_system"):inventory():voice()

					TimpaniWorld.set_parameter(timpani_world, event_id, "character_vo", voice)
				end
			else
				print("[ExecutionHelper.play_effects()] Failed to play execution sound event ", event)
			end
		end
	end
end

PlayerExecuting = class(PlayerExecuting, HumanExecuting)

function PlayerExecuting:enter(old_state, target_unit, t)
	PlayerExecuting.super.enter(self, old_state, target_unit, t)

	local internal = self._internal
	local inventory = internal:inventory()
	local wielded_slots = inventory:wielded_slots()
	local execution = ExecutionHelper.pick_execution(self._unit, self._target_unit, wielded_slots)

	self._execution = execution

	local network_manager = Managers.state.network

	self._target_unit_game_object_id = network_manager:game_object_id(self._target_unit)

	local execution_definition = ExecutionDefinitions[execution]

	if execution_definition.hide_wielded_weapons then
		for name, slot in pairs(wielded_slots) do
			slot.gear:hide_gear("execution")
		end
	end

	if Managers.lobby.lobby and network_manager:game() then
		InteractionHelper:request("execute", internal, internal.id, network_manager:game_object_id(target_unit), NetworkLookup.executions[execution])
	elseif not Managers.lobby.lobby then
		-- block empty
	end

	self._camera = ExecutionDefinitions[execution].attacker_camera
end

function PlayerExecuting:update(dt, t)
	if not Unit.alive(self._target_unit) then
		self:change_state("onground")

		return
	end

	self:_update_position(dt, t)
	PlayerExecuting.super.update(self, dt, t)

	local execution_time = self._execution_time

	if execution_time then
		self:_update_execution(t - execution_time, dt)
	end
end

function PlayerExecuting:_update_position(dt, t)
	self:_set_execution_pose(self._target_unit, ExecutionDefinitions[self._execution], dt)
	self:update_lerped_rotation(dt)
end

function PlayerExecuting:_set_execution_pose(victim_unit, execution_definition, dt)
	local position_offset = execution_definition.attacker_position_offset:unbox()
	local local_rotation_target = Unit.local_rotation(victim_unit, 0)
	local local_position_target = Unit.local_position(victim_unit, 0)
	local local_position_attacker = Unit.local_position(self._unit, 0)
	local world_position_offset = position_offset.x * Quaternion.right(local_rotation_target) + position_offset.y * Quaternion.forward(local_rotation_target)
	local attacker_rotation = Quaternion.look(-world_position_offset, Vector3.up())
	local attacker_position = local_position_target + world_position_offset

	self:set_local_position(attacker_position)
	self:update_aim_rotation()
	self:set_world_rotation(attacker_rotation)
	self._internal.velocity:store(Vector3(0, 0, 0))
end

function PlayerExecuting:_update_execution(execution_t, dt)
	local curve_data = self._animation_curves_data

	if curve_data then
		curve_data.t = execution_t

		local camera_manager = Managers.state.camera
		local viewport_name = self._internal.player.viewport_name

		if not viewport_name then
			return
		end

		camera_manager:set_variable(viewport_name, "execution_attacker_anim_curves", curve_data)
	end
end

function PlayerExecuting:exit(...)
	PlayerExecuting.super.exit(self, ...)

	self._internal.execute_camera = nil

	local execution = ExecutionDefinitions[self._execution]

	if execution and execution.hide_wielded_weapons then
		local internal = self._internal
		local inventory = internal:inventory()
		local wielded_slots = inventory:wielded_slots()

		for _, slot in pairs(wielded_slots) do
			slot.gear:unhide_gear("execution")
		end
	end

	self:set_local_position(Mover.position(Unit.mover(self._unit)))
end

function PlayerExecuting:_exit_on_fail()
	PlayerExecuting.super._exit_on_fail(self)

	local internal = self._internal
	local network_manager = Managers.state.network

	if Managers.lobby.lobby and network_manager:game() then
		InteractionHelper:abort("execute", internal, internal.id, self._target_unit_game_object_id)
	elseif not Managers.lobby.lobby then
		-- block empty
	end
end

function PlayerExecuting:interaction_confirmed()
	PlayerExecuting.super.interaction_confirmed(self)

	if Unit.alive(self._target_unit) then
		self:_begin_execution()
	else
		self:change_state("onground")
	end
end

function PlayerExecuting:_begin_execution()
	local attacker_unit = self._unit
	local victim_unit = self._target_unit
	local execution_definition = ExecutionDefinitions[self._execution]

	self:_set_execution_pose(victim_unit, execution_definition)
	ExecutionHelper.play_execution_attacker_anims(attacker_unit, victim_unit, execution_definition)

	self._internal.execute_camera = self._camera
	self._animation_curves_data = table.clone(execution_definition.attacker_animation_curves_data)
	self._animation_curves_data.resource = AnimationCurves(self._animation_curves_data.resource)
	self._execution_time = Managers.time:time("game")

	ScriptUnit.extension(victim_unit, "locomotion_system"):start_execution_victim(execution_definition, attacker_unit)
end
