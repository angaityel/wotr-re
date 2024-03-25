-- chunkname: @scripts/unit_extensions/default_player_unit/player_husk_damage.lua

require("scripts/settings/player_unit_damage_settings")

PlayerHuskDamage = class(PlayerHuskDamage, PlayerUnitDamage)
PlayerHuskDamage.SYSTEM = "damage_system"

function PlayerHuskDamage:init(world, unit, id, game)
	self._world = world
	self._unit = unit
	self._damage = 0
	self._dead = false
	self._wounded = false
	self._health = PlayerUnitDamageSettings.MAX_HP
	self._dead_threshold = PlayerUnitDamageSettings.MAX_HP + PlayerUnitDamageSettings.KD_MAX_HP
	self._regenerating = false
	self._game_object_id = nil
	self._revived_by = nil
	self._revive_time = 0
	self._damagers = {}
	self._effect_ids = {}
	self._damage_over_time_sources = table.clone(PlayerUnitDamageSettings.dot_types)

	if Managers.lobby.server then
		self:_create_game_object()

		self._is_client = false
	end

	self._is_husk = true

	local player_index = GameSession.game_object_field(game, id, "player")
	local player_manager = Managers.player
	local player = player_manager:player(player_index)

	self._player = player
	self._last_damager_timer = 0
	self._last_damager = nil
	self._drawer = Managers.state.debug:drawer()

	self:_setup_hit_zones(PlayerUnitDamageSettings.hit_zones)
end
