-- chunkname: @scripts/unit_extensions/default_player_unit/player_unit_interaction.lua

PlayerUnitInteraction = class(PlayerUnitInteraction)
PlayerUnitInteraction.SYSTEM = "interaction_system"

function PlayerUnitInteraction:init(world, unit, player_index)
	self._interaction_targets = {}
	self._interaction_target = nil
	self._interaction_type = nil
	self._unit = unit
	self._locomotion = ScriptUnit.extension(unit, "locomotion_system")
	self._player = Managers.player:player(player_index)
end

function PlayerUnitInteraction:update(unit, input, dt, context, t)
	self:_update_target(t)
end

function PlayerUnitInteraction:get_interaction_target()
	if self._interaction_target and not Unit.alive(self._interaction_target) then
		self:_clear_interaction_target()
	end

	return self._interaction_target, self._interaction_type
end

function PlayerUnitInteraction:flow_cb_add_interaction_target(unit, actor)
	self._interaction_targets[unit] = true
end

function PlayerUnitInteraction:flow_cb_remove_interaction_target(unit, actor)
	self._interaction_targets[unit] = nil

	if unit == self._interaction_target then
		self:_clear_interaction_target()
	end
end

function PlayerUnitInteraction:_set_interaction_target(unit, type)
	self._player.state_data.interaction = "interact_" .. tostring(Unit.get_data(unit, "interacts", type))
	self._interaction_target = unit
	self._interaction_type = type
end

function PlayerUnitInteraction:_clear_interaction_target()
	self._player.state_data.interaction = nil
	self._interaction_target = nil
	self._interaction_type = nil
end

function PlayerUnitInteraction:_update_target(t)
	self:_clear_interaction_target()

	for _, interact_type in ipairs(PlayerUnitMovementSettings.interaction.priorities) do
		for unit, _ in pairs(self._interaction_targets) do
			if Unit.alive(unit) then
				if self:_can_interact(unit, interact_type, t) then
					self:_set_interaction_target(unit, interact_type, t)

					return
				end
			else
				self._interaction_targets[unit] = nil
			end
		end
	end
end

function PlayerUnitInteraction:_can_interact(unit, interact_type, t)
	return Unit.has_data(unit, "interacts", interact_type) and self[interact_type](self, unit, t)
end

function PlayerUnitInteraction:mount(unit, t)
	local player_manager = Managers.player
	local owner = player_manager:owner(unit)
	local locomotion = self._locomotion
	local mount_damage_ext = ScriptUnit.extension(unit, "damage_system")
	local mount_locomotion_ext = ScriptUnit.extension(unit, "locomotion_system")
	local can_mount_on_network = true
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if game then
		local spawner_id = GameSession.game_object_field(game, mount_locomotion_ext.id, "spawner_unit_id")
		local spawner = network_manager:game_object_unit(spawner_id)
		local spawner_player = player_manager:owner(spawner)

		if spawner and Unit.alive(spawner) and spawner ~= self._unit and spawner_player.team == self._player.team then
			can_mount_on_network = false
		end
	end

	local can_mount = locomotion:can("can_mount", t)

	return can_mount and not mount_damage_ext:is_dead() and not owner and not locomotion.mounted_unit and can_mount_on_network
end

function PlayerUnitInteraction:dismount(unit, t)
	local player_manager = Managers.player
	local owner = player_manager:owner(unit)
	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")
	local mount_damage_ext = ScriptUnit.extension(unit, "damage_system")
	local can_unmount = locomotion:can("can_unmount", t)

	return can_unmount and not mount_damage_ext:is_dead() and locomotion.mounted_unit and owner == self._player
end

function PlayerUnitInteraction:revive(unit, t)
	local player_manager = Managers.player
	local owner = player_manager:owner(unit)
	local damage_ext = ScriptUnit.extension(unit, "damage_system")
	local can_revive = self._locomotion:can("can_revive", t)

	return can_revive and damage_ext:can_be_revived() and owner and owner.team == self._player.team
end

function PlayerUnitInteraction:execute(unit, t)
	local player_manager = Managers.player
	local owner = player_manager:owner(unit)
	local damage_ext = ScriptUnit.extension(unit, "damage_system")
	local can_execute = self._locomotion:can("can_execute", t)

	return can_execute and damage_ext:can_be_executed() and owner and owner.team ~= self._player.team
end

function PlayerUnitInteraction:bandage(unit, t)
	local player_manager = Managers.player
	local owner = player_manager:owner(unit)
	local damage_ext = ScriptUnit.extension(unit, "damage_system")
	local can_bandage = self._locomotion:can("can_bandage", t)

	return can_bandage and damage_ext:can_be_bandaged() and damage_ext:is_wounded() and owner and owner.team == self._player.team
end

function PlayerUnitInteraction:climb(unit, t)
	return self._locomotion:can("can_climb", t)
end

function PlayerUnitInteraction:flag_spawn(unit, t)
	local objective_ext = ScriptUnit.extension(unit, "objective_system")

	return objective_ext:can_spawn_flag(self._unit)
end

function PlayerUnitInteraction:flag_plant(unit, t)
	local objective_ext = ScriptUnit.extension(unit, "objective_system")
	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	return objective_ext:can_plant_flag(self._unit) and locomotion.carried_flag
end

function PlayerUnitInteraction:flag_pickup(unit, t)
	local flag_ext = ScriptUnit.extension(unit, "flag_system")

	return flag_ext:can_be_picked_up(self._unit)
end

function PlayerUnitInteraction:flag_drop(unit, t)
	local flag_ext = ScriptUnit.extension(unit, "flag_system")
	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	return flag_ext:can_be_dropped(self._unit) and not locomotion.planting_flag
end

function PlayerUnitInteraction:trigger(unit)
	if not self._player.team then
		return false
	end

	local side = self._player.team.side
	local extension = ScriptUnit.extension(unit, "objective_system")

	return extension:active(side) and not extension:interactor() and extension:can_interact(self._player)
end

function PlayerUnitInteraction:destroy(u, input)
	return
end
