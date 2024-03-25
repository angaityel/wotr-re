-- chunkname: @scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_circle")
require("scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_cross")
require("scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_timer")
require("scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame_background_circle")

HUDCrossbowMinigame = class(HUDCrossbowMinigame, HUDBase)

function HUDCrossbowMinigame:init(world, player)
	HUDCrossbowMinigame.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_crossbow_minigame()
	Managers.state.event:register(self, "event_crossbow_minigame_activated", "event_crossbow_minigame_activated")
	Managers.state.event:register(self, "event_crossbow_minigame_deactivated", "event_crossbow_minigame_deactivated")
end

function HUDCrossbowMinigame:_setup_crossbow_minigame()
	self._crossbow_minigame_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.crossbow_minigame.container
	})

	local circle_config = {
		z = 15,
		layout_settings = HUDSettings.crossbow_minigame.circle
	}

	self._crossbow_minigame_container:add_element("circle", HUDCrossbowMinigameCircle.create_from_config(circle_config))

	local cross_config = {
		z = 20,
		layout_settings = HUDSettings.crossbow_minigame.cross
	}

	self._crossbow_minigame_container:add_element("cross", HUDCrossbowMinigameCross.create_from_config(cross_config))

	local timer_config = {
		z = 10,
		layout_settings = HUDSettings.crossbow_minigame.timer
	}

	self._crossbow_minigame_container:add_element("timer", HUDCrossbowMinigameTimer.create_from_config(timer_config))

	local background_circle_config = {
		z = 5,
		layout_settings = HUDSettings.crossbow_minigame.background_circle
	}

	self._crossbow_minigame_container:add_element("background_circle", HUDCrossbowMinigameBackgroundCircle.create_from_config(background_circle_config))
end

function HUDCrossbowMinigame:event_crossbow_minigame_activated(dt, t, player, blackboard)
	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		local elements = self._crossbow_minigame_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end

		self:post_update(dt, t)
	end
end

function HUDCrossbowMinigame:event_crossbow_minigame_deactivated(player)
	if player == self._player then
		self._active = false

		local blackboard = self._blackboard

		if blackboard then
			blackboard.missing = false
			blackboard.hitting = false
		end

		self._blackboard = nil

		local elements = self._crossbow_minigame_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDCrossbowMinigame:post_update(dt, t)
	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._crossbow_minigame_container.config.layout_settings)
	local gui = self._gui

	self._crossbow_minigame_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._crossbow_minigame_container, layout_settings)

	self._crossbow_minigame_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._crossbow_minigame_container:render(dt, t, gui, layout_settings)
end

function HUDCrossbowMinigame:destroy()
	World.destroy_gui(self._world, self._gui)
end
