-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/player_base_inventory.lua

require("scripts/settings/inventory_slots")

PlayerBaseInventory = class(PlayerBaseInventory)

function PlayerBaseInventory:init(world, user_unit, player, tint_color, secondary_tint_color)
	self._world = world
	self._user_unit = user_unit
	self._player = player
	self._slots = {}
	self._helmet_attachment_units = {}
	self._primary_team_tint_color = tint_color
	self._secondary_team_tint_color = secondary_tint_color
	self._eye_constraint_target = nil
	self._visor_open = true
	self._weapon_grip_switched = false
	self._visor_name = nil
	self._helmet_name = nil

	self:_setup_slots()

	self._armour_definition = nil
	self._built_in_overlay = nil
	self._decap_allowed = true
end

function PlayerBaseInventory:voice()
	return self._voice
end

function PlayerBaseInventory:add_armour(armour, pattern_index)
	self._armour_name = armour
	self._pattern_index = pattern_index

	self:_load_armour_data(armour, pattern_index)
end

function PlayerBaseInventory:_load_armour_data(armour, pattern_index)
	local armour_definition = Armours[armour]
	local unit = self._user_unit

	Unit.set_data(unit, "armour_type", armour_definition.armour_type)
	Unit.set_data(unit, "penetration_value", armour_definition.penetration_value)
	Unit.set_data(unit, "absorption_value", armour_definition.absorption_value)

	local pattern = armour_definition.attachment_definitions.patterns[pattern_index]
	local meshes = armour_definition.meshes

	ProfileHelper:set_gear_patterns(unit, meshes, pattern)

	self._armour_definition = armour_definition
end

function PlayerBaseInventory:reload_armour_data()
	self:_load_armour_data(self._armour_name, self._pattern_index)
end

function PlayerBaseInventory:armour_values(hit_zone, back)
	if hit_zone == "helmet" then
		local helmet = self._helmet_definition

		if helmet then
			if script_data.armour_debug then
				print("helmet", helmet.armour_type, helmet.penetration_value, helmet.absorption_value)
			end

			return helmet.armour_type, helmet.penetration_value, helmet.absorption_value
		else
			error("PlayerBaseInventory:armour_values, no helmet definition set")
		end
	end

	local armour = self._armour_definition

	if armour then
		local hit_zone_armour = armour.hit_zones[hit_zone]

		if hit_zone_armour then
			local back_armour = hit_zone_armour.back

			if back and back_armour then
				if script_data.armour_debug then
					print("hit zone back armour", hit_zone, back_armour.armour_type, back_armour.penetration_value, back_armour.absorption_value)
				end

				return back_armour.armour_type, back_armour.penetration_value, back_armour.absorption_value
			else
				if script_data.armour_debug then
					print("hit zone armour", hit_zone, hit_zone_armour.armour_type, hit_zone_armour.penetration_value, hit_zone_armour.absorption_value)
				end

				return hit_zone_armour.armour_type, hit_zone_armour.penetration_value, hit_zone_armour.absorption_value
			end
		else
			if script_data.armour_debug then
				print("armour", hit_zone, armour.armour_type, armour.penetration_value, armour.absorption_value)
			end

			return armour.armour_type, armour.penetration_value, armour.absorption_value
		end
	else
		error("PlayerBaseInventory:armour_values, no armour definition set")
	end
end

function PlayerBaseInventory:_setup_slots()
	for name, settings in pairs(InventorySlots) do
		self._slots[name] = {
			settings = settings
		}
	end
end

function PlayerBaseInventory:find_slot_by_unit(unit)
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear then
			local gear_unit = gear:unit()

			if gear_unit == unit then
				return slot_name
			end
		end
	end
end

function PlayerBaseInventory:slots()
	return self._slots
end

function PlayerBaseInventory:_gear(slot_name)
	return self._slots[slot_name].gear
end

function PlayerBaseInventory:_set_gear(slot_name, gear)
	self._slots[slot_name].gear = gear
end

function PlayerBaseInventory:add_gear(gear_name, obj_id, ai_gear, attachments)
	local gear_settings = Gear[gear_name]
	local wanted_slot = GearTypes[gear_settings.gear_type].inventory_slot
	local current_gear = self:_gear(wanted_slot)

	fassert(not current_gear, "[PlayerBaseInventory:add_gear] Tried to add gear %q in occupied slot %q. Occupied by %q", gear_name, wanted_slot, current_gear and current_gear:name() or nil)

	local gear_class = rawget(_G, self.GEAR_CLASS)
	local has_ammo = false

	if gear_settings.starting_ammo then
		has_ammo = true
	end

	local gear = gear_class:new(self._world, self._user_unit, self._player, gear_name, obj_id, self._primary_team_tint_color, self._secondary_team_tint_color, ai_gear, has_ammo, attachments)

	self:_set_gear(wanted_slot, gear)

	if self._coat_of_arms_settings then
		gear:set_coat_of_arms(self._coat_of_arms_settings, self._coat_of_arms_team_name)
	end

	Unit.set_data(gear:unit(), "ai_gear", ai_gear)

	return gear:unit(), gear
