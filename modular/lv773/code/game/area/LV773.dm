//lv773 AREAS--------------------------------------//

/area/lv773
	name = "LV-773 Marlowe Ridge"
	icon = 'icons/turf/area_hybrisa.dmi'
	icon_state = "hybrisa"
	can_build_special = TRUE
	soundscape_playlist = SCAPE_PL_THUNDER
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY_RESANDCOM

//parent types

/area/lv773/indoors
	name = "Marlowe Point - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ambience_exterior = AMBIENCE_HYBRISA_INTERIOR

/area/lv773/outdoors
	name = "Marlowe Point - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV759_OUTDOORS
	ambience_exterior = AMBIENCE_CITY
	soundscape_interval = 25

/area/lv773/oob
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB
	requires_power = FALSE

/area/lv773/bunker
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOBURROW
	minimap_color = MINIMAP_AREA_OOB

// Landing Zone 1

/area/lv773/outdoors/landing_zone_1
	name = "Marlowe Point ROAF - Primary Landing Zone - Landing Zone One"
	icon_state = "medical_lz1"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/main_checkpoint
	name = "Marlowe Point ROAF - Primary Landing Zone - Landing Zone One - Checkpoint"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/technical_corridor
	name = "Marlowe Point ROAF - Primary Landing Zone - Landing Zone One - Technical Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/main_hangar_bay
	name = "Marlowe Point ROAF - Hangars - Landing Zone One - Main Hangar Bay"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/loader_hangar_room
	name = "Marlowe Point ROAF - Hangars - Landing Zone One - Loader Operations Room"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/roaf_flight_control_room
	name = "Marlowe Point ROAF - ROAF Office - Landing Zone One - Flight Briefings Room"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/roaf_pilots_dorm
	name = "Marlowe Point ROAF - ROAF Office - Landing Zone One - Pilots Lounge"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE

/area/lv773/indoors/landing_zone_1/roaf_corridor
	name = "Marlowe Ridge ROAF - ROAF Office - Landing Zone One - ROAF Office Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/roaf_technical_corridor
	name = "Marlowe Point ROAF - ROAF Office - Landing Zone One - ROAF Technical Access Corridor"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/roaf_comms_hub_1
	name = "Marlowe Point ROAF - ROAF Office - Landing Zone One - ROAF Communications Hub"
	icon_state = "comms_1"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ1

/area/lv773/indoors/landing_zone_1/lz1_console
	name = "Marlowe Point ROAF - Hangars - Landing Zone One - Dropship Alamo Console"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	is_landing_zone = TRUE
	linked_lz = DROPSHIP_LZ1

// Landing Zone 2

/area/lv773/outdoors/landing_zone_2
	name = "Marlowe Civilian Spaceport - Landing Zone Two"
	icon_state = "mining_lz2"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/landing_zone_2/marlowe_civ_spaceport_checkpoint_room
	name = "Marlowe Civilian Spaceport - Checkpoint"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/landing_zone_2/marlowe_civ_spaceport_storage
	name = "Marlowe Civilian Spaceport - Storage Depot"
	icon_state = "security_checkpoint"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/landing_zone_2/marlowe_civ_spaceport_store
	name = "Marlowe Civilian Spaceport - Loading Zone"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/landing_zone_2/marlowe_civ_spaceport_ship
	name = "Marlowe Civilian Spaceport - Spaceship"
	icon_state = "hybrisa"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/landing_zone_2/marlowe_civ_spaceport/lz2_console
	name = "Marlowe Civilian Spaceport - Dropship Normandy Console"
	icon_state = "hybrisa"
	requires_power = FALSE
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

// Shop

/area/lv773/indoors/wy_shop
	name = "WY Shop"
	ceiling = CEILING_METAL
	linked_lz = DROPSHIP_LZ2

/area/lv773/indoors/wy_shop/main_hall
	name = "WY Shop - Main Hall"

/area/lv773/indoors/wy_shop/storage_room
	name = "WY Shop - Storage Room"

/area/lv773/indoors/wy_shop/technical_room
	name = "WY Shop - Technical Room"

// Landing Cargo Area

/area/lv773/indoors/landing_cargo
	name = "ROAF Forward Cargo Area - Logistics Storage"
	icon_state = "mining"

/area/lv773/indoors/hospital/cryo_room
	name = "ROAF Forward Cargo Area - Crew Rest Zone"

// Hosptial

/area/lv773/indoors/hospital
	icon_state = "medical"
	minimap_color = MINIMAP_AREA_MEDBAY
	ceiling = CEILING_METAL

/area/lv773/indoors/hospital/reception
	name = "Marlowe Ridge Hospital Complex - Reception"

