-- chunkname: @scripts/unit_extensions/human/ai_player_unit/states/ai_stunned.lua

require("scripts/unit_extensions/human/base/states/human_stunned")

AIStunned = class(AIStunned, HumanStunned)

function AIStunned:enter(old_state)
	AIStunned.super.enter(self, old_state)
	self:safe_action_interrupt("stunned")

	local animation_stun_time = PlayerUnitDamageSettings.stun.duration

	self._stun_time = animation_stun_time + Managers.time:time("game")

	self:anim_event_with_variable_float("stun_back_head_down", "stun_time", animation_stun_time)
end

function AIStunned:exit(new_state)
	self:anim_event("stun_end")

	self._stun_time = nil
end

function AIStunned:update(dt, t)
	if t > self._stun_time then
		self:change_state("onground")
	end
end

function AIStunned:post_update(dt, t)
	return
end

function AIStunned:melee_attack(...)
	return
end

function AIStunned:block_attack(...)
	return
end

function AIStunned:wield_weapon(...)
	return
end

function AIStunned:_abort_pose()
	AIStunned.super._abort_pose(self)

	self._internal.melee_attack = false
end

function AIStunned:swing_finished()
	AIStunned.super.swing_finished(self)

	self._internal.melee_attack = false
end
