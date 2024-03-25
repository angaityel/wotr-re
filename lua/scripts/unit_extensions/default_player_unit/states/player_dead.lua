-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_dead.lua

require("scripts/unit_extensions/human/base/states/human_dead")

PlayerDead = class(PlayerDead, HumanDead)

function PlayerDead:init(unit, internal, world)
	self._unit = unit
	self._internal = internal
	self._world = world
end

function PlayerDead:anim_event(event, force_local)
	local internal = self._internal

	if internal.frozen then
		return
	end

	local unit = self._unit
	local event_id = NetworkLookup.anims[event]

	fassert(event_id, "[PlayerMovementStatebase:anim_event()] Network synked event %q does not exist in network_lookup.lua.", event)

	if not force_local and internal.game and internal.id then
		if Managers.lobby.server then
			Managers.state.network:send_rpc_clients("rpc_anim_event", event_id, internal.id)
		else
			Managers.state.network:send_rpc_server("rpc_anim_event", event_id, internal.id)
		end
	end

	Unit.animation_event(unit, event)
end

function PlayerDead:update(dt, t, context)
	local unit = self._unit

	self:update_movement(dt)

	self._despawn_timer = self._despawn_timer + dt

	if not self._despawned and self._despawn_timer > PlayerUnitDamageSettings.dead_player_destroy_time then
		Managers.player:relinquish_unit_ownership(unit)

		local network_manager = Managers.state.network

		if network_manager:game() then
			local object_id = network_manager:unit_game_object_id(unit)

			network_manager:destroy_game_object(object_id)
		else
			Managers.state.entity:unregister_unit(unit)
			World.destroy_unit(self._world, unit)
		end

		Managers.state.event:trigger("dead_player_unit_despawned", self._internal.player)

		self._despawned = true
	end
end

function PlayerDead:anim_cb_knockdown_finished()
	return
end

function PlayerDead:update_movement(dt)
	return
end

function PlayerDead:set_local_position(pos)
	local internal = self._internal

	Unit.set_local_position(self._unit, 0, pos)

	if internal.game and internal.id and Vector3.length(pos) < 1000 then
		GameSession.set_game_object_field(internal.game, internal.id, "position", pos)
	end
end

function PlayerDead:set_local_rotation(rot)
	local internal = self._internal

	Unit.set_local_rotation(self._unit, 0, rot)

	if internal.game and internal.id then
		GameSession.set_game_object_field(internal.game, internal.id, "rotation", rot)
	end
end

function PlayerDead:post_update(dt)
	local push = self._instakill_push

	if push then
		self:_apply_instakill_push(push)

		self._instakill_push = nil
	end
end

function PlayerDead:enter(old_state, instakill, damage_type, hit_zone, impact_direction)
	local unit = self._unit

	self._despawn_timer = 0
	self._despawned = false

	local internal = self._internal

	Managers.state.event:trigger("event_sprint_hud_deactivated", internal.player)

	internal.sprint_hud_blackboard = nil

	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(unit, "viewport_name")

	Unit.set_data(unit, "camera", "settings_tree", "player_dead")
	Unit.set_data(unit, "camera", "settings_node", "default")
	camera_manager:set_node_tree_root_unit(viewport_name, "player_dead", unit)

	local damage_ext = ScriptUnit.extension(unit, "damage_system")

	if damage_ext.wounded_camera_effect_active then
		World.destroy_particles(self._world, damage_ext.wounded_camera_particle_effect_id)

		damage_ext.wounded_camera_particle_effect_id = nil

		camera_manager:stop_camera_effect_shake_event(damage_ext.wounded_camera_shake_effect_id)

		damage_ext.wounded_camera_shake_effect_id = nil
		damage_ext.wounded_camera_effect_active = false
	end

	if not internal.yielded then
		if instakill and hit_zone == "head" and (damage_type == "cutting" or damage_type == "slashing") and GameSettingsDevelopment.allow_decapitation then
			local inventory = internal:inventory()
			local allow_decapitation = inventory:allow_decapitation()

			if allow_decapitation then
				self:anim_event("death_decap")

				local head_unit = inventory:head()

				if head_unit and Unit.alive(head_unit) then
					Unit.set_visibility(head_unit, "head_decap", true)
					Unit.set_visibility(head_unit, "head_all", false)

					local unit = self._unit
					local actor = Unit.create_actor(unit, "decap_head", 0.9)

					Unit.set_visibility(unit, "decapitated", true)
					Unit.set_visibility(unit, "undecapitated", false)

					local impulse = impact_direction * 2 * 0.001

					Actor.add_impulse_at(actor, impulse, Vector3(0, 0, -0.1))
					Actor.add_impulse_at(actor, Vector3(0, 0, 0.006), Vector3(0, 0, -0.1))
				end
			else
				self:anim_event("death")
				self:_add_instakill_push(hit_zone, impact_direction)
			end
		else
			self:anim_event("death")
			self:_add_instakill_push(hit_zone, impact_direction)
		end
	end
end

function PlayerDead:_add_instakill_push(hit_zone_name, impact_direction)
	if PlayerUnitDamageSettings.hit_zones[hit_zone_name] then
		local velocity = impact_direction * 40
		local mass = 15

		self._instakill_push = {
			hit_zone_name = hit_zone_name,
			velocity = velocity,
			mass = mass
		}

		local internal = self._internal
		local game, id = internal.game, internal.id

		if game and id then
			Managers.state.network:send_rpc_server("rpc_add_instakill_push", id, velocity, mass, NetworkLookup.hit_zones[hit_zone_name])
		end
	end
end

function PlayerDead:_apply_instakill_push(push_data)
	local hit_zone_name = push_data.hit_zone_name
	local hit_zone = PlayerUnitDamageSettings.hit_zones[hit_zone_name]
	local ragdoll_actor = hit_zone.ragdoll_actor
	local actor = Unit.actor(self._unit, ragdoll_actor)
	local velocity = push_data.velocity
	local mass = push_data.mass

	Actor.push(actor, velocity, push_data.mass)
end

function PlayerDead:exit(new_state)
	return
end

function PlayerDead:destroy()
	return
end

function PlayerDead:change_state(new_state)
	return
end

function PlayerDead:anim_cb_ready_arrow()
	local internal = self._internal

	internal.reloading = false
	internal.reload_slot_name = nil
end

function PlayerDead:anim_cb_wield()
	return
end

function PlayerDead:anim_cb_wield_finished()
	return
end

function PlayerDead:wielded_weapon_destroyed(slot_name)
	return
end

function PlayerDead:anim_cb_bow_action_finished()
	return
end

function PlayerDead:anim_cb_bow_draw_finished()
	return
end
