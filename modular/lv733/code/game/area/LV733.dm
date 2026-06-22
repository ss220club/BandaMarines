//lv733 AREAS--------------------------------------//

/area/lv733
	name = "LV-733 Whitchler Point"
	icon = 'icons/turf/area_hybrisa.dmi'
	icon_state = "hybrisa"
	can_build_special = TRUE
	soundscape_playlist = SCAPE_PL_DESERT_STORM
	soundscape_interval = 45
	ambience_exterior = AMBIENCE_BIGRED
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

//parent types

/area/lv733/indoors
	name = "Whitchler Point - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR
	soundscape_interval = 35

/area/lv733/outdoors
	name = "Whitchler Point - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_DESERT_STORM
	ambience_exterior = AMBIENCE_BIGRED
	soundscape_interval = 25

/area/lv733/oob
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	requires_power = FALSE

/area/lv733/bunker
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB

// Landing Zone 1

/area/lv733/outdoors/landing_zone_1
	name = "Whitchler Point ROAF - Primary Landing Zone - Landing Zone One"
	icon_state = "medical_lz1"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ1
	soundscape_playlist = SCAPE_PL_HANGAR
	ambience_exterior = AMBIENCE_ALMAYER
	soundscape_interval = 50

/area/lv733/indoors/landing_zone_1/main_checkpoint
	name = "Whitchler Point ROAF - Primary Landing Zone - Landing Zone One - Checkpoint"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/technical_corridor
	name = "Whitchler Point ROAF - Primary Landing Zone - Landing Zone One - Technical Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/main_hangar_bay
	name = "Whitchler Point ROAF - Hangars - Landing Zone One - Main Hangar Bay"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1
	soundscape_playlist = SCAPE_PL_HANGAR
	ambience_exterior = AMBIENCE_ALMAYER
	soundscape_interval = 50

/area/lv733/indoors/landing_zone_1/loader_hangar_room
	name = "Whitchler Point ROAF - Hangars - Landing Zone One - Loader Operations Room"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/roaf_flight_control_room
	name = "Whitchler Point ROAF - ROAF Office - Landing Zone One - Flight Briefings Room"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/roaf_pilots_dorm
	name = "Whitchler Point ROAF - ROAF Office - Landing Zone One - Pilots Lounge"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/roaf_corridor
	name = "Whitchler Point ROAF - ROAF Office - Landing Zone One - ROAF Office Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/roaf_technical_corridor
	name = "Whitchler Point ROAF - ROAF Office - Landing Zone One - ROAF Technical Access Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/roaf_comms_hub_1
	name = "Whitchler Point ROAF - ROAF Office - Landing Zone One - ROAF Communications Hub"
	icon_state = "comms_1"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_zone_1/lz1_console
	name = "Whitchler Point ROAF - Hangars - Landing Zone One - Dropship Alamo Console"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

// Landing Zone 2

/area/lv733/outdoors/landing_zone_2
	name = "Whitchler Civilian Spaceport - Landing Zone Two"
	icon_state = "mining_lz2"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ2
	soundscape_playlist = SCAPE_PL_HANGAR
	ambience_exterior = AMBIENCE_ALMAYER
	soundscape_interval = 50

/area/lv733/indoors/landing_zone_2/whitchler_civ_spaceport_checkpoint_room
	name = "Whitchler Civilian Spaceport - Checkpoint"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/landing_zone_2/whitchler_civ_spaceport_storage
	name = "Whitchler Civilian Spaceport - Storage Depot"
	icon_state = "security_checkpoint"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/landing_zone_2/whitchler_civ_spaceport_store
	name = "Whitchler Civilian Spaceport - Loading Zone"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/landing_zone_2/whitchler_civ_spaceport_ship
	name = "Whitchler Civilian Spaceport - Spaceship"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/landing_zone_2/whitchler_civ_spaceport/lz2_console
	name = "Whitchler Civilian Spaceport - Dropship Normandy Console"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

// Unloading common area”

/area/lv733/indoors/unloading_common
	name = "Unloading common area"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/unloading_common/tech
	name = "Unloading common area - Tech"
	icon_state = "comms_1"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

// Shop

/area/lv733/indoors/wy_shop
	name = "WY Shop"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2
	ambience_exterior = AMBIENCE_WEYMART
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/wy_shop/main_hall
	name = "WY Shop - Main Hall"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_shop/storage_room
	name = "WY Shop - Storage Room"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_shop/technical_room
	name = "WY Shop - Technical Room"
	linked_lz = DROPSHIP_LZ2

