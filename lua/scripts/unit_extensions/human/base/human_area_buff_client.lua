-- chunkname: @scripts/unit_extensions/human/base/human_area_buff_client.lua

HumanAreaBuffClient = class(HumanAreaBuffClient)
HumanAreaBuffClient.SYSTEM = "area_buff_system"
HumanAreaBuffClient.CLIENT_ONLY = true

function HumanAreaBuffClient:init(world, unit)
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

	Managers.state.event:trigger("buffs_activated", player, self._hud_buff_blackboard)
end

function HumanAreaBuffClient:set_game_object_id(obj_id, game)
	self._id = obj_id
	self._game = game
end

function HumanAreaBuffClient:update(dt, t)
	if self._game then
		for buff_type, blackboard in pairs(self._hud_buff_blackboard) do
			blackboard.level = self:buff_level(buff_type)
			blackboard.end_time = self:end_time(buff_type)
		end
	end
end

function HumanAreaBuffClient:buff_multiplier(buff_type)
	if self._game then
		local level = GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_level_key)
		local multiplier = BuffLevelMultiplierFunctions[buff_type](level)

		return multiplier
	end

	return BuffLevelMultiplierFunctions[buff_type](0)
end

function HumanAreaBuffClient:buff_level(buff_type)
	if self._game then
		return GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_level_key)
	else
		return 0
	end
end

function HumanAreaBuffClient:end_time(buff_type)
	if self._game then
		return GameSession.game_object_field(self._game, self._id, Buffs[buff_type].game_obj_end_time_key)
	else
		return 0
	end
end

function HumanAreaBuffClient:remove_game_object_id()
	self._id = nil
	self._game = nil
end

function HumanAreaBuffClient:destroy()
	return
end