/area/lv773/indoors/hospital/waiting_lounge
	name = "Marlowe Ridge Hospital Complex - Waiting Lounge"

/area/lv773/indoors/hospital/cmo_office
	name = "Marlowe Ridge Hospital Complex - Chief Medical Officer's Office"

/area/lv773/indoors/hospital/restroom
	name = "Marlowe Ridge Hospital Complex - Restroom"

/area/lv773/indoors/hospital/patient_ward
	name = "Marlowe Ridge Hospital Complex - Patient Ward"

/area/lv773/indoors/hospital/operation
	name = "Marlowe Ridge Hospital Complex - Operation Theatres & Observation"

/area/lv773/indoors/hospital/medical_storage
	name = "Marlowe Ridge Hospital Complex - Medical Storage"

/area/lv773/indoors/hospital/maintenance_south
	name = "Marlowe Ridge Hospital Complex - Unisex-Restroom"

// Residential District

// Bar

/area/lv773/indoors/bar
	name = "Bar"
	icon_state = "bar"
	ceiling = CEILING_METAL

/area/lv773/indoors/bar/entertainment
	name = "Bar - Entertainment Subsection"

/area/lv773/indoors/bar/bathroom
	name = "Bar - Restrooms"

/area/lv773/indoors/bar/maintenance
	name = "Bar - Maintenance"

// Cafeteria

/area/lv773/indoors/cafeteriakitchen
	name = "Weyland-Yutani Residential - Cafeteria - Dining Zone"
	icon_state = "wylab"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS
	ceiling = CEILING_METAL

/area/lv773/indoors/cafeteriakitchen/Kitchen
	name = "Weyland-Yutani Residential - Cafeteria - Kitchen"
	icon_state = "wylab"
	soundscape_playlist = SCAPE_PL_LV759_INDOORS

// Multi-Purpose Complex

/area/lv773/indoors/multicomplex
	name = "Multi-complex"
	icon_state = "bar"
	ceiling = CEILING_METAL

/area/lv773/indoors/multicomplex/foyer
	name = "Multi-complex - Foyer"

/area/lv773/indoors/multicomplex/detective_office
	name = "Multi-complex - Detective Office"

/area/lv773/indoors/multicomplex/laundry_room
	name = "Multi-complex - Laundry Room"

/area/lv773/indoors/multicomplex/pizzeria
	name = "Multi-complex - Pizzeria"


// Motel

/area/lv773/indoors/motel
	name = "Motel Complex - Apartments"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/motel/corridor
	name = "Motel Complex - Apartments - Corridor"

/area/lv773/indoors/motel/reception
	name = "Motel Complex - Apartments - Reception"

/area/lv773/indoors/motel/reception/room
	name = "Motel Complex - Apartments - room"

/area/lv773/indoors/motel/reception/lounge_area
	name = "Motel Complex - Apartments - Lounge Area"

/area/lv773/indoors/motel/reception/restrooms_showers
	name = "Motel Complex - Apartments - Restrooms and Showers"

// ROAF Training School

/area/lv773/indoors/training_school
	name = "Training School"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/training_school/reception
	name = "Training School - Reception"

/area/lv773/indoors/training_school/classroom
	name = "Training School - Classroom"

/area/lv773/indoors/training_school/training_hall
	name = "Training School - Training Hall"

// ROAF Base Operations

/area/lv773/indoors/base_operations
	name = "Training School"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/base_operations/west_corridor
	name = "ROAF Base Operations - West Wing Corridor"

/area/lv773/indoors/base_operations/east_corridor
	name = "ROAF Base Operations - East Wing Corridor"

/area/lv773/indoors/base_operations/central_corridor
	name = "ROAF Base Operations - Central Corridor"

/area/lv773/indoors/base_operations/south_corridor
	name = "ROAF Base Operations - South Wing Corridor"

/area/lv773/indoors/base_operations/north_corridor
	name = "ROAF Base Operations - North Wing Corridor"

/area/lv773/indoors/base_operations/emergency_exit
	name = "ROAF Base Operations - Emergency Exit"

/area/lv773/indoors/base_operations/barracks_one
	name = "ROAF Base Operations - ROAF Dorm #1"

/area/lv773/indoors/base_operations/barracks_two
	name = "ROAF Base Operations - ROAF Dorm #2"

/area/lv773/indoors/base_operations/barracks_three
	name = "ROAF Base Operations - ROAF Dorm #3"

/area/lv773/indoors/base_operations/laundry_room
	name = "ROAF Base Operations - Laundry Room"

/area/lv773/indoors/base_operations/supply_room
	name = "ROAF Base Operations - Supply Room"

