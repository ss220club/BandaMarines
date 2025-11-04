//lv759 AREAS--------------------------------------//

/area/Suburb_lv759
	name = "Suburb_lv759_hybrisa_prospera LV-759 Hybrisa Prospera"
	icon = 'icons/turf/hybrisareas.dmi'
	icon_state = "hybrisa"
	can_build_special = TRUE
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

// ... и так далее для всех дочерних зон
//parent types

/area/Suburb_lv759/indoors
	name = "Hybrisa - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR

/area/Suburb_lv759/outdoors
	name = "Hybrisa - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV759_OUTDOORS
	ambience_exterior = AMBIENCE_CITY
	soundscape_interval = 25


/area/Suburb_lv759/bunker
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL
	minimap_color = MINIMAP_AREA_OOB


/area/Suburb_lv759/bunker/checkpoint
	name = "Checkpoint & Hidden Bunker - Entrance"
	icon_state = "cliff_blocked"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL
	minimap_color = MINIMAP_AREA_OOB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR

// Landing Zone 1

/area/Suburb_lv759/outdoors/landing_zone_1
	name = "The landing platform near the reactor complex"
	icon_state = "medical_lz1"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ1


// Landing Zone 2

/area/Suburb_lv759/outdoors/landing_zone_2
	name = "The landing platform at the top of the mountain"
	icon_state = "mining_lz2"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ2


// Caves


/area/Suburb_lv759/indoors/caves/wy_research_complex_entrance
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - North Main Entrance"
	icon_state = "wylab"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES_ALARM
	soundscape_playlist = SCAPE_PL_LV759_DEEPCAVES
	ceiling_muffle = FALSE
	minimap_color = MINIMAP_AREA_HYBRISACAVES
	unoviable_timer = FALSE



/area/Suburb_lv759/indoors/caves/passage_to_bunker
	name = "Passage to the bunker"
	icon_state = "power0"

/area/Suburb_lv759/indoors/caves/Monorail
	name = "Monorail"
	icon_state = "power0"


// Colony Streets

/area/Suburb_lv759/outdoors/colony_streets
	name = "Colony Streets"
	icon_state = "colonystreets_north"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY_STREETS

/area/Suburb_lv759/outdoors/colony_streets/Main_road
	name = "Main road"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/Parking_space
	name = "Parking space"
	icon_state = "colonystreets_east"
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/outdoors/colony_streets/CLF_Camp
	name = "CLF camp"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/pizza
	name = "pizza"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage
	name = "cottage"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage2
	name = "cottage2"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage3
	name = "cottage3"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage4
	name = "cottage4"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage5
	name = "cottage5"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage6
	name = "cottage6"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage7
	name = "cottage7"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage8
	name = "cottage8"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage9
	name = "cottage9"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage10
	name = "cottage10"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/cottage11
	name = "cottage11"
	icon_state = "colonystreets_west"

/area/Suburb_lv759/outdoors/colony_streets/garage
	name = "garage"
	icon_state = "colonystreets_west"
// WY Security Checkpoints

/area/Suburb_lv759/indoors/wy_security
	minimap_color = MINIMAP_AREA_COLONY_MARSHALLS

/area/Suburb_lv759/indoors/wy_security/checkpoint_northeast
	name = "Weyland-Yutani Security Checkpoint - North East"
	icon_state = "security_checkpoint_northeast"
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/wy_security/checkpoint_east
	name = "Weyland-Yutani Security Checkpoint - East"
	icon_state = "security_checkpoint_east"
	linked_lz = list(DROPSHIP_LZ1, DROPSHIP_LZ2)

/area/Suburb_lv759/indoors/wy_security/checkpoint_central
	name = "Weyland-Yutani Security Checkpoint - Central"
	icon_state = "security_checkpoint_central"

/area/Suburb_lv759/indoors/wy_security/checkpoint_west
	name = "Weyland-Yutani Security Checkpoint - West"
	icon_state = "security_checkpoint_west"

/area/Suburb_lv759/indoors/wy_security/checkpoint_northwest
	name = "Weyland-Yutani Security Checkpoint - North West"
	icon_state = "security_checkpoint_northwest"

// Misc

/area/Suburb_lv759/indoors/hobosecret
	name = "Hidden Hobo Haven"
	icon_state = "hobo"
	ceiling = CEILING_REINFORCED_METAL
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL
	linked_lz = DROPSHIP_LZ2

/area/Suburb_lv759/indoors/spaceport/ifas_ship
	name = "UD4-UK 'For The The Empress'  "
	icon_state = "wydropship"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

// Weyland-Yutani Advanced Bio-Genomic Research Complex

/area/Suburb_lv759/indoors/wy_research_complex
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex"
	icon_state = "wylab"
	minimap_color = MINIMAP_AREA_HYBRISARESEARCH
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	unoviable_timer = FALSE
	ceiling_muffle = FALSE

/area/Suburb_lv759/indoors/wy_research_complex/medical_annex
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Medical Annex Building"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/reception
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Reception & Administration"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/cargo
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Requisitions & Cargo"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/researchanddevelopment
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Technology Research & Development Lab"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/mainlabs
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Advanced Chemical Testing & Research Lab"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/xenobiology
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Advanced Xenobiology Lab"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_2
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/weaponresearchlab
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Advanced Weapon Research Lab"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/weaponresearchlabtesting
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Advanced Weapon Research Lab - Weapons Testing Range"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/xenoarcheology
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Xenoarcheology Research Lab"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/vehicledeploymentbay
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Vehicle Deployment & Maintenance Bay"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/janitor
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Janitorial Supplies Storage"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/cafeteria
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Cafeteria"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/cafeteriakitchen
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Cafeteria - Kitchen"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/dormsfoyer
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Dorms Foyer"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/dormsbedroom
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Dorms"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/securitycommand
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Security Command Center & Deployment"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/securityarmory
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Armory"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hangarbay
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Hangar Bay"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hangarbayshuttle
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Hangar Bay - Weyland-Yutani PMC ERT Shuttle"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	minimap_color = MINIMAP_AREA_COLONY
	requires_power = FALSE

/area/Suburb_lv759/indoors/wy_research_complex/hallwaynorth
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - North Hallway"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hallwaynorthexit
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - North Hallway - Personnel Exit East"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hallwayeast
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Hallway East"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hallwaycentral
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Central Hallway"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hallwaysouthwest
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - South West Hallway"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/hallwaysoutheast
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - South East Hallway"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/southeastexit
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - South East Maintenace & Emergency Exit"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/changingroom
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Locker Room"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/Suburb_lv759/indoors/wy_research_complex/head_research_office
	name = "Weyland-Yutani - Advanced Bio-Genomic Research Complex - Head of Research's Office"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

// public spaceport

/area/Suburb_lv759/indoors/public_spaceport
	name = "Public space port"
	unoviable_timer = FALSE
	ceiling_muffle = FALSE
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/public_spaceport/hangarbay
	name = "Public space port - Hangar Bay"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/public_spaceport/cafeteria
	name = "public spaceport - Cafeteria"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/public_spaceport/vehicledeploymentbay
	name = "public spaceport - Vehicle Deployment & Maintenance Bay"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/public_spaceport/w_y_hangarbay
	name = "Weyland-Yutani -public spaceport - Hangar Bay"
	icon_state = "wylab"
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ1

/area/Suburb_lv759/indoors/public_spaceport/transformer_substation
	name = "public spaceport - transformer substation - "
	icon_state = "recycling"
	linked_lz = DROPSHIP_LZ1
