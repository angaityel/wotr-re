-- chunkname: @scripts/settings/team_settings.lua

TeamSettings = TeamSettings or {}
TeamSettings.red = {
	max_squad_members = 8,
	ui_name_plural = "lancastrians",
	ui_name_definite_plural = "the_lancastrians",
	ui_name = "lancaster",
	number_of_squads = 8,
	color = Vector3Box(0.43529411764705883, 0.0784313725490196, 0.1450980392156863),
	secondary_color = Vector3Box(0, 0, 0)
}
TeamSettings.white = {
	max_squad_members = 8,
	ui_name_plural = "yorkists",
	ui_name_definite_plural = "the_yorkists",
	ui_name = "york",
	number_of_squads = 8,
	color = Vector3Box(0.6745098039215687, 0.6745098039215687, 0.803921568627451),
	secondary_color = Vector3Box(0, 0, 0.4)
}
TeamSettings.unassigned = {
	max_squad_members = 0,
	number_of_squads = 0
}
