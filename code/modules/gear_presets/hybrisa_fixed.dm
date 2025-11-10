/datum/equipment_preset/hybrisa_event

	name = "Hybrisa - Civilian"
	assignment = "Resident"
	job_title = "Civilian"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/civilian
	languages = list(LANGUAGE_JAPANESE, LANGUAGE_ENGLISH)
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/lanyard
	access = list(ACCESS_HYBRISA)
	faction = FACTION_COLONIST
	faction_group = list(FACTION_COLONIST)
	origin_override = ORIGIN_TWE

	minimap_icon = "surv"
	minimap_background = "background_civillian"

/datum/equipment_preset/hybrisa_event/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = random_name(new_human.gender)
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(21,45)

/datum/equipment_preset/hybrisa_event/load_id(mob/living/carbon/human/new_human, client/mob_client)
	var/obj/item/clothing/under/uniform = new_human.w_uniform
	if(istype(uniform))
		uniform.has_sensor = UNIFORM_HAS_SENSORS
	return ..()

////////////////////////////////////////////////////
//////////////////// KELLAND ///////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/kelland_cleaner
	name = "Hybrisa - Kelland - Cleaning Technician"
	assignment = "KMCC - Cleaning Technician"
	skills = /datum/skills/hybrisa_event/kelland/sanitation
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_SANITATION, ACCESS_HYBRISA_DEPARTURE)


