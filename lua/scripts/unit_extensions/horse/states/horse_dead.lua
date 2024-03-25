-- chunkname: @scripts/unit_extensions/horse/states/horse_dead.lua

HorseDead = class(HorseDead, HorseMovementStateBase)

function HorseDead:init(unit, internal, world)
	self._unit = unit
	self._internal = internal
end

function HorseDead:update(unit, internal, controller, dt, context)
	local unit = self._unit

	self._despawn_timer = self._despawn_timer + dt

	if not self._despawned and self._despawn_timer > 15 then
		local network_manager = Managers.state.network
		local entity_manager = context.entity_manager
		local world = context.world
		local game = network_manager:game()

		if game then
			local object_id = network_manager:unit_game_object_id(unit)

			network_manager:destroy_game_object(object_id)
		else
			entity_manager:remove_unit(unit)
			World.destroy_unit(world, unit)

			if script_data.damage_debug then
				print("[HorseDead] unit " .. tostring(unit))
			end
		end

		self._despawned = true
	end
end

function HorseDead:post_update(unit, internal, controller, dt, context)
	return
end

function HorseDead:enter(old_state)
	HorseDead.super.enter(self, old_state)

	self._despawn_timer = 0
	self._despawned = false

	self:anim_event("horse_death")
end

function HorseDead:destroy()
	return
end

function HorseDead:change_state(new_state)
	return
end
