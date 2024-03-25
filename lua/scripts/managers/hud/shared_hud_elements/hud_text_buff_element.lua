-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_text_buff_element.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDTextBuffElement = class(HUDTextBuffElement, HUDTextElement)

function HUDTextBuffElement:init(config)
	HUDTextBuffElement.super.init(self, config)
end

function HUDTextBuffElement:_split_pad_text(text)
	text = Managers.localizer:simple_lookup(text)

	local prefix_arg_start, prefix_arg_end = string.find(text, "KEY")

	if prefix_arg_start then
		local prefix = string.sub(text, 1, prefix_arg_start - 2) .. " "
		local suffix_arg_start, suffix_arg_end = string.find(text, ":")
		local suffix = string.sub(text, suffix_arg_end + 1, -1)
		local button = Managers.localizer:_find_macro(string.sub(text, prefix_arg_start - 1, suffix_arg_start))

		return prefix, suffix, button
	else
		return L(text)
	end
end

function HUDTextBuffElement:render(dt, t, gui, layout_settings)
	local resolution_width, resolution_height = Gui.resolution()
	local font = MenuSettings.fonts.wotr_hud_text_36.font
	local font_material = MenuSettings.fonts.wotr_hud_text_36.material
	local font_size = layout_settings.font_size
	local config = self.config
	local loc_key = config.blackboard and config.blackboard.text or self.config.text

	if loc_key == "" then
		return
	end

	if Managers.input:pad_active(1) then
		local full_text = L(loc_key)
		local prefix, suffix, button = self:_split_pad_text(loc_key)
		local text_extent_min, text_extent_max = Gui.text_extents(gui, full_text, font, font_size)
		local text_width = text_extent_max[1] - text_extent_min[1]
		local text_height = text_extent_max[3] - text_extent_min[3]
		local x = self._x
		local y = self._y

		if prefix then
			Gui.text(gui, prefix, font, font_size, font_material, Vector3(x, y, 0), Color(255, 255, 255))
		end

		if button and prefix then
			local min, max = Gui.text_extents(gui, prefix, font, font_size)
			local button_offset = max[1] - min[1]

			Gui.text(gui, button, "materials/fonts/hell_shark_36", font_size, "hell_shark_36", Vector3(x + button_offset, y, 0), Color(255, 255, 255))
		end

		if prefix and button and suffix then
			local min, max = Gui.text_extents(gui, prefix .. button, font, font_size)
			local suffix_offset = max[1] - min[1]

			Gui.text(gui, suffix, font, font_size, font_material, Vector3(x + suffix_offset, y, 0), Color(255, 255, 255))
		end
	else
		local text = L(loc_key)
		local text_extent_min, text_extent_max = Gui.text_extents(gui, text, font, font_size)
		local text_width = text_extent_max[1] - text_extent_min[1]
		local text_height = text_extent_max[3] - text_extent_min[3]
		local x = resolution_width / 2 - text_width / 2
		local y = resolution_height / 2.5 - 120

		Gui.text(gui, text, font, font_size, font_material, Vector3(x, y, 0), Color(255, 255, 255))
	end
end

function HUDTextBuffElement.create_from_config(config)
	return HUDTextBuffElement:new(config)
end
