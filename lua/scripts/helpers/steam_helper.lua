-- chunkname: @scripts/helpers/steam_helper.lua

SteamHelper = SteamHelper or {}

function SteamHelper.friends()
	local num_friends = Friends.num_friends()
	local friends = {}

	for i = 1, num_friends do
		local id = Friends.id(i)

		friends[id] = {
			name = Friends.name(id),
			playing_game = Friends.playing_game(id)
		}
	end

	return friends
end
