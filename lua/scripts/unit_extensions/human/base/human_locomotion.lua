-- chunkname: @scripts/unit_extensions/human/base/human_locomotion.lua

HumanLocomotion = class(HumanLocomotion)

function HumanLocomotion:init(world, unit)
	self.world = world
	self.unit = unit

	Unit.set_animation_merge_options(unit)

	self._states = {}
end

function HumanLocomotion:_init_internal_variables(unit, t, position, rotation)
	self.anim_forced_upper_body_block = 0
end

function HumanLocomotion:_freeze()
	self.frozen = true

	Unit.disable_animation_state_machine(self.unit)
end

function HumanLocomotion:_unfreeze()
	self.frozen = false

	Unit.enable_animation_state_machine(self.unit)
end

function HumanLocomotion:_create_state(state_name, state_class)
	self._states[state_name] = state_class:new(self.unit, self, self.world)
end

function HumanLocomotion:_change_state(state_name, ...)
	self.current_state:change_state(state_name, ...)
end

function HumanLocomotion:_set_init_state(state_name, ...)
	self.current_state = self._states[state_name]

	self.current_state:enter("none", ...)

	self.current_state_name = state_name
end

function HumanLocomotion:destroy()
	self.current_state:exit("none")

	for _, state in pairs(self._states) do
		state:destroy()
	end
end

function HumanLocomotion:gear_dead(unit)
	local inventory = self._inventory
	local slot_name = inventory:find_slot_by_unit(unit)
	local wielded = inventory:is_wielded(slot_name)
	local attachments = inventory:_gear(slot_name):attachments()

	if wielded then
		self.current_state:wielded_weapon_destroyed(slot_name)
	end

	inventory:gear_dead(slot_name, attachments)
end

function HumanLocomotion:stun()
	return
end

function HumanLocomotion:received_damage()
	return
end

function HumanLocomotion:damage_interrupt()
	return
end

function HumanLocomotion:anim_cb(callback, unit, param)
	local cb = self.current_state[callback]

	if cb then
		cb(self.current_state, unit, param)
	elseif self[callback] then
		self[callback](self, unit, param)
	else
		printf("[HumanLocomotion:anim_cb] Unit has no animation callback with name '%s' neither global nor in '%s'", callback, self.current_state_name)
	end
end

function HumanLocomotion:can(can_function_name, t)
	local current_state = self.current_state
	local can_function = current_state[can_function_name]

	if can_function then
		return can_function(current_state, t)
	else
		return false
	end
end

function HumanLocomotion:hurt_sound_event()
	return "chr_vce_hurt"
end
