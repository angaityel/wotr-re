-- chunkname: @scripts/helpers/outfit_helper.lua

require("scripts/settings/release_settings")

OutfitHelper = OutfitHelper or {}
OutfitHelper._attachment_multiplier_to_gear_property = {
	pose_speed = {
		ui_invert = true,
		gear_property = "charge_time"
	},
	swing_speed = {
		ui_invert = true,
		gear_property = "attack_time"
	},
	pose_movement_speed = {
		gear_property = "pose_movement_multiplier"
	},
	damage = {
		gear_property = "base_damage"
	},
	absorption_armour = {
		gear_property = "absorption_value"
	},
	penetration_armour = {
		gear_property = "penetration_value"
	},
	health = {
		gear_property = "health"
	},
	encumbrance = {
		gear_property = "encumbrance"
	},
	reload_speed = {
		ui_invert = true,
		gear_property = "reload_time"
	},
	crossbow_miss = {
		gear_property = "reload_miss_time"
	},
	crossbow_hit = {
		gear_property = "reload_hit_time"
	},
	crossbow_hit_section = {
		gear_property = "reload_hit_section_size"
	},
	lance_speed_max = {
		ui_invert = true,
		gear_property = "speed_max"
	},
	lance_couch_time = {
		gear_property = "couch_time"
	},
	amunition_amount = {
		gear_property = "starting_ammo"
	},
	amunition_regeneration = {
		gear_property = "ammo_regen_rate"
	},
	gravity = {
		ui_invert = true,
		gear_property = "gravity"
	},
	miss_penalty = {
		gear_property = "miss_penalty"
	},
	blocked_penalty = {
		gear_property = "blocked_penalty"
	}
}

function OutfitHelper.attachment_multiplier_to_gear_property(multiplier_name)
	local config = OutfitHelper._attachment_multiplier_to_gear_property[multiplier_name]

	return config.gear_property, config.ui_invert
end

function OutfitHelper.gear_property_to_attachment_multiplier(gear_property)
	for multiplier_name, config in pairs(OutfitHelper._attachment_multiplier_to_gear_property) do
		if config.gear_property == gear_property then
			return multiplier_name
		end
	end
end

function OutfitHelper.gear_property(gear_name, property_name)
	if property_name == "speed" then
		return OutfitHelper._gear_mean_speed(gear_name)
	elseif property_name == "reload_time" then
		return OutfitHelper._gear_reload_time(gear_name)
	elseif property_name == "gravity" then
		return OutfitHelper._gear_gravity()
	elseif property_name == "charge_time" then
		return OutfitHelper._gear_attack_property_mean_value(gear_name, "charge_time")
	elseif property_name == "attack_time" then
		return OutfitHelper._gear_attack_property_mean_value(gear_name, "attack_time")
	elseif property_name == "base_damage" then
		return OutfitHelper._gear_attack_property_mean_value(gear_name, "base_damage")
	elseif property_name == "speed_max" then
		return OutfitHelper._gear_attack_property_mean_value(gear_name, "speed_max")
	elseif property_name == "couch_time" then
		return OutfitHelper._gear_attack_property_mean_value(gear_name, "couch_time")
	elseif property_name == "miss_penalty" then
		return OutfitHelper._gear_attack_penalty_mean_value(gear_name, "miss")
	elseif property_name == "blocked_penalty" then
		return OutfitHelper._gear_attack_penalty_mean_value(gear_name, "blocked", "parried")
	else
		return Gear[gear_name][property_name]
	end
end

function OutfitHelper._gear_gravity()
	return math.abs(ProjectileSettings.gravity:unbox()[3])
end

