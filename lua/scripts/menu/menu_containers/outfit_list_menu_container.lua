-- chunkname: @scripts/menu/menu_containers/outfit_list_menu_container.lua

require("scripts/menu/menu_containers/item_list_menu_container")

OutfitListMenuContainer = class(OutfitListMenuContainer, ItemListMenuContainer)

function OutfitListMenuContainer:init(items)
	OutfitListMenuContainer.super.init(self, items)
end

function OutfitListMenuContainer:load_profile(player_profile)
	for i, item in ipairs(self._items) do
		item:load_profile(player_profile)
	end
end

function OutfitListMenuContainer.create_from_config(items)
	return OutfitListMenuContainer:new(items)
end
