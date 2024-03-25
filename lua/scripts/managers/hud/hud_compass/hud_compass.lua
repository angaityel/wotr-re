-- chunkname: @scripts/managers/hud/hud_compass/hud_compass.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_compass/hud_compass_direction_icon")
require("scripts/managers/hud/hud_compass/hud_compass_unit_icon")

HUDCompass = class(HUDCompass, HUDBase)

function HUDCompass:init(world, player)
	HUDCompass.super.init(self, world, player)

	self._world = world
	self._player = player

	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(world, viewport_name)

	self._camera = ScriptViewport.camera(viewport)
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_compass()

	local event_manager = Managers.state.event

	event_manager:register(self, "objective_activated", "event_objective_activated")
	event_manager:register(self, "objective_deactivated", "event_objective_deactivated")
	event_manager:register(self, "event_flag_spawned", "event_flag_spawned")
	event_manager:register(self, "event_flag_destroyed", "event_flag_destroyed")
end

function HUDCompass:_setup_compass()
	self._compass_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.compass.container
	})

	local level_settings = LevelHelper:current_level_settings()
	local level_rotation = level_settings.minimap.rot or 0
	local init_dir = Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(level_rotation)), Vector3(0, 1, 0))
	local n_dir = Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(0)), init_dir)
	local w_dir = Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(90)), init_dir)
	local s_dir = Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(180)), init_dir)
	local e_dir = Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(270)), init_dir)
	local n_icon_config = {
		text = "N",
		world_direction = {
			n_dir.x,
			n_dir.y
		},
		camera = self._camera,
		world = self._world,
		layout_settings = HUDSettings.compass.direction_icon
	}

	self._compass_container:add_element("north", HUDCompassDirectionIcon.create_from_config(n_icon_config))

	local s_icon_config = {
		text = "S",
		world_direction = {
			s_dir.x,
			s_dir.y
		},
		camera = self._camera,
		world = self._world,
		layout_settings = HUDSettings.compass.direction_icon
	}

	self._compass_container:add_element("south", HUDCompassDirectionIcon.create_from_config(s_icon_config))

	local e_icon_config = {
		text = "E",
		world_direction = {
			e_dir.x,
			e_dir.y
		},
		camera = self._camera,
		world = self._world,
		layout_settings = HUDSettings.compass.direction_icon
	}

	self._compass_container:add_element("east", HUDCompassDirectionIcon.create_from_config(e_icon_config))

	local w_icon_config = {
		text = "W",
		world_direction = {
			w_dir.x,
			w_dir.y
		},
		camera = self._camera,
		world = self._world,
		layout_settings = HUDSettings.compass.direction_icon
	}

	self._compass_container:add_element("west", HUDCompassDirectionIcon.create_from_config(w_icon_config))
end

function HUDCompass:event_objective_activated(blackboard, unit)
	if not self._compass_container:has_element(unit) then
		self:_add_unit_icon(blackboard, unit)
	end
end

function HUDCompass:event_objective_deactivated(unit)
	if self._compass_container:has_element(unit) then
		self._compass_container:remove_element(unit)
	end
end

function HUDCompass:event_flag_spawned(blackboard, unit)
	self:_add_unit_icon(blackboard, unit)
end

function HUDCompass:event_flag_destroyed(unit)
	self._compass_container:remove_element(unit)
end

function HUDCompass:_add_unit_icon(blackboard, unit)
	local config = {
		blackboard = blackboard,
		unit = unit,
		camera = self._camera,
		world = self._world,
		z = self._compass_container:num_of_elements() + 10,
		layout_settings = HUDSettings.compass.unit_icon,
		player = self._player
	}

	self._compass_container:add_element(unit, HUDCompassUnitIcon.create_from_config(config))
end

function HUDCompass:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._compass_container.config.layout_settings)
	local gui = self._gui

	self._compass_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._compass_container, layout_settings)

	self._compass_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._compass_container:render(dt, t, gui, layout_settings)
end

function HUDCompass:destroy()
	World.destroy_gui(self._world, self._gui)
end
