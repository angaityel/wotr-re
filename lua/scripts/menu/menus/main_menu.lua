-- chunkname: @scripts/menu/menus/main_menu.lua

require("scripts/menu/menus/menu")
require("scripts/menu/menu_compiler")
require("scripts/menu/menu_logic")
require("scripts/menu/menu_containers/loading_indicator_menu_container")
require("scripts/utils/script_gui")

MainMenu = class(MainMenu, Menu)

function MainMenu:init(state, world, controller_settings, menu_settings, menu_definition, menu_callbacks, menu_data)
	MainMenu.super.init(self, state, world, controller_settings, menu_settings, menu_definition, menu_callbacks, menu_data)

	self._camera_dummy_units = menu_data.camera_dummy_units

	local layout_settings = MenuHelper:layout_settings(self._menu_settings.items.loading_indicator)

	self._loading_indicator = LoadingIndicatorMenuContainer.create_from_config(layout_settings, world)
	self._teleport_camera = true

	self:_load_camera()
	Managers.state.event:register(self, "event_load_started", "load_started", "event_load_finished", "load_finished", "event_save_started", "save_started", "event_save_finished", "save_finished")
end

function MainMenu:_load_camera()
	local camera_manager = Managers.state.camera

	camera_manager:add_viewport("menu_level_viewport", Vector3.zero(), Quaternion.identity())
	camera_manager:load_node_tree("menu_level_viewport", "default", "main_menu")
	camera_manager:set_camera_node("menu_level_viewport", "default", "default")
	camera_manager:set_variable("menu_level_viewport", "look_controller_input", Vector3.zero())
	camera_manager:change_environment("default", 0)
end

function MainMenu:update(dt, t)
	MainMenu.super.update(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self._menu_settings.items.loading_indicator)

	self._loading_indicator:update_size(dt, t, self._gui, layout_settings)

	local x, y = MenuHelper:container_position(self._loading_indicator, layout_settings)

	self._loading_indicator:update_position(dt, t, layout_settings, x, y, 500)
	self._loading_indicator:render(dt, t, self._gui, layout_settings)
	self:_update_camera_position(dt)
end

function MainMenu:_update_camera_position(dt)
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
			local current_position = camera_manager:camera_position("menu_level_viewport")
			local current_rotation = camera_manager:camera_rotation("menu_level_viewport")

			new_position = Vector3.lerp(current_position, dummy_position, dt * MenuSettings.camera_lerp_speed)
			new_rotation = Quaternion.lerp(current_rotation, dummy_rotation, dt * MenuSettings.camera_lerp_speed)
		end

		camera_manager:set_node_tree_root_position("menu_level_viewport", "default", new_position)
		camera_manager:set_node_tree_root_rotation("menu_level_viewport", "default", new_rotation)
	end
end

function MainMenu:load_started(text_loading, text_loaded)
	self._loading_indicator:load_started(text_loading, text_loaded)
end

function MainMenu:load_finished()
	self._loading_indicator:load_finished()
end

function MainMenu:save_started(text_saving, text_saved)
	self._loading_indicator:save_started(text_saving, text_saved)
end

function MainMenu:save_finished()
	self._loading_indicator:save_finished()
end

function MainMenu:cb_on_enter_page(page)
	local environment = page:environment()

	Managers.state.camera:change_environment(environment, 0)

	self._current_camera = page:camera()
end

function MainMenu:destroy()
	MainMenu.super.destroy(self)
	World.destroy_gui(self._world, self._gui)
end
