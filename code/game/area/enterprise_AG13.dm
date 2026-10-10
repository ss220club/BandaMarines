//enterprise_AG13
/area/enterprise_AG13
//	name = "Enterprise AG13"
	icon_state = "tutorial"
	can_build_special = TRUE
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY

//parent types

/area/enterprise_AG13/indoors
	name = "Bunker AG13 - Indoors"
	icon_state = "unknown"
	ceiling = CEILING_METAL
	ceiling_muffle = FALSE
	soundscape_playlist = SCAPE_PL_LV522_INDOORS

/area/enterprise_AG13/outdoors
	name = "Bunker AG13 - Outdoors"
	icon_state = "unknown"
	ceiling = CEILING_NONE
	temperature = ICE_COLONY_TEMPERATURE

/area/enterprise_AG13/oob
	name = "Out Of Bounds"
	icon_state = "unknown"
	ceiling = CEILING_MAX
	ceiling_muffle = FALSE
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL|AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	requires_power = FALSE
	unlimited_power = TRUE

/area/enterprise_AG13/oob/surface_light
	base_lighting_alpha = 35

//Landing Zones

/area/enterprise_AG13/landing_zone_1
	name = "Surface Exterior - East - Landing Zone One"
	icon_state = "shuttlered2"
	is_landing_zone = TRUE
	minimap_color = MINIMAP_ICE
	linked_lz = DROPSHIP_LZ1
	base_lighting_alpha = 15

//Exterior Areas

// --

/area/enterprise_AG13/outdoors/surface_exterior
	name = "Surface Exterior"
	icon_state = "green"
	minimap_color = MINIMAP_SNOW

/area/enterprise_AG13/outdoors/surface_exterior/center
	icon_state = "central"
	name = "Surface Exterior - South Bunker Exterior"

	linked_lz = DROPSHIP_LZ1
/area/enterprise_AG13/outdoors/surface_exterior/south
	icon_state = "central"
	name = "Surface Exterior - South"
	linked_lz = DROPSHIP_LZ1

/area/enterprise_AG13/outdoors/surface_exterior/south_west
	icon_state = "southwest"
	name = "Surface Exterior - Southwest"
	linked_lz = DROPSHIP_LZ1

/area/enterprise_AG13/outdoors/surface_exterior/south_east
	icon_state = "southeast"
	name = "Surface Exterior - Southeast"
	linked_lz = DROPSHIP_LZ2

/area/enterprise_AG13/outdoors/surface_exterior/east
	icon_state = "east"
	name = "Surface Exterior - East"
	linked_lz = DROPSHIP_LZ1

/area/enterprise_AG13/outdoors/surface_exterior/north_east
	icon_state = "northeast"
	name = "Surface Exterior - Northeast"
	linked_lz = DROPSHIP_LZ1

// --

/area/enterprise_AG13/outdoors/eastern_cavern
	name = "Eastern Cavern - Bunker Eastern Exterior"
	icon_state = "central"
	minimap_color = MINIMAP_SNOW

/area/enterprise_AG13/outdoors/eastern_cavern/mid_light
	name = "Eastern Cavern - Bunker Eastern Exterior"
	icon_state = "central"
	minimap_color = MINIMAP_SNOW

/area/enterprise_AG13/outdoors/eastern_cavern/low_light
	name = "Eastern Cavern - Bunker Eastern Exterior"
	icon_state = "central"
	minimap_color = MINIMAP_SNOW

/area/enterprise_AG13/outdoors/eastern_cavern/no_light
	name = "Eastern Cavern - Bunker Eastern Exterior"
	icon_state = "central"
	minimap_color = MINIMAP_SNOW

// --

/area/enterprise_AG13/outdoors/cavern_external_access
	name = "Bunker Cavern - Roof"
	icon_state = "central"
	minimap_color = MINIMAP_SNOW
	base_lighting_alpha = 35

/area/enterprise_AG13/outdoors/cavern_external_access/central
	name = "Bunker Cavern - Exposed Roof - Central"

/area/enterprise_AG13/outdoors/cavern_external_access/central/adj
	base_lighting_alpha = 20

/area/enterprise_AG13/outdoors/cavern_external_access/north
	name = "Bunker Cavern - Exposed Roof - North"

/area/enterprise_AG13/outdoors/cavern_external_access/north/adj
	base_lighting_alpha = 20

/area/enterprise_AG13/outdoors/cavern_external_access/west
	name = "Bunker Cavern - Exposed Roof - West"