/datum/equipment_preset/hybrisa_event/kelland_cleaner/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/santiation(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm/green(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/sanitation(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/brown(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_reprocess
	name = "Hybrisa - Kelland - Material Reprocessing Technician"
	assignment = "KMCC - Material Reprocessing Technician"
	skills = /datum/skills/hybrisa_event/kelland/sanitation
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_SANITATION, ACCESS_HYBRISA_DEPARTURE)


/datum/equipment_preset/hybrisa_event/kelland_reprocess/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/santiation(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm/green(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/hybrisa/sanitation_utility(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/brown(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_engineer1
	name = "Hybrisa - Kelland - Engineer1"
	assignment = "KMCC - DynaGrid Engineer"
	skills = /datum/skills/hybrisa_event/kelland/engineer
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_engineer1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_ENGINEER)

/datum/equipment_preset/hybrisa_event/kelland_engineer1/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/orange(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/engineering_utility(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_engineer2
	name = "Hybrisa - Kelland - Engineer2"
	assignment = "KMCC - DynaGrid Engineer"
	skills = /datum/skills/hybrisa_event/kelland/engineer
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_engineer2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_ENGINEER)

/datum/equipment_preset/hybrisa_event/kelland_engineer2/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/engineering_utility(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/hybrisa/engineering_utility_oversuit(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/nailgun(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_electrician1
	name = "Hybrisa - Kelland - Electrician1"
	assignment = "KMCC - DynaGrid Electrician"
	skills = /datum/skills/hybrisa_event/kelland/electrician
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_electrician1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_ENGINEER, ACCESS_LIST_HYBRISA_SUBSTATIONS)

/datum/equipment_preset/hybrisa_event/kelland_electrician1/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/dblue(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/engineering_utility/alt(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_electrician2
	name = "Hybrisa - Kelland - Electrician2"
	assignment = "KMCC - DynaGrid Electrician"
	skills = /datum/skills/hybrisa_event/kelland/electrician
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_electrician2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_ENGINEER, ACCESS_LIST_HYBRISA_SUBSTATIONS)

/datum/equipment_preset/hybrisa_event/kelland_electrician2/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/engineering_utility/alt(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/hybrisa/engineering_utility_oversuit/alt(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_telecomms
	name = "Hybrisa - Kelland - Telecommunications Technician"
	assignment = "KMCC - DynaGrid Telecommunications Technician"
	skills = /datum/skills/hybrisa_event/kelland/telecomms
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_DYNAGRID_GENERAL, ACCESS_HYBRISA_DYNAGRID_GEAR, ACCESS_HYBRISA_DYNAGRID_TELECOMMS)


/datum/equipment_preset/hybrisa_event/kelland_telecomms/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/headset(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/kelland_chiefengineer
	name = "Hybrisa - Kelland - Chief Engineer"
	assignment = "KMCC - DynaGrid Chief Engineer"
	skills = /datum/skills/hybrisa_event/kelland/ce
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_chiefengineer/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_CHIEF_ENGINEER)

/datum/equipment_preset/hybrisa_event/kelland_chiefengineer/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility/gray(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/kelland_mining(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/eng(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/kelland_engichef
	name = "Hybrisa - Kelland - Mess Technician"
	assignment = "KMCC - DynaGrid Mess Technician"
	skills = /datum/skills/hybrisa_event/kelland/messtech
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_DYNAGRID_GENERAL, ACCESS_HYBRISA_DYNAGRID_KITCHEN)


/datum/equipment_preset/hybrisa_event/kelland_engichef/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chef(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/chef(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/chefhat(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/kelland_miner
	name = "Hybrisa - Kelland - Miner"
	assignment = "KMCC - Miner"
	skills = /datum/skills/hybrisa_event/kelland/miner
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/kelland_miner/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_MINER)

/datum/equipment_preset/hybrisa_event/kelland_miner/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/kelland_mining(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/kelland_leadminer
	name = "Hybrisa - Kelland - Foreman"
	assignment = "KMCC - Foreman"
	skills = /datum/skills/hybrisa_event/kelland/leadminer
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_COMMAND, ACCESS_HYBRISA_DEPARTURE)
	idtype = /obj/item/card/id

/datum/equipment_preset/hybrisa_event/kelland_leadminer/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_MINER)

/datum/equipment_preset/hybrisa_event/kelland_leadminer/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/kelland_mining(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/bomber(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_cargotech1
	name = "Hybrisa - Kelland - Cargo Technician1"
	assignment = "KMCC - Cargo Technician"
	skills = /datum/skills/hybrisa_event/kelland/cargotech
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CARGO, ACCESS_HYBRISA_DEPARTURE)


/datum/equipment_preset/hybrisa_event/kelland_cargotech1/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility/brown(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/tan(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing/brown(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_cargotech2
	name = "Hybrisa - Kelland - Cargo Technician2"
	assignment = "KMCC - Cargo Technician"
	skills = /datum/skills/hybrisa_event/kelland/cargotech
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CARGO, ACCESS_HYBRISA_DEPARTURE)


/datum/equipment_preset/hybrisa_event/kelland_cargotech2/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/kelland_mining(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/corporate(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/soft/trucker/red(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/kelland_mining(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_cargotech3
	name = "Hybrisa - Kelland - Cargo Technician3"
	assignment = "KMCC - Cargo Technician"
	skills = /datum/skills/hybrisa_event/kelland/cargotech
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CARGO, ACCESS_HYBRISA_DEPARTURE)


/datum/equipment_preset/hybrisa_event/kelland_cargotech3/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/frontier(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/blue(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/soft/trucker(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/tan(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_quartermaster
	name = "Hybrisa - Kelland - Quartermaster"
	assignment = "KMCC - Quartermaster"
	skills = /datum/skills/hybrisa_event/kelland/quartermaster
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CARGO, ACCESS_HYBRISA_DEPARTURE, ACCESS_HYBRISA_COMMAND)
	idtype = /obj/item/card/id


/datum/equipment_preset/hybrisa_event/kelland_quartermaster/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/green(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm/orange_line(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/civilian/brown(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_airtraffic
	name = "Hybrisa - Kelland - Air Traffic Controller"
	assignment = "KMCC - Air Traffic Controller"
	skills = /datum/skills/hybrisa_event/kelland/airtraffic
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_DEPARTURE, ACCESS_HYBRISA_COMMAND, ACCESS_HYBRISA_TOWER_KMCC)
	idtype = /obj/item/card/id


/datum/equipment_preset/hybrisa_event/kelland_airtraffic/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/white_service(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/bridge(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber/grey(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/kelland_manager
	name = "Hybrisa - Kelland - Manager"
	assignment = "KMCC - Manager"
	skills = /datum/skills/hybrisa_event/kelland/manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/pmc

/datum/equipment_preset/hybrisa_event/kelland_manager/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_KMCC_MANAGER)

/datum/equipment_preset/hybrisa_event/kelland_manager/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/brown(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black/lockable/no_override(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/fedora/brown(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB/trenchcoat/brown(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/new_bimex/black(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/tie/black(new_human), WEAR_ACCESSORY)

	..()

/datum/equipment_preset/synth/hybrisa_event/kellandsynth
	name = "Hybrisa - Kelland - Synthetic"
	assignment = "KMCC - Synthetic Unit"
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	var/survivor_variant = CIVILIAN_SURVIVOR

/datum/equipment_preset/synth/hybrisa_event/kellandsynth/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/brown/jacket(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/synthetic(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator/silver(new_human), WEAR_EYES)

	..()


/////////////////////////////////////////////////
//////////////////// NSPA ///////////////////////
/////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/nspa_constable
	name = "Hybrisa - NSPA - Constable"
	assignment = "NSPA - Constable"
	skills = /datum/skills/hybrisa_event/nspa/constable
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_CST = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/nspa_silver

/datum/equipment_preset/hybrisa_event/nspa_constable/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_NSPA_CONSTABLE)

/datum/equipment_preset/hybrisa_event/nspa_constable/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/nspa_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/nspa_peaked_cap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/blue(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nspa_senconstable
	name = "Hybrisa - NSPA - Senior Constable"
	assignment = "NSPA - Senior Constable"
	skills = /datum/skills/hybrisa_event/nspa/senior_constable
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_SC = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/nspa_silver

/datum/equipment_preset/hybrisa_event/nspa_senconstable/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_NSPA_SENIOR_CONSTABLE)

/datum/equipment_preset/hybrisa_event/nspa_senconstable/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/nspa_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/nspa_peaked_cap_goldandsilver(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/blue(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nspa_sergeant
	name = "Hybrisa - NSPA - Sergeant"
	assignment = "NSPA - Sergeant"
	skills = /datum/skills/hybrisa_event/nspa/sergeant
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_SGT = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/nspa_silver_gold

/datum/equipment_preset/hybrisa_event/nspa_sergeant/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_NSPA_SERGEANT)

/datum/equipment_preset/hybrisa_event/nspa_sergeant/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/nspa_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/nspa_peaked_cap_gold(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/blue(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB/hybrisa/nspa_formal_jacket(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/nspa_inspector
	name = "Hybrisa - NSPA - Inspector"
	assignment = "NSPA - Inspector"
	skills = /datum/skills/hybrisa_event/nspa/inspector
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_INSP = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/nspa_gold

/datum/equipment_preset/hybrisa_event/nspa_inspector/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_NSPA_INSPECTOR)

/datum/equipment_preset/hybrisa_event/nspa_inspector/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/nspa_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/fedora/grey(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/blue(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB/trenchcoat/grey(new_human), WEAR_JACKET)

	..()

////////////////////////////////////////////////////
//////////////// WEYLAND-YUTANI ////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/weymart_worker
	name = "Hybrisa - Weyland-Yutani - Weymart Employee"
	assignment = "Weyland-Yutani - Weymart Employee"
	skills = /datum/skills/hybrisa_event/weyland/weymart_worker
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_WEYMART, ACCESS_HYBRISA_ASSEMBLY)


/datum/equipment_preset/hybrisa_event/weymart_worker/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/weymart(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/weymart(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/weymart(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/synth/hybrisa_event/weymart_joe
	name = "Hybrisa - Weyland-Yutani - Weymart Joe"
	assignment = "Weyland-Yutani - Weymart Joe"
	flags = EQUIPMENT_PRESET_START_OF_ROUND

	skills = /datum/skills/working_joe
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_APOLLO, LANGUAGE_JAPANESE, LANGUAGE_SPANISH)
	/// Used to set species when loading race
	var/joe_type = SYNTH_WORKING_JOE

	remove_tts = TRUE // BANDAMARINES ADD

/datum/equipment_preset/synth/hybrisa_event/weymart_joe/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WEYMART_MANAGER)

/datum/equipment_preset/synth/hybrisa_event/weymart_joe/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.bubble_icon = "robot"
	new_human.gender = MALE
	new_human.flavor_text = ""
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	new_human.r_eyes = 0
	new_human.g_eyes = 255
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255

/datum/equipment_preset/synth/hybrisa_event/weymart_joe/load_vanity(mob/living/carbon/human/new_human)
	return


/datum/equipment_preset/synth/hybrisa_event/weymart_joe/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/weymart(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/weymart(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/weymart(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/weymart_manager
	name = "Hybrisa - Weyland-Yutani - Weymart Manager"
	assignment = "Weyland-Yutani - Weymart Manager"
	skills = /datum/skills/hybrisa_event/weyland/weymart_manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND

/datum/equipment_preset/hybrisa_event/weymart_manager/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WEYMART_MANAGER)

/datum/equipment_preset/hybrisa_event/weymart_manager/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/white_service(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/weymart(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/weymart(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/wypilot
	name = "Hybrisa - Weyland-Yutani - Commercial Pilot"
	assignment = "Weyland-Yutani - Commercial Pilot"
	skills = /datum/skills/hybrisa_event/weyland/pilot
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/gold

/datum/equipment_preset/hybrisa_event/wypilot/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_PILOT)

/datum/equipment_preset/hybrisa_event/wypilot/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_pilot(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/wy_po_cap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hybrisa/wy_Pilot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator/silver(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/meridianoffice1
	name = "Hybrisa - Meridian - Office Worker1"
	assignment = "Meridian - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker_meridian
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_MERIDIAN, ACCESS_HYBRISA_ASSEMBLY)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/meridianoffice1/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/brown(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/stowaway(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/meridianoffice2
	name = "Hybrisa - Meridian - Office Worker2"
	assignment = "Meridian - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker_meridian
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_MERIDIAN, ACCESS_HYBRISA_ASSEMBLY)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/meridianoffice2/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/blazer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/blue(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/wyoffice1
	name = "Hybrisa - Weyland-Yutani - Office Worker1"
	assignment = "Weyland-Yutani - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver/clearance_badge/cl

/datum/equipment_preset/hybrisa_event/wyoffice1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WYOFFICE)

/datum/equipment_preset/hybrisa_event/wyoffice1/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/white_service(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/wyoffice2
	name = "Hybrisa - Weyland-Yutani - Office Worker2"
	assignment = "Weyland-Yutani - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver/clearance_badge/cl

/datum/equipment_preset/hybrisa_event/wyoffice2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WYOFFICE)

/datum/equipment_preset/hybrisa_event/wyoffice2/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/suspenders(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/blue(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/wyoffice3
	name = "Hybrisa - Weyland-Yutani - Office Worker3"
	assignment = "Weyland-Yutani - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver/clearance_badge/cl

/datum/equipment_preset/hybrisa_event/wyoffice3/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WYOFFICE)

/datum/equipment_preset/hybrisa_event/wyoffice3/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/brown(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/wyoffice4
	name = "Hybrisa - Weyland-Yutani - Office Worker4"
	assignment = "Weyland-Yutani - Office Worker"
	skills = /datum/skills/hybrisa_event/weyland/officeworker
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver/clearance_badge/cl

/datum/equipment_preset/hybrisa_event/wyoffice4/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WYOFFICE)

/datum/equipment_preset/hybrisa_event/wyoffice4/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/white_service(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/meridiantech
	name = "Hybrisa - Meridian - Car Mechanic"
	assignment = "Meridian - Car Mechanic"
	skills = /datum/skills/hybrisa_event/weyland/techmeridian
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_FACTORY, ACCESS_HYBRISA_MERIDIAN)


/datum/equipment_preset/hybrisa_event/meridiantech/load_gear(mob/living/carbon/human/new_human)

	var/obj/item/clothing/under/color/brown/uniform = new()
	if(prob(100))
		uniform.roll_suit_jacket()
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette(new_human), WEAR_FACE)

	..()

/datum/equipment_preset/hybrisa_event/wyexec
	name = "Hybrisa - Weyland-Yutani - Senior Executive"
	assignment = "Weyland-Yutani - Senior Executive"
	skills = /datum/skills/hybrisa_event/weyland/sen_executive
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/pmc

/datum/equipment_preset/hybrisa_event/wyexec/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_WYEXECUTIVE)

/datum/equipment_preset/hybrisa_event/wyexec/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_exec_suit_uniform(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/wy_cap(new_human), WEAR_HEAD)
	..()

/datum/equipment_preset/hybrisa_event/meridianmanager
	name = "Hybrisa - Meridian - Manager"
	assignment = "Meridian - Manager"
	skills = /datum/skills/hybrisa_event/weyland/meridian_manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id

/datum/equipment_preset/hybrisa_event/meridianmanager/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MERIDIAN_MANAGER)

/datum/equipment_preset/hybrisa_event/meridianmanager/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/brown(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB/trenchcoat(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm/red_line(new_human), WEAR_BACK)
	..()

/datum/equipment_preset/hybrisa_event/wyh_supervisor
	name = "Hybrisa - Weyland-Yutani - Colony Supervisor"
	assignment = "Weyland-Yutani - Colony Supervisor"
	skills = /datum/skills/hybrisa_event/weyland/supervisor
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_WYC8 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/general

/datum/equipment_preset/hybrisa_event/wyh_supervisor/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_SUPERVISOR)

/datum/equipment_preset/hybrisa_event/wyh_supervisor/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/jacket_only(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black/lockable/no_override(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/fedora/grey(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB/hybrisa/fur_lined_trench_coat(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/wyh_guard
	name = "Hybrisa - Weyland-Yutani - Personal Protection Officer"
	assignment = "Weyland-Yutani - Personal Protection Officer"
	skills = /datum/skills/hybrisa_event/weyland/ppo
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	paygrades = list(PAY_SHORT_WYC8 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/pmc/commando

/datum/equipment_preset/hybrisa_event/wyh_guard/New()
	. = ..()
	access += get_access(ACCESS_LIST_HYBRISA_SUPERVISOR)

/datum/equipment_preset/hybrisa_event/wyh_guard/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/corporate/hybrisa(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/corporate/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/gray(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/lead(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/lead(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/fake/blue(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/WY/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/wy(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/kelotane(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/p90(new_human), WEAR_IN_BACK)

	..()

////////////////////////////////////////////////////
///////////////// PIZZA GALAXY /////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/pizza_worker
	name = "Hybrisa - Pizza Galaxy - Cashier"
	assignment = "Pizza Galaxy - Cashier"
	skills = /datum/skills/hybrisa_event/pizza/cashier
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_PIZZA, ACCESS_HYBRISA_PIZZA_GARAGE)
	idtype = /obj/item/card/id/pizza


/datum/equipment_preset/hybrisa_event/pizza_worker/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/pizza_galaxy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/pizza_galaxy(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/pizza_manager
	name = "Hybrisa - Pizza Galaxy - Manager"
	assignment = "Pizza Galaxy - Manager"
	skills = /datum/skills/hybrisa_event/pizza/manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_PIZZA, ACCESS_HYBRISA_PIZZA_GARAGE)
	idtype = /obj/item/card/id/pizza


/datum/equipment_preset/hybrisa_event/pizza_manager/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/pizza_galaxy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/pizza_galaxy(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/tie/red(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	..()

/datum/equipment_preset/hybrisa_event/pizza_chef
	name = "Hybrisa - Pizza Galaxy - Chef"
	assignment = "Pizza Galaxy - Chef"
	skills = /datum/skills/hybrisa_event/pizza/chef
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_PIZZA, ACCESS_HYBRISA_PIZZA_GARAGE)
	idtype = /obj/item/card/id/pizza


/datum/equipment_preset/hybrisa_event/pizza_chef/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/pizza_galaxy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hybrisa/pizza_galaxy(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/apron/cuppa_joes(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)

	..()

/datum/equipment_preset/hybrisa_event/pizza_deliverydriver
	name = "Hybrisa - Pizza Galaxy - Delivery Driver"
	assignment = "Pizza Galaxy - Delivery Driver"
	skills = /datum/skills/hybrisa_event/pizza/delivery
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_PIZZA, ACCESS_HYBRISA_PIZZA_GARAGE)
	idtype = /obj/item/card/id/pizza


/datum/equipment_preset/hybrisa_event/pizza_deliverydriver/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/pizza_galaxy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/hybrisa/pizza_galaxy(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/red(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/tie/red(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)

	..()

////////////////////////////////////////////////////
////////////////// CUPPA JOE'S /////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/cuppa_waitress
	name = "Hybrisa - Cuppa Joe's - Waitress"
	assignment = "Cuppa Joe's - Waitress"
	skills = /datum/skills/hybrisa_event/cuppa/waitress
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CUPPA, ACCESS_HYBRISA_MAINTS)


/datum/equipment_preset/hybrisa_event/cuppa_waitress/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/cuppa_joes(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/regular/hipster(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/cuppa_manager
	name = "Hybrisa - Cuppa Joe's - Manager"
	assignment = "Cuppa Joe's - Manager"
	skills = /datum/skills/hybrisa_event/cuppa/manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CUPPA, ACCESS_HYBRISA_MAINTS)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/cuppa_manager/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/cuppa_joes(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/lawyer/redjacket(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/cuppa_barista
	name = "Hybrisa - Cuppa Joe's - Barista"
	assignment = "Cuppa Joe's - Barista"
	skills = /datum/skills/hybrisa_event/cuppa/barista
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CUPPA, ACCESS_HYBRISA_MAINTS)


/datum/equipment_preset/hybrisa_event/cuppa_barista/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/cuppa_joes(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/apron/cuppa_joes(new_human), WEAR_JACKET)

	..()

////////////////////////////////////////////////////
/////////////// NIGHT GOLD CASINO //////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/ngc_manager
	name = "Hybrisa - Night Gold Casino - Manager"
	assignment = "Night Gold Casino - Manager"
	skills = /datum/skills/hybrisa_event/ngc/manager
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CASINO_GENERAL, ACCESS_HYBRISA_CASINO_BAR, ACCESS_HYBRISA_CASINO_MANAGER)
	idtype = /obj/item/card/id/souto


/datum/equipment_preset/hybrisa_event/ngc_manager/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/brown/jacket(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/lawyer/brown(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette/cigar/cohiba(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/fake/yellow(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cowboy(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/ngc_bouncer1
	name = "Hybrisa - Night Gold Casino - Bouncer1"
	assignment = "Night Gold Casino - Bouncer"
	skills = /datum/skills/hybrisa_event/ngc/goon
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CASINO_GENERAL, ACCESS_HYBRISA_CASINO_BAR)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/ngc_bouncer1/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/UPP/army/alt(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/upp(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/keffiyeh/green(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/butterfly(new_human), WEAR_IN_BACK)

	..()

/datum/equipment_preset/hybrisa_event/ngc_bouncer2
	name = "Hybrisa - Night Gold Casino - Bouncer2"
	assignment = "Night Gold Casino - Bouncer"
	skills = /datum/skills/hybrisa_event/ngc/goon
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CASINO_GENERAL, ACCESS_HYBRISA_CASINO_BAR)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/ngc_bouncer2/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/tshirt/gray_blu(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/boonie(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/butterfly/switchblade(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/new_bimex/black(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/ngc_bartender
	name = "Hybrisa - Night Gold Casino - Bartender"
	assignment = "Night Gold Casino - Bartender"
	skills = /datum/skills/hybrisa_event/ngc/bartender
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_CASINO_GENERAL, ACCESS_HYBRISA_CASINO_BAR)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/ngc_bartender/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/detective/grey(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/bowlerhat(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baseballbat(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/wcoat(new_human), WEAR_JACKET)
	..()

////////////////////////////////////////////////////
////////////////// NOVA MEDICA /////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/nm_emt1
	name = "Hybrisa - Nova Medica - Emergency Medical Technician1"
	assignment = "Nova Medica - Emergency Medical Technician"
	skills = /datum/skills/hybrisa_event/novamedica/emt
	paygrades = list(PAY_SHORT_CPARA = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_emt1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_emt1/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/paramedic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/hybrisa/EMT_green_utility(new_human), WEAR_JACKET)
	..()

/datum/equipment_preset/hybrisa_event/nm_emt2
	name = "Hybrisa - Nova Medica - Emergency Medical Technician2"
	assignment = "Nova Medica - Emergency Medical Technician"
	skills = /datum/skills/hybrisa_event/novamedica/emt
	paygrades = list(PAY_SHORT_CPARA = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_emt2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_emt2/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/hybrisa/paramedic/red(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/hybrisa/EMT_red_utility(new_human), WEAR_JACKET)
	..()

/datum/equipment_preset/hybrisa_event/nm_nurse1
	name = "Hybrisa - Nova Medica - Nurse1"
	assignment = "Nova Medica - Nurse"
	skills = /datum/skills/hybrisa_event/novamedica/nurse
	paygrades = list(PAY_SHORT_CNUR = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_nurse1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_nurse1/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/purple(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/purple(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical(new_human), WEAR_WAIST)
	..()

/datum/equipment_preset/hybrisa_event/nm_nurse2
	name = "Hybrisa - Nova Medica - Nurse2"
	assignment = "Nova Medica - Nurse"
	skills = /datum/skills/hybrisa_event/novamedica/nurse
	paygrades = list(PAY_SHORT_CNUR = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_nurse2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_nurse2/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/green(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/green(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical(new_human), WEAR_WAIST)
	..()

/datum/equipment_preset/hybrisa_event/nm_firefighter
	name = "Hybrisa - Nova Medica - Fire Protection Specialist"
	assignment = "Nova Medica - Fire Protection Specialist"
	skills = /datum/skills/hybrisa_event/novamedica/firefighter
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_NOVAMEDICA_GENERAL, ACCESS_HYBRISA_NOVAMEDICA_TOWER)
	idtype = /obj/item/card/id/data

/datum/job/generate_money_account(mob/living/carbon/human/account_user)
	var/generated_account = generate_money_account(account_user)
	addtimer(CALLBACK(src, PROC_REF(announce_entry_message), account_user, generated_account), 2 SECONDS)
	return

/datum/equipment_preset/hybrisa_event/nm_firefighter/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility/gray(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/urban(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/insulated/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/twohanded/fireaxe(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/hybrisa/firefighter(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/pyro(new_human), WEAR_WAIST)

	..()

/datum/equipment_preset/hybrisa_event/nm_doctor1
	name = "Hybrisa - Nova Medica - Medical Doctor1"
	assignment = "Nova Medica - Medical Doctor"
	skills = /datum/skills/hybrisa_event/novamedica/doctor
	paygrades = list(PAY_SHORT_CDOC = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_doctor1/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_doctor1/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/blue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/blue(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nm_doctor2
	name = "Hybrisa - Nova Medica - Medical Doctor2"
	assignment = "Nova Medica - Medical Doctor"
	skills = /datum/skills/hybrisa_event/novamedica/doctor
	paygrades = list(PAY_SHORT_CDOC = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_doctor2/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_doctor2/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nm_coroner
	name = "Hybrisa - Nova Medica - Coroner"
	assignment = "Nova Medica - Coroner"
	skills = /datum/skills/hybrisa_event/novamedica/coroner
	paygrades = list(PAY_SHORT_CDOC = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_coroner/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_coroner/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/long(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nm_virologist
	name = "Hybrisa - Nova Medica - Virologist"
	assignment = "Nova Medica - Virologist"
	skills = /datum/skills/hybrisa_event/novamedica/virologist
	paygrades = list(PAY_SHORT_CCMOC = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_virologist/New()
	. = ..()
	access = list(ACCESS_HYBRISA_NOVAMEDICA_VIROLOGY) + get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_virologist/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/virologist(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/vir(new_human), WEAR_BACK)

	..()

/datum/equipment_preset/hybrisa_event/nm_dispatcher
	name = "Hybrisa - Nova Medica - Dispatcher"
	assignment = "Nova Medica - Dispatcher"
	skills = /datum/skills/hybrisa_event/novamedica/dispatcher
	paygrades = list(PAY_SHORT_OPR = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_dispatcher/New()
	. = ..()
	access = get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_dispatcher/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/olive(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/sensor(new_human), WEAR_EYES)

	..()

/datum/equipment_preset/hybrisa_event/nm_cmo
	name = "Hybrisa - Nova Medica - Chief Medical Officer"
	assignment = "Nova Medica - Chief Medical Officer"
	skills = /datum/skills/hybrisa_event/novamedica/cmo
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/hybrisa_event/nm_cmo/New()
	. = ..()
	access = list(ACCESS_HYBRISA_NOVAMEDICA_VIROLOGY, ACCESS_HYBRISA_NOVAMEDICA_CMO) + get_access(ACCESS_LIST_HYBRISA_MEDICA)

/datum/equipment_preset/hybrisa_event/nm_cmo/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/cmo(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/cmo(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmo(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/med(new_human), WEAR_BACK)

	..()

////////////////////////////////////////////////////
//////////////// JACK'S SURPLUS ////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/jack
	name = "Hybrisa - Jack's Surplus - Jack"
	assignment = "Jack's Surplus - Owner"
	skills = /datum/skills/hybrisa_event/surplus/jack
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_JACK)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/jack/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket/burgundy(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/lawyer/blackjacket(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/monocle(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/collectable/tophat(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/jack_assistant
	name = "Hybrisa - Jack's Surplus - Employee"
	assignment = "Jack's Surplus - Employee"
	skills = /datum/skills/hybrisa_event/surplus/jacks_assistant
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_JACK)


/datum/equipment_preset/hybrisa_event/jack_assistant/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/pink(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)

	..()

////////////////////////////////////////////////////
////////////////// INDEPENDENT /////////////////////
////////////////////////////////////////////////////

/datum/equipment_preset/hybrisa_event/iasf_veteran
	name = "Hybrisa - Independent - IASF Veteran"
	assignment = "IASF - Itto Kaii"
	skills = /datum/skills/hybrisa_event/iasf_veteran
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = /obj/item/card/id/dogtag


/datum/equipment_preset/hybrisa_event/iasf_veteran/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/royal_marine/iasf(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress/rmc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/alt(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/brown(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/iasf_commander_cap(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/cr_veteran
	name = "Hybrisa - Independent - FORECON Veteran"
	assignment = "FORECON - Staff Sergeant"
	skills = /datum/skills/hybrisa_event/forecon_veteran
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = /obj/item/card/id/dogtag


/datum/equipment_preset/hybrisa_event/cr_veteran/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/reconnaissance(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/black(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing/brown(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e6(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/black_vest(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/jungle(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/helmet_gasmask(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/helmet_nvg(new_human), WEAR_IN_HELMET)

	..()

/datum/equipment_preset/hybrisa_event/reporter
	name = "Hybrisa - Independent - Reporter"
	assignment = "Daily Bagels Hybrisa - Reporter"
	skills = /datum/skills/hybrisa_event/reporter
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)


/datum/equipment_preset/hybrisa_event/reporter/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/reporter/black(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/grey(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/broadcasting(new_human), WEAR_R_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera/oldcamera(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/camera_film(new_human), WEAR_IN_BACK)

	..()

/datum/equipment_preset/hybrisa_event/hobo_hoarder
	name = "Hybrisa - Hobo - Hoarder"
	assignment = "Access"
	skills = /datum/skills/hybrisa_event/hobo/hoarder
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = null


/datum/equipment_preset/hybrisa_event/hobo_hoarder/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/steward(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/foil(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas(new_human), WEAR_FACE)

	..()

/datum/equipment_preset/hybrisa_event/hobo_brawler
	name = "Hybrisa - Hobo - Brawler"
	assignment = "Access"
	skills = /datum/skills/hybrisa_event/hobo/brawler
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = null


/datum/equipment_preset/hybrisa_event/hobo_brawler/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/shorts/black(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/welding/painted(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/poncho/green(new_human), WEAR_JACKET)

	..()

/datum/equipment_preset/hybrisa_event/hobo_escapist
	name = "Hybrisa - Hobo - Escapist"
	assignment = "Access"
	skills = /datum/skills/hybrisa_event/hobo/escapist
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)
	idtype = null


/datum/equipment_preset/hybrisa_event/hobo_escapist/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/color/escaped_prisoner_colony(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/carp_cook
	name = "Hybrisa - Independent - Cook"
	assignment = "Carpe Carp - Cook"
	skills = /datum/skills/hybrisa_event/cook
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_BAR_KITCHEN, ACCESS_HYBRISA_ENTERTAIMENT)


/datum/equipment_preset/hybrisa_event/carp_cook/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/chef(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/chef/classic/stain(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmbandana/tan(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/carp_bartender
	name = "Hybrisa - Independent - Bartender"
	assignment = "Carpe Carp - Bartender"
	skills = /datum/skills/hybrisa_event/bartender
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_BAR_KITCHEN, ACCESS_HYBRISA_ENTERTAIMENT)


/datum/equipment_preset/hybrisa_event/carp_bartender/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/waiter(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/bowlerhat(new_human), WEAR_HEAD)

	..()

/datum/equipment_preset/hybrisa_event/grandhotel
	name = "Hybrisa - Independent - Hotel Administrator"
	assignment = "Grand Prospera Hotel - Administrator"
	skills = /datum/skills/hybrisa_event/hotel_admin
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_HYBRISA_HOTEL)
	idtype = /obj/item/card/id/data


/datum/equipment_preset/hybrisa_event/grandhotel/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/field(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)

	..()

/datum/equipment_preset/hybrisa_event/civilian
	name = "Hybrisa - Independent - Civilian"
	assignment = "Civilian"
	skills = /datum/skills/hybrisa_event/civilian
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(ACCESS_CIVILIAN_PUBLIC)


/datum/equipment_preset/hybrisa_event/civilian/load_gear(mob/living/carbon/human/new_human)

	var/random_gear = rand(1,10)
	switch(random_gear)
		if(1) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/soft/grey(new_human), WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_blue(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/khaki(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack(new_human), WEAR_BACK)
		if(2) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_brown(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/pink(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/industrial(new_human), WEAR_BACK)
		if(3) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_green(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/green(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
		if(4) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_brown(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/green(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
		if(5) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_blue(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
		if(6) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_red(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
		if(7) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/soft/ferret(new_human), WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber/grey(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/khaki(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
		if(8) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear/pink(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
		if(9) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/soft/trucker/red(new_human), WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber/red(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/workwear(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
		if(10) // Colonist
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/royal_marine(new_human), WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/bomber/alt(new_human), WEAR_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/steward(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack(new_human), WEAR_BACK)

	..()
