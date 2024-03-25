-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/player_gear.lua

require("scripts/unit_extensions/default_player_unit/inventory/base_gear")

PlayerGear = class(PlayerGear, BaseGear)

function PlayerGear:init(world, user_unit, player, name, obj_id, primary_tint, secondary_tint, ai_gear, has_ammo, attachments)
	self._world = world
	self._game = nil
	self._id = nil
	self._wielded = false
	self._settings = Gear[name]

	self:_spawn_unit(world)

	self._projectile_name = nil
	self._user_unit = user_unit
	self._player = player
	self._name = name

	local properties = self:_calculate_properties(attachments)
	local attachment_multipliers = self:_calculate_attachment_multipliers(attachments)

	if script_data.attachment_debug then
		print("---", name, "---")
		table.dump(attachments)
		print("--- multipliers ---")
		table.dump(attachment_multipliers)
		print("--- properties ---")
		table.dump(properties)
	end

	self:_set_unit_data(attachment_multipliers)

	local game = Managers.state.network:game()

	if game then
		self:_create_game_object(game, self._unit, has_ammo, attachments)
		BaseGear.init(self, world, user_unit, player, name, primary_tint, secondary_tint, ai_gear, attachments, attachment_multipliers, properties)
	else
		BaseGear.init(self, world, user_unit, player, name, primary_tint, secondary_tint, ai_gear, attachments, attachment_multipliers, properties)

		local extensions = ScriptUnit.extension_definitions(self._unit)

		for _, extension in ipairs(extensions) do
			ScriptUnit.add_extension(world, self._unit, extension)
		end
	end
end

function PlayerGear:_create_game_object(game, unit, has_ammo, attachments)
	local player_unit_game_object_id = Managers.state.network:unit_game_object_id(self._user_unit)

	fassert(player_unit_game_object_id, "[PlayerGear:_create_game_object] unit: '%s' does not have have a game object id.", tostring(self._user_unit))

	local attachment_one_id = self:_calculate_attachment_value(1, attachments) or 0
	local attachment_two_id = self:_calculate_attachment_value(2, attachments) or 0
	local attachment_three_id = self:_calculate_attachment_value(3, attachments) or 0
	local attachment_four_id = self:_calculate_attachment_value(4, attachments) or 0

	if script_data.attachment_debug then
		print("---", self._name, "---")
		print("attachment_one_net_id: ", attachment_one_id)
		print("attachment_two_net_id: ", attachment_two_id)
		print("attachment_three_net_id: ", attachment_three_id)
		print("attachment_four_net_id: ", attachment_four_id)
	end

	local data_table = {
		gear_name = NetworkLookup.inventory_gear[self._name],
		user_object_id = player_unit_game_object_id,
		game_object_created_func = NetworkLookup.game_object_functions.cb_spawn_gear,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		object_destroy_func = NetworkLookup.game_object_functions.cb_destroy_gear,
		att_id_1 = attachment_one_id,
		att_id_2 = attachment_two_id,
		att_id_3 = attachment_three_id,
		att_id_4 = attachment_four_id
	}

	if has_ammo then
		data_table.ammunition = 0
	end

	local callback = callback(self, "cb_game_session_disconnect")
	local unit_type = has_ammo and "gear_unit_ammo" or "gear_unit"

	self._id = Managers.state.network:create_game_object(unit_type, data_table, callback, "cb_local_gear_unit_spawned", unit)
	self._game = game
end

function PlayerGear:_calculate_attachment_value(slot, attachments)
	local settings = self._settings
	local potential_attachment = settings.attachments[slot]

	if potential_attachment then
		local category = potential_attachment.category

		for key, attachment in pairs(attachments) do
			if key == category then
				local attachment_items = WeaponHelper:attachment_items_by_category(self._name, category) or {}

				if potential_attachment.menu_page_type == "checkbox" then
					return self:_multiple_attachments_network_value(attachment_items, attachment)
				else
					for index, item in ipairs(attachment_items) do
						if item.name == attachment[1] then
							return index
						end
					end
				end
			end
		end
	end
end

function PlayerGear:_multiple_attachments_network_value(attachment_items, misc_attachments)
	local network_value = 0

	for _, attachment in ipairs(misc_attachments) do
		for index, item in ipairs(attachment_items) do
			if item.name == attachment then
				network_value = network_value + 2^(index - 1)
			end
		end
	end

	return network_value
end

function PlayerGear:cb_game_session_disconnect()
	self._frozen = true
	self._id = nil
	self._game = nil
end

function PlayerGear:_spawn_unit(world)
	self._unit = World.spawn_unit(world, self._settings.unit)
end

function PlayerGear:update(dt, t)
	if self._frozen then
		return
	end

	for _, extension in pairs(self._extensions) do
		if extension.update then
			extension:update(dt, t)
		end
	end
end

function PlayerGear:is_melee_weapon()
	return self._settings.gear_type == "one_handed_sword" or self._settings.gear_type == "one_handed_club" or self._settings.gear_type == "one_handed_axe" or self._settings.gear_type == "dagger" or self._settings.gear_type == "two_handed_sword" or self._settings.gear_type == "two_handed_club" or self._settings.gear_type == "two_handed_axe" or self._settings.gear_type == "polearm" or self._settings.gear_type == "spear" or self._settings.gear_type == "bastard_weapon"
end

function PlayerGear:is_weapon()
	return self:is_melee_weapon() or self:is_ranged_weapon()
end

function PlayerGear:is_shield()
	return self._settings.gear_type == "shield"
end

function PlayerGear:is_one_handed()
	return self._settings.hand == "left_hand" or self._settings.hand == "right_hand"
end

function PlayerGear:is_two_handed()
	return self._settings.hand == "both_hands"
end

function PlayerGear:is_left_handed()
	return self._settings.hand == "left_hand"
end

function PlayerGear:is_right_handed()
	return self._settings.hand == "right_hand"
end

function PlayerGear:can_block()
	return self._settings.block_type
end

function PlayerGear:start_melee_attack(charge_time, swing_direction, quick_swing, cb_abort_attack, swing_time)
	self._extensions.base:start_attack(charge_time, swing_direction, quick_swing, cb_abort_attack, swing_time)
end

function PlayerGear:start_couch(cb_abort_attack)
	self._extensions.base:start_couch(cb_abort_attack)
end

function PlayerGear:end_couch()
	return self._extensions.base:end_couch()
end

function PlayerGear:end_melee_attack()
	return self._extensions.base:end_attack()
end

function PlayerGear:die()
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local unit = self._unit

	if game and Managers.lobby.server then
		local object_id = network_manager:game_object_id(unit)

		network_manager:send_rpc_clients("rpc_gear_dead", object_id)
	elseif game then
		local object_id = network_manager:game_object_id(unit)

		network_manager:send_rpc_server("rpc_gear_dead", object_id)
	end

	PlayerGear.super.die(self)
end

function PlayerGear:has_attachment(category, name)
	local attachments_in_category = self._attachments and self._attachments[category]

	if attachments_in_category then
		return table.contains(attachments_in_category, name)
	end
end

function PlayerGear:destroy(keep_unit)
	PlayerGear.super.destroy(self)

	local unit = self._unit

	if Managers.state.network:game() then
		Managers.state.network:destroy_game_object(self._id)
	end

	if not Managers.lobby.lobby then
		ScriptUnit.remove_extensions(unit)
	end

	if not keep_unit then
		World.destroy_unit(self._world, unit)
	end
end