// Landing Cargo Area

/area/lv733/indoors/landing_cargo
	name = "ROAF Forward Cargo Area - Logistics Storage"
	icon_state = "mining"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_cargo/cryo_room
	name = "ROAF Forward Cargo Area - Crew Rest Zone"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/landing_cargo/tech_hub
	name = "ROAF Forward Cargo Area Tech Hub"
	icon_state = "comms_1"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ1

// Hosptial

/area/lv733/indoors/hospital
	icon_state = "medical"
	minimap_color = MINIMAP_AREA_MEDBAY
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/reception
	name = "Whitchler Hospital Complex - Reception"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/waiting_lounge
	name = "Whitchler Hospital Complex - Waiting Lounge"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/cmo_office
	name = "Whitchler Hospital Complex - Chief Medical Officer's Office"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/restroom
	name = "Whitchler Hospital Complex - Restroom"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/patient_ward
	name = "Whitchler Hospital Complex - Patient Ward"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/operation
	name = "Whitchler Hospital Complex - Operation Theatres & Observation"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/medical_storage
	name = "Whitchler Hospital Complex - Medical Storage"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/hospital/maintenance_south
	name = "Whitchler Hospital Complex - Unisex-Restroom"
	linked_lz = DROPSHIP_LZ1

// Residential District

// Bar

/area/lv733/indoors/bar
	name = "Bar"
	icon_state = "bar"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/bar/entertainment
	name = "Bar - Entertainment Subsection"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/bar/bathroom
	name = "Bar - Restrooms"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/bar/maintenance
	name = "Bar - Maintenance"
	linked_lz = DROPSHIP_LZ2

//WY Administration

/area/lv733/indoors/wy_administration
	name = "WY Administration"
	icon_state = "wylab"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_administration/office1
	name = "WY Administration - Office #1"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_administration/office2
	name = "WY Administration - Office #2"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_administration/corridor
	name = "WY Administration - Corridor"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_administration/meeting_room
	name = "WY Administration - Meeting room"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/wy_administration/directors_office
	name = "WY Administration - Directors office"
	linked_lz = DROPSHIP_LZ2

// Crashed spacecraft

/area/lv733/indoors/crashed_spacecraft
	name = "Crashed spacecraft"
	ceiling = CEILING_METAL


// Cafeteria

/area/lv733/indoors/cafeteriakitchen
	name = "Weyland-Yutani Residential - Cafeteria - Dining Zone"
	icon_state = "wylab"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/cafeteriakitchen/Kitchen
	name = "Weyland-Yutani Residential - Cafeteria - Kitchen"
	icon_state = "wylab"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	linked_lz = DROPSHIP_LZ2

// Multi-Purpose Complex

/area/lv733/indoors/multicomplex
	name = "Multi-complex"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv733/indoors/multicomplex/foyer
	name = "Multi-complex - Foyer"

/area/lv733/indoors/multicomplex/detective_office
	name = "Multi-complex - Detective Office"

/area/lv733/indoors/multicomplex/laundry_room
	name = "Multi-complex - Laundry Room"

/area/lv733/indoors/multicomplex/pizzeria
	name = "Multi-complex - Pizzeria"


// Motel

/area/lv733/indoors/motel
	name = "Motel Complex - Apartments"
	icon_state = "apartments"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/corridor
	name = "Motel Complex - Apartments - Corridor"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception
	name = "Motel Complex - Apartments - Reception"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/room1
	name = "Motel Complex - Apartments - room1"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/room2
	name = "Motel Complex - Apartments - room2"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/room3
	name = "Motel Complex - Apartments - room3"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/room4
	name = "Motel Complex - Apartments - room4"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/lounge_area
	name = "Motel Complex - Apartments - Lounge Area"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/motel/reception/restrooms_showers
	name = "Motel Complex - Apartments - Restrooms and Showers"
	linked_lz = DROPSHIP_LZ2

// ROAF Training School

/area/lv733/indoors/training_school
	name = "Training School"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv733/indoors/training_school/reception
	name = "Training School - Reception"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/training_school/classroom
	name = "Training School - Classroom"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/training_school/training_hall
	name = "Training School - Training Hall"

// ROAF Base Operations

/area/lv733/indoors/base_operations
	name = "ROAF Base Operations"
	icon_state = "security_hub"
	ceiling = CEILING_METAL

