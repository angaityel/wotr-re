-- chunkname: @scripts/menu/menu_pages/key_mapping_pad_menu_page.lua

KeyMappingPadMenuPage = class(KeyMappingPadMenuPage, KeyMappingMenuPage)

function KeyMappingPadMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups)
	local config = {
		controller_type = "pad360",
		parent_page = parent_page,
		render_parent_page = page_config.render_parent_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return KeyMappingPadMenuPage:new(config, item_groups, compiler_data.world)
end
