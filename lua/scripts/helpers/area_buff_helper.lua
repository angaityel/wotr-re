-- chunkname: @scripts/helpers/area_buff_helper.lua

AreaBuffHelper = AreaBuffHelper or {}

function AreaBuffHelper:play_squad_area_buff_voice_over(unit, buff_type, world, sender)
	local sound_event = Buffs[buff_type].sound_event
	local timpani_world = World.timpani_world(world)

	if Unit.alive(unit) and ScriptUnit.has_extension(unit, "locomotion_system") then
		local event_id = TimpaniWorld.trigger_event(timpani_world, sound_event, unit, Unit.node(unit, "Head"))
		local voice = ScriptUnit.extension(unit, "locomotion_system"):inventory():voice()

		TimpaniWorld.set_parameter(timpani_world, event_id, "character_vo", voice)
	end

	local network_manager = Managers.state.network

	if Managers.lobby.server and network_manager:game() then
		network_manager:send_rpc_clients_except("rpc_play_squad_area_buff_vo", sender, NetworkLookup.buff_types[buff_type], network_manager:game_object_id(unit))
	end
end

function AreaBuffHelper:create_squad_area_buff(player, owning_unit, buff_type, world)
	local area_buff_level_callback = callback(self, "cb_squad_area_buff_level_calculation")
	local eligible_target_callback = callback(self, "cb_squad_eligible_target_calculation", player)
	local buff_settings = Buffs[buff_type]
	local buff_id = buff_type .. "_" .. Managers.state.network:game_object_id(owning_unit)

	Managers.state.area_buff:create_area_buff(owning_unit, buff_type, area_buff_level_callback, eligible_target_callback, buff_settings.duration, "sphere", AreaBuffSettings.RANGE, buff_id)
end

function AreaBuffHelper:unit_in_buff_area(unit, owning_unit, shape, radius)
	local area_buff_position = Unit.world_position(owning_unit, 0)
	local eligible_target_position = Unit.world_position(unit, 0)
	local distance

	if shape == "sphere" then
		distance = Vector3.distance(area_buff_position, eligible_target_position)
	elseif shape == "cylinder" then
		distance = Vector3.distance(Vector3.flat(area_buff_position), Vector3.flat(eligible_target_position))
	end

	return distance <= radius
end

function AreaBuffHelper:cb_squad_eligible_target_calculation(player)
	return self:alive_units_in_squad(player)
end

function AreaBuffHelper:alive_units_in_squad(player)
	local squad_index = player.squad_index
	local squad = squad_index and player.team.squads[squad_index]
	local members = squad and squad:members() or {}
	local squad_units = {}

	for squad_member, _ in pairs(members) do
		local unit = squad_member.player_unit

		if Unit.alive(unit) then
			squad_units[#squad_units + 1] = unit
		end
	end

	return squad_units
end

function AreaBuffHelper:cb_squad_area_buff_level_calculation(source_name)
	local affected_targets = Managers.state.area_buff:affected_targets(source_name)

	return table.size(affected_targets)
end
