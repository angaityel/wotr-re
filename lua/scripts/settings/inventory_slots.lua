-- chunkname: @scripts/settings/inventory_slots.lua

InventorySlots = {
	two_handed_weapon = {
		wield_input = "wield_two_handed_weapon",
		wield_toggle = false
	},
	one_handed_weapon = {
		wield_input = "wield_one_handed_weapon",
		wield_toggle = false
	},
	dagger = {
		wield_input = "wield_dagger",
		wield_toggle = false
	},
	shield = {
		wield_input = "wield_shield",
		wield_toggle = true
	}
}
InventorySlotPriority = {
	"two_handed_weapon",
	"one_handed_weapon",
	"dagger"
}