function OutfitHelper._gear_mean_speed(gear_name)
	local sum_speed = 0
	local num_attacks = 0
	local gear_settings = Gear[gear_name]
	local mean_speed

	if gear_settings.category == "handgonne" then
		for _, attack_name in ipairs(gear_settings.menu_stats_attacks) do
			local attack = gear_settings.attacks[attack_name]

			sum_speed = sum_speed + attack.reload_time
			num_attacks = num_attacks + 1
		end
	elseif gear_settings.category == "crossbow" then
		for _, attack_name in ipairs(gear_settings.menu_stats_attacks) do
			local attack = gear_settings.attacks[attack_name]

			sum_speed = sum_speed + (attack.reload_time + gear_settings.raise_time)
			num_attacks = num_attacks + 1
		end
	elseif gear_settings.category == "bow" then
		for _, attack_name in ipairs(gear_settings.menu_stats_attacks) do
			local attack = gear_settings.attacks[attack_name]

			sum_speed = sum_speed + (attack.bow_draw_time + attack.reload_time + attack.bow_tense_time)
			num_attacks = num_attacks + 1
		end
	elseif gear_settings.category == "lance" then
		for _, attack_name in ipairs(gear_settings.menu_stats_attacks) do
			local attack = gear_settings.attacks[attack_name]

			sum_speed = sum_speed + attack.couch_time
			num_attacks = num_attacks + 1
		end
	else
		for _, attack_name in ipairs(gear_settings.menu_stats_attacks) do
			local attack = gear_settings.attacks[attack_name]

			sum_speed = sum_speed + (attack.charge_time + attack.attack_time)
			num_attacks = num_attacks + 1
		end
	end

	if num_attacks > 0 then
		return 1 / (sum_speed / num_attacks)
	end
end

function OutfitHelper._gear_reload_time(gear_name)
	local gear_settings = Gear[gear_name]

	if gear_settings.attacks.ranged then
		return gear_settings.attacks.ranged.reload_time
	end
end

function OutfitHelper._gear_attack_penalty_mean_value(gear_name, ...)
	local sum = 0
	local num = select("#", ...)
	local changed = false

	for i = 1, num do
		local property = select(i, ...)
		local total = OutfitHelper._gear_attack_property_mean_value(gear_name, property, "penalties")

		if total then
			sum = sum + total
			changed = true
		end
	end

	if changed and num > 0 then
		return sum / num
	end
end

function OutfitHelper._gear_attack_property_mean_value(gear_name, property_name, ...)
	local sum = 0
	local num_attacks = 0
	local gear_settings = Gear[gear_name]

	for key, attack_name in ipairs(gear_settings.menu_stats_attacks) do
		local attack = gear_settings.attacks[attack_name]

		for i = 1, select("#", ...) do
			attack = attack[select(i, ...)]
		end

		if attack and attack[property_name] then
			sum = sum + attack[property_name]
			num_attacks = num_attacks + 1
		end
	end

	if num_attacks > 0 then
		return sum / num_attacks
	end
end

function OutfitHelper.gear_property_min(property_name)
	local min_value = math.huge

	for gear_name, gear_config in pairs(Gear) do
		local base_value = OutfitHelper.gear_property(gear_name, property_name)

		if base_value and base_value ~= math.huge then
			local multiplier_min

			for _, attachment in ipairs(gear_config.attachments) do
				for _, attachment_item in ipairs(attachment.items) do
					local attachment_name = OutfitHelper.gear_property_to_attachment_multiplier(property_name)

					if attachment_item.multipliers and attachment_item.multipliers[attachment_name] then
						multiplier_min = math.min(multiplier_min or math.huge, attachment_item.multipliers[attachment_name])
					end
				end
			end

			local modified_value

			if property_name == "reload_hit_section_size" then
				modified_value = base_value + (multiplier_min or 0) * 15
			else
				modified_value = base_value * (multiplier_min or 1)
			end

			if modified_value < min_value then
				min_value = modified_value
			end
		end
	end

	return min_value
end

function OutfitHelper.gear_property_max(property_name)
	local max_value = 0

	for gear_name, gear_config in pairs(Gear) do
		local base_value = OutfitHelper.gear_property(gear_name, property_name)

		if base_value and base_value ~= math.huge then
			local multiplier_max

			for _, attachment in ipairs(gear_config.attachments) do
				for _, attachment_item in ipairs(attachment.items) do
					local attachment_name = OutfitHelper.gear_property_to_attachment_multiplier(property_name)

					if attachment_item.multipliers and attachment_item.multipliers[attachment_name] then
						multiplier_max = math.max(multiplier_max or 0, attachment_item.multipliers[attachment_name])
					end
				end
			end

			local modified_value

			if property_name == "reload_hit_section_size" then
				modified_value = base_value + (multiplier_max or 0) * 15
			else
				modified_value = base_value * (multiplier_max or 1)
			end

			if max_value < modified_value then
				max_value = modified_value
			end
		end
	end

	return max_value
end

function OutfitHelper.armour_property_max(property_name)
	local max_value = 0

	for gear_name, config in pairs(Armours) do
		local value = config[property_name]

		if value and max_value < value then
			max_value = value
		end
	end

	return max_value
end

