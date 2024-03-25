-- chunkname: @scripts/menu/menu_pages/changelog_popup_menu_page.lua

ChangelogPopupMenuPage = class(ChangelogPopupMenuPage, ExpandablePopupMenuPage)

function ChangelogPopupMenuPage:init(config, item_groups, world)
	ChangelogPopupMenuPage.super.init(self, config, item_groups, world)
end

function ChangelogPopupMenuPage:_update_input(input)
	if input:has("wheel") and input:get("wheel").y ~= 0 then
		local y = input:get("wheel").y

		if math.abs(y) > 0.9 then
			self:find_item_by_name("popup_text"):scroll(-y * 10)
		end
	end
end

function ChangelogPopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		render_parent_page = true,
		type = "popup",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_options = page_config.on_enter_options,
		on_enter_options_args = page_config.on_enter_options_args or {},
		on_item_selected = page_config.on_item_selected,
		on_cancel_exit = page_config.on_cancel_exit,
		show_revision = page_config.show_revision,
		no_cancel_to_parent_page = page_config.no_cancel_to_parent_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		in_splash_screen = page_config.in_splash_screen
	}

	return ChangelogPopupMenuPage:new(config, item_groups, compiler_data.world)
end
