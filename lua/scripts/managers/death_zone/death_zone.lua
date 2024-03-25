-- chunkname: @scripts/managers/death_zone/death_zone.lua

DeathZone = class(DeathZone)

function DeathZone:init(level, volume_name)
	self._level = level
	self._volume_name = volume_name
end

function DeathZone:update(dt, t, unit)
	if Unit.alive(unit) then
		local damage_extension = ScriptUnit.extension(unit, "damage_system")

		if damage_extension:is_alive() then
			local unit_pos = Unit.world_position(unit, 0) + Vector3.up()

			if Level.is_point_inside_volume(self._level, self._volume_name, unit_pos) then
				local owner = Managers.player:owner(unit)

				damage_extension:die(owner, nil, nil, "death_zone")
			end
		end
	end
end
