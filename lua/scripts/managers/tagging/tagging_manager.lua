-- chunkname: @scripts/managers/tagging/tagging_manager.lua

TaggingManager = class(TaggingManager)

function TaggingManager:init(world)
	self._world = world
	self._tags = {}

	Managers.state.event:register(self, "player_unit_dead", "event_player_unit_dead", "remote_player_destroyed", "event_remote_player_destroyed", "player_no_longer_corporal", "event_player_no_longer_corporal")
end

function TaggingManager:event_remote_player_destroyed(player)
	self:_remove_tag(player, "player_disconect")
end

function TaggingManager:event_player_no_longer_corporal(player)
	self:_remove_tag(player, "player_no_longer_corporal")
end

function TaggingManager:event_player_unit_dead(player)
	self:_remove_tag(player, "player_unit_dead")
end

function TaggingManager:update(dt, t)
	local round_t = Managers.time:time("round")

	for tagging_player, tag in pairs(self._tags) do
		if round_t >= tag.end_time then
			self:_remove_tag(tagging_player, "player_tag_timed_out")
		end
	end

	if script_data.tagging_debug then
		for _, tag in pairs(self._tags) do
			table.dump(tag)
		end
	end
end

function TaggingManager:can_tag_player_unit(player, tagged_unit)
	local tagger_unit = player.player_unit

	if Unit.alive(tagger_unit) and Unit.alive(tagged_unit) then
		local tagger_damage_ext = ScriptUnit.extension(tagger_unit, "damage_system")
		local tagee_damage_ext = ScriptUnit.extension(tagged_unit, "damage_system")

		if not tagger_damage_ext:is_dead() and not tagee_damage_ext:is_dead() then
			return true
		end
	end

	return false
end

function TaggingManager:can_tag_objective(player, tagged_unit)
	local tagger_unit = player.player_unit

	if Unit.alive(tagger_unit) and Unit.alive(tagged_unit) then
		local tagger_locomotion_ext = ScriptUnit.extension(tagger_unit, "locomotion_system")
		local tagger_damage_ext = ScriptUnit.extension(tagger_unit, "damage_system")

		if player.is_corporal and not tagger_damage_ext:is_dead() and tagger_locomotion_ext:has_perk("officer_training") then
			return true
		end
	end

	return false
end

function TaggingManager:add_player_unit_tag(tagging_player, tagged_unit, end_time)
	local tags = self._tags

	if not tags[tagging_player] then
		tags[tagging_player] = {}
	end

	local player_tag = tags[tagging_player]

	player_tag.tagged_unit = tagged_unit
	player_tag.end_time = end_time

	local game = Managers.state.network:game()

	if game then
		local tagged_player_object_id = Unit.get_data(tagged_unit, "game_object_id")

		GameSession.set_game_object_field(game, tagging_player.game_object_id, "tagged_player_object_id", tagged_player_object_id)
		GameSession.set_game_object_field(game, tagging_player.game_object_id, "tagged_objective_level_id", 0)
	end
end

function TaggingManager:add_objective_tag(tagging_player, tagged_unit, end_time)
	local tags = self._tags

	if not tags[tagging_player] then
		tags[tagging_player] = {}
	end

	local player_tag = tags[tagging_player]

	player_tag.tagged_unit = tagged_unit
	player_tag.end_time = end_time

	local game = Managers.state.network:game()

	if game then
		local objective_system = ScriptUnit.extension(tagged_unit, "objective_system")
		local tagged_objective_level_id = objective_system:level_index()

		GameSession.set_game_object_field(game, tagging_player.game_object_id, "tagged_objective_level_id", tagged_objective_level_id)
		GameSession.set_game_object_field(game, tagging_player.game_object_id, "tagged_player_object_id", 0)
	end
end

function TaggingManager:_remove_tag(player, reason)
	local player_manager = Managers.player
	local tags = self._tags
	local player_tag = tags[player]

	if reason == "player_disconect" then
		for tagging_player, tag in pairs(tags) do
			if player_manager:owner(tag.tagged_unit) == player then
				tag.end_time = 0
				tag.tagged_unit = nil
			end
		end

		tags[player] = nil
	elseif reason == "player_tag_timed_out" or reason == "player_no_longer_corporal" then
		if player_tag then
			player_tag.end_time = 0
			player_tag.tagged_unit = nil
		end
	elseif reason == "player_unit_dead" then
		for tagging_player, tag in pairs(tags) do
			if player_manager:owner(tag.tagged_unit) == player then
				tag.end_time = 0
				tag.tagged_unit = nil
			end
		end

		if player_tag and not player.is_corporal then
			player_tag.end_time = 0
			player_tag.tagged_unit = nil
		end
	end

	local game = Managers.state.network:game()

	if game then
		GameSession.set_game_object_field(game, player.game_object_id, "tagged_player_object_id", 0)
		GameSession.set_game_object_field(game, player.game_object_id, "tagged_objective_level_id", 0)
	end
end

function TaggingManager:tagger_by_tagged_unit(tagged_unit)
	for player, tag_info in pairs(self._tags) do
		if tag_info.tagged_unit == tagged_unit then
			return player
		end
	end
end
