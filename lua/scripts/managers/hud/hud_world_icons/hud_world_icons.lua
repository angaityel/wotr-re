-- chunkname: @scripts/managers/hud/hud_world_icons/hud_world_icons.lua

require("scripts/managers/hud/hud_world_icons/floating_hud_icon")
require("scripts/managers/hud/hud_world_icons/floating_player_hud_icon")
require("scripts/managers/hud/hud_world_icons/floating_objective_hud_icon")

HUDWorldIcons = class(HUDWorldIcons, HUDBase)

function HUDWorldIcons:init(world, player)
	HUDWorldIcons.super.init(self, world, player)

	self._world = world
	self._player = player

	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(world, viewport_name)

	self._camera = ScriptViewport.camera(viewport)
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")
	self._floating_icons = {}
	self._raycast_queue = {}

	Managers.state.event:register(self, "objective_activated", "event_objective_activated", "objective_deactivated", "event_objective_deactivated", "event_flag_spawned", "event_flag_spawned", "event_flag_destroyed", "event_flag_destroyed", "player_spawned", "event_player_spawned", "player_destroyed", "event_player_destroyed", "own_horse_spawned", "event_own_horse_spawned", "horse_destroyed", "event_horse_destroyed", "recieved_help_request", "event_recieved_help_request", "completed_revive", "event_completed_revive", "update_hud_objective_icons", "event_update_hud_objective_icons")
end

function HUDWorldIcons:event_update_hud_objective_icons(unit, icon_name, icon_name_2)
	fassert(self._floating_icons[unit], "No HUD objective icons exists for unit %s", unit)
	Unit.set_data(unit, "hud", "icon_name", icon_name)
	Unit.set_data(unit, "hud", "icon_name_2", icon_name_2)

	local floating_icon = self._floating_icons[unit].objective_icon
	local blackboard = floating_icon._blackboard

	self:_create_icon(blackboard, unit)
end

function HUDWorldIcons:event_objective_activated(blackboard, unit)
	if not self._floating_icons[unit] then
		self:_create_icon(blackboard, unit)
	end
end

function HUDWorldIcons:_create_icon(blackboard, unit)
	local icon_name = Unit.get_data(unit, "hud", "icon_name")
	local layout_settings = HUDSettings.world_icons[icon_name]
	local layout_settings_2
	local icon_name_2 = Unit.get_data(unit, "hud", "icon_name_2")

	if icon_name_2 and icon_name_2 ~= "" then
		layout_settings_2 = HUDSettings.world_icons[icon_name_2]
	end

	local tagging_layout_settings = HUDSettings.world_icons.objective_tag
	local progress_settings = HUDSettings.world_icons.objective_progress

	self._floating_icons[unit] = {}
	self._floating_icons[unit].objective_icon = FloatingObjectiveHUDIcon:new(blackboard, self._gui, unit, self._camera, self._world, {
		layout_settings = layout_settings,
		layout_settings_2 = layout_settings_2,
		tagging_layout_settings = tagging_layout_settings
	}, self._player)
end

function HUDWorldIcons:event_objective_deactivated(unit)
	self:_destroy_icon(unit)
end

function HUDWorldIcons:event_flag_spawned(blackboard, unit)
	local icon_name = Unit.get_data(unit, "hud", "icon_name")
	local layout_settings = HUDSettings.world_icons[icon_name]

	self._floating_icons[unit] = {}
	self._floating_icons[unit].flag_icon = FloatingHUDIcon:new(blackboard, self._gui, unit, self._camera, self._world, {
		layout_settings = layout_settings
	}, self._player)
end

function HUDWorldIcons:event_flag_destroyed(unit)
	self:_destroy_icon(unit)
end

function HUDWorldIcons:event_player_spawned(player, unit)
	if not self._floating_icons[unit] then
		local icon_name = Unit.get_data(unit, "hud", "icon_name")
		local layout_settings = HUDSettings.world_icons[icon_name]

		self._floating_icons[unit] = {}
		self._floating_icons[unit].name_tag = FloatingPlayerHUDIcon:new(self._gui, self._player, unit, self._camera, self._world, {
			layout_settings = layout_settings
		})

		local player_tag_layout_settings = HUDSettings.world_icons.player_tag

		self._floating_icons[unit].player_tag = FloatingHUDIcon:new(nil, self._gui, unit, self._camera, self._world, {
			layout_settings = player_tag_layout_settings
		}, self._player, nil, "Spine2")
	end
end

function HUDWorldIcons:_destroy_icon(unit)
	local icon = self._floating_icons[unit]

	if icon then
		for key, object in pairs(icon) do
			if type(object) == "table" and object.destroy then
				object:destroy()
			end
		end
	end

	self._floating_icons[unit] = nil
	self._raycast_queue[unit] = nil
end

function HUDWorldIcons:event_player_destroyed(unit)
	self:_destroy_icon(unit)
end

function HUDWorldIcons:event_own_horse_spawned(player, blackboard)
	local mount_unit = blackboard.mount_unit
	local player_unit = blackboard.player_unit

	if Unit.alive(mount_unit) and not self._floating_icons[mount_unit] then
		local layout_settings = HUDSettings.world_icons.current_horse

		self._floating_icons[mount_unit] = {}
		self._floating_icons[mount_unit].mount_icon = FloatingHUDIcon:new(nil, self._gui, mount_unit, self._camera, self._world, {
			layout_settings = layout_settings
		}, self._player, player_unit)
	end
end

function HUDWorldIcons:event_horse_destroyed(mount_unit)
	self:_destroy_icon(mount_unit)
end

function HUDWorldIcons:event_recieved_help_request(unit)
	local help_request_tag_layout_settings = HUDSettings.world_icons.help_request_tag

	self._floating_icons[unit].help_request_tag = FloatingHUDIcon:new(nil, self._gui, unit, self._camera, self._world, {
		layout_settings = help_request_tag_layout_settings
	}, self._player)
end

function HUDWorldIcons:event_completed_revive(unit)
	self._floating_icons[unit].help_request_tag = nil
end

function HUDWorldIcons:post_update(dt, t)
	for _, icons in pairs(self._floating_icons) do
		for _, icon in pairs(icons) do
			local layout_settings = HUDHelper:layout_settings(icon.config.layout_settings)
			local layout_settings_2

			if icon.config.layout_settings_2 then
				layout_settings_2 = HUDHelper:layout_settings(icon.config.layout_settings_2)
			end

			if icon.wants_line_of_sight_check and icon:wants_line_of_sight_check() and not self._raycast_queue[icon:unit()] then
				self._raycast_queue[icon:unit()] = t
			end

			icon:post_update(dt, t, layout_settings, layout_settings_2)
		end
	end

	self:_update_raycast_queue()
end

function HUDWorldIcons:_update_raycast_queue()
	local oldest_t = math.huge
	local unit

	for u, t in pairs(self._raycast_queue) do
		if t < oldest_t then
			oldest_t = t
			unit = u
		end
	end

	if unit then
		for _, icon in pairs(self._floating_icons[unit]) do
			if icon.wants_line_of_sight_check and icon:wants_line_of_sight_check() then
				icon:check_line_of_sight()
			end
		end

		self._raycast_queue[unit] = nil
	end
end

function HUDWorldIcons:destroy()
	World.destroy_gui(self._world, self._gui)
end
