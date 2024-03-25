-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/base_gear.lua

require("scripts/settings/gear_settings")
require("scripts/settings/gear_templates")
require("scripts/settings/gear_require")
require("scripts/unit_extensions/weapons/weapon_bow")
require("scripts/unit_extensions/weapons/weapon_crossbow")
require("scripts/unit_extensions/weapons/weapon_handgonne")
require("scripts/unit_extensions/weapons/weapon_one_handed")
require("scripts/unit_extensions/weapons/weapon_lance")
require("scripts/unit_extensions/weapons/weapon_shield")
require("scripts/helpers/weapon_helper")

BaseGear = class(BaseGear)

function BaseGear:init(world, user_unit, player, name, primary_team_tint, secondary_team_tint, ai_gear, attachments, attachment_multipliers, properties)
	self._scene_graph_links = {}
	self._hide_reasons = {}

	self:set_wielded(false)

	self._extensions = {}

	self:_setup_gear_extensions(ai_gear, player, attachments, properties, attachment_multipliers)

	self._attachments = attachments
	self._attachment_multipliers = attachment_multipliers
	self._properties = properties

	if Unit.get_data(self._unit, "uses_team_material_variation") then
		self:_set_team_material_variation()
	end

	local quiver_settings = self._settings.quiver

	if quiver_settings then
		self:_spawn_quiver(quiver_settings)
	end
end

function BaseGear:_calculate_attachment_multipliers(attachments)
	local multipliers = WeaponHelper:new_attachment_multipliers()

	for attachment_category, attachment in pairs(attachments) do
		for _, attachment_type in ipairs(attachment) do
			local attachment_settings = WeaponHelper:attachment_settings(self._name, attachment_category, attachment_type)
			local mults = attachment_settings and attachment_settings.multipliers

			if mults then
				for key, multiplier in pairs(mults) do
					if multipliers[key] ~= 0 then
						multipliers[key] = multipliers[key] * multiplier
					else
						multipliers[key] = multiplier
					end
				end
			end
		end
	end

	return multipliers
end