function OutfitHelper.helmet_property_max(property_name)
	local max_value = 0

	for gear_name, config in pairs(Helmets) do
		local value = config[property_name]

		if value and max_value < value then
			max_value = value
		end
	end

	return max_value
end

function OutfitHelper.mount_property_max(property_name)
	local max_value = 0

	for gear_name, config in pairs(MountProfiles) do
		local value = config[property_name]

		if value and max_value < value then
			max_value = value
		end
	end

	return max_value
end

function OutfitHelper.small_attachment_textures(gear_name, attachment_category, attachment_name)
	local gear_settings = Gear[gear_name]
	local textures = {}

	for i, attachment in ipairs(gear_settings.attachments) do
		if attachment.category == attachment_category then
			for i, item in ipairs(attachment.items) do
				if item.name == attachment_name then
					for _, texture in ipairs(item.ui_textures_small) do
						textures[#textures + 1] = texture
					end
				end
			end
		end
	end

	return textures
end

function OutfitHelper.outfit_editor_character_profiles_options()
	local options = {}

	for i, config in ipairs(PlayerProfiles) do
		local release_name = config.release_name
		local release_setting = ReleaseSettings[release_name or "default"]

		fassert(release_setting, "Invalid release setting %q", release_name)

		if release_setting ~= "hide" then
			options[#options + 1] = {
				key = i,
				value = config.display_name,
				no_editing = config.no_editing
			}
		end
	end

	return options, 1
end

function OutfitHelper.outfit_editor_slot_options()
	local options = {
		{
			value = "menu_perks",
			key = "perks"
		},
		{
			value = "menu_main_weapon",
			key = "two_handed_weapon"
		},
		{
			value = "menu_sidearm",
			key = "one_handed_weapon"
		},
		{
			value = "menu_dagger",
			key = "dagger"
		},
		{
			value = "menu_shield",
			key = "shield",
			required_perk = "shield_bearer"
		},
		{
			value = "menu_helmet",
			key = "helmet"
		},
		{
			value = "menu_head",
			key = "head",
			default_page = "_head_page",
			on_select_function = "cb_head_slot_selected"
		},
		{
			value = "menu_armour",
			key = "armour"
		},
		{
			value = "menu_mount",
			key = "mount",
			required_perk = "cavalry"
		}
	}

	return options, 1
end

function OutfitHelper.outfit_editor_gear_category_options(slot_name)
	local sorted_table = {}

	for gear_category, config in pairs(GearCategories[slot_name]) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].gear_category = gear_category
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		local required_perk = (config.gear_category == "bow" or config.gear_category == "crossbow") and "archer"

		options[#options + 1] = {
			category = config.gear_category,
			required_perk = required_perk,
			text = config.ui_header,
			description = config.ui_description,
			fluff_text = config.ui_fluff_text
		}
	end

	return options, 1
end

function OutfitHelper.outfit_editor_armour_category_options()
	local sorted_table = {}

	for armour_category, config in pairs(ArmourCategories) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].armour_category = armour_category
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		options[#options + 1] = {
			category = config.armour_category,
			text = config.ui_header,
			description = config.ui_description,
			fluff_text = config.ui_fluff_text
		}
	end

	return options, 1
end

function OutfitHelper.outfit_editor_helmet_category_options()
	local sorted_table = {}

	for helmet_category, config in pairs(HelmetCategories) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].helmet_category = helmet_category
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		options[#options + 1] = {
			category = config.helmet_category,
			text = config.ui_header,
			description = config.ui_description,
			fluff_text = config.ui_fluff_text
		}
	end

	return options, 1
end

function OutfitHelper.outfit_editor_perk_category_options()
	local options = {
		{
			text = "menu_offensive_perks",
			description = "menu_offensive_perks_description",
			fluff_text = "menu_offensive_perks_fluff_text",
			category = "offensive"
		},
		{
			text = "menu_defensive_perks",
			description = "menu_defensive_perks_description",
			fluff_text = "menu_defensive_perks_fluff_text",
			category = "defensive"
		},
		{
			text = "menu_supportive_perks",
			description = "menu_supportive_perks_description",
			fluff_text = "menu_supportive_perks_fluff_text",
			category = "supportive"
		},
		{
			text = "menu_movement_perks",
			description = "menu_movement_perks_description",
			fluff_text = "menu_movement_perks_fluff_text",
			category = "movement"
		},
		{
			text = "menu_officer_perks",
			description = "menu_officer_perks_description",
			fluff_text = "menu_officer_perks_fluff_text",
			category = "officer"
		}
	}

	return options, 1
