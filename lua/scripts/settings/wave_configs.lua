-- chunkname: @scripts/settings/wave_configs.lua

WaveConfigs = WaveConfigs or {}
WaveConfigs.coop_castle = {
	{
		{
			amount = 10,
			duration = 10,
			ai_profile = "light_man_01",
			type = "spawn"
		},
		{
			duration = 2,
			type = "delay"
		},
		{
			amount = 10,
			duration = 5,
			ai_profile = "light_man_02",
			type = "spawn"
		},
		{
			duration = 5,
			type = "delay"
		},
		{
			amount = 5,
			duration = 5,
			ai_profile = "light_man_01",
			type = "spawn"
		},
		{
			amount = 10,
			duration = 5,
			ai_profile = "light_man_01",
			type = "spawn"
		},
		{
			duration = 5,
			type = "delay"
		},
		{
			amount = 5,
			duration = 5,
			ai_profile = "heavy_man_01",
			type = "spawn"
		},
		auto_next_wave = 60
	},
	{
		{
			amount = 60,
			duration = 30,
			ai_profile = "peasant",
			type = "spawn"
		},
		auto_next_wave = 50
	},
	{
		{
			amount = 10,
			duration = 10,
			ai_profile = "medium_man_01",
			type = "spawn"
		},
		{
			duration = 2,
			type = "delay"
		},
		{
			amount = 10,
			duration = 5,
			ai_profile = "medium_man_02",
			type = "spawn"
		},
		{
			duration = 5,
			type = "delay"
		},
		{
			amount = 5,
			duration = 5,
			ai_profile = "medium_man_01",
			type = "spawn"
		},
		{
			amount = 10,
			duration = 5,
			ai_profile = "medium_man_01",
			type = "spawn"
		},
		{
			duration = 5,
			type = "delay"
		},
		{
			amount = 5,
			duration = 5,
			ai_profile = "heavy_man_01",
			type = "spawn"
		},
		auto_next_wave = 60
	}
}
