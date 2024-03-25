-- chunkname: @scripts/entity_system/systems/damage/damage_system.lua

require("scripts/unit_extensions/generic/generic_unit_damage")
require("scripts/unit_extensions/default_player_unit/player_unit_damage")
require("scripts/unit_extensions/default_player_unit/player_husk_damage")
require("scripts/unit_extensions/human/ai_player_unit/ai_unit_damage")
require("scripts/unit_extensions/objectives/objective_unit_damage")
require("scripts/unit_extensions/objectives/assault_unit_damage")
require("scripts/unit_extensions/horse/horse_damage")

DamageSystem = class(DamageSystem, ExtensionSystemBase)

function DamageSystem:update(...)
	DamageSystem.super.update(self, ...)
end

function DamageSystem:update_extension(extension_name, dt, context, t)
	local entities = self.entity_manager:get_entities(extension_name)

	for unit, _ in pairs(entities) do
		local internal = ScriptUnit.extension(unit, self.NAME)

		if internal.update then
			internal:update(unit, t, dt, context, t)
		end
	end
end
