-- chunkname: @scripts/unit_extensions/human/ai_player_unit/states/ai_dead.lua

require("scripts/unit_extensions/human/base/states/human_onground")

AIDead = class(AIDead, HumanDead)

function AIDead:init(unit, internal, world)
	self._unit = unit
	self._internal = internal
	self._world = world
end

function AIDead:enter()
	self._despawned = false
	self._despawn_timer = 0

	self:anim_event("knocked_down")

	local ai_base = ScriptUnit.extension(self._unit, "ai_system")

	ai_base:brain():set_behaviours("main", "dead")
end

function AIDead:update(dt, t, context)
	self._despawn_timer = self._despawn_timer + dt

	if not self._despawned and self._despawn_timer >= 5 then
		local network_manager = Managers.state.network

		if network_manager:game() then
			local object_id = network_manager:unit_game_object_id(self._unit)

			network_manager:destroy_game_object(object_id)
		else
			Managers.state.entity:unregister_unit(self._unit)
			World.destroy_unit(self._world, self._unit)
		end

		self._despawned = true
	end
end

function AIDead:post_update(dt, t)
	return
end

function AIDead:anim_event(event, force_local)
	local unit = self._unit

	if not Unit.has_animation_state_machine(unit) then
		return
	end

	Unit.animation_event(unit, event)
end
