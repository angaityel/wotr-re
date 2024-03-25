-- chunkname: @scripts/helpers/menu_helper.lua

MenuHelper = MenuHelper or {}

function MenuHelper:layout_settings(settings_table)
	if type(settings_table) == "string" then
		return MenuHelper:layout_settings_string(settings_table)
	end

	local res_width, res_height = Gui.resolution()
	local selected_width = 0
	local selected_height = 0
	local lowest_available_width = math.huge
	local lowest_available_height = math.huge

	for width, setting in pairs(settings_table) do
		if width <= res_width and selected_width < width then
			selected_width = width
		end

		if width < lowest_available_width then
			lowest_available_width = width
		end
	end

	if selected_width == 0 then
		selected_width = lowest_available_width
	end

	for height, setting in pairs(settings_table[selected_width]) do
		if height <= res_height and selected_height < height then
			selected_height = height
		end

		if height < lowest_available_height then
			lowest_available_height = height
		end
	end

	if selected_height == 0 then
		selected_height = lowest_available_height
	end

	return settings_table[selected_width][selected_height]
end

function MenuHelper:layout_settings_string(settings_string)
	local settings = string.split(settings_string, ".")
	local settings_table = rawget(_G, settings[1])

	for i = 2, #settings do
		settings_table = settings_table[settings[i]]
	end

	local res_width, res_height = Gui.resolution()
	local selected_width = 0
	local selected_height = 0
	local lowest_available_width = math.huge
	local lowest_available_height = math.huge

	for width, setting in pairs(settings_table) do
		if width <= res_width and selected_width < width then
			selected_width = width
		end

		if width < lowest_available_width then
			lowest_available_width = width
		end
	end

	if selected_width == 0 then
		selected_width = lowest_available_width
	end

	for height, setting in pairs(settings_table[selected_width]) do
		if height <= res_height and selected_height < height then
			selected_height = height
		end

		if height < lowest_available_height then
			lowest_available_height = height
		end
	end

	if selected_height == 0 then
		selected_height = lowest_available_height
	end

	return settings_table[selected_width][selected_height]
end

function MenuHelper:container_position(container, layout_settings)
	local res_width, res_height = Gui.resolution()
	local screen_x, screen_y, pivot_x, pivot_y

	if layout_settings.screen_align_x == "left" then
		screen_x = 0
	elseif layout_settings.screen_align_x == "center" then
		screen_x = res_width / 2
	elseif layout_settings.screen_align_x == "right" then
		screen_x = res_width
	end

	if layout_settings.screen_align_y == "bottom" then
		screen_y = 0
	elseif layout_settings.screen_align_y == "center" then
		screen_y = res_height / 2
	elseif layout_settings.screen_align_y == "top" then
		screen_y = res_height
	end

	screen_x = screen_x + layout_settings.screen_offset_x * res_width
	screen_y = screen_y + layout_settings.screen_offset_y * res_height

	if layout_settings.pivot_align_x == "left" then
		pivot_x = 0
	elseif layout_settings.pivot_align_x == "center" then
		pivot_x = -container:width() / 2
	elseif layout_settings.pivot_align_x == "right" then
		pivot_x = -container:width()
	end

	if layout_settings.pivot_align_y == "bottom" then
		pivot_y = 0
	elseif layout_settings.pivot_align_y == "center" then
		pivot_y = -container:height() / 2
	elseif layout_settings.pivot_align_y == "top" then
		pivot_y = -container:height()
	end

	pivot_x = pivot_x + (type(layout_settings.pivot_offset_x) == "function" and layout_settings.pivot_offset_x(res_width, res_height) or layout_settings.pivot_offset_x)
	pivot_y = pivot_y + (type(layout_settings.pivot_offset_y) == "function" and layout_settings.pivot_offset_y(res_width, res_height) or layout_settings.pivot_offset_y)

	local x = screen_x + pivot_x
	local y = screen_y + pivot_y

	return x, y
end

