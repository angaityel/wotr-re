-- chunkname: @scripts/unit_extensions/weapons/weapon_ranged_projectile_base.lua

require("scripts/unit_extensions/weapons/weapon_ranged_base")

WeaponRangedProjectileBase = class(WeaponRangedProjectileBase, WeaponRangedBase)

function WeaponRangedProjectileBase:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	WeaponRangedProjectileBase.super.init(self, world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)

	self._projectile_dummy_unit = nil
	self._projectile_dummy_unit_visible = false

	local settings = self._settings

	self._attachments = attachments
	self._properties = properties
	self._attachment_multipliers = attachment_multipliers

	local attachment_multipliers = self._attachment_multipliers

	self._maximum_ammo = settings.starting_ammo * attachment_multipliers.amunition_amount
	self._current_ammo = self._maximum_ammo

	self:_spawn_projectile_dummy(self._projectile_name)
	self:_hide_projectile_dummy()

	self._hud_ammo_counter_blackboard = {
		timer = 0,
		text = self._current_ammo,
		maximum_ammo = self._maximum_ammo
	}
	self._game = Managers.state.network:game()
end

function WeaponRangedProjectileBase:_projectile_properties_id(properties)
	local network_value = 0
	local network_properties = NetworkLookup.weapon_properties

	for _, prop in ipairs(properties) do
		for index, net_prop in ipairs(network_properties) do
			if net_prop == prop then
				network_value = network_value + 2^(index - 1)
			end
		end
	end

	return network_value
end

function WeaponRangedProjectileBase:_spawn_projectile_dummy(projectile_name)
	local unit = self._unit
	local user_unit = self._user_unit
	local projectile_settings = self._projectile_settings
	local projectile_attachment = WeaponHelper:attachment_settings(self._gear_name, "projectile_head", self._projectile_name)
	local projectile_dummy_unit = World.spawn_unit(self._world, projectile_attachment.dummy_unit)
	local user_link_node = Unit.node(user_unit, projectile_settings.parent_link_node)
	local user_link_pose = Unit.local_pose(user_unit, user_link_node)

	Unit.set_local_pose(projectile_dummy_unit, 0, user_link_pose)
	World.link_unit(self._world, projectile_dummy_unit, user_unit, user_link_node)

	self._projectile_dummy_unit = projectile_dummy_unit
	self._projectile_dummy_unit_visible = true
end

function WeaponRangedProjectileBase:_show_projectile_dummy()
	Unit.set_unit_visibility(self._projectile_dummy_unit, true)
	Unit.flow_event(self._projectile_dummy_unit, "spawn_projectile_effect")

	self._projectile_dummy_unit_visible = true
end

function WeaponRangedProjectileBase:_hide_projectile_dummy()
	Unit.set_unit_visibility(self._projectile_dummy_unit, false)
	Unit.flow_event(self._projectile_dummy_unit, "despawn_projectile_effect")

	self._projectile_dummy_unit_visible = false
end

function WeaponRangedProjectileBase:ready_projectile(slot_name)
	WeaponRangedProjectileBase.super.ready_projectile(self, slot_name)
	self:_show_projectile_dummy()
end

function WeaponRangedProjectileBase:release_projectile(slot_name, draw_time)
	WeaponRangedProjectileBase.super.release_projectile(self, slot_name, draw_time)

	if self._player_gear and not script_data.unlimited_ammo then
		self._current_ammo = self._current_ammo - 1

		if self._game then
			GameSession.set_game_object_field(self._game, self._game_object_id, "ammunition", self._current_ammo)
		end
	end

	self:_hide_projectile_dummy()
	self:_play_fire_sound()
end

function WeaponRangedProjectileBase:enter_ghost_mode()
	WeaponRangedProjectileBase.super.enter_ghost_mode(self)

	if self._projectile_dummy_unit then
		self:_hide_projectile_dummy()
	end
end

function WeaponRangedProjectileBase:exit_ghost_mode()
	WeaponRangedProjectileBase.super.exit_ghost_mode(self)
end

function WeaponRangedProjectileBase:update(dt, t)
	return
end

function WeaponRangedProjectileBase:_update_ammunition(dt, t)
	if not self._husk_gear then
		local user_unit = self._user_unit

		if not Unit.alive(user_unit) then
			return
		end

		local enc_multiplier = ScriptUnit.has_extension(user_unit, "locomotion_system") and PlayerUnitMovementSettings.encumbrance.functions.ammo_regen_rate(ScriptUnit.extension(user_unit, "locomotion_system"):inventory():encumbrance()) or 1

		if ScriptUnit.has_extension(user_unit, "area_buff_system") then
			local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")
			local ammo_regen_rate = self._settings.ammo_regen_rate * self._attachment_multipliers.amunition_regeneration * area_buff_ext:buff_multiplier("replenish") * enc_multiplier

			if self._current_ammo < self._maximum_ammo then
				self._current_ammo = self._current_ammo + dt * ammo_regen_rate
				self._hud_ammo_counter_blackboard.timer = self._current_ammo - math.floor(self._current_ammo)

				if self._game and self._player_gear then
					GameSession.set_game_object_field(self._game, self._game_object_id, "ammunition", math.floor(self._current_ammo))
				end
			elseif self._current_ammo > self._maximum_ammo then
				self._current_ammo = self._maximum_ammo
			end

			self._hud_ammo_counter_blackboard.text = math.floor(self._current_ammo)
		end
	else
		self._current_ammo = GameSession.game_object_field(self._game, self._game_object_id, "ammunition")
	end
end

function WeaponRangedProjectileBase:set_wielded(wielded)
	if not wielded and self._projectile_dummy_unit then
		self:_hide_projectile_dummy()
	end
end

function WeaponRangedProjectileBase:set_faux_unwielded(unwielded)
	if unwielded and self._projectile_dummy_unit then
		self:_hide_projectile_dummy()
	elseif self._projectile_dummy_unit then
		self:_show_projectile_dummy()
	end
end

function WeaponRangedProjectileBase:_destroy_projectile_dummy()
	local unit = self._projectile_dummy_unit

	if unit then
		World.unlink_unit(self._world, unit)
		World.destroy_unit(self._world, unit)

		self._projectile_dummy_unit = nil
		self._projectile_dummy_unit_visible = false
	end
end

function WeaponRangedProjectileBase:has_visible_projectile()
	return self._projectile_dummy_unit and Unit.alive(self._projectile_dummy_unit) and self._projectile_dummy_unit_visible
end

function WeaponRangedProjectileBase:hot_join_synch(sender, player, player_object_id, slot_name)
	if self:has_visible_projectile() then
		RPC.rpc_synch_ready_projectile(sender, player_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.projectiles[self._projectile_name])
	end
end

function WeaponRangedProjectileBase:uses_ammo()
	return true
end

function WeaponRangedProjectileBase:can_reload()
	return math.floor(self._current_ammo) > 0
end

function WeaponRangedProjectileBase:destroy()
	self:_destroy_projectile_dummy()
	Managers.state.event:trigger("event_hud_ammo_counter_deactivated", self._player)
end
