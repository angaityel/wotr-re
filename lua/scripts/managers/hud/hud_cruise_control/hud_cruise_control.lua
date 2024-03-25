-- chunkname: @scripts/managers/hud/hud_cruise_control/hud_cruise_control.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_cruise_control/hud_cruise_control_icon")

HUDCruiseControl = class(HUDCruiseControl, HUDBase)

function HUDCruiseControl:init(world, player)
	HUDCruiseControl.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "immediate")

	self:_setup()

	self._active = false
	self._mount_locomotion = nil

	Managers.state.event:register(self, "local_player_mounted", "event_local_player_mounted")
	Managers.state.event:register(self, "local_player_dismounted", "event_local_player_dismounted")
end

function HUDCruiseControl:_setup()
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.cruise_control.container
	})

	local icon_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.cruise_control.icon)
	}

	self._container:add_element("icon", HUDCruiseControlIcon.create_from_config(icon_config))
end

function HUDCruiseControl:event_local_player_mounted(player, mount_locomotion, blackboard)
	if player == self._player then
		self._active = true
		self._mount_locomotion = mount_locomotion

		local elements = self._container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDCruiseControl:event_local_player_dismounted(player)
	if player == self._player then
		self._active = false
		self._mount_locomotion = nil

		local elements = self._container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDCruiseControl:post_update(dt, t)
	if not self._active then
		return
	end

	local pad_active = Managers.input:pad_active(1)

	if pad_active then
		return
	end

	local player_unit = self._player.player_unit
	local locomotion = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system")

	if not locomotion or not locomotion.mounted_unit then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
	local gui = self._gui

	self._container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

	self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._container:render(dt, t, gui, layout_settings)
end

function HUDCruiseControl:destroy()
	World.destroy_gui(self._world, self._gui)
end
