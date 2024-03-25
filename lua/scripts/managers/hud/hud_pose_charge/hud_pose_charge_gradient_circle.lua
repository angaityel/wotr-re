-- chunkname: @scripts/managers/hud/hud_pose_charge/hud_pose_charge_gradient_circle.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPoseChargeGradientCircle = class(HUDPoseChargeGradientCircle, HUDTextureElement)

function HUDPoseChargeGradientCircle:init(config)
	HUDPoseChargeGradientCircle.super.init(self, config)

	self._fade_timer = 0
end

function HUDPoseChargeGradientCircle:update_position(dt, t, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local trans_pos_x = x + self._width / 2
	local trans_pos_y = y + self._height / 2
	local alpha_value = 40 + (40 + blackboard.charge_factor * 175)

	layout_settings.color = {
		alpha_value * config.alpha_multiplier,
		layout_settings.color[2],
		layout_settings.color[3],
		layout_settings.color[4]
	}
	config.gradient_shader_value = blackboard.shader_value
	config.transform_matrix = Rotation2D(Vector2(x, y), blackboard.gradient_rot_angle, Vector2(trans_pos_x, trans_pos_y))

	HUDPoseChargeGradientCircle.super.update_position(self, dt, t, layout_settings, x, y, z)
end

function HUDPoseChargeGradientCircle:render(dt, t, gui, layout_settings)
	local config = self.config
	local color = config.blackboard and config.blackboard.color or layout_settings.color or {
		255,
		255,
		255,
		255
	}
	local material = Gui.material(gui, config.blackboard and config.blackboard.texture or layout_settings.texture)

	if material then
		Material.set_scalar(material, "gradient_threshold", config.gradient_shader_value)
	end

	local w, h = Gui.resolution()

	if color[1] > 0 then
		local circle_section_size = HUDSettings.circle_section_size
		local half_circle_size = circle_section_size * 0.5
		local circle_section_min_size = HUDSettings.marker_offset * 2

		Gui.bitmap(gui, "clear_mask", Vector3(0, 0, 0), Vector2(w, h))

		local set_color = Color(color[1], color[2], color[3], color[4])

		Gui.bitmap(gui, "hud_pose_circle", Vector3(w * 0.5 - self._width * 0.5, h * 0.5 - self._height * 0.5, 1), Vector2(self._width, self._height), set_color)

		local pos = Vector3(w * 0.5, h * 0.5, 1)
		local base_rot = Rotation2D(Vector3(0, 0, 0), math.degrees_to_radians(config.blackboard.charge_rotation), pos)

		Gui.bitmap_3d(gui, "mask_rect", base_rot, Vector3(w * 0.5 - self._width * 0.5, h * 0.5 - self._height * 0.5, 2), 1, Vector2(self._width, self._height * 0.5), Color(0, 1, 1, 1))

		local mat = Rotation2D(Vector3(0, 0, 0), math.degrees_to_radians(90 - half_circle_size + config.blackboard.charge_factor * (90 - half_circle_size + circle_section_min_size)), pos)
		local mat = Matrix4x4.multiply(mat, base_rot)

		Gui.bitmap_3d(gui, "mask_rect", mat, Vector3(w * 0.5 - self._width * 0.5, h * 0.5 - self._height * 0.5, 1), 1, Vector2(self._width * 0.5, self._height * 0.5), Color(0, 0, 0, 0))

		local mat = Rotation2D(Vector3(0, 0, 0), math.degrees_to_radians(-(90 - half_circle_size) - config.blackboard.charge_factor * (90 - half_circle_size + circle_section_min_size)), pos)
		local mat = Matrix4x4.multiply(mat, base_rot)

		Gui.bitmap_3d(gui, "mask_rect", mat, Vector3(w * 0.5, h * 0.5 - self._height, 1), 1, Vector2(self._width * 0.5, self._height), Color(0, 0, 0, 0))
	end
end

function HUDPoseChargeGradientCircle.create_from_config(config)
	return HUDPoseChargeGradientCircle:new(config)
end
