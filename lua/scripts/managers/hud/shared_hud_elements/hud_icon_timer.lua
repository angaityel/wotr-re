-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_icon_timer.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDIconTimer = class(HUDIconTimer, HUDTextureElement)

function HUDIconTimer:init(config)
	HUDIconTimer.super.init(self, config)
end

function HUDIconTimer:render(dt, t, gui, layout_settings, x, y, z)
	local config = self.config
	local blackboard = config.blackboard
	local remaining_time = blackboard.timer - t
	local max_time = blackboard.max_time
	local percentage = math.clamp(1 - remaining_time / max_time, 0, 1)
	local position = self:_position(dt, t, gui, layout_settings, config)
	local size = self:_size(dt, t, gui, layout_settings, config)
	local color = self:_color(dt, t, gui, layout_settings, config)
	local texture_atlas_settings = layout_settings.texture_atlas_settings
	local uv00 = Vector2(texture_atlas_settings.uv00[1], texture_atlas_settings.uv00[2])
	local uv11 = Vector2(texture_atlas_settings.uv11[1], texture_atlas_settings.uv11[2])

	Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, position, size, color)

	local texture_atlas_settings = layout_settings.texture_atlas_settings2
	local uv00 = Vector2(texture_atlas_settings.uv00[1], texture_atlas_settings.uv00[2])
	local uv11 = Vector2(texture_atlas_settings.uv11[1], texture_atlas_settings.uv11[2])

	Gui.bitmap_uv(gui, layout_settings.texture_atlas, Vector2(uv00[1], uv00[2] + (uv11[2] - uv00[2]) * (1 - percentage)), uv11, position + Vector3(0, 0, 1), Vector2(size[1], size[2] * percentage), color)

	if layout_settings.shine and remaining_time <= layout_settings.shine_time then
		local offset = Vector3(layout_settings.shine_offset[1], layout_settings.shine_offset[2], 2)
		local size = Vector2(layout_settings.shine_size[1], layout_settings.shine_size[2])
		local timer = 2 * (layout_settings.shine_time - remaining_time) / layout_settings.shine_time
		local uv00 = Vector2(0, 0 + timer * 0.5)
		local uv11 = Vector2(1, 0.5 + timer * 0.5)

		Gui.bitmap_uv(gui, layout_settings.shine_texture, uv00, uv11, position + offset, size)
	end
end

function HUDIconTimer.create_from_config(config)
	return HUDIconTimer:new(config)
end
