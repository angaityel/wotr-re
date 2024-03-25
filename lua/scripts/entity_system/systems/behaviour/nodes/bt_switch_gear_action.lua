-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_switch_gear_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSwitchGearAction = class(BTSwitchGearAction, BTNode)

function BTSwitchGearAction:init(...)
	BTSwitchGearAction.super.init(self, ...)
	fassert(self._data.slot_name, "No weapon slot name stated for %q", self._name)
end

function BTSwitchGearAction:setup(unit, blackboard, profile)
	self._slot_name = self._data.slot_name
end

function BTSwitchGearAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local slot_name = self._slot_name

	if not locomotion.wield_new_weapon then
		locomotion:wield_weapon(slot_name)
	end
end

function BTSwitchGearAction:_choose_best_gear()
	return
end