/area/lv733/indoors/base_operations/west_corridor
	name = "ROAF Base Operations - West Wing Corridor"

/area/lv733/indoors/base_operations/east_corridor
	name = "ROAF Base Operations - East Wing Corridor"

/area/lv733/indoors/base_operations/central_corridor
	name = "ROAF Base Operations - Central Corridor"

/area/lv733/indoors/base_operations/south_corridor
	name = "ROAF Base Operations - South Wing Corridor"

/area/lv733/indoors/base_operations/north_corridor
	name = "ROAF Base Operations - North Wing Corridor"

/area/lv733/indoors/base_operations/emergency_exit
	name = "ROAF Base Operations - Emergency Exit"

/area/lv733/indoors/base_operations/barracks_one
	name = "ROAF Base Operations - ROAF Dorm #1"

/area/lv733/indoors/base_operations/barracks_two
	name = "ROAF Base Operations - ROAF Dorm #2"

/area/lv733/indoors/base_operations/barracks_three
	name = "ROAF Base Operations - ROAF Dorm #3"

/area/lv733/indoors/base_operations/barracks_4
	name = "ROAF Base Operations - ROAF Dorm #4"

/area/lv733/indoors/base_operations/barracks_5
	name = "ROAF Base Operations - ROAF Dorm #5"

/area/lv733/indoors/base_operations/barracks_6
	name = "ROAF Base Operations - ROAF Dorm #6"

/area/lv733/indoors/base_operations/barracks_7
	name = "ROAF Base Operations - ROAF Dorm #3"

/area/lv733/indoors/base_operations/barracks_three
	name = "ROAF Base Operations - ROAF Dorm #7"

/area/lv733/indoors/base_operations/ai
	name = "ROAF Base Operations - AI Comm"


/area/lv733/indoors/base_operations/laundry_room
	name = "ROAF Base Operations - Laundry Room"

/area/lv733/indoors/base_operations/supply_room
	name = "ROAF Base Operations - Supply Room"

/area/lv733/indoors/base_operations/bathrooms
	name = "ROAF Base Operations - Bathrooms"

/area/lv733/indoors/base_operations/toilets
	name = "ROAF Base Operations - Toilets"

/area/lv733/indoors/base_operations/officers_quarters
	name = "ROAF Base Operations - ROAF Staff Dorm"

/area/lv733/indoors/base_operations/communications_office
	name = "ROAF Base Operations - Communications Office"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/base_operations/co_office
	name = "ROAF Base Operations - Chief of ROAF Staff Office"

/area/lv733/indoors/base_operations/mess_hall
	name = "ROAF Base Operations - Mess Hall"

/area/lv733/indoors/base_operations/kitchen
	name = "ROAF Base Operations - Kitchen"

/area/lv733/indoors/base_operations/freezer
	name = "ROAF Base Operations - Freezer"

/area/lv733/indoors/base_operations/south_w_checkpoint
	name = "ROAF Base Operations - South-West Checkpoint"

/area/lv733/indoors/base_operations/south_e_checkpoint
	name = "ROAF Base Operations - South-East Checkpoint"

/area/lv733/indoors/base_operations/training_yard
	name = "ROAF Base Operations - Training Yard"

/area/lv733/indoors/base_operations/storage_facility
	name = "ROAF Base Operations - Storage Facility"

/area/lv733/indoors/base_operations/unloading_zone
	name = "ROAF Base Operations - Unloading Zone"

/area/lv733/indoors/base_operations/armory
	name = "ROAF Base Operations - Armory#1"


/area/lv733/indoors/base_operations/armory
	name = "ROAF Base Operations - Armory#2"


/area/lv733/indoors/base_operations/armory
	name = "ROAF Base Operations - Armory#3"

// Engineering Sector

/area/lv733/indoors/main_eng
	name = "Engineering Hub"
	icon_state = "power0"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_SHIP_ALT
	soundscape_playlist = SCAPE_PL_ENG
	soundscape_interval = 25

/area/lv733/indoors/main_eng/reception
	name = "Engineering Hub - Reception"

/area/lv733/indoors/main_eng/generator_core
	name = "Engineering Hub - Generator Core"

/area/lv733/indoors/main_eng/storage
	name = "Engineering Hub - Storage"

/area/lv733/indoors/main_eng/relay
	name = "Engineering Hub - Communications Relay Buffer"
	icon_state = "comms_1"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/main_eng/technical_storage
	name = "Engineering Hub - Technical Storage"

