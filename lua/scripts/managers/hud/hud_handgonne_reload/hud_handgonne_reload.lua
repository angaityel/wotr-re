-- chunkname: @scripts/managers/hud/hud_handgonne_reload/hud_handgonne_reload.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_circle_timer")
require("scripts/managers/hud/shared_hud_elements/hud_icon_timer")

HUDHandgonneReload = class(HUDHandgonneReload, HUDBase)

function HUDHandgonneReload:init(world, player)
	HUDHandgonneReload.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_handgonne_reload()
	Managers.state.event:register(self, "event_handgonne_reload_activated", "event_handgonne_reload_activated", "event_handgonne_reload_deactivated", "event_handgonne_reload_deactivated")
end

function HUDHandgonneReload:_setup_handgonne_reload()
	self._handgonne_reload_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.handgonne_reload.container
	})

	local timer_config = {
		z = 10,
		layout_settings = HUDSettings.handgonne_reload.timer
	}

	self._handgonne_reload_container:add_element("timer", HUDIconTimer.create_from_config(timer_config))
end

function HUDHandgonneReload:event_handgonne_reload_activated(dt, t, player, blackboard)
	if player == self._player then
		self._active = true

		local elements = self._handgonne_reload_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDHandgonneReload:event_handgonne_reload_deactivated(player)
	if player == self._player then
		self._active = false

		local elements = self._handgonne_reload_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDHandgonneReload:post_update(dt, t)
	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._handgonne_reload_container.config.layout_settings)
	local gui = self._gui

	self._handgonne_reload_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._handgonne_reload_container, layout_settings)

	self._handgonne_reload_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._handgonne_reload_container:render(dt, t, gui, layout_settings)
end

function HUDHandgonneReload:destroy()
	World.destroy_gui(self._world, self._gui)
end
