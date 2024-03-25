-- chunkname: @scripts/managers/hud/hud_lance_recharge/hud_lance_recharge.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_circle_timer")
require("scripts/managers/hud/shared_hud_elements/hud_icon_timer")

HUDLanceRecharge = class(HUDLanceRecharge, HUDBase)

function HUDLanceRecharge:init(world, player)
	HUDLanceRecharge.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_lance_recharge()
	Managers.state.event:register(self, "event_lance_recharge_activated", "event_lance_recharge_activated", "event_lance_recharge_deactivated", "event_lance_recharge_deactivated")
end

function HUDLanceRecharge:_setup_lance_recharge()
	self._lance_recharge_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.lance_recharge.container
	})

	local timer_config = {
		z = 10,
		layout_settings = HUDSettings.lance_recharge.timer
	}

	self._lance_recharge_container:add_element("timer", HUDIconTimer.create_from_config(timer_config))
end

function HUDLanceRecharge:event_lance_recharge_activated(dt, t, player, blackboard)
	if player == self._player then
		self._active = true

		local elements = self._lance_recharge_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDLanceRecharge:event_lance_recharge_deactivated(player)
	if player == self._player then
		self._active = false

		local elements = self._lance_recharge_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDLanceRecharge:post_update(dt, t)
	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._lance_recharge_container.config.layout_settings)
	local gui = self._gui

	self._lance_recharge_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._lance_recharge_container, layout_settings)

	self._lance_recharge_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._lance_recharge_container:render(dt, t, gui, layout_settings)
end

function HUDLanceRecharge:destroy()
	World.destroy_gui(self._world, self._gui)
end
