-- chunkname: @scripts/menu/menu_pages/empty_menu_page.lua

EmptyMenuPage = class(EmptyMenuPage, MenuPage)

function EmptyMenuPage:init(config, item_groups, world)
	EmptyMenuPage.super.init(self, config, item_groups, world)
end

function EmptyMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "empty",
		parent_page = parent_page,
		callback_object = callback_object,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return EmptyMenuPage:new(config, item_groups, compiler_data.world)
end
