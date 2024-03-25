-- chunkname: @scripts/menu/menus/ingame_menu.lua

require("scripts/menu/menus/menu")
require("scripts/menu/menu_controller_settings/ingame_menu_controller_settings")
require("scripts/menu/menu_definitions/ingame_menu_definition")
require("scripts/menu/menu_callbacks/ingame_menu_callbacks")

IngameMenu = class(IngameMenu, Menu)

function IngameMenu:init(game_state, world, menu_data)
	IngameMenu.super.init(self, game_state, world, IngameMenuControllerSettings, IngameMenuSettings, IngameMenuDefinition, IngameMenuCallbacks, menu_data)

	self._local_player = menu_data.local_player
	self._camera_dummy_units = {}

	Managers.state.event:register(self, "menu_camera_dummy_spawned", "event_menu_camera_dummy_spawned")
end

function IngameMenu:event_menu_camera_dummy_spawned(name, unit)
	self._camera_dummy_units[name] = unit
end

function IngameMenu:_load_camera()
	local viewport_name = self._local_player.viewport_name
	local camera_manager = Managers.state.camera

	camera_manager:add_viewport(viewport_name, Vector3.zero(), Quaternion.identity())
	camera_manager:load_node_tree(viewport_name, "default", "ingame_menu")
	camera_manager:set_camera_node(viewport_name, "default", "default")
	camera_manager:set_variable(viewport_name, "look_controller_input", Vector3.zero())
end

function IngameMenu:cb_on_enter_page(page)
	self._teleport_camera = true
	self._current_camera = page:camera()
end

function IngameMenu:update(dt, t)
	IngameMenu.super.update(self, dt, t)
	self:_update_camera_position(dt)

	local controller_active = Managers.input:pad_active(1)

	if controller_active and self:current_page_is_root() and self._input_source:get("cancel") then
		self:set_active(false)
	end
end

function IngameMenu:_update_camera_position(dt)
	local viewport_name = self._local_player.viewport_name
	local camera_dummy_unit = self._camera_dummy_units[self._current_camera]

	if camera_dummy_unit then
		local camera_manager = Managers.state.camera
		local new_position, new_rotation
		local dummy_position = Unit.local_position(camera_dummy_unit, 0)
		local dummy_rotation = Unit.local_rotation(camera_dummy_unit, 0)

		if self._teleport_camera then
			new_position = dummy_position
			new_rotation = dummy_rotation
			self._teleport_camera = false
		else
			local current_position = camera_manager:camera_position(viewport_name)
			local current_rotation = camera_manager:camera_rotation(viewport_name)

			new_position = Vector3.lerp(current_position, dummy_position, dt * MenuSettings.camera_lerp_speed)
			new_rotation = Quaternion.lerp(current_rotation, dummy_rotation, dt * MenuSettings.camera_lerp_speed)
		end

		camera_manager:set_node_tree_root_position(viewport_name, "default", new_position)
		camera_manager:set_node_tree_root_rotation(viewport_name, "default", new_rotation)
	end
end

function IngameMenu:set_active(flag)
	IngameMenu.super.set_active(self, flag)
	Window.set_show_cursor(flag)
	Managers.state.event:trigger("ingame_menu_set_active", flag)

	if flag then
		Managers.state.hud:set_huds_enabled_except(false, {
			"game_mode_status",
			"spawn"
		})
	else
		Managers.state.hud:set_huds_enabled_except(true)
	end
end