function MenuHelper.scale_to_fullscren(original_width, original_height, keep_aspect_ratio)
	local res_width, res_height = Gui.resolution()
	local width, height

	if keep_aspect_ratio then
		width = res_width
		height = res_width * original_height / original_width
	else
		width = res_width
		height = res_height
	end

	return width, height
end

function MenuHelper:format_text(text, gui, font, font_size, max_width)
	return Gui.word_wrap(gui, text, font, font_size, max_width, " ", "-+&/*", "\n")
end

function MenuHelper:lines(str)
	local t = {}

	local function helper(line)
		table.insert(t, line)

		return ""
	end

	helper((str:gsub("(.-)\r?\n", helper)))

	return t
end

function MenuHelper:create_input_popup_page(world, parent_page, callback_object, on_enter_options, on_item_selected, cb_save_button_disabled, page_z, sounds, header_text, layout_settings_page, layout_settings_header, layout_settings_input, layout_settings_button, min_text_length, max_text_length, password)
	local compiler_data = {
		world = world
	}
	local page_config = {
		try_big_picture_input = true,
		on_enter_options = on_enter_options,
		on_item_selected = on_item_selected,
		z = page_z,
		layout_settings = layout_settings_page,
		sounds = sounds,
		big_picture_input_params = {
			bp_callback_object = "parent_page",
			bp_callback_name = "cb_set_profile_name",
			description = header_text,
			min_text_length = min_text_length,
			max_text_length = max_text_length,
			password = password
		}
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local header_config = {
		disabled = true,
		text = header_text,
		z = page_z + 1,
		layout_settings = layout_settings_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local input_config = {
		name = "text_input",
		z = page_z + 1,
		min_text_length = min_text_length,
		max_text_length = max_text_length,
		layout_settings = layout_settings_input,
		parent_page = page
	}
	local input_item = TextInputMenuItem.create_from_config({
		world = world
	}, input_config, page)

	page:add_item(input_item, "item_list")

	local cancel_btn_config = {
		text = "menu_cancel",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local cancel_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, cancel_btn_config, page)

	page:add_item(cancel_item, "button_list")

	local ok_btn_config = {
		text = "menu_ok",
		on_select = "cb_item_selected",
		disabled_func = cb_save_button_disabled and "cb_item_disabled",
		disabled_func_args = cb_save_button_disabled,
		on_select_args = {
			"close",
			"save"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local ok_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, ok_btn_config, page)

	page:add_item(ok_item, "button_list")

	return page
end

function MenuHelper:create_confirmation_popup_page(world, parent_page, callback_object, on_enter_options, on_item_selected, page_z, sounds, header_text, message_text, layout_settings_page, layout_settings_header, layout_settings_message, layout_settings_button)
	local compiler_data = {
		world = world
	}
	local page_config = {
		on_enter_options = on_enter_options,
		on_item_selected = on_item_selected,
		z = page_z,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local header_config = {
		disabled = true,
		text = header_text,
		z = page_z + 1,
		layout_settings = layout_settings_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local message_config = {
		disabled = true,
		name = "text_message",
		text = message_text,
		z = page_z + 1,
		layout_settings = layout_settings_message,
		parent_page = page
	}
	local message_item = TextMenuItem.create_from_config({
		world = world
	}, message_config, page)

	page:add_item(message_item, "item_list")

	local cancel_btn_config = {
		text = "menu_cancel",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local cancel_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, cancel_btn_config, page)

	page:add_item(cancel_item, "button_list")

	local ok_btn_config = {
		text = "menu_ok",
		on_select = "cb_item_selected",
		on_select_args = {
			"close",
			"confirm"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local ok_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, ok_btn_config, page)

	page:add_item(ok_item, "button_list")

	return page
end

function MenuHelper:cb_buy_entity_popup_selected(args)
	if args.action and args.action[1] == "purchase" then
		local market_items = Managers.persistence:market().items
		local market_item_name = args.action[2]
		local market_item = market_items[market_item_name]
		local popup_parent_page = args.action[3]

		Managers.persistence:purchase_item(market_item, callback(MenuHelper, "cb_purchase_complete"))
	elseif args.action and args.action[1] == "wants_buy_gold" then
		local cb_wants_buy_gold = args.action[2]

		cb_wants_buy_gold()
	end
end

function MenuHelper:cb_purchase_complete(success)
	print("[MenuHelper:cb_purchase_complete] success:", success)

	if success then
		Managers.state.event:trigger("purchase_complete")

		local world = Application.main_world()
		local timpani_world = World.timpani_world(world)

		TimpaniWorld.trigger_event(timpani_world, MenuSettings.sounds.buy_item_success)
	end
end

function MenuHelper:create_purchase_market_item_popup_page(world, parent_page, market_item_type, market_item_name, message_args, page_z, sounds)
	local layout_settings_page = MainMenuSettings.pages.text_input_popup
	local layout_settings_header = MainMenuSettings.items.popup_header
	local layout_settings_header_alert = MainMenuSettings.items.popup_header_alert
	local layout_settings_message = MainMenuSettings.items.popup_textbox
	local layout_settings_button = MainMenuSettings.items.popup_button
	local market_items = Managers.persistence:market().items
	local item = market_items[market_item_name]
	local header_text, message_text, insufficient_funds

	if not item then
		header_text = "menu_store_notice_confirmation_header"
		message_text = string.format("Item not found in backend!", message_args[1])

		Application.warning("Item not found in backend %q %q", market_item_type, market_item_name)
	else
		local prices = item.prices
		local price_table = prices[1]

		if not price_table then
			header_text = "menu_store_notice_confirmation_header"
			message_text = string.format("Item has no currency attached in backend!", message_args[1])

			Application.warning("Item does not have currency attached in backend %q %q", market_item_type, market_item_name)

			item = nil
		else
			local price = price_table.price
			local profile_data = Managers.persistence:profile_data()
			local profile_coins = profile_data.attributes.coins

			insufficient_funds = profile_coins < price

			if insufficient_funds then
				header_text = "menu_store_notice_insufficient_funds_header"
				message_text = string.format(L("menu_store_notice_insufficient_funds_message"), message_args[1], price, price - profile_coins)
			elseif market_item_type == "perk" then
				header_text = "menu_store_notice_confirmation_header"
				message_text = string.format(L("menu_store_notice_perk_confirmation"), message_args[1], price)
			elseif market_item_type == "gear_attachment" or market_item_type == "armour_attachment" or market_item_type == "helmet_attachment" then
				header_text = "menu_store_notice_confirmation_header"
				message_text = string.format(L("menu_store_notice_attachment_confirmation"), message_args[1], message_args[2], price)
			else
				header_text = "menu_store_notice_confirmation_header"
				message_text = string.format(L("menu_store_notice_item_confirmation"), message_args[1], price)
			end
		end
	end

	local compiler_data = {
		world = world
	}
	local page_config = {
		on_item_selected = "cb_buy_entity_popup_selected",
		z = page_z + 100,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, MenuHelper)
	local header_config = {
		disabled = true,
		text = header_text,
		z = page_z + 1,
		layout_settings = insufficient_funds and layout_settings_header_alert or layout_settings_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local message_config = {
		no_localization = true,
		disabled = true,
		text = message_text,
		z = page_z + 1,
		layout_settings = layout_settings_message,
		parent_page = page
	}
	local message_item = TextBoxMenuItem.create_from_config({
		world = world
	}, message_config, page)

	page:add_item(message_item, "item_list")

	local cancel_btn_config = {
		text = "menu_cancel",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local cancel_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, cancel_btn_config, page)

	page:add_item(cancel_item, "button_list")

	if not IS_DEMO and GameSettingsDevelopment.enable_micro_transactions and insufficient_funds and item then
		local btn_config = {
			text = "buy_gold_upper",
			on_select = "cb_item_selected",
			on_select_args = {
				"close",
				{
					"wants_buy_gold",
					callback(parent_page, "cb_wants_buy_gold")
				}
			},
			z = page_z + 1,
			layout_settings = layout_settings_button,
			parent_page = page
		}
		local ok_item = TextureButtonMenuItem.create_from_config({
			world = world
		}, btn_config, page)

		page:add_item(ok_item, "button_list")
	end

	if not insufficient_funds and item then
		local ok_btn_config = {
			text = "menu_store_purchase",
			on_select = "cb_item_selected",
			on_select_args = {
				"close",
				{
					"purchase",
					market_item_name
				}
			},
			z = page_z + 1,
			layout_settings = layout_settings_button,
			parent_page = page
		}
		local ok_item = TextureButtonMenuItem.create_from_config({
			world = world
		}, ok_btn_config, page)

		page:add_item(ok_item, "button_list")
	end

	return page
end

function MenuHelper:create_rank_not_met_popup_page(world, parent_page, entity_type, unlock_key, entity_ui_name, page_z, sounds)
	local layout_settings_page = MainMenuSettings.pages.message_popup
	local layout_settings_header = MainMenuSettings.items.popup_header
	local layout_settings_message = MainMenuSettings.items.popup_textbox
	local layout_settings_button = MainMenuSettings.items.popup_button
	local required_rank = ProfileHelper:required_entity_rank(entity_type, unlock_key)
	local missing_xp = ProfileHelper:xp_left_to_rank(required_rank)
	local message_text = string.format(L("menu_xplock_notice_message"), L(entity_ui_name), L(entity_ui_name), required_rank, missing_xp or "?")
	local compiler_data = {
		world = world
	}
	local page_config = {
		z = page_z + 100,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, MenuHelper)
	local header_config = {
		text = "menu_xplock_notice_header",
		disabled = true,
		z = page_z + 1,
		layout_settings = layout_settings_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local message_config = {
		no_localization = true,
		disabled = true,
		text = message_text,
		layout_settings = layout_settings_message,
		parent_page = page
	}
	local message_item = TextBoxMenuItem.create_from_config({
		world = world
	}, message_config, page)

	page:add_item(message_item, "item_list")

	local ok_btn_config = {
		text = "menu_ok",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local ok_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, ok_btn_config, page)

	page:add_item(ok_item, "button_list")

	return page
end

function MenuHelper:create_locked_in_demo_popup_page(world, parent_page, page_z, sounds)
	local layout_settings_page = MainMenuSettings.pages.demo_popup
	local layout_settings_header = MainMenuSettings.items.popup_header
	local layout_settings_message = MainMenuSettings.items.popup_textbox
	local layout_settings_button = MainMenuSettings.items.demo_popup_buy_button
	local layout_settings_cancel_button = MainMenuSettings.items.demo_popup_cancel_button
	local compiler_data = {
		world = world
	}
	local page_config = {
		on_item_selected = "cb_buy_game",
		z = page_z + 100,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = DemoPopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, parent_page)
	local buy_btn_config = {
		text = "",
		on_select = "cb_item_selected",
		on_select_args = {
			"close",
			"confirm"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local buy_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, buy_btn_config, page)

	page:add_item(buy_item, "button_list")

	local cancel_btn_config = {
		text = "",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_cancel_button,
		parent_page = page
	}
	local cancel_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, cancel_btn_config, page)

	page:add_item(cancel_item, "button_list")

	return page
end

function MenuHelper:create_filter_popup_page(world, parent_page, page_z, sounds)
	local layout_settings_page = MainMenuSettings.pages.filter_popup
	local compiler_data = {
		world = world
	}
	local page_config = {
		z = page_z + 100,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, parent_page)
	local header_config = {
		text = "menu_filter_settings",
		disabled = true,
		z = page_z + 1,
		layout_settings = MainMenuSettings.items.filter_popup_header,
		parent_page = parent_page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local compiler_data = {
		world = world
	}
	local game_mode_config = {
		on_option_changed = "cb_on_option_changed_local_filter_game_mode",
		on_enter_options = "cb_on_enter_options_local_filter_game_mode",
		layout_settings = ServerBrowserSettings.pages.popup_server_filter_ddl,
		sounds = MenuSettings.sounds.default,
		z = page_z + 150,
		callback_object = parent_page
	}
	local item_groups = {
		items = {}
	}
	local filter_game_mode_config = {
		on_enter_text = "cb_on_enter_text_local_filter_game_mode",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_ddl_closed_text,
		parent_page = parent_page,
		page = DropDownListMenuPage.create_from_config(compiler_data, game_mode_config, page, item_groups, parent_page)
	}
	local game_mode_page = DropDownListMenuItem.create_from_config({
		world = world
	}, filter_game_mode_config, parent_page)

	page:add_item(game_mode_page, "item_list")

	local compiler_data = {
		world = world
	}
	local level_config = {
		on_option_changed = "cb_on_option_changed_query_filter_level_popup",
		on_enter_options = "cb_on_enter_options_query_filter_level",
		layout_settings = ServerBrowserSettings.pages.popup_server_filter_ddl,
		sounds = MenuSettings.sounds.default,
		z = page_z + 150,
		callback_object = parent_page
	}
	local item_groups = {
		items = {}
	}
	local filter_level_config = {
		on_enter_text = "cb_on_enter_text_query_filter_level",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_ddl_closed_text,
		parent_page = parent_page,
		page = DropDownListMenuPage.create_from_config(compiler_data, level_config, page, item_groups, parent_page)
	}
	local filter_level_item = DropDownListMenuItem.create_from_config({
		world = world
	}, filter_level_config, parent_page)

	page:add_item(filter_level_item, "item_list")

	local filter_password_config = {
		on_enter_select = "cb_on_enter_local_filter_password",
		name = "local_filter_password",
		text = "menu_password_protected",
		on_select = "cb_on_select_local_filter_password_popup",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_checkbox,
		parent_page = parent_page
	}
	local filter_password = CheckboxMenuItem.create_from_config({
		world = world
	}, filter_password_config, parent_page)

	page:add_item(filter_password, "item_list")

	local filter_demo_config = {
		text = "menu_demo",
		name = "local_filter_demo",
		remove_func = "cb_demo_checkbox_remove",
		on_enter_select = "cb_on_enter_local_filter_demo",
		on_select = "cb_on_select_local_filter_demo_popup",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_checkbox,
		parent_page = parent_page
	}
	local filter_demo = CheckboxMenuItem.create_from_config({
		world = world
	}, filter_demo_config, parent_page)

	page:add_item(filter_demo, "item_list")

	local filter_only_available_config = {
		on_enter_select = "cb_on_enter_local_filter_only_available",
		name = "local_filter_demo",
		text = "menu_only_available",
		on_select = "cb_on_select_local_filter_only_available_popup",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_checkbox,
		parent_page = parent_page
	}
	local filter_only_available = CheckboxMenuItem.create_from_config({
		world = world
	}, filter_only_available_config, parent_page)

	page:add_item(filter_only_available, "item_list")

	local filter_not_full_config = {
		on_enter_select = "cb_on_enter_query_filter_not_full",
		name = "query_filter_not_full",
		text = "menu_server_not_full",
		on_select = "cb_on_select_query_filter_not_full_popup",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_checkbox,
		parent_page = parent_page
	}
	local filter_not_full = CheckboxMenuItem.create_from_config({
		world = world
	}, filter_not_full_config, parent_page)

	page:add_item(filter_not_full, "item_list")

	local filter_has_players_config = {
		on_enter_select = "cb_on_enter_query_filter_has_players",
		name = "query_filter_has_players",
		text = "menu_server_has_players",
		on_select = "cb_on_select_query_filter_has_players_popup",
		z = page_z + 1,
		layout_settings = ServerBrowserSettings.items.popup_filter_checkbox,
		parent_page = parent_page
	}
	local filter_has_players = CheckboxMenuItem.create_from_config({
		world = world
	}, filter_has_players_config, parent_page)

	page:add_item(filter_has_players, "item_list")

	local cancel_item_config = {
		text = "main_menu_cancel",
		on_select = "_cancel",
		z = page_z + 1,
		layout_settings = MainMenuSettings.items.filter_popup_text_left_aligned,
		parent_page = page
	}
	local cancel_item = TextMenuItem.create_from_config({
		world = world
	}, cancel_item_config, parent_page)

	page:add_item(cancel_item, "item_list")

	return page
end

function MenuHelper:create_required_perk_popup_page(world, parent_page, ui_name, required_perk, page_z, sounds)
	local layout_settings_page = MainMenuSettings.pages.message_popup
	local layout_settings_header = MainMenuSettings.items.popup_header
	local layout_settings_message = MainMenuSettings.items.popup_textbox
	local layout_settings_button = MainMenuSettings.items.popup_button
	local required_perk_name = L(Perks[required_perk].ui_header)
	local message_text = string.format(L("menu_perk_needed_notice_message"), required_perk_name, ui_name)
	local compiler_data = {
		world = world
	}
	local page_config = {
		z = page_z + 100,
		layout_settings = layout_settings_page,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, MenuHelper)
	local header_config = {
		text = "menu_perk_needed_notice_header",
		disabled = true,
		z = page_z + 1,
		layout_settings = layout_settings_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local message_config = {
		no_localization = true,
		disabled = true,
		text = message_text,
		layout_settings = layout_settings_message,
		parent_page = page
	}
	local message_item = TextBoxMenuItem.create_from_config({
		world = world
	}, message_config, page)

	page:add_item(message_item, "item_list")

	local ok_btn_config = {
		text = "menu_ok",
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = layout_settings_button,
		parent_page = page
	}
	local ok_item = TextureButtonMenuItem.create_from_config({
		world = world
	}, ok_btn_config, page)

	page:add_item(ok_item, "button_list")

	return page
end

function MenuHelper:create_buy_gold_popup_page(world, parent_page, callback_object, on_enter_options, on_item_selected, page_z, sounds)
	local page_config = {
		on_enter_options = on_enter_options,
		on_item_selected = on_item_selected,
		z = page_z,
		layout_settings = MainMenuSettings.pages.buy_gold_popup,
		sounds = sounds
	}
	local item_groups = {
		header_list = {},
		item_list = {},
		button_list = {}
	}
	local page = PopupMenuPage.create_from_config({
		world = world
	}, page_config, parent_page, item_groups, callback_object)
	local header_config = {
		text = "buy_gold",
		disabled = true,
		z = page_z + 1,
		layout_settings = MainMenuSettings.items.popup_header,
		parent_page = page
	}
	local header_item = TextMenuItem.create_from_config({
		world = world
	}, header_config, page)

	page:add_item(header_item, "header_list")

	local message_config = {
		text = "select_amount",
		name = "text_message",
		disabled = true,
		z = page_z + 1,
		layout_settings = MainMenuSettings.items.popup_text,
		parent_page = page
	}
	local message_item = TextMenuItem.create_from_config({
		world = world
	}, message_config, page)

	page:add_item(message_item, "item_list")

	local store = Managers.persistence:store()
	local currency_code = "EUR"

	for i = 1, #store do
		local store_item = store[i]
		local id = store_item.id
		local description = store_item.descriptions.default
		local price = math.round(store_item.prices[currency_code] / 100, 2)
		local item_config = {
			no_localization = true,
			on_select = "cb_item_selected",
			on_select_args = {
				[2] = id
			},
			text = sprintf("%4.2f", price) .. " " .. currency_code,
			z = page_z + 1,
			layout_settings = table.clone(MainMenuSettings.items.coins_amount_button),
			parent_page = page
		}
		local layout_settings = item_config.layout_settings

		for _, rez in pairs(layout_settings) do
			for _, settings in pairs(rez) do
				settings.texture_middle = settings.texture_middle .. tostring(i)
				settings.texture_middle_highlighted = settings.texture_middle_highlighted .. tostring(i)
			end
		end

		local item = TextureButtonMenuItem.create_from_config({
			world = world
		}, item_config, page)

		page:add_item(item, "button_list")
	end

	local cancel_btn_config = {
		on_select = "cb_item_selected",
		on_select_args = {
			"close"
		},
		z = page_z + 1,
		layout_settings = MainMenuSettings.items.popup_close_texture,
		parent_page = page
	}
	local cancel_item = TextureMenuItem.create_from_config({
		world = world
	}, cancel_btn_config, page)

	page:add_item(cancel_item, "header_list")

	return page
end

function MenuHelper:create_sale_popup_page(world, callback_object, parent_page, page_z, sounds, sale_items)
	local page_config = {
		layout_settings = "MainMenuSettings.pages.sale_popup",
		render_parent_page = true,
		z = page_z,
		sounds = sounds,
		sale_popup_items = sale_items
	}
	local item_groups = {
		header_list = {},
		content_header_list = {},
		content_texture_list = {},
		content_description_list = {},
		content_navigation_list = {}
	}
	local compiler_data = {
		world = world
	}
	local page = SalePopupMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local item
	local header_icon_config = {
		disabled = true,
		layout_settings = MainMenuSettings.items.sale_popup_header_icon,
		parent_page = page
	}

	item = AtlasTextureMenuItem.create_from_config({
		world = world
	}, header_icon_config, page)

	page:add_item(item, "header_list")

	local header_sale_text_config = {
		text = "HEADER",
		on_update_text = "cb_sale_header",
		layout_settings = "MainMenuSettings.items.sale_popup_header_text",
		disabled = true,
		callback_object = page,
		parent_page = page
	}

	item = TextMenuItem.create_from_config({
		world = world
	}, header_sale_text_config, page)

	page:add_item(item, "header_list")

	local header_sale_off_config = {
		text = "SUB_HEADER",
		on_update_text = "cb_sale_sub_header",
		layout_settings = "MainMenuSettings.items.sale_popup_header_text_price_off",
		disabled = true,
		callback_object = page,
		parent_page = page
	}

	item = TextMenuItem.create_from_config({
		world = world
	}, header_sale_off_config, page)

	page:add_item(item, "header_list")

	local header_price_config = {
		layout_settings = "MainMenuSettings.items.sale_popup_price_text",
		visible_func = "cb_price_visible",
		text = "PRICE",
		disabled = true,
		on_update_text = "cb_sale_price",
		callback_object = page,
		parent_page = page
	}

	item = TextMenuItem.create_from_config({
		world = world
	}, header_price_config, page)

	page:add_item(item, "header_list")

	local header_close_config = {
		layout_settings = "MainMenuSettings.items.sale_popup_close_button",
		on_select = "cb_cancel",
		callback_object = page,
		parent_page = page
	}

	item = AtlasTextureMenuItem.create_from_config({
		world = world
	}, header_close_config, page)

	page:add_item(item, "header_list")

	local selection_config = {
		layout_settings = "MainMenuSettings.items.sale_popup_index_indicator",
		on_update_selection = "cb_selection",
		on_select_new_index = "cb_new_selection",
		disabled = false,
		callback_object = page,
		parent_page = page
	}

	item = SelectionIndicatorMenuItem.create_from_config({
		world = world
	}, selection_config, page)

	page:add_item(item, "content_navigation_list")

	local content_header_config = {
		text = "ITEM_NAME",
		on_update_text = "cb_sale_name",
		layout_settings = "MainMenuSettings.items.sale_popup_item_header",
		disabled = true,
		callback_object = page,
		parent_page = page
	}

	item = TextMenuItem.create_from_config({
		world = world
	}, content_header_config, page)

	page:add_item(item, "content_header_list")

	local content_arrow_left_config = {
		on_select = "cb_previous_sale",
		layout_settings = MainMenuSettings.items.sale_popup_arrow_left,
		callback_object = page,
		parent_page = page
	}

	item = AtlasTextureMenuItem.create_from_config({
		world = world
	}, content_arrow_left_config, page)

	page:add_item(item, "content_texture_list")

	local content_texture_config = {
		on_select = "cb_buy_item",
		height = 120,
		width = 400,
		on_update_texture = "cb_sale_texture",
		layout_settings = MainMenuSettings.items.sale_popup_item_texture,
		callback_object = page,
		parent_page = page
	}

	item = AtlasTextureMenuItem.create_from_config({
		world = world
	}, content_texture_config, page)

	page:add_item(item, "content_texture_list")

	local content_arrow_right_config = {
		on_select = "cb_next_sale",
		layout_settings = MainMenuSettings.items.sale_popup_arrow_right,
		callback_object = page,
		parent_page = page
	}

	item = AtlasTextureMenuItem.create_from_config({
		world = world
	}, content_arrow_right_config, page)

	page:add_item(item, "content_texture_list")

	local content_description_config = {
		text = "ITEM_DESC",
		on_update_text = "cb_sale_description",
		layout_settings = "MainMenuSettings.items.sale_popup_item_desc",
		disabled = true,
		callback_object = page,
		parent_page = page
	}

	item = TextBoxMenuItem.create_from_config({
		world = world
	}, content_description_config, page)

	page:add_item(item, "content_description_list")

	return page
end

function MenuHelper.outfit_menu_item_requirement_info(layout_settings, config)
	local texture, text, requirement_not_met

	if config.unavalible_reason == "required_perk" then
		texture = layout_settings.texture_unavalible_perk_required
		text = L(Perks[config.required_perk].ui_header)
		requirement_not_met = true
	elseif config.unavalible_reason == "rank_not_met" then
		texture = layout_settings.texture_unavalible_rank_not_met

		local required_rank = ProfileHelper:required_entity_rank(config.entity_type, config.unlock_key)

		text = required_rank
		requirement_not_met = true
	elseif config.unavalible_reason == "locked_in_demo" then
		texture = layout_settings.texture_unavalible_demo
		text = L("menu_demo_text")
		requirement_not_met = true
	elseif config.unavalible_reason == "not_owned" then
		texture = layout_settings.texture_unavalible_not_owned

		local market_items = Managers.persistence:market().items
		local item = market_items[config.market_item_name]

		if not item then
			text = string.format("Item not found in backend!", config.ui_name)

			Application.warning("Item not found in backend %q %q", config.entity_type, config.market_item_name)
		else
			local prices = item.prices
			local price_table = prices[1]

			if not price_table then
				text = string.format("Item has no currency attached in backend!", config.ui_name)

				Application.warning("Item does not have currency attached in backend %q %q", config.entity_type, config.market_item_name)
			else
				local price = price_table.price
				local profile_data = Managers.persistence:profile_data()
				local profile_coins = profile_data.attributes.coins

				text = price

				if profile_coins < price then
					requirement_not_met = true
				end
			end
		end
	end

	local text_color = requirement_not_met and layout_settings.requirement_not_met_color or layout_settings.color

	return texture, text, text_color
end

function MenuHelper.calculate_minimap_position(pos, minimap_props)
	local origo = minimap_props.origo:unbox()
	local offset = pos - origo
	local offset_x = Vector3.dot(minimap_props.x_axis:unbox(), offset)
	local offset_y = Vector3.dot(minimap_props.y_axis:unbox(), offset)
	local x = minimap_props.texture_scale_x * (offset_x / minimap_props.x_scale)
	local y = minimap_props.texture_scale_y * (offset_y / minimap_props.y_scale)

	return x, y
end

function MenuHelper.light_adaption_fix_shading_callback(world, shading_env)
	local reset = World.get_data(world, "luminance_reset")

	if reset then
		ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 0)
	else
		ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 1)
		World.set_data(world, "luminance_reset", true)
	end

	if Managers.state.camera then
		Managers.state.camera:shading_callback(world, shading_env)
	end
end

function MenuHelper.is_outside_screen(x, y, w, h, padding)
	local res_width, res_height = Gui.resolution()

	if y + h + padding < 0 or res_height < y - padding or x + w + padding < 0 or res_width < x - padding then
		return true
	end
end

function MenuHelper.single_player_levels_sorted()
	local sorted_table = {}

	for level_key, config in pairs(LevelSettings) do
		if config.visible and config.single_player then
			sorted_table[#sorted_table + 1] = config
			sorted_table[#sorted_table].level_key = level_key
		end
	end

	table.sort(sorted_table, function(a, b)
		return a.sort_index < b.sort_index
	end)

	return sorted_table
end
