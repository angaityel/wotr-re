-- chunkname: @scripts/network_lookup/network_constants.lua

NetworkConstants = NetworkConstants or {}
NetworkConstants.damage = Network.type_info("damage")
NetworkConstants.health = Network.type_info("health")
NetworkConstants.velocity = Network.type_info("velocity")
NetworkConstants.VELOCITY_EPSILON = Vector3.length(Vector3(NetworkConstants.velocity.tolerance, NetworkConstants.velocity.tolerance, NetworkConstants.velocity.tolerance)) * 1.1
NetworkConstants.position = Network.type_info("position")
NetworkConstants.rotation = Network.type_info("rotation")
NetworkConstants.team_score = Network.type_info("team_score")
NetworkConstants.max_attachments = 4
NetworkConstants.time_multiplier = Network.type_info("time_multiplier")
NetworkConstants.ping = Network.type_info("ping")
NetworkConstants.animation_variable_float = Network.type_info("animation_variable_float")
NetworkConstants.game_object_funcs = Network.type_info("game_object_funcs")

assert(#NetworkLookup.game_object_functions <= NetworkConstants.game_object_funcs.max, "Too many game object functions in network lookup, time to up the network config max value")

NetworkConstants.anim_event = Network.type_info("anim_event")

assert(#NetworkLookup.anims <= NetworkConstants.anim_event.max, "Too many anim events in network lookup, time to up the network config max value")

NetworkConstants.helmet_attachment_lookup = Network.type_info("helmet_attachment_lookup")

assert(#NetworkLookup.helmet_attachments <= NetworkConstants.helmet_attachment_lookup.max, "There are more helmet attachments than the current global.network_config value for \"helmet_attachment_lookup\". Please increase the value in the network config.")

local max_encumbrance_wield = PlayerUnitMovementSettings.encumbrance.functions.wield_time(100)
local anim_value_max = NetworkConstants.animation_variable_float.max

for gear_name, gear in pairs(Gear) do
	local wield_time = gear.wield_time
	local max_wield_time = wield_time * max_encumbrance_wield

	fassert(max_wield_time < anim_value_max, "Gear %q has a wield time of %f (%f * %f) which is higher than the max for network synched animation variables (%f)", gear_name, max_wield_time, wield_time, max_encumbrance_wield, anim_value_max)
end
