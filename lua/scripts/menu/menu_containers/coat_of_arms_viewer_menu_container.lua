-- chunkname: @scripts/menu/menu_containers/coat_of_arms_viewer_menu_container.lua

require("scripts/menu/menu_containers/unit_viewer_menu_container")

CoatOfArmsViewerMenuContainer = class(CoatOfArmsViewerMenuContainer, UnitViewerMenuContainer)

function CoatOfArmsViewerMenuContainer:init(world_name, viewport_name)
	CoatOfArmsViewerMenuContainer.super.init(self, world_name)

	self._viewport_name = viewport_name
	self._alignment_units = {}
end

function CoatOfArmsViewerMenuContainer:add_alignment_unit(name, unit)
	self._alignment_units[name] = unit
end

function CoatOfArmsViewerMenuContainer:clear()
	self:remove_unit("shield")
end

function CoatOfArmsViewerMenuContainer:load_coat_of_arms(settings, offset_forward, offset_up, offset_right)
	self:remove_unit("shield")
	self:load_shield(settings, offset_forward, offset_up, offset_right)
	self:load_helmet(settings)
	self:load_helmet_crest(settings)
end

function CoatOfArmsViewerMenuContainer:load_shield(settings, offset_forward, offset_up, offset_right)
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_unit = Camera.get_data(camera, "unit")
	local cam_pos = Unit.local_position(camera_unit, 0)
	local cam_rot = Unit.local_rotation(camera_unit, 0)
	local position, rotation

	if self._alignment_units.coat_of_arms then
		position = Unit.local_position(self._alignment_units.coat_of_arms, 0)
		rotation = Unit.local_rotation(self._alignment_units.coat_of_arms, 0)
	else
		position = cam_pos + Quaternion.forward(cam_rot) * (offset_forward or 0) + Quaternion.up(cam_rot) * (offset_up or 0) + Quaternion.right(cam_rot) * (offset_right or 0)

		local dir = cam_pos - position

		Vector3.set_z(dir, 0)

		rotation = Quaternion.look(dir, Vector3.up())
	end

	local spawn_config = {
		unit_name = CoatOfArmsHelper:coat_of_arms_setting("shields", settings.shield).ui_unit,
		position = position,
		rotation = rotation
	}

	self:spawn_unit(nil, "shield", spawn_config)
	self:set_coat_of_arms_material_properties(settings)
end

function CoatOfArmsViewerMenuContainer:set_coat_of_arms_material_properties(settings)
	local shield_unit = self:unit("shield")

	CoatOfArmsHelper:set_material_properties(settings, shield_unit, "g_heraldry_projection", "mtr_heraldry_projection", settings.ui_team_name)

	local mesh = Unit.mesh(shield_unit, "g_mantling")
	local material = Mesh.material(mesh, "mtr_coat_of_arms_mantling")
	local color_index = "mantling_color"

	if settings.field_color == "team_primary" or settings.field_color == "team_secondary" then
		color_index = color_index .. "_team_" .. settings.ui_team_name
	end

	local field_color_table = CoatOfArmsHelper:coat_of_arms_setting("field_colors", settings.field_color)[color_index]
	local field_color = Vector3(field_color_table[1] / 255, field_color_table[2] / 255, field_color_table[3] / 255)

	Material.set_vector3(material, "tint_rgb", field_color)

	local color_index = "mantling_color"

	if settings.division_color == "team_primary" or settings.division_color == "team_secondary" then
		color_index = color_index .. "_team_" .. settings.ui_team_name
	end

	local division_color_table = CoatOfArmsHelper:coat_of_arms_setting("division_colors", settings.division_color)[color_index]
	local division_color = Vector3(division_color_table[1] / 255, division_color_table[2] / 255, division_color_table[3] / 255)

	Material.set_vector3(material, "tint1_rgb", division_color)
end

function CoatOfArmsViewerMenuContainer:load_helmet(settings)
	local helmet_settings = CoatOfArmsHelper:coat_of_arms_setting("helmets", settings.helmet)
	local spawn_config = {
		unit_name = helmet_settings.ui_unit,
		attachment_node_linking = helmet_settings.ui_attachment_node_linking,
		animation_events = {}
	}

	self:spawn_unit("shield", "helmet", spawn_config)
end

function CoatOfArmsViewerMenuContainer:load_helmet_crest(settings)
	local crest_settings = CoatOfArmsHelper:coat_of_arms_setting("crests", settings.crest)

	if not crest_settings.ui_unit then
		return
	end

	local spawn_config = {
		unit_name = crest_settings.ui_unit,
		attachment_node_linking = crest_settings.ui_attachment_node_linking,
		animation_events = {}
	}

	self:spawn_unit("helmet", "crest", spawn_config)
end

function CoatOfArmsViewerMenuContainer:render(dt, t, gui, layout_settings)
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local res_width, res_height = Gui.resolution()
	local width = self._width / res_width
	local height = self._height / res_height

	self._viewport_x = self._x / res_width
	self._viewport_y = math.floor(res_height - self._y - self._height) / res_height

	Viewport.set_rect(viewport, self._viewport_x, self._viewport_y, width, height)
end

function CoatOfArmsViewerMenuContainer.create_from_config(world_name, viewport_name)
	return CoatOfArmsViewerMenuContainer:new(world_name, viewport_name)
end
