-- chunkname: @scripts/game_state/state_context.lua

StateContext = StateContext or {}

function StateContext.set_context(c)
	StateContext.context = c
end

function StateContext.get(parent, child)
	assert(StateContext.context[parent], "parent does not exist")

	return StateContext.context[parent][child]
end

function StateContext.manager(name)
	return StateContext.get("manager", name)
end

function StateContext.event()
	return StateContext.get("manager", "event")
end