function BaseGear:_calculate_properties(attachments)
	local properties = {}

	for attachment_category, attachment in pairs(attachments) do
		for _, attachment_type in ipairs(attachment) do
			local attachment_settings = WeaponHelper:attachment_settings(self._name, attachment_category, attachment_type)
			local props = attachment_settings and attachment_settings.properties

			if props then
				for _, property in ipairs(props) do
					if not table.contains(properties, property) then
						properties[#properties + 1] = property
					end
				end
			end
		end
	end

	return properties
end

function BaseGear:attachment_multiplier(multiplier)
	return self._attachment_multipliers[multiplier]
end

function BaseGear:has_property(weapon_property)
	for _, property in ipairs(self._properties) do
		if property == weapon_property then
			return true
		end
	end

	return false
end

function BaseGear:attachments()
	return self._attachments
end

function BaseGear:attachment_multipliers()
	return self._attachment_multipliers
end

function BaseGear:properties()
	return self._properties
end

function BaseGear:_setup_gear_extensions(ai_gear, player, attachments, properties, attachment_multipliers)
	local unit = self._unit
	local user_unit = self._user_unit
	local extensions = {}
	local i = 0

	while Unit.has_data(unit, "gear_extensions", i) do
		local class_name = Unit.get_data(unit, "gear_extensions", i, "class")
		local name = Unit.get_data(unit, "gear_extensions", i, "name")
		local class = rawget(_G, class_name)

		i = i + 1
		extensions[name] = class:new(self._world, unit, user_unit, player, self._id, ai_gear, attachments, properties, attachment_multipliers)
	end

	self._extensions = extensions
end

function BaseGear:is_ranged_weapon()
	local extensions = self._extensions
	local weapon_ext = extensions.base

	if not weapon_ext then
		return false
	end

	local category = weapon_ext:category()

	return category == "bow" or category == "crossbow" or category == "handgonne"
end

function BaseGear:_set_team_material_variation()
	local unit = self._unit
	local team_name = Unit.get_data(self._user_unit, "team_name")

	if team_name then
		local unit_name = self._settings.unit
		local material_variation = unit_name .. "_" .. team_name

		Unit.set_material_variation(unit, material_variation)
	end
end

function BaseGear:settings()
	return self._settings
end

function BaseGear:_set_unit_data(attachment_multipliers)
	local unit = self._unit
	local settings = self._settings

	Unit.set_data(unit, "gear_name", self._name)
	Unit.set_data(unit, "user_unit", self._user_unit)
	Unit.set_data(unit, "attacks", self._settings.attacks)
	Unit.set_data(unit, "health", settings.health * attachment_multipliers.health)
	Unit.set_data(unit, "armour_type", self._settings.armour_type)
	Unit.set_data(unit, "penetration_value", settings.penetration_value * attachment_multipliers.penetration_armour)
	Unit.set_data(unit, "absorption_value", settings.absorption_value * attachment_multipliers.absorption_armour)
	Unit.set_data(unit, "settings", self._settings)
end

function BaseGear:_link(attachment_node_linking)
	local unit = self._unit
	local user_unit = self._user_unit
	local link_table = self._scene_graph_links

	table.clear(link_table)
	self:_link_units(attachment_node_linking, user_unit, unit, link_table)
end

function BaseGear:_spawn_quiver(quiver_settings)
	local unit_name = quiver_settings.unit
	local attachment_node_linking = quiver_settings.attachment_node_linking
	local unit = World.spawn_unit(self._world, unit_name)
	local link_table = {}

	self:_link_units(attachment_node_linking, self._user_unit, unit, link_table)

	local quiver_data = {
		unit = unit,
		link_table = link_table,
		hide_reasons = {}
	}

	self._quiver_data = quiver_data
end

function BaseGear:_link_units(attachment_node_linking, source, target, link_table)
	for i, attachment_nodes in ipairs(attachment_node_linking) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = type(source_node) == "string" and Unit.node(source, source_node) or source_node
		local target_node_index = type(target_node) == "string" and Unit.node(target, target_node) or target_node

		link_table[#link_table + 1] = {
			unit = target,
			i = target_node_index,
			parent = Unit.scene_graph_parent(target, target_node_index),
			local_pose = Matrix4x4Box(Unit.local_pose(target, target_node_index))
		}

		World.link_unit(self._world, target, target_node_index, source, source_node_index)
	end
end

function BaseGear:wielded()
	return self._wielded
end

function BaseGear:name()
	return self._name
end

function BaseGear:unit()
	return self._unit
end

function BaseGear:set_wielded(wielded)
	local unit = self._unit
	local settings = self._settings

	World.unlink_unit(self._world, unit)

	if settings.hide_unwielded and wielded then
		self:unhide_gear("wielded")
	elseif settings.hide_unwielded then
		self:hide_gear("wielded")
	end

	self:_restore_scene_graph()

	local attachment_node_linking = wielded and settings.attachment_node_linking.wielded or settings.attachment_node_linking.unwielded

	self:_link(attachment_node_linking)

	self._wielded = wielded

	if self._extensions and self._extensions.base then
		self._extensions.base:set_wielded(wielded)
	end
end

function BaseGear:set_faux_unwielded(unwielded)
	local unit = self._unit
	local settings = self._settings

	World.unlink_unit(self._world, unit)

	if settings.hide_unwielded and not unwielded then
		self:unhide_gear("wielded")
	elseif settings.hide_unwielded then
		self:hide_gear("wielded")
	end

	self:_restore_scene_graph()

	local attachment_node_linking = unwielded and settings.attachment_node_linking.unwielded or settings.attachment_node_linking.wielded

	self:_link(attachment_node_linking)

	if self._extensions and self._extensions.base and self._extensions.base.set_faux_unwielded then
		self._extensions.base:set_faux_unwielded(unwielded)
	end
end

function BaseGear:_restore_scene_graph()
	if self._scene_graph_links then
		for i, link in ipairs(self._scene_graph_links) do
			if link.parent then
				Unit.scene_graph_link(link.unit, link.i, link.parent)
				Unit.set_local_pose(link.unit, link.i, link.local_pose:unbox())
			end
		end
	end
end

function BaseGear:die()
	self:destroy(true)

	local unit = self._unit

	Unit.flow_event(unit, "lua_break")

	local collision_actor_index = Unit.find_actor(unit, "c_weapon_collision")

	if collision_actor_index then
		Unit.destroy_actor(unit, collision_actor_index)
	end

	Managers.state.broken_gear:register_gear(unit)
end

function BaseGear:extensions()
	return self._extensions
end

function BaseGear:destroy(keep_unit)
	local unit = self._unit

	for _, extension in pairs(self._extensions) do
		extension:destroy()
	end

	if Unit.alive(unit) then
		World.unlink_unit(self._world, unit)
	end

	local quiver = self._quiver_data and self._quiver_data.unit

	if Unit.alive(quiver) then
		World.unlink_unit(self._world, quiver)
		World.destroy_unit(self._world, quiver)
	end
end

function BaseGear:enter_ghost_mode()
	self:_disable_collisions()

	local extensions = self._extensions

	for _, extension in pairs(extensions) do
		extension:enter_ghost_mode()
	end
end

function BaseGear:_disable_collisions()
	local unit = self._unit
	local num_actors = Unit.num_actors(unit)

	for i = 0, num_actors - 1 do
		local actor = Unit.actor(unit, i)

		if actor then
			Actor.set_collision_enabled(actor, false)
			Actor.set_scene_query_enabled(actor, false)
		end
	end
end

function BaseGear:_enable_collisions()
	local unit = self._unit
	local num_actors = Unit.num_actors(unit)

	for i = 0, num_actors - 1 do
		local actor = Unit.actor(unit, i)

		if actor then
			Actor.set_collision_enabled(actor, true)
			Actor.set_scene_query_enabled(actor, true)
		end
	end
end

function BaseGear:set_kinematic(kinematic)
	local unit = self._unit
	local actor_index = Unit.find_actor(unit, "dropped")

	if actor_index then
		if kinematic and self._dropped then
			self._dropped = false

			local settings = self._settings
			local attachment_node_linking = self._wielded and settings.attachment_node_linking.wielded or settings.attachment_node_linking.unwielded

			Unit.destroy_actor(unit, actor_index)
			self:_link(attachment_node_linking)

			if Unit.has_node(unit, "dropped") then
				Unit.set_local_pose(unit, Unit.node(unit, "dropped"), self._dropped_local_pose:unbox())
			end
		else
			self._dropped = true

			if Unit.has_node(unit, "dropped") then
				self._dropped_local_pose = Matrix4x4Box(Unit.local_pose(unit, Unit.node(unit, "dropped")))
			end

			self:_restore_scene_graph()
			World.unlink_unit(self._world, unit)
			Unit.create_actor(unit, actor_index)
		end
	end
end

function BaseGear:exit_ghost_mode()
	self:_enable_collisions()

	local extensions = self._extensions

	for _, extension in pairs(extensions) do
		extension:exit_ghost_mode()
	end
end

function BaseGear:hide_gear(reason)
	if table.is_empty(self._hide_reasons) then
		Unit.set_visibility(self._unit, "unbroken", false)
	end

	self._hide_reasons[reason] = true
end

function BaseGear:hide_quiver(reason)
	local quiver_data = self._quiver_data

	if not quiver_data then
		return
	end

	if table.is_empty(quiver_data.hide_reasons) then
		Unit.set_unit_visibility(quiver_data.unit, false)
	end

	quiver_data.hide_reasons[reason] = true
end

function BaseGear:unhide_quiver(reason)
	local quiver_data = self._quiver_data

	if not quiver_data then
		return
	end

	quiver_data.hide_reasons[reason] = nil

	table.dump(quiver_data.hide_reasons)

	if table.is_empty(quiver_data.hide_reasons) then
		Unit.set_unit_visibility(quiver_data.unit, true)
	end
end

function BaseGear:unhide_gear(reason)
	self._hide_reasons[reason] = nil

	if table.is_empty(self._hide_reasons) then
		Unit.set_visibility(self._unit, "unbroken", true)
	end
end

function BaseGear:trigger_timpani_event(event_config)
	local timpani_world = World.timpani_world(self._world)
	local gear_settings = Gear[self._name]
	local config = gear_settings.timpani_events[event_config]

	fassert(config, "[BaseGear] Timpani event config %q missing for gear %s", event_config, self._name)

	local event_id = TimpaniWorld.trigger_event(timpani_world, config.event, Unit.world_position(self._unit, 0))

	if event_id and config.parameters then
		for _, param in ipairs(config.parameters) do
			TimpaniWorld.set_parameter(timpani_world, event_id, param.name, param.value)
		end
	elseif not event_id then
		print("[BaseGear:trigger_timpani_event] missing sound event for event_config:", event_config)
	end
end

function BaseGear:set_coat_of_arms(settings, team_name)
	if Gear[self._name].show_coat_of_arms then
		CoatOfArmsHelper:set_material_properties(settings, self._unit, "g_heraldry_projector", "heraldry_projector", team_name)
		CoatOfArmsHelper:set_material_properties(settings, self._unit, "g_broken_heraldry_projector", "broken_heraldry_projector", team_name)
	end
end
