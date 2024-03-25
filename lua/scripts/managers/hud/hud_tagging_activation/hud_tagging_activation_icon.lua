-- chunkname: @scripts/managers/hud/hud_tagging_activation/hud_tagging_activation_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDTaggingActivationIcon = class(HUDTaggingActivationIcon, HUDTextureElement)

function HUDTaggingActivationIcon:init(config)
	HUDTaggingActivationIcon.super.init(self, config)
end

function HUDTaggingActivationIcon:render(dt, t, gui, layout_settings)
	local config = self.config
	local blackboard = config.blackboard
	local player = blackboard.player
	local player_unit = player.player_unit
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")

	if locomotion.current_state:_can_tag(t, player) then
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

	layout_settings.texture_atlas_settings = HUDAtlas.tag_activation

	HUDTaggingActivationIcon.super.render(self, dt, t, gui, layout_settings)
end

function HUDTaggingActivationIcon.create_from_config(config)
	return HUDTaggingActivationIcon:new(config)
end
