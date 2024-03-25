-- chunkname: @foundation/scripts/util/state_machine.lua

StateMachine = class(StateMachine)
StateMachine.DEBUG = false

function StateMachine:init(parent, start_state, params)
	self._parent = parent
	self._params = params

	self:_change_state(start_state, params)

	if StateMachine.DEBUG then
		print("Init state", start_state.NAME)
	end
end

function StateMachine:_change_state(new_state, params)
	if self._state and self._state.on_exit then
		self._state:on_exit()
	end

	self._state = new_state:new()
	self._state.parent = self._parent

	if self._state.on_enter then
		self._state:on_enter(params)
	end
end

function StateMachine:update(dt, t)
	local new_state = self._state:update(dt, t)

	if new_state then
		if StateMachine.DEBUG then
			print("Changing state to", new_state.NAME)
		end

		self:_change_state(new_state, self._params)
	end
end

function StateMachine:post_update(dt, t)
	if self._state and self._state.post_update then
		self._state:post_update(dt, t)
	end
end

function StateMachine:render()
	if self._state and self._state.render then
		self._state:render()
	end
end

function StateMachine:destroy()
	if self._state and self._state.on_exit then
		self._state:on_exit()
	end
end
