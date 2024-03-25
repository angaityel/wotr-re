-- chunkname: @scripts/managers/death_zone/damage_zone.lua

DamageZone = class(DamageZone)

function DamageZone:init(level, volume_name, damage)
	self._level = level
	self._volume_name = volume_name
	self._damage = damage
	self._damaged_units = {}
end

function DamageZone:update(dt, t, unit)
	if Unit.alive(unit) and not self._damaged_units[unit] then
		local damage_extension = ScriptUnit.extension(unit, "damage_system")

		if damage_extension:is_alive() then
			local unit_pos = Unit.world_position(unit, 0) + Vector3.up()

			if Level.is_point_inside_volume(self._level, self._volume_name, unit_pos) then
				local owner = Managers.player:owner(unit)

				damage_extension:add_damage(owner, unit, "death_zone", self._damage, nil, nil, nil, "melee", nil, "torso", Vector3.zero(), self._damage, nil, nil)

				self._damaged_units[unit] = true
			end
		end
	end
end
