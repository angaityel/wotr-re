-- chunkname: @scripts/managers/hud/hud_compass/hud_compass_unit_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDCompassUnitIcon = class(HUDCompassUnitIcon)

function HUDCompassUnitIcon:init(config)
	local unit = config.unit

	if Unit.has_data(unit, "hud", "icon_world_position_offset") then
		self._unit_offset = Vector3Box(Unit.get_data(unit, "hud", "icon_world_position_offset", "x"), Unit.get_data(unit, "hud", "icon_world_position_offset", "y"), Unit.get_data(unit, "hud", "icon_world_position_offset", "z"))
	end

	self.config = config
	self._blackboard = config.blackboard
	self._is_clamped = false
	self._scale = 1
end

function HUDCompassUnitIcon:width()
	return self._width
end

function HUDCompassUnitIcon:height()
	return self._height
end

function HUDCompassUnitIcon:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local icon_name = Unit.get_data(self.config.unit, "hud", "icon_name")
	local icon_settings = layout_settings.icons[icon_name]
	local texture = icon_settings.texture_func and icon_settings.texture_func(config.blackboard, config.player, config.unit, self._world)

	if not texture then
		self._width = 0
		self._height = 0

		return
	end

	if self._is_clamped then
		self._scale = icon_settings.clamped_scale
	else
		self._scale = icon_settings.scale
	end

	self._width = texture.size[1] * self._scale
	self._height = texture.size[2] * self._scale
end

function HUDCompassUnitIcon:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local icon_name = Unit.get_data(config.unit, "hud", "icon_name")
	local icon_settings = layout_settings.icons[icon_name]
	local texture = icon_settings.texture_func and icon_settings.texture_func(config.blackboard, config.player, config.unit, self._world)

	if not texture then
		return
	end

	local cam_rotation = Camera.world_rotation(config.camera)
	local cam_forward = Quaternion.forward(cam_rotation)

	Vector3.set_z(cam_forward, 0)

	local unit_position

	if self._unit_offset then
		unit_position = Unit.world_position(config.unit, 0) + Quaternion.rotate(Unit.world_rotation(config.unit, 0), self._unit_offset:unbox())
	else
		unit_position = Unit.world_position(config.unit, 0)
	end

	local cam_to_unit = unit_position - Camera.world_position(config.camera)

	Vector3.set_z(cam_to_unit, 0)

	local angle = (math.atan2(cam_to_unit.x, cam_to_unit.y) - math.atan2(cam_forward.x, cam_forward.y)) / (math.pi / 180)

	if math.abs(angle) < layout_settings.degrees / 2 then
		x = x + angle * (layout_settings.compass_width / layout_settings.degrees)
		self._is_clamped = false
	elseif angle > layout_settings.degrees / 2 then
		x = x + layout_settings.compass_width / 2
		self._is_clamped = true
	elseif angle < layout_settings.degrees / 2 then
		x = x - layout_settings.compass_width / 2
		self._is_clamped = true
	end

	self._x = x
	self._y = y
	self._z = z
end

function HUDCompassUnitIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local icon_name = Unit.get_data(config.unit, "hud", "icon_name")

	self:_render_icon(dt, t, gui, layout_settings, icon_name)

	local icon_name_2 = Unit.get_data(config.unit, "hud", "icon_name_2")

	if icon_name_2 and icon_name_2 ~= "" then
		self:_render_icon(dt, t, gui, layout_settings, icon_name_2)
	end
end

function HUDCompassUnitIcon:_render_icon(dt, t, gui, layout_settings, icon_name)
	local config = self.config
	local icon_settings = layout_settings.icons[icon_name]
	local texture = icon_settings.texture_func and icon_settings.texture_func(config.blackboard, config.player, config.unit, self._world)

	if not texture then
		return
	end

	local color = self:_color(config.player, layout_settings, config.blackboard)
	local uv00 = Vector2(texture.uv00[1], texture.uv00[2])
	local uv11 = Vector2(texture.uv11[1], texture.uv11[2])
	local size = Vector2(texture.size[1] * self._scale, texture.size[2] * self._scale)

	Gui.bitmap_uv(gui, icon_settings.texture_atlas, uv00, uv11, Vector3(self._x + self._width / 2 - size[1] / 2, self._y + self._height / 2 - size[2] / 2, self._z), size, color)
end

function HUDCompassUnitIcon:_color(player, settings, blackboard)
	local color_table = {
		255,
		255,
		255,
		255
	}

	if blackboard.owner_team_side and player.team then
		if blackboard.owner_team_side == "neutral" then
			color_table = HUDSettings.player_colors.neutral_team
		elseif blackboard.owner_team_side == player.team.side then
			color_table = HUDSettings.player_colors.team_member
		else
			color_table = HUDSettings.player_colors.enemy
		end
	elseif blackboard.color then
		color_table = blackboard.color
	elseif settings.color then
		color_table = settings.color
	end

	return Color(color_table[1], color_table[2], color_table[3], color_table[4])
end

function HUDCompassUnitIcon.create_from_config(config)
	return HUDCompassUnitIcon:new(config)
end
