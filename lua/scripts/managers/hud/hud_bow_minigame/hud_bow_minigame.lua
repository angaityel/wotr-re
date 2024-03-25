-- chunkname: @scripts/managers/hud/hud_bow_minigame/hud_bow_minigame.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_texture_element")
require("scripts/managers/hud/hud_bow_minigame/hud_bow_minigame_hit_section")
require("scripts/managers/hud/shared_hud_elements/hud_rotating_marker")
require("scripts/managers/hud/hud_bow_minigame/hud_bow_minigame_timer")

HUDBowMinigame = class(HUDBowMinigame, HUDBase)

function HUDBowMinigame:init(world, player)
	HUDBowMinigame.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_bow_minigame()
	Managers.state.event:register(self, "event_bow_minigame_activated", "event_bow_minigame_activated")
	Managers.state.event:register(self, "event_bow_minigame_deactivated", "event_bow_minigame_deactivated")
end

function HUDBowMinigame:_setup_bow_minigame()
	self._bow_minigame_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.bow_minigame.container
	})

	local marker_config = {
		circle_radius = 76,
		z = 20,
		layout_settings = HUDSettings.bow_minigame.marker
	}

	self._bow_minigame_container:add_element("marker_one", HUDRotatingMarker.create_from_config(table.clone(marker_config)))
	self._bow_minigame_container:add_element("marker_two", HUDRotatingMarker.create_from_config(table.clone(marker_config)))
	self._bow_minigame_container:add_element("marker_three", HUDRotatingMarker.create_from_config(table.clone(marker_config)))
	self._bow_minigame_container:add_element("marker_four", HUDRotatingMarker.create_from_config(table.clone(marker_config)))

	local timer_one_config = {
		z = 15,
		layout_settings = HUDSettings.bow_minigame.timer_one
	}
	local timer_two_config = {
		z = 15,
		layout_settings = HUDSettings.bow_minigame.timer_two
	}
	local hit_section_config = {
		z = 10,
		layout_settings = HUDSettings.bow_minigame.hit_section
	}

	self._bow_minigame_container:add_element("hit_section", HUDBowMinigameHitSection.create_from_config(hit_section_config))

	local background_circle_config = {
		z = 5,
		layout_settings = HUDSettings.bow_minigame.background_circle
	}

	self._bow_minigame_container:add_element("background_circle", HUDTextureElement.create_from_config(background_circle_config))

	local crosshair_config = {
		z = 0,
		layout_settings = HUDSettings.bow_minigame.crosshair
	}
end

function HUDBowMinigame:event_bow_minigame_activated(player, blackboard)
	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		local elements = self._bow_minigame_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
			element.config.name = id
		end
	end
end

function HUDBowMinigame:event_bow_minigame_deactivated(player)
	if player == self._player then
		self._active = false

		local blackboard = self._blackboard

		if blackboard then
			blackboard.missing = false
			blackboard.hitting = false
		end

		self._blackboard = nil

		local elements = self._bow_minigame_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDBowMinigame:post_update(dt, t)
	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._bow_minigame_container.config.layout_settings)
	local gui = self._gui

	self._bow_minigame_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._bow_minigame_container, layout_settings)

	self._bow_minigame_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._bow_minigame_container:render(dt, t, gui, layout_settings)
end

function HUDBowMinigame:destroy()
	World.destroy_gui(self._world, self._gui)
end
