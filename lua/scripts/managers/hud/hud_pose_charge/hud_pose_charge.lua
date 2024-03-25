-- chunkname: @scripts/managers/hud/hud_pose_charge/hud_pose_charge.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_pose_charge/hud_pose_charge_circle_segment")
require("scripts/managers/hud/hud_pose_charge/hud_pose_charge_gradient_circle")
require("scripts/managers/hud/shared_hud_elements/hud_rotating_marker")

HUDPoseCharge = class(HUDPoseCharge, HUDBase)

function HUDPoseCharge:init(world, player)
	HUDPoseCharge.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_pose_charge()

	self._fading = false
	self._active = false

	Managers.state.event:register(self, "event_pose_charge_activated", "event_pose_charge_activated", "event_pose_charge_fade", "event_pose_charge_fade", "event_pose_charge_deactivated", "_deactivate")
end

function HUDPoseCharge:_setup_pose_charge()
	self._pose_charge_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.pose_charge.container
	})

	local marker_config = {
		alpha_multiplier = 1,
		z = 20,
		circle_radius = 145,
		layout_settings = HUDSettings.pose_charge.marker
	}

	self._pose_charge_container:add_element("marker_one", HUDRotatingMarker.create_from_config(table.clone(marker_config)))
	self._pose_charge_container:add_element("marker_two", HUDRotatingMarker.create_from_config(table.clone(marker_config)))

	local circle_segment_config = {
		alpha_multiplier = 1,
		z = 15,
		circle_radius = 145,
		layout_settings = HUDSettings.pose_charge.circle_segment
	}

	self._pose_charge_container:add_element("circle_segment", HUDPoseChargeCircleSegment.create_from_config(circle_segment_config))

	local gradient_circle_config = {
		alpha_multiplier = 1,
		z = 10,
		layout_settings = HUDSettings.pose_charge.gradient_circle
	}

	self._pose_charge_container:add_element("gradient_circle", HUDPoseChargeGradientCircle.create_from_config(gradient_circle_config))
end

function HUDPoseCharge:event_pose_charge_activated(player, blackboard)
	if not HUDSettings.show_pose_charge_helper then
		return
	end

	if player == self._player then
		self._active = true
		self._fading = false
		self._blackboard = blackboard

		local elements = self._pose_charge_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
			element.config.name = id
			element.config.alpha_multiplier = 1
		end
	end
end

function HUDPoseCharge:event_pose_charge_fade(t, player)
	if player == self._player then
		self._fading = true
		self._fade_timer = t + 1
	end
end

function HUDPoseCharge:_deactivate(player)
	if player == self._player then
		self._active = false
		self._blackboard = nil

		local elements = self._pose_charge_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDPoseCharge:post_update(dt, t)
	if self._fading then
		if t >= self._fade_timer then
			self:_deactivate()

			self._fading = false

			local elements = self._pose_charge_container:elements()

			for id, element in pairs(elements) do
				element.config.alpha_multiplier = 0
			end
		else
			local elements = self._pose_charge_container:elements()

			for id, element in pairs(elements) do
				element.config.alpha_multiplier = (self._fade_timer - t) / 1
				element.config.swinging = true
			end
		end
	else
		local elements = self._pose_charge_container:elements()

		for id, element in pairs(elements) do
			element.config.swinging = false
		end
	end

	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._pose_charge_container.config.layout_settings)
	local gui = self._gui

	self._pose_charge_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._pose_charge_container, layout_settings)

	self._pose_charge_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._pose_charge_container:render(dt, t, gui, layout_settings)
end

function HUDPoseCharge:destroy()
	World.destroy_gui(self._world, self._gui)
end
