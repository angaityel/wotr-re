-- chunkname: @scripts/entity_system/systems/spawner/spawner_system.lua

require("scripts/hub_elements/ai_spawner")
require("scripts/hub_elements/ai_wave_spawner")
require("scripts/hub_elements/ai_group_spawner")

SpawnerSystem = class(SpawnerSystem, ExtensionSystemBase)

function SpawnerSystem:init(...)
	SpawnerSystem.super.init(self, ...)

	self._deterministic = false
	self._active_spawners = {}

	local event_manager = Managers.state.event

	event_manager:register(self, "activate_ai_spawner", "flow_cb_activate_ai_spawner")
	event_manager:register(self, "deactivate_ai_spawner", "flow_cb_deactivate_ai_spawner")
end

function SpawnerSystem:set_deterministic(deterministic)
	self._deterministic = deterministic
end

function SpawnerSystem:flow_cb_activate_ai_spawner(spawner)
	self._active_spawners[spawner] = true

	local extension = ScriptUnit.extension(spawner, "spawner_system")

	extension:on_activate()

	local seed, random = Math.next_random(self._seed or 0, 1, 1000000)

	self._seed = seed
	self._random = random

	extension:set_deterministic(self._deterministic, self._random)
end

function SpawnerSystem:flow_cb_deactivate_ai_spawner(spawner)
	self._active_spawners[spawner] = nil

	local extension = ScriptUnit.extension(spawner, "spawner_system")

	extension:on_deactivate()
end

function SpawnerSystem:update_extension(extension_name, dt, context, t)
	for unit, _ in pairs(self._active_spawners) do
		local extension = ScriptUnit.extension(unit, self.NAME)
		local extension_input = ScriptUnit.extension_input(unit, self.NAME)

		extension:update(unit, extension_input, dt, context, t)
	end
end
