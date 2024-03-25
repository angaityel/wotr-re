-- chunkname: @scripts/managers/hud/hud_manager.lua

require("scripts/managers/hud/hud_base")
require("scripts/managers/hud/hud_mockup/hud_mockup")
require("scripts/managers/hud/hud_world_icons/hud_world_icons")
require("scripts/managers/hud/hud_compass/hud_compass")
require("scripts/managers/hud/hud_chat/hud_chat")
require("scripts/managers/hud/hud_crossbow_minigame/hud_crossbow_minigame")
require("scripts/managers/hud/hud_bow_minigame/hud_bow_minigame")
require("scripts/managers/hud/hud_pose_charge/hud_pose_charge")
require("scripts/managers/hud/hud_parry_helper/hud_parry_helper")
require("scripts/managers/hud/hud_player_effects/hud_buffs")
require("scripts/managers/hud/hud_player_effects/hud_debuffs")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation")
require("scripts/managers/hud/hud_ammo_counter/hud_ammo_counter")
require("scripts/managers/hud/hud_handgonne_reload/hud_handgonne_reload")
require("scripts/managers/hud/hud_lance_recharge/hud_lance_recharge")
require("scripts/managers/hud/hud_hit_marker/hud_hit_marker")
require("scripts/managers/hud/hud_spawn/hud_spawn")
require("scripts/managers/hud/hud_sprint/hud_sprint")
require("scripts/managers/hud/hud_deserting/hud_deserting")
require("scripts/managers/hud/hud_fade_to_black/hud_fade_to_black")
require("scripts/managers/hud/hud_game_mode_status/hud_game_mode_status")
require("scripts/managers/hud/hud_combat_log/hud_combat_log")
require("scripts/managers/hud/hud_announcements/hud_announcements")
require("scripts/managers/hud/hud_sp_tutorial/hud_sp_tutorial")
require("scripts/managers/hud/hud_cruise_control/hud_cruise_control")
require("scripts/managers/hud/hud_call_horse/hud_call_horse")
require("scripts/managers/hud/hud_damage_numbers/hud_damage_numbers")
require("scripts/managers/hud/hud_tagging/hud_tagging")
require("scripts/managers/hud/hud_tagging_activation/hud_tagging_activation")
require("scripts/managers/hud/hud_xp_coins/hud_xp_coins")
require("scripts/managers/hud/hud_interaction/hud_interaction")
require("scripts/managers/hud/hud_mount_charge/hud_mount_charge")
require("scripts/helpers/hud_helper")
require("scripts/managers/hud/hud_chat/chat_output_window")

HUDManager = class(HUDManager)

function HUDManager:init(world)
	self._world = world
	self._huds = {}
	self._active = true
end

function HUDManager:add_player(player, menu_world)
	self._huds[player] = {
		world_icons = HUDWorldIcons:new(self._world, player),
		mockup = HUDMockup:new(self._world, player, menu_world),
		chat = HUDChat:new(self._world, player),
		crossbow_minigame = HUDCrossbowMinigame:new(self._world, player),
		bow_minigame = HUDBowMinigame:new(self._world, player),
		pose_charge = HUDPoseCharge:new(self._world, player),
		parry_helper = HUDParryHelper:new(self._world, player),
		buffs = HUDBuffs:new(self._world, player),
		debuffs = HUDDebuffs:new(self._world, player),
		buff_activation = HUDOfficerBuffActivation:new(self._world, player),
		ammo_counter = HUDAmmoCounter:new(self._world, player),
		handgonne_reload = HUDHandgonneReload:new(self._world, player),
		lance_recharge = HUDLanceRecharge:new(self._world, player),
		spawn = HUDSpawn:new(self._world, player),
		deserting = HUDDeserting:new(self._world, player),
		hit_marker = HUDHitMarker:new(self._world, player),
		fade_to_black = HUDFadeToBlack:new(self._world, player),
		game_mode_status = HUDGameModeStatus:new(self._world, player),
		combat_log = HUDCombatLog:new(self._world, player),
		announcements = HUDAnnouncements:new(self._world, player),
		sprint = HUDSprint:new(self._world, player),
		mount_charge = HUDMountCharge:new(self._world, player),
		sp_tutorial = HUDSPTutorial:new(self._world, player),
		cruise_control = HUDCruiseControl:new(self._world, player),
		call_horse = HUDCallHorse:new(self._world, player),
		damage_numbers = HUDDamageNumbers:new(self._world, player),
		tagging = HUDTagging:new(self._world, player),
		xp_coins = HUDXPCoins:new(self._world, player),
		interaction = HUDInteraction:new(self._world, player),
		chat_window = ChatOutputWindow:new(self._world, player)
	}
end

function HUDManager:set_active(active)
	self._active = active

	for player, huds in pairs(self._huds) do
		for hud_name, hud in pairs(huds) do
			if active then
				hud:on_activated()
			else
				hud:on_deactivated()
			end
		end
	end
end

function HUDManager:active()
	return self._active
end

function HUDManager:set_hud_enabled(name, enabled)
	for player, huds in pairs(self._huds) do
		huds[name]:set_enabled(enabled)
	end
end

function HUDManager:set_huds_enabled_except(enabled, except)
	for player, huds in pairs(self._huds) do
		for hud_name, hud in pairs(huds) do
			if not except or not table.contains(except, hud_name) then
				hud:set_enabled(enabled)
			end
		end
	end
end

function HUDManager:post_update(dt, t, player)
	if self._active and HUDSettings.show_hud then
		local huds = self._huds[player]

		for _, hud in pairs(huds) do
			if hud:enabled() then
				hud:post_update(dt, t, player)
			else
				hud:disabled_post_update(dt, t)
			end
		end
	end
end

function HUDManager:destroy()
	for player, huds in pairs(self._huds) do
		for hud_name, hud in pairs(huds) do
			hud:destroy()
		end
	end

	self._huds = {}
end

function HUDManager:post(channel_name, name, text, color, display_time)
	for player, huds in pairs(self._huds) do
		huds.chat_window:post(channel_name, name, text, color, display_time)
	end
end

function HUDManager:output_console_text(text, color)
	for player, huds in pairs(self._huds) do
		huds.chat_window:output_console_text(text, color)
	end
end

function ChatOutputWindow:network_output_console_text(text_id, color, display_time)
	for player, huds in pairs(self._huds) do
		huds.chat_window:network_output_console_text(text_id, color, display_time)
	end
end