end

function PlayerBaseInventory:remove_gear(slot_name)
	self:_set_gear(slot_name, nil)
end

function PlayerBaseInventory:gear_dead(slot_name)
	local gear = self:_gear(slot_name)

	self:remove_gear(slot_name)
	gear:die()
end

function PlayerBaseInventory:player_unit_gear_anims(gear)
	local gear_settings = gear:settings()
	local hand = gear_settings.hand
	local main_body_state

	if gear:wielded() then
		main_body_state = GearTypes[gear_settings.gear_type].wield_main_body_state
	else
		main_body_state = GearTypes[gear_settings.gear_type].unwield_main_body_state
	end

	local hand_anim = hand .. "/empty"

	if gear:wielded() and gear_settings.hand_anim then
		hand_anim = hand .. "/" .. gear_settings.hand_anim
	end

	return main_body_state, hand_anim
end

function PlayerBaseInventory:gear_unit(slot_name)
	local gear = self:_gear(slot_name)
	local unit = gear and gear:unit()

	return unit
end

function PlayerBaseInventory:gear_settings(slot_name)
	local gear = self:_gear(slot_name)

	return gear:settings()
end

function PlayerBaseInventory:wielded_slots()
	local wielded = {}

	for name, slot in pairs(self._slots) do
		if slot.gear and slot.gear:wielded() then
			wielded[name] = slot
		end
	end

	return wielded
end

