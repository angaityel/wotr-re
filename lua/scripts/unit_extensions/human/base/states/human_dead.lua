-- chunkname: @scripts/unit_extensions/human/base/states/human_dead.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")

HumanDead = class(HumanDead)

function HumanDead:aim_direction()
	return
end
