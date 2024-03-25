-- chunkname: @scripts/managers/hud/hud_player_effects/hud_player_effect_icon.lua

require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDPlayerEffectIcon = class(HUDPlayerEffectIcon, HUDTextureElement)

function HUDPlayerEffectIcon:init(config)
	HUDPlayerEffectIcon.super.init(self, config)

	self._alpha_modifier = 0
end

function HUDPlayerEffectIcon:render(dt, t, gui, layout_settings)
	local round_t = Managers.time:time("round")
	local config = self.config
	local effect_type = config.effect_type
	local blackboard = config.blackboard[effect_type]
	local level = blackboard.level

	if effect_type and level > 0 then
		local buff_settings = Buffs[effect_type]
		local icon_texture = buff_settings and buff_settings.hud_icon or Debuffs[effect_type].hud_icon

		layout_settings.texture_atlas_settings = HUDAtlas[icon_texture]

		if buff_settings and blackboard.end_time <= round_t + AreaBuffSettings.FADE_TIME then
			self:update_alpha(dt, t, gui, layout_settings)
		else
			layout_settings.color[1] = 255
		end

		HUDPlayerEffectIcon.super.render(self, dt, t, gui, layout_settings)
	end
end

function HUDPlayerEffectIcon:update_alpha(dt, t, gui, layout_settings)
	if layout_settings.color[1] >= 255 then
		self._alpha_modifier = 250
	elseif layout_settings.color[1] <= 50 then
		self._alpha_modifier = 255
	end

	layout_settings.color[1] = layout_settings.color[1] + self._alpha_modifier * dt
end

function HUDPlayerEffectIcon.create_from_config(config)
	return HUDPlayerEffectIcon:new(config)
end
