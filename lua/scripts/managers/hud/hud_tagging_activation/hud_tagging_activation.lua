-- chunkname: @scripts/managers/hud/hud_tagging_activation/hud_tagging_activation.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_texture_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")
require("scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_icon")
require("scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_timer")
require("scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_timer_background")
require("scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_cooldown")

HUDTaggingActivation = class(HUDTaggingActivation, HUDBase)

function HUDTaggingActivation:init(world, player)
	HUDTaggingActivation.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup()

	self._is_corporal = false
	self._active = false

	Managers.state.event:register(self, "player_became_corporal", "event_player_became_corporal")
	Managers.state.event:register(self, "player_no_longer_corporal", "event_player_no_longer_corporal")
	Managers.state.event:register(self, "player_spawned", "event_player_spawned")
	Managers.state.event:register(self, "player_unit_dead", "event_player_unit_dead")
end

function HUDTaggingActivation:event_player_became_corporal(player)
	if player == self._player then
		self._is_corporal = true

		local locomotion = ScriptUnit.extension(player.player_unit, "locomotion_system")
		local blackboard = locomotion.tagging_blackboard
		local elements = self._container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDTaggingActivation:event_player_no_longer_corporal(player)
	if player == self._player then
		self._is_corporal = false
	end
end

function HUDTaggingActivation:event_player_spawned(player)
	if player == self._player then
		self._active = true
	end
end

function HUDTaggingActivation:event_player_unit_dead(player)
	if player == self._player then
		self._active = false
	end
end

function HUDTaggingActivation:_setup()
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.tagging_activation.container
	})

	local icon_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.tagging_activation.icon)
	}

	self._container:add_element("icon", HUDTaggingActivationIcon.create_from_config(icon_config))

	local cooldown_config = {
		z = 2,
		layout_settings = table.clone(HUDSettings.tagging_activation.cooldown)
	}

	self._container:add_element("cooldown", HUDTaggingActivationCooldown.create_from_config(cooldown_config))

	local key_circle_config = {
		z = 3,
		layout_settings = table.clone(HUDSettings.tagging_activation.key_circle)
	}

	self._container:add_element("key_circle", HUDTextureElement.create_from_config(key_circle_config))

	local key_text_config = {
		text = "",
		z = 4,
		layout_settings = table.clone(HUDSettings.tagging_activation.key_text)
	}

	self._container:add_element("key_text", HUDTextElement.create_from_config(key_text_config))

	local timer_background_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.tagging_activation.timer_background)
	}

	self._container:add_element("timer_background", HUDTaggingActivationTimerBackground.create_from_config(timer_background_config))

	local timer_config = {
		z = 2,
		layout_settings = table.clone(HUDSettings.tagging_activation.timer)
	}

	self._container:add_element("timer", HUDTaggingActivationTimer.create_from_config(timer_config))
end

function HUDTaggingActivation:post_update(dt, t)
	if not self._active or not self._is_corporal then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
	local gui = self._gui

	self._container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

	self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._container:render(dt, t, gui, layout_settings)
end

function HUDTaggingActivation:destroy()
	World.destroy_gui(self._world, self._gui)
end
