-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/player_husk_inventory.lua

require("scripts/unit_extensions/default_player_unit/inventory/player_base_inventory")
require("scripts/unit_extensions/default_player_unit/inventory/husk_gear")

PlayerHuskInventory = class(PlayerHuskInventory, PlayerBaseInventory)
PlayerHuskInventory.GEAR_CLASS = "HuskGear"

local function copy_lod_object(source_unit, dest_unit, lod_object_name)
	if GameSettingsDevelopment.disable_uniform_lod then
		return
	end

	local source_lod_object = Unit.lod_object(source_unit, lod_object_name)
	local dest_lod_object = Unit.lod_object(dest_unit, lod_object_name)
	local source_bounding_volume = LODObject.bounding_volume(source_lod_object)

	LODObject.set_bounding_volume(dest_lod_object, source_bounding_volume)
	LODObject.set_orientation_node(dest_lod_object, source_unit, Unit.node(source_unit, "c_afro"))
end

function PlayerHuskInventory:init(world, user_unit, player, tint_color, secondary_tint_color)
	self._voice_type = "husk_voice"

	PlayerBaseInventory.init(self, world, user_unit, player, tint_color, secondary_tint_color)

	self._anim_wielded_weapons_hidden = false
end

function PlayerHuskInventory:enter_ghost_mode()
	self.ghost_mode = true

	local slots = self._slots

	for slot_name, slot in pairs(slots) do
		local gear = slot.gear

		if gear then
			gear:enter_ghost_mode()
		end
	end

	local head_unit = self._head_unit

	if Unit.alive(head_unit) then
		Unit.set_unit_visibility(head_unit, false)
	end

	local helmet_unit = self._helmet_unit

	if Unit.alive(helmet_unit) then
		Unit.set_unit_visibility(helmet_unit, false)
	end

	for attachment_type, attachment_unit in pairs(self._helmet_attachment_units) do
		Unit.set_unit_visibility(attachment_unit, false)
	end
end

function PlayerHuskInventory:anim_cb_hide_wielded_weapons(hide)
	self._anim_wielded_weapons_hidden = hide

	local func_name = hide and "hide_gear" or "unhide_gear"

	for name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() then
			gear[func_name](gear, "animation")
		end
	end
end

function PlayerHuskInventory:set_gear_wielded(slot_name, wielded, ignore_sound)
	local gear = self._slots[slot_name].gear

	assert(gear, "[PlayerHuskInventory:wield_gear] Tried to wield slot without gear! slot_name: " .. tostring(slot_name))
	gear:set_wielded(wielded)

	local main_body_state, hand_anim = self:player_unit_gear_anims(gear)

	if main_body_state then
		Unit.animation_event(self._user_unit, main_body_state)
	end

	if hand_anim then
		Unit.animation_event(self._user_unit, hand_anim)
	end

	if not ignore_sound and wielded and Gear[gear:name()].timpani_events and Gear[gear:name()].timpani_events.wield then
		gear:trigger_timpani_event("wield")
	end

	if self._anim_wielded_weapons_hidden then
		if wielded then
			gear:hide_gear("animation")
		else
			gear:unhide_gear("animation")
		end
	end
end

function PlayerHuskInventory:exit_ghost_mode()
	self.ghost_mode = false

	local slots = self._slots

	for slot_name, slot in pairs(slots) do
		local gear = slot.gear

		if gear then
			gear:exit_ghost_mode()
		end
	end

	local head_unit = self._head_unit

	if Unit.alive(head_unit) then
		Unit.set_unit_visibility(head_unit, true)
		Unit.set_visibility(head_unit, "head_decap", false)
	end

	local helmet_unit = self._helmet_unit

	if Unit.alive(helmet_unit) then
		Unit.set_unit_visibility(helmet_unit, true)

		local helmet_settings = Helmets[self:helmet_name()]

		if helmet_settings.hide_head_visibility_group then
			assert(head_unit, "[PlayerHuskInventory:exit_ghost_mode] set_visibility self._head_unit = nil")
			Unit.set_visibility(head_unit, helmet_settings.hide_head_visibility_group, false)
		end
	end

	for attachment_type, attachment_unit in pairs(self._helmet_attachment_units) do
		Unit.set_unit_visibility(attachment_unit, true)
	end
end

function PlayerHuskInventory:add_gear(gear_name, obj_id, attachment_ids)
	local attachments = {}

	for i = 1, NetworkConstants.max_attachments do
		local category, items = self:_calculate_items(gear_name, i, attachment_ids)

		if category then
			attachments[category] = items
		end
	end

	local gear_unit, gear = PlayerHuskInventory.super.add_gear(self, gear_name, obj_id, false, attachments)

	if self.ghost_mode then
		gear:enter_ghost_mode()
	end

	copy_lod_object(self._user_unit, gear_unit, "LOD")

	return gear_unit
end

function PlayerHuskInventory:_calculate_items(gear_name, index, attachment_ids)
	local category, items
	local gear_settings = Gear[gear_name]
	local potential_attachments = gear_settings.attachments
	local value = attachment_ids[index]

	if value ~= 0 then
		local attachment = potential_attachments[index]

		category = attachment.category

		local attachment_items = WeaponHelper:attachment_items_by_category(gear_name, category) or {}

		if attachment.menu_page_type == "checkbox" then
			items = self:_calculate_misc_items(attachment_items, value)
		else
			items = {
				attachment_items[value].name
			}
		end
	end

	return category, items
end

function PlayerHuskInventory:_calculate_misc_items(attachment_items, value)
	local items = {}

	for i = 1, NetworkConstants.max_attachments do
		local result = value % 2

		value = (value - result) / 2

		if result ~= 0 then
			items[#items + 1] = attachment_items[i].name
		end
	end

	return items
end

function PlayerHuskInventory:add_head(head_name, head_material, voice)
	PlayerHuskInventory.super.add_head(self, head_name, head_material, voice)
	copy_lod_object(self._user_unit, self._head_unit, "LOD")

	if self.ghost_mode then
		Unit.set_unit_visibility(self._head_unit, false)
	end
end

function PlayerHuskInventory:add_helmet(helmet_name, team_name)
	PlayerHuskInventory.super.add_helmet(self, helmet_name, team_name)
	copy_lod_object(self._user_unit, self._helmet_unit, "LOD")

	if self.ghost_mode then
		Unit.set_unit_visibility(self._helmet_unit, false)
	end
end

function PlayerHuskInventory:add_helmet_attachment(helmet_name, attachment_type, attachment_name, team_name)
	PlayerHuskInventory.super.add_helmet_attachment(self, helmet_name, attachment_type, attachment_name, team_name)

	if self.ghost_mode and attachment_type ~= "pattern" then
		Unit.set_unit_visibility(self._helmet_attachment_units[attachment_type], false)
	end
end

function PlayerHuskInventory:add_helmet_crest(crest_name, team_name)
	PlayerHuskInventory.super.add_helmet_crest(self, crest_name, team_name)

	if self.ghost_mode then
		Unit.set_unit_visibility(self._helmet_attachment_units.crest, false)
	end
end

function PlayerHuskInventory:helmet()
	return self._helmet_unit
end
