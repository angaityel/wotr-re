-- chunkname: @scripts/managers/hud/hud_sprint/hud_sprint_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDSprintIcon = class(HUDSprintIcon, HUDTextureElement)

function HUDSprintIcon:init(config)
	HUDSprintIcon.super.init(self, config)
end

function HUDSprintIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local player_unit = blackboard.player.player_unit
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

	if locomotion.current_state:can_rush(t) then
		layout_settings.color = {
			255,
			255,
			255,
			255
		}
	else
		layout_settings.color = {
			255,
			150,
			150,
			150
		}
	end

	layout_settings.texture_atlas_settings = HUDAtlas.sprint

	HUDSprintIcon.super.render(self, dt, t, gui, layout_settings)
end

function HUDSprintIcon.create_from_config(config)
	return HUDSprintIcon:new(config)
end
