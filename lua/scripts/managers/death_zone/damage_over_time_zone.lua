-- chunkname: @scripts/managers/death_zone/damage_over_time_zone.lua

DamageOverTimeZone = class(DamageOverTimeZone)

function DamageOverTimeZone:init(level, volume_name, damage, period)
	self._level = level
	self._volume_name = volume_name
	self._damage = damage
	self._period = period
	self._damaged_units = {}
end

function DamageOverTimeZone:update(dt, t, unit)
	if Unit.alive(unit) then
		local damage_extension = ScriptUnit.extension(unit, "damage_system")

		if damage_extension:is_alive() then
			local unit_pos = Unit.world_position(unit, 0) + Vector3.up()

			if Level.is_point_inside_volume(self._level, self._volume_name, unit_pos) and (self._damaged_units[unit] == nil or t >= self._damaged_units[unit]) then
				local owner = Managers.player:owner(unit)

				damage_extension:add_damage(owner, unit, "death_zone", self._damage, nil, nil, nil, "melee", nil, "torso", Vector3.zero(), self._damage, nil, nil)

				self._damaged_units[unit] = t + self._period
			end
		end
	end
end
