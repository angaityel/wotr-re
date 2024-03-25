-- chunkname: @scripts/managers/hud/hud_parry_helper/hud_parry_helper.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_parry_helper/hud_parry_helper_element")

HUDParryHelper = class(HUDParryHelper, HUDBase)

function HUDParryHelper:init(world, player)
	HUDParryHelper.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_parry_helper()

	self._active = false

	Managers.state.event:register(self, "event_parry_helper_activated", "event_parry_helper_activated", "event_parry_helper_deactivated", "event_parry_helper_deactivated")
end

function HUDParryHelper:_setup_parry_helper()
	self._parry_helper_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.parry_helper.container
	})

	local parry_direction_config = {
		circle_radius = 105,
		z = 30,
		layout_settings = HUDSettings.parry_helper.parry_direction
	}

	self._parry_helper_container:add_element("parry_direction", HUDParryHelperElement.create_from_config(parry_direction_config))

	local attack_direction_config = {
		circle_radius = 190,
		z = 30,
		layout_settings = HUDSettings.parry_helper.attack_direction
	}

	self._parry_helper_container:add_element("attack_direction", HUDParryHelperElement.create_from_config(attack_direction_config))
end

function HUDParryHelper:event_parry_helper_activated(player, blackboard)
	if not HUDSettings.show_parry_helper then
		return
	end

	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		local elements = self._parry_helper_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
			element.config.name = id
		end
	end
end

function HUDParryHelper:event_parry_helper_deactivated(player)
	if player == self._player then
		self._active = false

		local elements = self._parry_helper_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDParryHelper:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._parry_helper_container.config.layout_settings)
	local gui = self._gui

	if self._active then
		self._parry_helper_container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._parry_helper_container, layout_settings)

		self._parry_helper_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._parry_helper_container:render(dt, t, gui, layout_settings)
	end
end

function HUDParryHelper:destroy()
	World.destroy_gui(self._world, self._gui)
end
