-- chunkname: @scripts/unit_extensions/human/base/states/human_reviving_teammate.lua

require("scripts/unit_extensions/human/base/states/human_interacting")

HumanRevivingTeammate = class(HumanRevivingTeammate, HumanInteracting)

function HumanRevivingTeammate:init(unit, internal, world)
	HumanRevivingTeammate.super.init(self, unit, internal, world, "revive")

	self._target_unit = nil
end

function HumanRevivingTeammate:enter(old_state, target_unit, t)
	self._target_unit = target_unit

	HumanRevivingTeammate.super.enter(self, old_state, t)

	self._internal.reviving = true
end

function HumanRevivingTeammate:exit(new_state)
	HumanRevivingTeammate.super.exit(self, new_state)

	self._target_unit = nil
end

function HumanRevivingTeammate:_exit_on_fail()
	HumanRevivingTeammate.super._exit_on_fail(self)

	self._internal.reviving = false
end

function HumanRevivingTeammate:_exit_on_complete()
	HumanRevivingTeammate.super._exit_on_complete(self)

	self._internal.reviving = false
end
