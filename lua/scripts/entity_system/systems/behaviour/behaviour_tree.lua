-- chunkname: @scripts/entity_system/systems/behaviour/behaviour_tree.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_sequence")
require("scripts/entity_system/systems/behaviour/nodes/bt_selector")
require("scripts/entity_system/systems/behaviour/nodes/bt_update_filter")
require("scripts/entity_system/systems/behaviour/nodes/bt_morale_state_update_filter")
require("scripts/entity_system/systems/behaviour/nodes/bt_pick_random_node_filter")
require("scripts/entity_system/systems/behaviour/nodes/bt_pick_random_morale_state_filter")
require("scripts/entity_system/systems/behaviour/nodes/bt_players_detected_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_alive_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_within_range_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_attacking_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_blocking_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_posing_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_aiming_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_knocked_down_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_unit_has_weapon_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_nil_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_follow_player_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_melee_attack_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_ranged_attack_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_switch_gear_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_block_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_crouch_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_start_couch_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_execute_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_revive_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_change_behaviour_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_print_text_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_avoid_players_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_pick_target_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_agent_tethered_condition")
require("scripts/entity_system/systems/behaviour/nodes/bt_move_agent_to_spawn_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_process_move_orders_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_ranged_aim_action")
require("scripts/entity_system/systems/behaviour/nodes/bt_melee_aim_action")

BehaviourTree = class(BehaviourTree)

function BehaviourTree:init(name, tree_definition)
	self._name = name
	self._root_node = self:_create_node(tree_definition[1])

	self:_parse_tree_definition(tree_definition[1], self._root_node)
end

function BehaviourTree:name()
	return self._name
end

function BehaviourTree:_parse_tree_definition(node_definition, parent_node)
	for _, child_definition in ipairs(node_definition) do
		local node = self:_create_node(child_definition, parent_node)

		self:_parse_tree_definition(child_definition, node)
	end
end

function BehaviourTree:_create_node(node_definition, parent_node)
	local name = node_definition.name
	local data = node_definition.data

	fassert(node_definition.class, "[Tree = %q] No class specified for node %q", self._name, name)

	local class_name = node_definition.class
	local node_type = rawget(_G, class_name)

	fassert(node_type, "[Tree = %q] No node type registered with name %q", self._name, class_name)

	local input = node_definition.input
	local output = node_definition.output
	local node = node_type:new(name or class_name, parent_node, data, input, output)

	if parent_node and parent_node.add_child then
		parent_node:add_child(node)
	end

	return node
end

function BehaviourTree:setup(unit, blackboard, profile)
	self._root_node:setup(unit, blackboard, profile)
end

function BehaviourTree:run(unit, blackboard, t, dt)
	self._root_node:run(unit, blackboard, t, dt)
end
