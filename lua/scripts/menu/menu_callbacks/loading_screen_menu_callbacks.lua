-- chunkname: @scripts/menu/menu_callbacks/loading_screen_menu_callbacks.lua

LoadingScreenMenuCallbacks = class(LoadingScreenMenuCallbacks)

function LoadingScreenMenuCallbacks:init(menu_state)
	self._menu_state = menu_state
end

function LoadingScreenMenuCallbacks:cb_game_data()
	local loading_context = self._menu_state.parent.loading_context
	local data = {
		level = loading_context.level_key,
		game_mode = loading_context.game_mode_key
	}

	return data
end