/area/lv773/indoors/base_operations/bathrooms
	name = "ROAF Base Operations - Bathrooms"

/area/lv773/indoors/base_operations/toilets
	name = "ROAF Base Operations - Toilets"

/area/lv773/indoors/base_operations/officers_quarters
	name = "ROAF Base Operations - ROAF Staff Dorm"

/area/lv773/indoors/base_operations/communications_office
	name = "ROAF Base Operations - Communications Office"

/area/lv773/indoors/base_operations/co_office
	name = "ROAF Base Operations - Chief of ROAF Staff Office"

/area/lv773/indoors/base_operations/mess_hall
	name = "ROAF Base Operations - Mess Hall"

/area/lv773/indoors/base_operations/kitchen
	name = "ROAF Base Operations - Kitchen"

/area/lv773/indoors/base_operations/freezer
	name = "ROAF Base Operations - Freezer"

/area/lv773/indoors/base_operations/south_w_checkpoint
	name = "ROAF Base Operations - South-West Checkpoint"

/area/lv773/indoors/base_operations/south_e_checkpoint
	name = "ROAF Base Operations - South-East Checkpoint"

/area/lv773/indoors/base_operations/training_yard
	name = "ROAF Base Operations - Training Yard"

/area/lv773/indoors/base_operations/storage_facility
	name = "ROAF Base Operations - Storage Facility"

/area/lv773/indoors/base_operations/unloading_zone
	name = "ROAF Base Operations - Unloading Zone"

/area/lv773/indoors/base_operations/armory
	name = "ROAF Base Operations - Armory"

// Engineering Sector

/area/lv773/indoors/main_eng
	name = "Engineering Hub"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/main_eng/reception
	name = "Engineering Hub - Reception"

/area/lv773/indoors/main_eng/generator_core
	name = "Engineering Hub - Generator Core"

/area/lv773/indoors/main_eng/storage
	name = "Engineering Hub - Storage"

/area/lv773/indoors/main_eng/relay
	name = "Engineering Hub - Communications Relay Buffer"
	icon_state = "comms_2"
	linked_lz = DROPSHIP_LZ2

// Weyland-Yutani – Main Complex

/area/lv773/indoors/main_complex
	name = "Weyland-Yutani – Main Complex"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/main_complex/north_corridor
	name = "Weyland-Yutani – North Corridor"

/area/lv773/indoors/main_complex/central_corridor
	name = "Weyland-Yutani – Central Corridor"

/area/lv773/indoors/main_complex/south_corridor
	name = "Weyland-Yutani – South Corridor"

/area/lv773/indoors/main_complex/reception
	name = "Weyland-Yutani – Reception"

/area/lv773/indoors/main_complex/office
	name = "Weyland-Yutani – Office"

// Weyland-Yutani – Residential Block

/area/lv773/indoors/residential_block
	name = "Weyland-Yutani – Residential"
	icon_state = "apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/residential_block/north_corridor
	name = "Weyland-Yutani – Residential – North Corridor"

/area/lv773/indoors/residential_block/south_corridor
	name = "Weyland-Yutani – Residential – South Corridor"

/area/lv773/indoors/residential_block/living_quarters
	name = "Weyland-Yutani – Residential – Living Quarters"

/area/lv773/indoors/residential_block/restroom
	name = "Weyland-Yutani – Residential – Restroom"

// Street

/area/lv773/outdoors/colony_streets
	name = "Colony Streets"
	icon_state = "colonystreets_north"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY_STREETS

/area/lv773/outdoors/colony_streets
	name = "Street - Landing Zone Exit"
	linked_lz = DROPSHIP_LZ1

/area/lv773/outdoors/colony_streets
	name = "Street - Northern Technical Streets"
	linked_lz = DROPSHIP_LZ1

/area/lv773/outdoors/colony_streets
	name = "Street - Northern City Streets"
	linked_lz = DROPSHIP_LZ2

/area/lv773/outdoors/colony_streets
	name = "Street - Central Avenue"

/area/lv773/outdoors/colony_streets
	name = "Street - Eastern Tunnel"

/area/lv773/outdoors/colony_streets
	name = "Street - ROAF Base Streets"

/area/lv773/outdoors/colony_streets
	name = "Street - Southern Technical Road"

/area/lv773/outdoors/colony_streets
	name = "Street - Complex Access Roads"

// Mining Complex

/area/lv773/indoors/mining_complex
	name = "Mining Complex"
	icon_state = "mining"
	ceiling = CEILING_METAL

/area/lv773/indoors/mining_complex/main_operations
	name = "Mining Complex – Main Operations Zone"

/area/lv773/indoors/mining_complex/locker_room
	name = "Mining Complex – Locker Room"

