-- chunkname: @scripts/unit_extensions/grail/grail_pickup_client.lua

GrailPickupClient = class(GrailPickupClient)
GrailPickupClient.CLIENT_ONLY = true
GrailPickupClient.SYSTEM = "flag_system"

function GrailPickupClient:init(world, unit)
	self._world = world
	self._unit = unit
	self._id = nil
	self._carried = false
	self._carrier_unit = nil
	self._team_name = nil
	self._flag_spawned_event_triggered = false
end

function GrailPickupClient:set_game_object_id(obj_id, game)
	self._id = obj_id

	local team_name = NetworkLookup.team[GameSession.game_object_field(game, obj_id, "team_name")]

	self._team_name = team_name

	Unit.set_data(self._unit, "team_name", team_name)

	if team_name == "neutral" then
		self._blackboard = {
			color = {
				255,
				255,
				255,
				0
			}
		}
	else
		local color = Managers.state.team:team_color_by_name(team_name)

		self._blackboard = {
			color = {
				255,
				color.x * 255,
				color.y * 255,
				color.z * 255
			}
		}
	end

	Managers.state.event:trigger("event_flag_spawned", self._blackboard, self._unit)

	self._flag_spawned_event_triggered = true
end

function GrailPickupClient:update(unit, input, dt, context)
	local game = Managers.state.network:game()
	local id = self._id

	if not self._carried and game and id then
		local unit = self._unit

		Unit.set_local_position(unit, 0, GameSession.game_object_field(game, id, "position", Unit.local_position(self._unit, 0)))
		Unit.set_local_rotation(unit, 0, GameSession.game_object_field(game, id, "rotation", Unit.local_rotation(self._unit, 0)))
	end

	if game and id then
		local team_name = NetworkLookup.team[GameSession.game_object_field(game, id, "team_name")]

		if team_name ~= self._team_name then
			if team_name == "neutral" then
				self._blackboard.color = {
					255,
					255,
					255,
					0
				}
			else
				local color = Managers.state.team:team_color_by_name(team_name)

				self._blackboard.color = {
					255,
					color.x * 255,
					color.y * 255,
					color.z * 255
				}
			end

			self._team_name = team_name

			Unit.set_data(self._unit, "team_name", team_name)
		end
	end

	if false then
		-- block empty
	end
end

function GrailPickupClient:can_be_picked_up(picker_unit)
	return not self._carried
end

function GrailPickupClient:pickup(carrier_unit)
	self._carried = true
	self._carrier_unit = carrier_unit

	World.link_unit(self._world, self._unit, carrier_unit, Unit.node(carrier_unit, "a_left_hand"))
end

function GrailPickupClient:can_be_dropped(dropper_unit)
	return self._carried and self._carrier_unit == dropper_unit
end

function GrailPickupClient:drop()
	self._carried = false
	self._carrier_unit = nil

	World.unlink_unit(self._world, self._unit)

	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		local unit = self._unit

		Unit.set_local_position(unit, 0, GameSession.game_object_field(game, id, "position", Unit.local_position(self._unit, 0)))
		Unit.set_local_rotation(unit, 0, GameSession.game_object_field(game, id, "rotation", Unit.local_rotation(self._unit, 0)))
	end
end

function GrailPickupClient:destroy()
	if self._flag_spawned_event_triggered then
		Managers.state.event:trigger("event_flag_destroyed", self._unit)
	end
end
