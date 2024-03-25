-- chunkname: @scripts/entity_system/entity_system.lua

require("scripts/entity_system/systems/extension_system_base")
require("scripts/entity_system/systems/locomotion/locomotion_system")
require("scripts/entity_system/systems/damage/damage_system")
require("scripts/entity_system/systems/spawner/spawner_system")
require("scripts/entity_system/systems/deserting/deserting_system")
require("scripts/entity_system/systems/cutscene/cutscene_system")
require("scripts/unit_extensions/default_player_unit/player_unit_interaction")
require("scripts/unit_extensions/objectives/zone_capture_point_client")
require("scripts/unit_extensions/objectives/zone_capture_point_server")
require("scripts/unit_extensions/objectives/zone_capture_point_offline")
require("scripts/unit_extensions/objectives/flag_capture_point_client")
require("scripts/unit_extensions/objectives/flag_capture_point_server")
require("scripts/unit_extensions/objectives/flag_capture_point_offline")
require("scripts/unit_extensions/objectives/grail_spawn_point_client")
require("scripts/unit_extensions/objectives/grail_spawn_point_server")
require("scripts/unit_extensions/objectives/grail_spawn_point_offline")
require("scripts/unit_extensions/objectives/objective_unit_interactable")
require("scripts/unit_extensions/objectives/archery_target_objective")
require("scripts/unit_extensions/objectives/payload_server")
require("scripts/unit_extensions/objectives/payload_client")
require("scripts/unit_extensions/objectives/assault_ladder")
require("scripts/unit_extensions/objectives/assault_gate")
require("scripts/unit_extensions/flag/flag_client")
require("scripts/unit_extensions/flag/flag_server")
require("scripts/unit_extensions/flag/flag_offline")
require("scripts/unit_extensions/grail/grail_pickup_client")
require("scripts/unit_extensions/grail/grail_pickup_server")
require("scripts/unit_extensions/grail/grail_pickup_offline")
require("scripts/unit_extensions/grail/grail_plant_interactable")
require("scripts/unit_extensions/projectiles/projectile")
require("scripts/unit_extensions/generic/generic_unit_interactable")
require("scripts/unit_extensions/human/ai_player_unit/ai_base")
require("scripts/unit_extensions/cutscene_camera/cutscene_camera")
require("scripts/unit_extensions/human/base/human_area_buff_client")
require("scripts/unit_extensions/human/base/human_area_buff_server")
require("scripts/unit_extensions/human/base/human_area_buff_offline")
require("scripts/unit_extensions/generic/perlin_light")

EntitySystem = class(EntitySystem)

function EntitySystem:init(creation_context)
	self.entity_manager = creation_context.entity_manager
	self.world = creation_context.world
	self.startup_data = creation_context.startup_data
	self.timer_enabled = false
	self.level_timer = 0
	self.t = 0

	self:_init_systems()
end

function EntitySystem:_init_systems()
	self.systems = {}
	self.systems_by_name = {}
	self.active_systems = {}
	self.post_update_systems = {}

	local system_context = {}

	system_context.entity_manager = self.entity_manager
	system_context.world = self.world
	system_context.startup_data = self.startup_data

	self:_add_system("interaction_system", ExtensionSystemBase, system_context, true)
	self:_add_system("locomotion_system", LocomotionSystem, system_context, true, true)
	self:_add_system("damage_system", DamageSystem, system_context, true)
	self:_add_system("objective_system", ExtensionSystemBase, system_context, true)
	self:_add_system("projectile_system", ExtensionSystemBase, system_context, true)
	self:_add_system("flag_system", ExtensionSystemBase, system_context, true)
	self:_add_system("spawner_system", SpawnerSystem, system_context, true)
	self:_add_system("deserting_system", DesertingSystem, system_context, true)
	self:_add_system("ai_system", ExtensionSystemBase, system_context, true)
	self:_add_system("cutscene_system", CutsceneSystem, system_context, true)
	self:_add_system("area_buff_system", ExtensionSystemBase, system_context, true)
	self:_add_system("props_system", ExtensionSystemBase, system_context, true)
end

function EntitySystem:_add_system(name, class, context, active, post_update)
	local system = class:new(context, name)

	self.systems[#self.systems + 1] = system

	if post_update then
		self.post_update_systems[#self.post_update_systems + 1] = system
	end

	self.systems_by_name[name] = system
	self.active_systems[name] = active
end

function EntitySystem:finalize_setup()
	self.entity_manager:finalize_setup()
end

function EntitySystem:update(dt, spec_system_table)
	self.delta_time = dt
	self.t = self.t + dt

	if self.timer_enabled then
		self.level_timer = self.level_timer + dt
	end

	self:system_update("update", self.systems, spec_system_table)
end

function EntitySystem:post_update(dt)
	self:system_update("post_update", self.post_update_systems)
end

function EntitySystem:system_update(update_func, system_table, spec_system_table)
	local system_context = {}

	system_context.world = self.world
	system_context.dt = self.delta_time
	system_context.level_time = self.level_timer
	system_context.entity_manager = self.entity_manager
	system_context.blackboard = self.bb

	local spec_table = spec_system_table or self.active_systems

	for _, system in ipairs(system_table) do
		if self.active_systems[system.NAME] and spec_table[system.NAME] then
			system[update_func](system, system_context, self.t)
		end
	end
end

function EntitySystem:hot_join_synch(sender, player)
	for _, system in ipairs(self.systems) do
		system:hot_join_synch(sender, player)
	end
end

function EntitySystem:destroy()
	for _, system in ipairs(self.systems) do
		system:destroy()
	end

	for _, system in ipairs(self.post_update_systems) do
		system:destroy()
	end
end

function EntitySystem:timer(enabled)
	self.timer_enabled = enabled
	self.bb.timer_enabled = enabled
end

function EntitySystem:get_entities(system_name)
	return self.systems_by_name[system_name]:get_entities()
end
