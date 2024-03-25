-- chunkname: @scripts/menu/menu_definitions/credits_page_definition.lua

require("scripts/menu/menu_definitions/credits_page_settings_1920")
require("scripts/menu/menu_definitions/credits_page_settings_1366")
require("scripts/settings/credits")

local function text(config)
	return config.localize and L(config.text) or config.text
end

local item_list = {}

for i, config in ipairs(Credits.entries) do
	if config.type == "company" then
		local layout_settings

		if i == 1 then
			layout_settings = table.clone(CreditsPageSettings.items.company)
			layout_settings[1680][1050].padding_top = 0
		else
			layout_settings = CreditsPageSettings.items.company
		end

		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextMenuItem",
			text = config.text,
			no_localization = not config.localized,
			layout_settings = layout_settings
		}
	elseif config.type == "company_small" then
		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextMenuItem",
			text = config.text,
			no_localization = not config.localized,
			layout_settings = CreditsPageSettings.items.company_small
		}
	elseif config.type == "title" then
		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextMenuItem",
			text = config.text,
			no_localization = not config.localized,
			layout_settings = CreditsPageSettings.items.title
		}
	elseif config.type == "person" then
		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextMenuItem",
			text = config.text,
			no_localization = not config.localized,
			layout_settings = CreditsPageSettings.items.person
		}
	elseif config.type == "info" then
		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextBoxMenuItem",
			text = config.text,
			no_localization = not config.localized,
			layout_settings = CreditsPageSettings.items.info
		}
	elseif config.type == "image" then
		local layout_settings = table.clone(CreditsPageSettings.items.texture)

		layout_settings[1680][1050].texture = config[1680].texture
		layout_settings[1680][1050].texture_width = config[1680].width
		layout_settings[1680][1050].texture_height = config[1680].height
		item_list[#item_list + 1] = {
			no_render_outside_screen = true,
			disabled = true,
			not_pixel_perfect_y = true,
			type = "TextureMenuItem",
			layout_settings = layout_settings
		}
	else
		ferror("Invalid type \"%s\" found in Credits.lua", config.type)
	end
end

CreditsPageDefinition = {
	text = "menu_credits",
	type = "TextMenuItem",
	layout_settings = MainMenuSettings.items.text_right_aligned,
	page = {
		z = 50,
		environment = "blurred",
		type = "CreditsMenuPage",
		layout_settings = CreditsPageSettings.pages.credits,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			item_list = item_list
		}
	}
}
