-- chunkname: @scripts/unit_extensions/human/base/states/human_interacting.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")
require("scripts/helpers/interaction_helper")

HumanInteracting = class(HumanInteracting, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5

function HumanInteracting:init(unit, internal, world, interaction_type)
	self._unit = unit
	self._internal = internal
	self._complete_time = nil
	self._interaction_type = interaction_type
	self._player = internal.player
	self._interaction_confirmed = false
	self._interaction_denied = false
	self._controller_mapping = "interacting"
end

function HumanInteracting:update(dt, t)
	HumanInteracting.super.update(self, dt, t)

	local controller = self._internal.controller
	local interacting_input = controller and controller:get(self._controller_mapping) > BUTTON_THRESHOLD

	self._player.state_data.interaction_progress = self._complete_time - t

	if t > self._complete_time and self._interaction_confirmed then
		self:_exit_on_complete()
		self:change_state("onground")
	elseif not interacting_input and self._interaction_confirmed then
		self:_exit_on_fail()
		self:change_state("onground")
	end
end

function HumanInteracting:_interaction_settings()
	return PlayerUnitMovementSettings.interaction.settings[self._interaction_type]
end

function HumanInteracting:post_update(dt)
	self:update_camera(dt)

	local internal = self._internal

	if internal.id and internal.game then
		GameSession.set_game_object_field(internal.game, internal.id, "velocity", internal.velocity:unbox())
	end
end

function HumanInteracting:_exit_on_fail()
	self._internal.interacting = false
end

function HumanInteracting:_exit_on_complete()
	self._internal.interacting = false
end

function HumanInteracting:_interact_duration()
	return PlayerUnitMovementSettings.interaction.settings[self._interaction_type].duration
end

function HumanInteracting:enter(old_state, t)
	local internal = self._internal

	internal.velocity:store(Vector3(0, 0, 0))

	local duration = self:_interact_duration()

	self._complete_time = t + duration
	internal.interacting = true
	self._interaction_confirmed = false
	self._interaction_denied = false

	local interaction_settings = self:_interaction_settings()
	local begin_anim_event = interaction_settings.begin_anim_event
	local animation_time_var = interaction_settings.animation_time_var

	if begin_anim_event and animation_time_var then
		self:anim_event_with_variable_float(begin_anim_event, animation_time_var, duration)
	elseif begin_anim_event then
		self:anim_event(begin_anim_event)
	end
end

function HumanInteracting:interaction_confirmed()
	self._interaction_confirmed = true
end

function HumanInteracting:interaction_denied()
	self._interaction_denied = true
end

function HumanInteracting:exit(new_state)
	HumanInteracting.super.exit(self, new_state)

	local internal = self._internal
	local end_anim_event = self:_interaction_settings().end_anim_event

	if end_anim_event then
		self:anim_event(end_anim_event)
	end

	if internal.interacting and not self._interaction_denied then
		self:_exit_on_fail()
	elseif internal.interacting then
		internal.interacting = false
	end

	self._player.state_data.interaction_progress = nil
end

function HumanInteracting:destroy()
	return
end