/area/enterprise_AG13/outdoors/cavern_external_access/west/adj
	base_lighting_alpha = 20

/area/enterprise_AG13/outdoors/cavern_external_access/south_west
	name = "Bunker Cavern - Exposed Roof - South-West"

/area/enterprise_AG13/outdoors/cavern_external_access/south_west/adj
	base_lighting_alpha = 20

//Interior Areas

// --

/area/enterprise_AG13/indoors/comms
	name = "Communications Areas"
	minimap_color = MINIMAP_AREA_COLONY_ENGINEERING
	icon_state = "engine"

/area/enterprise_AG13/indoors/comms/tcomms_1
	name = "Bunker AG13 - Primary Communications"

/area/enterprise_AG13/indoors/comms/tcomms_2_a
	name = "Bunker AG13 - Secondary Communications"

/area/enterprise_AG13/indoors/comms/tcomms_2_b
	name = "Bunker AG13 - Tertiary Communications"

// --

/area/enterprise_AG13/indoors/entry_zone
	name = "Bunker AG13 - Entrance/Logistics Zone"
	minimap_color = MINIMAP_AREA_MINING
	icon_state = "maint_cargo"

/area/enterprise_AG13/indoors/entry_zone/train
	name = "Bunker AG13 - Rail System"
	minimap_color = MINIMAP_AREA_COLONY_SPACE_PORT
	icon_state = "HH_Basement"

/area/enterprise_AG13/indoors/entry_zone/power
	name = "Bunker AG13 - Emergency Bunker Generator"
	minimap_color = MINIMAP_AREA_COLONY_ENGINEERING
	icon_state = "HH_Basement"

// --

/area/enterprise_AG13/indoors/sustainment_zone
	name = "Bunker AG13 - Medical Zone"
	minimap_color = MINIMAP_AREA_MEDBAY
	icon_state = "medbay"

// --

/area/enterprise_AG13/indoors/residential_zone
	name = "Bunker AG13 - Residential Zone"
	minimap_color = MINIMAP_AREA_RESEARCH
	icon_state = "purple"

// --

/area/enterprise_AG13/indoors/hanger_zone
	name = "Bunker AG13 - Hanger Zone"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	icon_state = "dk_yellow"

// --

/area/enterprise_AG13/indoors/synthetic_zone
	name = "Bunker AG13 - Synthetic Operations Zone"
	minimap_color = MINIMAP_AREA_SEC
	icon_state = "ai_cyborg"

// --

/area/enterprise_AG13/indoors/command_zone
	name = "Bunker AG13 - Bunker Command Ops Zone"
	minimap_color = MINIMAP_AREA_COMMAND
	icon_state = "bridge"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

// --

/area/enterprise_AG13/indoors/cavern
	name = "Bunker Cavern"
	minimap_color = MINIMAP_AREA_CAVES
	icon_state = "cave"
	ceiling = CEILING_SANDSTONE_ALLOW_CAS
	temperature = ICE_COLONY_TEMPERATURE

/area/enterprise_AG13/indoors/cavern/south_entrance
	name = "Bunker Cavern - Tram/Bunker Cavern - South"
	base_lighting_alpha = 35

/area/enterprise_AG13/indoors/cavern/south_entrance/low_light
	base_lighting_alpha = 20

/area/enterprise_AG13/indoors/cavern/south_entrance/zero_light
	base_lighting_alpha = 0

/area/enterprise_AG13/indoors/cavern/north_entrance
	name = "Bunker Cavern - Tram/Bunker Cavern - North"
	base_lighting_alpha = 35

/area/enterprise_AG13/indoors/cavern/north_entrance/low_light
	base_lighting_alpha = 20

/area/enterprise_AG13/indoors/cavern/north_entrance/zero_light
	base_lighting_alpha = 0

/area/enterprise_AG13/indoors/cavern/central
	name = "Bunker Cavern - Interior Area - Central"

/area/enterprise_AG13/indoors/cavern/west
	name = "Bunker Cavern - Interior Area - West"

/area/enterprise_AG13/indoors/cavern/north
	name = "Bunker Cavern - Interior Area - North"

//Special Out Of Bound Areas

// --

/area/enterprise_AG13/oob/electrical_tunnel
	name = "Bunker AG13 - Electrical Sub-Network"
	icon_state = "engine"

// --

/area/enterprise_AG13/oob/manufactory
	name = "Bunker AG13 - Primary manufactory"

// --

/area/enterprise_AG13/oob/train
	name = "Bunker Extended Network - External Rail System"
	icon_state = "engine_monitoring"
