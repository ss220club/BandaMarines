/// LV-733 - ROAF survivors.

/datum/equipment_preset/survivor/roaf
	name = "Survivor - ROAF"
	paygrades = list(PAY_SHORT_ROAFE3 = JOB_PLAYTIME_TIER_0)
	job_title = JOB_TWE_RAF_RIFLEMAN
	assignment = "ROAF - Rifleman"
	skills = /datum/skills/survivor/roaf_rifleman
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	origin_override = ORIGIN_TWE
	minimap_icon = "rifleman"
	minimap_background = "background_roaf"
	role_comm_title = "24/ROAF"
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_EXTRA
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
	)

/datum/equipment_preset/survivor/roaf/proc/equip_common_gear(mob/living/carbon/human/new_human, equip_backpack = TRUE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/iasf_para_belt/webley_near_empty(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	if(equip_backpack)
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(new_human.back), WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/device/radio(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/twe(new_human), WEAR_ACCESSORY)

/datum/equipment_preset/survivor/roaf/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_uniform(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/roaf/paratrooper
	name = "Survivor - ROAF Paratrooper"
	paygrades = list(PAY_SHORT_ROAFE3 = JOB_PLAYTIME_TIER_0)
	assignment = "ROAF - Paratrooper"
	job_title = JOB_TWE_RAF_RIFLEMAN
	skills = /datum/skills/survivor/roaf_rifleman

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/roaf/engi
	name = "Survivor - ROAF Combat Engineer"
	paygrades = list(PAY_SHORT_ROAFE4 = JOB_PLAYTIME_TIER_0)
	assignment = "ROAF - Combat Engineer"
	job_title = JOB_TWE_RAF_ENGI
	minimap_icon = "engi"
	skills = /datum/skills/survivor/roaf_engi

/datum/equipment_preset/survivor/roaf/engi/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/lv733/roaf_boonie(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_support(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/planted_flag/roaf(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/roaf/medic
	name = "Survivor - ROAF Combat Medical Technician"
	paygrades = list(PAY_SHORT_ROAFE4 = JOB_PLAYTIME_TIER_0)
	assignment = "ROAF - Combat Medical Technician"
	job_title = JOB_TWE_ROAF_MEDIC
	minimap_icon = "medic"
	skills = /datum/skills/survivor/roaf_medic

/datum/equipment_preset/survivor/roaf/medic/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_support(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/survivor(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/p90/twe(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(new_human.back), WEAR_IN_BACK)


///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/roaf/pilot
	name = "Survivor - ROAF Pilot"
	assignment = "ROAF - Pilot"
	job_title = JOB_TWE_ROAF_PILOT
	minimap_icon = "pilot"
	paygrades = list(PAY_SHORT_ROAFE4 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_pilot

/datum/equipment_preset/survivor/roaf/pilot/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/lv733/roaf_pilot_hat(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_pilot(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_pilot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/p90/twe(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/p90/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf_pilot(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/roaf/sniper
	name = "Survivor - ROAF Sniper"
	assignment = JOB_TWE_ROAF_SNIPER
	job_title = JOB_TWE_ROAF_SNIPER
	minimap_icon = "sniper"
	skills = /datum/skills/survivor/roaf_sniper

/datum/equipment_preset/survivor/roaf/sniper/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(new_human, FALSE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_sniper(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/lv733/roaf_boonie(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/scope(new_human), WEAR_J_STORE)

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/roaf/squad_leader
	name = "Survivor - ROAF Squad Leader"
	paygrades = list(PAY_SHORT_ROAFE4 = JOB_PLAYTIME_TIER_0)
	assignment = "ROAF - Squad Leader"
	job_title = JOB_TWE_RAF_SQUAD_LEADER
	minimap_icon = "sl"
	role_comm_title = "24/ROAF SL"
	skills = /datum/skills/survivor/roaf_leader

/datum/equipment_preset/survivor/roaf/squad_leader/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/lv733/suit_roaf_CO(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/synth/survivor/roaf_synth
	name = "Survivor - ROAF Support Synthetic"
	assignment = "ROAF - Support Synthetic"
	flags = EQUIPMENT_PRESET_EXTRA
	languages = ALL_SYNTH_LANGUAGES
	job_title = JOB_TWE_ROAF_SYNTH
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	origin_override = ORIGIN_TWE
	paygrades = list(PAY_SHORT_SYN = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag
	role_comm_title = "24/ROAF Syn"
	minimap_background = "background_roaf"
	minimap_icon = "synth"

/datum/equipment_preset/synth/survivor/roaf_synth/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_shooter(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/pilot/lv733/roaf_shooter_helmet(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_shooter(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/synthetic(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/survivor(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/twe(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/synth/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)

///////////////////////////////////////////////////////////////////

/datum/equipment_preset/survivor/whitchler/roaf_commander
	name = "Survivor - ROAF Commander"
	assignment = "ROAF - Commander"
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	skills = /datum/skills/survivor/roaf_lieutenant
	paygrades = list(PAY_SHORT_ROAFO5 = JOB_PLAYTIME_TIER_0)
	job_title = JOB_TWE_ROAF_COMMANDER
	minimap_icon = "co"
	minimap_background = "background_roaf"
	idtype = /obj/item/card/id/gold
	role_comm_title = "ROAF CDR"
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
		ACCESS_CIVILIAN_BRIG,
		ACCESS_CIVILIAN_MEDBAY,
		ACCESS_CIVILIAN_COMMAND,
	)

/datum/equipment_preset/survivor/whitchler/roaf_commander/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/tie/black(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/brown(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/lv733/suit_roaf_CO(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/multicolor/fountain(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/lv733/roaf_pilot_hat(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/iasf_para_belt/custom/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
