-- chunkname: @scripts/managers/hud/hud_hit_marker/hud_hit_marker.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_hit_marker/hud_hit_marker_marker")

HUDHitMarker = class(HUDHitMarker, HUDBase)

function HUDHitMarker:init(world, player)
	HUDHitMarker.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_hit_marker()
	Managers.state.event:register(self, "event_hit_marker_activated", "event_hit_marker_activated", "event_hit_marker_deactivated", "event_hit_marker_deactivated")
end

function HUDHitMarker:_setup_hit_marker()
	self._hit_marker_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.hit_marker.container
	})

	local marker_config = {
		z = 20,
		layout_settings = HUDSettings.hit_marker.marker
	}

	self._hit_marker_container:add_element("marker", HUDHitMarkerMarker.create_from_config(marker_config))
end

function HUDHitMarker:event_hit_marker_activated(player, hit_player)
	if not HUDSettings.show_reticule then
		return
	end

	if player == self._player then
		local same_team = hit_player and player.team == hit_player.team and true
		local elements = self._hit_marker_container:elements()

		for id, element in pairs(elements) do
			element.config.active = true
			element.config.same_team = same_team
		end

		self._active = true
	end
end

function HUDHitMarker:event_hit_marker_deactivated(player)
	if player == self._player then
		self._active = false
	end
end

function HUDHitMarker:post_update(dt, t)
	if not self._active then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._hit_marker_container.config.layout_settings)
	local gui = self._gui

	self._hit_marker_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._hit_marker_container, layout_settings)

	self._hit_marker_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._hit_marker_container:render(dt, t, gui, layout_settings)
end

function HUDHitMarker:destroy()
	World.destroy_gui(self._world, self._gui)
end