/area/lv733/indoors/main_eng/rail_transit_dock
	name = "Engineering Hub - Rail Transit Dock"

// Weyland-Yutani – Main Complex

/area/lv733/indoors/main_complex
	name = "Weyland-Yutani – Main Complex"
	icon_state = "wyoffice"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/main_complex/civ_checkpoint
	name = "Weyland-Yutani – Main Complex – CIV Checkpoint"
	icon_state = "security_checkpoint_central"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/main_complex/checkpoint
	name = "Weyland-Yutani – Main Complex – Checkpoint"
	icon_state = "security_checkpoint_central"

/area/lv733/indoors/main_complex/north_corridor
	name = "Weyland-Yutani – North Corridor"

/area/lv733/indoors/main_complex/central_corridor
	name = "Weyland-Yutani – Central Corridor"

/area/lv733/indoors/main_complex/south_corridor
	name = "Weyland-Yutani – South Corridor"

/area/lv733/indoors/main_complex/reception
	name = "Weyland-Yutani – Reception"

/area/lv733/indoors/main_complex/office
	name = "Weyland-Yutani – Office"

// Administration

/area/lv733/indoors/administration
	name = "Administration"
	icon_state = "wyoffice"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_LAB_HALLWAY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/administration/main_hall
	name = "Administration – Main Hall"

/area/lv733/indoors/administration/offices
	name = "Administration – Offices"

/area/lv733/indoors/administration/communications_offices
	name = "Administration – Communications Offices"

/area/lv733/indoors/administration/communications_relay_buffer
	name = "Administration – Communications Relay Buffer"
	icon_state = "comms_1"

// Outpost

/area/lv733/indoors/outpost
	name = "Outpost"
	icon_state = "security_hub"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/outpost/city_military_police_post
	name = "Outpost – City Military Police Post"
	linked_lz = DROPSHIP_LZ1

/area/lv733/indoors/outpost/main_checkpoint
	name = "Outpost – Main Checkpoint"
	icon_state = "security_checkpoint_central"

/area/lv733/indoors/outpost/west_checkpoint_one
	name = "Outpost – West Checkpoint #1"
	icon_state = "security_checkpoint_west"

/area/lv733/indoors/outpost/west_checkpoint_two
	name = "Outpost – West Checkpoint #2"
	icon_state = "security_checkpoint_west"

/area/lv733/indoors/outpost/sensor_checkpoint
	name = "Outpost – Sensor Checkpoint"
	icon_state = "security_checkpoint_northwest"

// Weyland-Yutani – Residential Block

/area/lv733/indoors/residential_block
	name = "Weyland-Yutani – Residential"
	icon_state = "apartments"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_TYRARGO_CITY
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

/area/lv733/indoors/residential_block/north_corridor
	name = "Weyland-Yutani – Residential – North Corridor"

/area/lv733/indoors/residential_block/south_corridor
	name = "Weyland-Yutani – Residential – South Corridor"

/area/lv733/indoors/residential_block/living_quarters1
	name = "Weyland-Yutani – Residential – Living Quarters #1"

/area/lv733/indoors/residential_block/living_quarters2
	name = "Weyland-Yutani – Residential – Living Quarters #2"

/area/lv733/indoors/residential_block/living_quarters3
	name = "Weyland-Yutani – Residential – Living Quarters #3"

/area/lv733/indoors/residential_block/restroom
	name = "Weyland-Yutani – Residential – Restroom"

// Street

/area/lv733/outdoors/colony_streets
	name = "Colony Streets"
	icon_state = "colonystreets_north"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY_STREETS
	ambience_exterior = AMBIENCE_TYRARGO_CITY
	soundscape_playlist = SCAPE_PL_DESERT_STORM
	soundscape_interval = 35

/area/lv733/outdoors/colony_streets/roaf_technical_street
	name = "Street - ROAF Technical Street"
	icon_state = "colonystreets_southeast"
	linked_lz = DROPSHIP_LZ1


/area/lv733/outdoors/colony_streets/roaf_spaceport_south
	name = "Street - ROAF Spaceport South"
	icon_state = "colonystreets_southeast"
	linked_lz = DROPSHIP_LZ1


/area/lv733/outdoors/colony_streets/engineering_street
	name = "Street - Engineering Street"
	icon_state = "colonystreets_southeast"


/area/lv733/outdoors/colony_streets/medical_street
	name = "Street - Medical Street"
	icon_state = "colonystreets_southeast"


