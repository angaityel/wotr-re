-- chunkname: @scripts/unit_extensions/human/base/states/human_executing.lua

require("scripts/unit_extensions/human/base/states/human_interacting")

HumanExecuting = class(HumanExecuting, HumanInteracting)

function HumanExecuting:init(unit, internal, world)
	HumanExecuting.super.init(self, unit, internal, world, "execute")

	self._target_unit = nil
end

function HumanExecuting:enter(old_state, target_unit, t)
	HumanExecuting.super.enter(self, old_state, t)

	self._target_unit = target_unit
	self._internal.executing = true
end

function HumanExecuting:exit(new_state)
	HumanExecuting.super.exit(self, new_state)

	self._target_unit = nil
end

function HumanExecuting:_exit_on_fail()
	HumanExecuting.super._exit_on_fail(self)

	self._internal.executing = false
end

function HumanExecuting:_exit_on_complete()
	HumanExecuting.super._exit_on_complete(self)

	self._internal.executing = false
end

function HumanExecuting:update(dt, t)
	HumanExecuting.super.super.update(self, dt, t)

	self._player.state_data.interaction_progress = self._complete_time + PlayerUnitMovementSettings.interaction.settings.execute.duration_after_kill - t

	if t > self._complete_time and self._internal.interacting and self._interaction_confirmed then
		self:_exit_on_complete()
	elseif t > self._complete_time + PlayerUnitMovementSettings.interaction.settings.execute.duration_after_kill and self._interaction_confirmed then
		self:change_state("onground")
	end
end