/area/lv773/indoors/mining_complex/rest_area
	name = "Mining Complex – Crew Rest Area"

/area/lv773/indoors/mining_complex/storage
	name = "Mining Complex – Storage Depot"

/area/lv773/indoors/mining_complex/office
	name = "Mining Complex – Supervisor Office"


// Residential Building

/area/lv773/indoors/residential_building
	name = "Residential Building"
	icon_state = "wy_apartments"
	ceiling = CEILING_METAL

/area/lv773/indoors/residential_building/corridor
	name = "Residential Building – Residential Corridor"

/area/lv773/indoors/residential_building/common_area
	name = "Residential Building – Common Area"

/area/lv773/indoors/residential_building/living_quarters
	name = "Residential Building – Living Quarters"


// Weyland-Yutani Research Complex

/area/lv773/indoors/wy_research_complex
	icon_state = "wy_research"
	ceiling = CEILING_METAL
	name = "Weyland-Yutani – Research Complex"

/area/lv773/indoors/wy_research_complex/west_entrance
	name = "Weyland-Yutani – Research Complex – West Entrance"

/area/lv773/indoors/wy_research_complex/offices
	name = "Weyland-Yutani – Research Complex – Office Wing"

/area/lv773/indoors/wy_research_complex/botany_department
	name = "Weyland-Yutani – Research Complex – General Botany Department"

/area/lv773/indoors/wy_research_complex/storage
	name = "Weyland-Yutani – Research Complex – Storage Facility"

/area/lv773/indoors/wy_research_complex/supply_department
	name = "Weyland-Yutani – Research Complex – Supply Department"

/area/lv773/indoors/wy_research_complex/main_entrance
	name = "Weyland-Yutani – Research Complex – Main Entrance"

/area/lv773/indoors/wy_research_complex/central_corridor
	name = "Weyland-Yutani – Research Complex – Central Corridor"

/area/lv773/indoors/wy_research_complex/research_office
	name = "Weyland-Yutani – Research Complex – Research Staff Office"

/area/lv773/indoors/wy_research_complex/reception
	name = "Weyland-Yutani – Research Complex – Reception"

/area/lv773/indoors/wy_research_complex/cafeteria
	name = "Weyland-Yutani – Research Complex – Cafeteria"

/area/lv773/indoors/wy_research_complex/restroom
	name = "Weyland-Yutani – Research Complex – Restroom"

/area/lv773/indoors/wy_research_complex/processing_chamber
	name = "Weyland-Yutani – Research Complex – Processing Chamber"

/area/lv773/indoors/wy_research_complex/security_office
	name = "Weyland-Yutani – Research Complex – Security Office"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/surveillance_room
	name = "Weyland-Yutani – Research Complex – Surveillance Room"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/north_corridor
	name = "Weyland-Yutani – Research Complex – North Corridor"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/south_corridor
	name = "Weyland-Yutani – Research Complex – South Corridor"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/east_corridor
	name = "Weyland-Yutani – Research Complex – East Corridor"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/west_corridor
	name = "Weyland-Yutani – Research Complex – West Corridor"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/cargo_bay
	name = "Weyland-Yutani – Research Complex – Cargo Bay"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/spraying_chamber
	name = "Weyland-Yutani – Research Complex – Spraying Chamber"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/plant_cell_lab
	name = "Weyland-Yutani – Research Complex – Plant Cell Research Lab"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/cultivation_chamber
	name = "Weyland-Yutani – Research Complex – Cultivation Chamber"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/indoors/wy_research_complex/special_containment
	name = "Weyland-Yutani – Research Complex – Special Containment Room"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

// Cave System

/area/lv773/outdoors/caves
	name = "Cave System"
	icon_state = "cave"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/lv773/outdoors/caves/eastern_caves
	name = "Cave System – Eastern Caves"

/area/lv773/outdoors/caves/central_caves
	name = "Cave System – Central Caves"

/area/lv773/outdoors/caves/western_caves
	name = "Cave System – Western Caves"


// Terraforming Generator Facility

/area/lv773/indoors/terraforming_generator
	name = "Terraforming Generator Facility"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	icon_state = "terra"

/area/lv773/indoors/terraforming_generator/north_generator
	name = "Terraforming Generator Facility – Northern Generator"

/area/lv773/indoors/terraforming_generator/distribution_room
	name = "Terraforming Generator Facility – Distribution Room"


// Technical Sensor Facility

/area/lv773/indoors/sensor_facility
	name = "Technical Sensor Facility"
	ceiling = CEILING_METAL
	icon_state = "cave"

/area/lv773/indoors/sensor_facility/sensor_room
	name = "Technical Sensor Facility – Sensor Room"