end

function OutfitHelper.outfit_editor_mount_category_options()
	local sorted_table = {}

	for mount_category, config in pairs(MountCategories) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].mount_category = mount_category
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		local required_perk = config.mount_category == "barded" and "heavy_cavalry"

		options[#options + 1] = {
			category = config.mount_category,
			required_perk = required_perk,
			text = config.ui_header,
			description = config.ui_description,
			fluff_text = config.ui_fluff_text
		}
	end

	return options, 1
end

function OutfitHelper.gear_hidden(config)
	local release_setting = ReleaseSettings[config.release_name or "default"]

	fassert(release_setting, "Invalid release setting %q", config.release_name)

	return config.hide_if_unavailable or release_setting == "hide"
end

function OutfitHelper.outfit_editor_gear_options(category)
	local sorted_table = {}

	for gear_name, config in pairs(Gear) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].gear_name = gear_name
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		if category == config.category then
			local available, unavalible_reason = ProfileHelper:is_entity_avalible("gear", config.gear_name, "gear", config.gear_name, config.release_name)

			if available or not OutfitHelper.gear_hidden(config) then
				local slot_name = GearTypes[config.gear_type].inventory_slot

				options[#options + 1] = {
					key = config.gear_name,
					slot_name = slot_name,
					text = config.ui_header,
					description = config.ui_description,
					fluff_text = config.ui_fluff_text,
					release_name = config.release_name
				}
			end
		end
	end

	return options, 1
end

function OutfitHelper.outfit_editor_armour_options(category)
	local sorted_table = {}

	for armour_name, config in pairs(Armours) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].armour_name = armour_name
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		if category == config.category then
			local available, unavalible_reason = ProfileHelper:is_entity_avalible("armour", config.armour_name, "armour", config.armour_name, config.release_name, config.release_name)

			if available or not OutfitHelper.gear_hidden(config) then
				options[#options + 1] = {
					key = config.armour_name,
					text = config.ui_header,
					description = config.ui_description,
					fluff_text = config.ui_fluff_text,
					release_name = config.release_name
				}
			end
		end
	end

	return options, 1
end

function OutfitHelper.outfit_editor_helmet_options(category)
	local sorted_table = {}

	for helmet_name, config in pairs(Helmets) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].helmet_name = helmet_name
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		if category == config.category then
			local available, unavalible_reason = ProfileHelper:is_entity_avalible("helmet", config.helmet_name, "helmet", config.helmet_name, config.release_name)

			if available or not OutfitHelper.gear_hidden(config) then
				options[#options + 1] = {
					key = config.helmet_name,
					text = config.ui_header,
					description = config.ui_description,
					fluff_text = config.ui_fluff_text,
					release_name = config.release_name
				}
			end
		end
	end

	return options, 1
end

function OutfitHelper.outfit_editor_basic_perk_options(category, player_profile)
	local options = {}

	for _, perk_name in ipairs(PerkSlotTypes[category]) do
		options[#options + 1] = {
			key = perk_name,
			slot_name = category,
			text = Perks[perk_name].ui_header,
			description = Perks[perk_name].ui_description,
			fluff_text = Perks[perk_name].ui_fluff_text
		}
	end

	return options, 1
end

function OutfitHelper.outfit_editor_specialized_perk_options(basic_perk, player_profile)
	local options = {}

	for i, perk_name in ipairs(Perks[basic_perk].specializations) do
		local selected = table.contains(player_profile.perks, perk_name)

		options[#options + 1] = {
			key = perk_name,
			text = Perks[perk_name].ui_header,
			description = Perks[perk_name].ui_description,
			fluff_text = Perks[perk_name].ui_fluff_text,
			selected = selected
		}
	end

	return options
end

function OutfitHelper.outfit_editor_mount_options(category)
	local sorted_table = {}

	for mount_name, config in pairs(MountProfiles) do
		sorted_table[#sorted_table + 1] = config
		sorted_table[#sorted_table].mount_name = mount_name
	end

	table.sort(sorted_table, function(a, b)
		return a.ui_sort_index < b.ui_sort_index
	end)

	local options = {}

	for _, config in ipairs(sorted_table) do
		if category == config.category then
			options[#options + 1] = {
				avalible = true,
				key = config.mount_name,
				text = config.ui_header,
				description = config.ui_description,
				fluff_text = config.ui_fluff_text,
				release_name = config.release_name
			}
		end
	end

	return options, 1
end