function PlayerBaseInventory:is_ranged_weapon(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:is_ranged_weapon()
end

function PlayerBaseInventory:wielded_ranged_weapon_slot()
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() and gear:is_ranged_weapon() then
			return slot_name
		end
	end
end

function PlayerBaseInventory:head()
	return self._head_unit
end

function PlayerBaseInventory:add_head(head_name, head_material, voice)
	Unit.set_data(self._user_unit, "head", head_name)

	local head_settings = Heads[head_name]

	fassert(head_settings, "Head %q not found", head_name)

	local unit = World.spawn_unit(self._world, head_settings.unit)
	local head_material_settings = HeadMaterials[head_material]

	if head_material_settings then
		Unit.set_material_variation(unit, head_material_settings.material_name)
	end

	self:_attachment_node_linking(self._user_unit, unit, head_settings.attachment_node_linking)
	Unit.set_animation_merge_options(unit)

	self._head_unit = unit

	Unit.set_visibility(unit, "head_decap", false)

	if Unit.has_animation_state_machine(unit) then
		self._eye_constraint_target = Unit.animation_find_constraint_target(unit, "eye_target")
	end

	self._voice = voice or head_settings[self._voice_type]

	Unit.set_flow_variable(self._user_unit, "character_vo", self._voice)
end

function PlayerBaseInventory:add_helmet(helmet_name, team_name)
	local user_unit = self._user_unit

	Unit.set_data(user_unit, "helmet", helmet_name)

	local helmet_definition = Helmets[helmet_name]

	Unit.set_data(user_unit, "helmet_armour_type", helmet_definition.armour_type)
	Unit.set_data(user_unit, "helmet_penetration_value", helmet_definition.penetration_value)
	Unit.set_data(user_unit, "helmet_absorption_value", helmet_definition.absorption_value)

	local settings = Helmets[helmet_name]
	local unit_name = helmet_definition.unit
	local unit = World.spawn_unit(self._world, unit_name)

	self._decap_allowed = self._decap_allowed and not settings.no_decapitation

	self:_attachment_node_linking(self._user_unit, unit, helmet_definition.attachment_node_linking)

	if helmet_definition.hide_head_visibility_group then
		Unit.set_visibility(self._head_unit, helmet_definition.hide_head_visibility_group, false)
	end

	self._helmet_unit = unit
	self._helmet_name = helmet_name

	Unit.set_data(unit, "armour_owner", self._user_unit)

	local head_actor = Unit.actor(user_unit, "c_head")
	local neck_actor = Unit.actor(user_unit, "helmet")

	Actor.set_scene_query_enabled(head_actor, false)
	Actor.set_scene_query_enabled(neck_actor, false)

	self._helmet_definition = helmet_definition

	if helmet_definition.built_in_visor then
		self._visor_name = helmet_definition.built_in_visor
	end

	if helmet_definition.built_in_overlay then
		self._built_in_overlay = helmet_definition.built_in_overlay
	end
end

function PlayerBaseInventory:built_in_overlay()
	return self._built_in_overlay
end

function PlayerBaseInventory:add_helmet_attachment(helmet_name, attachment_type, attachment_name, team_name)
	local helmet_unit = self._helmet_unit
	local helmet = Helmets[helmet_name]
	local helmet_attachment = helmet.attachments[attachment_name]
	local unit_name = helmet_attachment.unit
	local unit = World.spawn_unit(self._world, unit_name)

	self:_attachment_node_linking(helmet_unit, unit, helmet_attachment.attachment_node_linking)

	self._helmet_attachment_units[attachment_type] = unit

	if attachment_type == "visor" then
		self._visor_name = helmet_attachment.hud_overlay_texture
	end

	Unit.set_data(unit, "armour_owner", self._user_unit)

	self._decap_allowed = self._decap_allowed and not helmet_attachment.no_decapitation
end

function PlayerBaseInventory:allow_decapitation()
	return self._decap_allowed
end

function PlayerBaseInventory:add_helmet_crest(crest_name, team_name)
	local crest = HelmetCrests[crest_name]
	local unit_name = crest.unit
	local unit = World.spawn_unit(self._world, unit_name)

	self:_attachment_node_linking(self._helmet_unit, unit, crest.attachment_node_linking)

	self._helmet_attachment_units.crest = unit

	Unit.set_data(self._user_unit, "crest_name", crest_name)
end

function PlayerBaseInventory:add_coat_of_arms(settings, team_name)
	CoatOfArmsHelper:set_material_properties(settings, self._user_unit, "g_heraldry_projection", "heraldry_projection", team_name)

	local extra_coat_of_arms = self._armour_definition.extra_coat_of_arms

	if extra_coat_of_arms then
		CoatOfArmsHelper:set_material_properties(settings, self._user_unit, extra_coat_of_arms.mesh, extra_coat_of_arms.material, team_name)
	end

	for name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear then
			gear:set_coat_of_arms(settings, team_name)
		end
	end

	self._coat_of_arms_settings = settings
	self._coat_of_arms_team_name = team_name
end

function PlayerBaseInventory:_attachment_node_linking(source_unit, target_unit, linking_setup)
	for i, attachment_nodes in ipairs(linking_setup) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = type(source_node) == "string" and Unit.node(source_unit, source_node) or source_node
		local target_node_index = type(target_node) == "string" and Unit.node(target_unit, target_node) or target_node

		World.link_unit(self._world, target_unit, target_node_index, source_unit, source_node_index)
	end
end

function PlayerBaseInventory:set_eye_target(aim_target)
	if self._head_unit and Unit.alive(self._head_unit) and self._eye_constraint_target and aim_target then
		Unit.animation_set_constraint_target(self._head_unit, self._eye_constraint_target, aim_target)
	end
end

function PlayerBaseInventory:visor_open()
	return self._visor_open
end

function PlayerBaseInventory:visor_name()
	return self._visor_name
end

function PlayerBaseInventory:helmet_name()
	return self._helmet_name
end

function PlayerBaseInventory:helmet_unit()
	return self._helmet_unit
end

function PlayerBaseInventory:helmet_attachment_unit(name)
	return self._helmet_attachment_units[name]
end

function PlayerBaseInventory:set_visor_open(open, fast)
	if open then
		if fast then
			Unit.flow_event(self._helmet_unit, "visor_opened")
		else
			Unit.flow_event(self._helmet_unit, "visor_open")
		end

		self._visor_open = true
	else
		if fast then
			Unit.flow_event(self._helmet_unit, "visor_closed")
		else
			Unit.flow_event(self._helmet_unit, "visor_close")
		end

		self._visor_open = false
	end
end

function PlayerBaseInventory:hot_join_synch(sender, player, player_object_id)
	for slot_name, slot in pairs(self._slots) do
		if slot.gear then
			if slot.gear:wielded() then
				RPC.rpc_set_gear_wielded(sender, player_object_id, NetworkLookup.inventory_slots[slot_name], true, true)
			end

			local extensions = slot.gear:extensions()

			for _, extension in pairs(extensions) do
				extension:hot_join_synch(sender, player, player_object_id, slot_name)
			end
		end
	end

	RPC.rpc_set_visor_open(sender, player_object_id, self._visor_open, true)
end

function PlayerBaseInventory:destroy()
	for name, slot in pairs(self._slots) do
		if slot.gear then
			slot.gear:destroy()
		end
	end

	self._slots = {}

	if self._helmet_unit and Unit.alive(self._helmet_unit) then
		World.destroy_unit(self._world, self._helmet_unit)

		self._helmet_unit = nil
		self._helmet_name = nil
	end

	for _, attachment_unit in pairs(self._helmet_attachment_units) do
		if Unit.alive(attachment_unit) then
			World.destroy_unit(self._world, attachment_unit)
		end
	end

	self._helmet_attachment_units = {}
	self._visor_name = nil

	if self._head_unit and Unit.alive(self._head_unit) then
		World.destroy_unit(self._world, self._head_unit)

		self._head_unit = nil
	end
end

function PlayerBaseInventory:set_kinematic_wielded_gear(kinematic)
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() then
			gear:set_kinematic(kinematic)
		end
	end
end

function PlayerBaseInventory:set_faux_unwielded(bool)
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() then
			gear:set_faux_unwielded(bool)
		end
	end
end
