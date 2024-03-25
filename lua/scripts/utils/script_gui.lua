-- chunkname: @scripts/utils/script_gui.lua

ScriptGUI = ScriptGUI or {}

function ScriptGUI.text(gui, text, font, font_size, material, pos, color, drop_shadow_color, drop_shadow_offset)
	if drop_shadow_color then
		Gui.text(gui, text, font, font_size, material, pos + drop_shadow_offset, drop_shadow_color)
	end

	Gui.text(gui, text, font, font_size, material, pos, color)
end
