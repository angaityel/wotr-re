-- chunkname: @scripts/managers/hud/hud_combat_log/hud_combat_log_entry.lua

HUDCombatLogEntry = class(HUDCombatLogEntry)

function HUDCombatLogEntry:init(config)
	self.config = config
	self._local_player = config.local_player
	self._attacker_name = nil
	self._victim_name = nil
	self._weapon_texture_settings = nil
	self._attacker_color = nil
	self._victim_color = nil
end

function HUDCombatLogEntry:set_entry_data(attacking_player, victim_player, gear_name)
	self._attacker_name = attacking_player:name()
	self._victim_name = victim_player:name()

	local layout_settings = HUDHelper:layout_settings(self.config.layout_settings)
	local weapon_texture_name = Gear[gear_name].ui_combat_log_texture

	self._weapon_texture_settings = layout_settings.texture_atlas_settings[weapon_texture_name]
	self._attacker_color = attacking_player.team == self._local_player.team and HUDSettings.player_colors.team_member or HUDSettings.player_colors.enemy
	self._victim_color = victim_player.team == self._local_player.team and HUDSettings.player_colors.team_member or HUDSettings.player_colors.enemy
end

function HUDCombatLogEntry:width()
	return self._width
end

function HUDCombatLogEntry:height()
	return self._height
end

function HUDCombatLogEntry:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width
	self._height = layout_settings.height
end

function HUDCombatLogEntry:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function HUDCombatLogEntry:render(dt, t, gui, layout_settings)
	if self._weapon_texture_settings then
		local c = self._victim_color
		local color = Color(c[1] * layout_settings.alpha_multiplier, c[2], c[3], c[4])
		local victim_name_cropped = HUDHelper:crop_text(gui, self._victim_name, layout_settings.font.font, layout_settings.font_size, layout_settings.text_max_width, "...")
		local min, max = Gui.text_extents(gui, victim_name_cropped, layout_settings.font.font, layout_settings.font_size)
		local victim_name_width = max[1] - min[1]
		local victim_name_x = self._x + self._width - victim_name_width

		Gui.text(gui, victim_name_cropped, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, Vector3(math.floor(victim_name_x), self._y, self._z), color)

		local weapon_texture_settings = self._weapon_texture_settings
		local uv00 = Vector2(weapon_texture_settings.uv00[1], weapon_texture_settings.uv00[2])
		local uv11 = Vector2(weapon_texture_settings.uv11[1], weapon_texture_settings.uv11[2])
		local size = Vector2(weapon_texture_settings.size[1], weapon_texture_settings.size[2])
		local color = Color(255 * layout_settings.alpha_multiplier, 255, 255, 255)
		local weapon_texture_x = victim_name_x - layout_settings.padding - weapon_texture_settings.size[1]

		Gui.bitmap_uv(gui, layout_settings.texture_atlas, uv00, uv11, Vector3(math.floor(weapon_texture_x), self._y, self._z), size, color)

		local c = self._attacker_color
		local color = Color(c[1] * layout_settings.alpha_multiplier, c[2], c[3], c[4])
		local attacker_name_cropped = HUDHelper:crop_text(gui, self._attacker_name, layout_settings.font.font, layout_settings.font_size, layout_settings.text_max_width, "...")
		local min, max = Gui.text_extents(gui, attacker_name_cropped, layout_settings.font.font, layout_settings.font_size)
		local attacker_name_width = max[1] - min[1]
		local attacker_name_x = weapon_texture_x - layout_settings.padding - attacker_name_width

		Gui.text(gui, attacker_name_cropped, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, Vector3(math.floor(attacker_name_x), self._y, self._z), color)
	end
end

function HUDCombatLogEntry.create_from_config(config)
	return HUDCombatLogEntry:new(config)
end