/area/lv733/outdoors/colony_streets/city_streets
	name = "Street - City Streets"
	icon_state = "colonystreets_southeast"
	linked_lz = DROPSHIP_LZ2


/area/lv733/outdoors/colony_streets/civil_spaceport_south
	name = "Street - Civil Spaceport South"
	icon_state = "colonystreets_southeast"
	linked_lz = DROPSHIP_LZ2


/area/lv733/outdoors/colony_streets/military_complex_streets
	name = "Street - Military Complex Streets"
	icon_state = "colonystreets_southeast"


/area/lv733/outdoors/colony_streets/wy_complex_streets
	name = "Street - WY Complex Streets"
	icon_state = "colonystreets_southeast"


/area/lv733/outdoors/colony_streets/avenue
	name = "Street - Avenue"
	icon_state = "colonystreets_southeast"


// Street

/area/lv733/indoors/colony_streets
	name = "Colony Streets Underground"
	icon_state = "colonystreets_under"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COLONY_STREETS
	ambience_exterior = AMBIENCE_TYRARGO_CITY
	soundscape_playlist = SCAPE_PL_DESERT_STORM
	soundscape_interval = 35
	linked_lz = DROPSHIP_LZ2

// Mining Complex

/area/lv733/indoors/mining_complex
	name = "Mining Complex"
	icon_state = "mining"
	ceiling = CEILING_METAL
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE
	soundscape_interval = 25

/area/lv733/indoors/mining_complex/main_operations
	name = "Mining Complex – Main Operations Zone"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/mining_complex/garage_forecourt
	name = "Mining Complex – Garage Forecourt"

/area/lv733/indoors/mining_complex/small_generator
	name = "Mining Complex – Small Generator Room"
	icon_state = "power0"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/mining_complex/corridors
	name = "Mining Complex – Corridors"

/area/lv733/indoors/mining_complex/locker_room
	name = "Mining Complex – Locker Room"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/mining_complex/rest_area
	name = "Mining Complex – Crew Rest Area"

/area/lv733/indoors/mining_complex/storage
	name = "Mining Complex – Storage Depot"

/area/lv733/indoors/mining_complex/office
	name = "Mining Complex – Supervisor Office"
	linked_lz = DROPSHIP_LZ2

/area/lv733/indoors/mining_complex/areight_access_corridor
	name = "Mining Complex – Freight Access Corridor"

/area/lv733/indoors/mining_complex/supply_administration
	name = "Mining Complex – Supply Administration"

/area/lv733/indoors/mining_complex/primary_corridor
	name = "Mining Complex – Primary Corridor"


// Residential Building

/area/lv733/indoors/residential_building
	name = "Residential Building"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv733/indoors/residential_building/corridor
	name = "Residential Building – Residential Corridor"

/area/lv733/indoors/residential_building/common_area
	name = "Residential Building – Common Area"

/area/lv733/indoors/residential_building/living_quarters
	name = "Residential Building – Living Quarters"


// Weyland-Yutani Research Complex

/area/lv733/indoors/wy_research_complex
	icon_state = "wylab"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	name = "Weyland-Yutani – Research Complex"
	ambience_exterior = AMBIENCE_LAB
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ceiling_muffle = FALSE
	unoviable_timer = FALSE

/area/lv733/indoors/wy_research_complex/west_entrance
	name = "Weyland-Yutani – Research Complex – West Entrance"

/area/lv733/indoors/wy_research_complex/main_vestibule
	name = "Weyland-Yutani – Research Complex – Main Vestibule"

/area/lv733/indoors/wy_research_complex/departure_reception
	name = "Weyland-Yutani – Research Complex – Departure Reception"

/area/lv733/indoors/wy_research_complex/technical_operations
	name = "Weyland-Yutani – Research Complex – Technical Operations"

/area/lv733/indoors/wy_research_complex/checkpoint
	name = "Weyland-Yutani – Research Complex – Checkpoint"
	icon_state = "security_checkpoint_central"

/area/lv733/indoors/wy_research_complex/offices
	name = "Weyland-Yutani – Research Complex – Office Wing"

/area/lv733/indoors/wy_research_complex/botany_department
	name = "Weyland-Yutani – Research Complex – General Botany Department"

/area/lv733/indoors/wy_research_complex/storage
	name = "Weyland-Yutani – Research Complex – Storage Facility"

/area/lv733/indoors/wy_research_complex/supply_department
	name = "Weyland-Yutani – Research Complex – Supply Department"

