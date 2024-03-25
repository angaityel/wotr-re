-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/husk_gear.lua

require("scripts/unit_extensions/default_player_unit/inventory/base_gear")

HuskGear = class(HuskGear, BaseGear)

function HuskGear:init(world, user_unit, player, name, obj_id, primary_tint, secondary_tint, ai_gear, has_ammo, attachments)
	self._world = world
	self._settings = Gear[name]

	self:_spawn_unit(world)

	self._name = name
	self._projectile_name = nil
	self._user_unit = user_unit
	self._player = player

	local properties = self:_calculate_properties(attachments)
	local attachment_multipliers = self:_calculate_attachment_multipliers(attachments)

	if script_data.attachment_debug_husk then
		print("---", name, "---")
		table.dump(attachments)
		print("--------------------")
		table.dump(attachment_multipliers)
	end

	self:_set_unit_data(attachment_multipliers)
	BaseGear.init(self, world, user_unit, player, name, primary_tint, secondary_tint, ai_gear, attachments, attachment_multipliers, properties)

	self._id = obj_id
end

function HuskGear:_spawn_unit(world)
	local unit = World.spawn_unit(world, self._settings.husk_unit)

	Unit.set_data(unit, "husk", true)

	self._unit = unit
end

function HuskGear:enter_ghost_mode()
	self:hide_gear("ghost_mode")
	self:hide_quiver("ghost_mode")
	HuskGear.super.enter_ghost_mode(self)
end

function HuskGear:exit_ghost_mode()
	self:unhide_gear("ghost_mode")
	self:unhide_quiver("ghost_mode")
	HuskGear.super.exit_ghost_mode(self)
end

function HuskGear:destroy()
	if Unit.alive(self._unit) then
		local lod_object = Unit.lod_object(self._unit, "LOD")

		LODObject.set_orientation_node(lod_object, self._unit, 0)
	end

	HuskGear.super.destroy(self)
end
