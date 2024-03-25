-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_event_handler.lua

AIEventHandler = class(AIEventHandler)

function AIEventHandler:init(unit)
	self._unit = unit

	Managers.state.event:register(self, "ai_event_stopped", "ai_stopped", "ai_event_moving", "ai_moving")
end

function AIEventHandler:ai_stopped(unit)
	if self._unit ~= unit then
		return
	end

	local brain = ScriptUnit.extension(self._unit, "ai_system"):brain()

	if brain:has_behaviour("avoidance") then
		brain:change_behaviour("avoidance", "nil_tree")
	end
end

function AIEventHandler:ai_moving(unit)
	if self._unit ~= unit then
		return
	end

	local brain = ScriptUnit.extension(self._unit, "ai_system"):brain()

	if brain:has_behaviour("avoidance") then
		brain:change_behaviour("avoidance", "default_avoidance")
	end
end