/area/lv733/indoors/wy_research_complex/main_entrance
	name = "Weyland-Yutani – Research Complex – Main Entrance"

/area/lv733/indoors/wy_research_complex/central_corridor
	name = "Weyland-Yutani – Research Complex – Central Corridor"

/area/lv733/indoors/wy_research_complex/research_office
	name = "Weyland-Yutani – Research Complex – Research Staff Office"

/area/lv733/indoors/wy_research_complex/reception
	name = "Weyland-Yutani – Research Complex – Reception"

/area/lv733/indoors/wy_research_complex/cafeteria
	name = "Weyland-Yutani – Research Complex – Cafeteria"

/area/lv733/indoors/wy_research_complex/restroom
	name = "Weyland-Yutani – Research Complex – Restroom"

/area/lv733/indoors/wy_research_complex/processing_chamber
	name = "Weyland-Yutani – Research Complex – Processing Chamber"

/area/lv733/indoors/wy_research_complex/security_office
	name = "Weyland-Yutani – Research Complex – Security Office"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/surveillance_room
	name = "Weyland-Yutani – Research Complex – Surveillance Room"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/north_corridor
	name = "Weyland-Yutani – Research Complex – North Corridor"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/south_corridor
	name = "Weyland-Yutani – Research Complex – South Corridor"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/east_corridor
	name = "Weyland-Yutani – Research Complex – East Corridor"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/west_corridor
	name = "Weyland-Yutani – Research Complex – West Corridor"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/cargo_bay
	name = "Weyland-Yutani – Research Complex – Cargo Bay"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/plant_cell_lab
	name = "Weyland-Yutani – Research Complex – Plant Cell Research Lab"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/cultivation_chamber
	name = "Weyland-Yutani – Research Complex – Cultivation Chamber"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/special_containment
	name = "Weyland-Yutani – Research Complex – Special Containment Room"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/mess_hall
	name = "Weyland-Yutani – Research Complex – Mess Hall"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/personnel_changing_bay
	name = "Weyland-Yutani – Research Complex – Personnel Changing Bay"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/hygiene_facility
	name = "Weyland-Yutani – Research Complex – Hygiene Facility"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/rd_office
	name = "Weyland-Yutani – Research Complex – Research Director's Office"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/rd_office
	name = "Weyland-Yutani – Research Complex – Research Director's Office"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/emergency_power
	name = "Weyland-Yutani – Research Complex – Emergency Power Module"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/biological_assessment
	name = "Weyland-Yutani – Research Complex – Biological Assessment Unit"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

/area/lv733/indoors/wy_research_complex/materials_testing
	name = "Weyland-Yutani – Research Complex – Materials Testing Lab"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS

// Cave System

/area/lv733/outdoors/caves
	name = "Cave System"
	icon_state = "caves_central"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_HYBRISA_CAVES
	soundscape_playlist = SCAPE_PL_LV759_CAVES
	soundscape_interval = 25
	ceiling_muffle = FALSE

/area/lv733/outdoors/caves/eastern_caves
	name = "Cave System – Eastern Caves"
	icon_state = "caves_east"

/area/lv733/outdoors/caves/central_caves
	name = "Cave System – Central Caves"
	icon_state = "caves_central"

/area/lv733/outdoors/caves/western_caves
	name = "Cave System – Western Caves"
	icon_state = "caves_west"


// Terraforming Generator Facility

/area/lv733/indoors/terraforming_generator
	name = "Terraforming Generator Facility"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "power0"
	ambience_exterior = AMBIENCE_SHIP_ALT
	soundscape_playlist = SCAPE_PL_ENG
	soundscape_interval = 25

/area/lv733/indoors/terraforming_generator/north_generator
	name = "Terraforming Generator Facility – Northern Generator"

/area/lv733/indoors/terraforming_generator/distribution_room
	name = "Terraforming Generator Facility – Distribution Room"


// Technical Sensor Facility

/area/lv733/indoors/sensor_facility
	name = "Technical Sensor Facility"
	ceiling = CEILING_METAL
	icon_state = "power0"
	ambience_exterior = AMBIENCE_DERELICT
	soundscape_playlist = SCAPE_PL_LV759_DERELICTSHIP
	soundscape_interval = 35

/area/lv733/indoors/sensor_facility/sensor_room
	name = "Technical Sensor Facility – Sensor Room"

/area/lv733/indoors/sensor_facility/tech_room
	name = "Technical Sensor Facility – Technical Room"


