-- chunkname: @scripts/unit_extensions/human/base/human_area_buff_server.lua

HumanAreaBuffServer = class(HumanAreaBuffServer)
HumanAreaBuffServer.SYSTEM = "area_buff_system"
HumanAreaBuffServer.SERVER_ONLY = true

function HumanAreaBuffServer:init(world, unit)
	self._world = world
	self._unit = unit

	local player = Managers.player:owner(unit)

	self._hud_buff_blackboard = {
		reinforce = {
			end_time = 0,
			level = 0
		},
		replenish = {
			end_time = 0,
			level = 0
		},
		regen = {
			end_time = 0,
			level = 0
		},
		courage = {
			end_time = 0,
			level = 0
		},
		armour = {
			end_time = 0,
			level = 0
		},
		march_speed = {
			end_time = 0,
			level = 0
		},
		mounted_speed = {
			end_time = 0,
			level = 0
		},
		berserker = {
			end_time = 0,
			level = 0
		}
	}

	self:_create_game_object()
	Managers.state.event:trigger("buffs_activated", player, self._hud_buff_blackboard)
end

function HumanAreaBuffServer:_create_game_object()
	local data_table = {
		reinforce_end_time = 0,
		reinforce_level = 0,
		armour_end_time = 0,
		march_speed_end_time = 0,
		mounted_speed_level = 0,
		mounted_speed_end_time = 0,
		courage_level = 0,
		march_speed_level = 0,
		regen_end_time = 0,
		replenish_end_time = 0,
		armour_level = 0,
		berserker_end_time = 0,
		replenish_level = 0,
		regen_level = 0,
		berserker_level = 0,
		courage_end_time = 0,
		game_object_created_func = NetworkLookup.game_object_functions.cb_area_buff_game_object_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_area_buff_game_object_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		player_unit_game_object_id = Unit.get_data(self._unit, "game_object_id")
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self._id = Managers.state.network:create_game_object("area_buffs", data_table, callback, nil, self._unit)
	self._game = Managers.state.network:game()
end

function HumanAreaBuffServer:update(dt, t)
	return
end

function HumanAreaBuffServer:cb_game_session_disconnect()
	self._id = nil
	self._game = nil
end

function HumanAreaBuffServer:buff_multiplier(buff_type)
	if self._game then
		local level = GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_level_key)
		local multiplier = BuffLevelMultiplierFunctions[buff_type](level)

		return multiplier
	end

	return BuffLevelMultiplierFunctions[buff_type](0)
end

function HumanAreaBuffServer:buff_level(buff_type)
	if self._game then
		return GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_level_key)
	else
		return 0
	end
end

function HumanAreaBuffServer:end_time(buff_type)
	if self._game then
		return GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_end_time_key)
	else
		return 0
	end
end

function HumanAreaBuffServer:set_buff_level(buff_type, value)
	self._hud_buff_blackboard[buff_type].level = value

	if self._game then
		GameSession.set_game_object_field(self._game, self._id, Buffs[buff_type].game_obj_level_key, value)
	end
end

function HumanAreaBuffServer:set_end_time(buff_type, value)
	self._hud_buff_blackboard[buff_type].end_time = value

	if self._game then
		GameSession.set_game_object_field(self._game, self._id, Buffs[buff_type].game_obj_end_time_key, value)
	end
end

function HumanAreaBuffServer:remove_game_object_id()
	self._id = nil
	self._game = nil
end

function HumanAreaBuffServer:destroy()
	if self._game and self._id then
		Managers.state.network:destroy_game_object(self._id)
	end
end
