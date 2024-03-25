-- chunkname: @scripts/helpers/coat_of_arms_helper.lua

require("scripts/settings/coat_of_arms")

CoatOfArmsHelper = CoatOfArmsHelper or {}

function CoatOfArmsHelper:coat_of_arms_setting(category, name)
	for _, setting in ipairs(CoatOfArms[category]) do
		if name == setting.name then
			return setting
		end
	end
end

function CoatOfArmsHelper:set_material_properties(settings, unit, mesh_name, material_name, team_name)
	local mesh = Unit.mesh(unit, mesh_name)
	local material = Mesh.material(mesh, material_name)
	local color_index = "material_color"

	if settings.field_color == "team_primary" or settings.field_color == "team_secondary" then
		color_index = color_index .. "_team_" .. team_name
	end

	local field_color_table = self:coat_of_arms_setting("field_colors", settings.field_color)[color_index]
	local field_color = Vector3(field_color_table[1] / 255, field_color_table[2] / 255, field_color_table[3] / 255)

	Material.set_vector3(material, "rgb_field", field_color)

	local color_index = "material_color"

	if settings.variation_1_color == "team_primary" or settings.variation_1_color == "team_secondary" then
		color_index = color_index .. "_team_" .. team_name
	end

	local variation_1_color_table = self:coat_of_arms_setting("material_variation_colors", settings.variation_1_color)[color_index]
	local variation_1_color = Vector3(variation_1_color_table[1] / 255, variation_1_color_table[2] / 255, variation_1_color_table[3] / 255)

	Material.set_vector3(material, "tint_rgb_field_variation_1", variation_1_color)

	local variation_1_atlas_settings = self:coat_of_arms_setting("material_variation_types", settings.variation_1_type).texture_atlas_settings
	local variation_1_scale = Vector2(variation_1_atlas_settings.uv11[1] - variation_1_atlas_settings.uv00[1], variation_1_atlas_settings.uv11[2] - variation_1_atlas_settings.uv00[2])

	Material.set_vector2(material, "uv_scale_variation_1", variation_1_scale)
	Material.set_vector2(material, "uv_offset_variation_1", Vector2(variation_1_atlas_settings.uv00[1], variation_1_atlas_settings.uv00[2]))

	local color_index = "material_color"

	if settings.variation_2_color == "team_primary" or settings.variation_2_color == "team_secondary" then
		color_index = color_index .. "_team_" .. team_name
	end

	local variation_2_color_table = self:coat_of_arms_setting("material_variation_colors", settings.variation_2_color)[color_index]
	local variation_2_color = Vector3(variation_2_color_table[1] / 255, variation_2_color_table[2] / 255, variation_2_color_table[3] / 255)

	Material.set_vector3(material, "tint_rgb_field_variation_2", variation_2_color)

	local variation_2_atlas_settings = self:coat_of_arms_setting("material_variation_types", settings.variation_2_type).texture_atlas_settings
	local variation_2_scale = Vector2(variation_2_atlas_settings.uv11[1] - variation_2_atlas_settings.uv00[1], variation_2_atlas_settings.uv11[2] - variation_2_atlas_settings.uv00[2])

	Material.set_vector2(material, "uv_scale_variation_2", variation_2_scale)
	Material.set_vector2(material, "uv_offset_variation_2", Vector2(variation_2_atlas_settings.uv00[1], variation_2_atlas_settings.uv00[2]))

	local color_index = "material_color"

	if settings.division_color == "team_primary" or settings.division_color == "team_secondary" then
		color_index = color_index .. "_team_" .. team_name
	end

	local division_color_table = self:coat_of_arms_setting("division_colors", settings.division_color)[color_index]
	local division_color = Vector3(division_color_table[1] / 255, division_color_table[2] / 255, division_color_table[3] / 255)

	Material.set_vector3(material, "tint_rgb_division", division_color)

	local division_atlas_settings = self:coat_of_arms_setting("division_types", settings.division_type).texture_atlas_settings
	local division_scale = Vector2(division_atlas_settings.uv11[1] - division_atlas_settings.uv00[1], division_atlas_settings.uv11[2] - division_atlas_settings.uv00[2])

	Material.set_vector2(material, "uv_scale_division", division_scale)
	Material.set_vector2(material, "uv_offset_division", Vector2(division_atlas_settings.uv00[1], division_atlas_settings.uv00[2]))

	local color_index = "material_color"

	if settings.ordinary_color == "team_primary" or settings.ordinary_color == "team_secondary" then
		color_index = color_index .. "_team_" .. team_name
	end

	local ordinary_color_table = self:coat_of_arms_setting("ordinary_colors", settings.ordinary_color)[color_index]
	local ordinary_color = Vector3(ordinary_color_table[1] / 255, ordinary_color_table[2] / 255, ordinary_color_table[3] / 255)

	Material.set_vector3(material, "tint_rgb_ordinary", ordinary_color)

	local ordinary_atlas_settings = self:coat_of_arms_setting("ordinary_types", settings.ordinary_type).texture_atlas_settings
	local ordinary_scale = Vector2(ordinary_atlas_settings.uv11[1] - ordinary_atlas_settings.uv00[1], ordinary_atlas_settings.uv11[2] - ordinary_atlas_settings.uv00[2])

	Material.set_vector2(material, "uv_scale_ordinary", ordinary_scale)
	Material.set_vector2(material, "uv_offset_ordinary", Vector2(ordinary_atlas_settings.uv00[1], ordinary_atlas_settings.uv00[2]))

	local color_index = "material_color"
	local complement_color_index = "material_complement_color"

	if settings.charge_color == "team_primary" or settings.charge_color == "team_secondary" then
		local team_substr = "_team_" .. team_name

		color_index = color_index .. team_substr
		complement_color_index = complement_color_index .. team_substr
	end

	local charge_color_settings = self:coat_of_arms_setting("charge_colors", settings.charge_color)
	local charge_color_table = charge_color_settings[color_index]
	local charge_color_complement_table = charge_color_settings[complement_color_index]
	local charge_color = Vector3(charge_color_table[1] / 255, charge_color_table[2] / 255, charge_color_table[3] / 255)
	local charge_color_complement = Vector3(charge_color_complement_table[1] / 255, charge_color_complement_table[2] / 255, charge_color_complement_table[3] / 255)

	Material.set_vector3(material, "tint_rgb_charge_complement", charge_color_complement)
	Material.set_vector3(material, "tint_rgb_charge", charge_color)

	local charge_atlas_settings = self:coat_of_arms_setting("charge_types", settings.charge_type).texture_atlas_settings
	local charge_scale = Vector2(charge_atlas_settings.uv11[1] - charge_atlas_settings.uv00[1], charge_atlas_settings.uv11[2] - charge_atlas_settings.uv00[2])

	Material.set_vector2(material, "uv_scale_charge", charge_scale)
	Material.set_vector2(material, "uv_offset_charge", Vector2(charge_atlas_settings.uv00[1], charge_atlas_settings.uv00[2]))
end
