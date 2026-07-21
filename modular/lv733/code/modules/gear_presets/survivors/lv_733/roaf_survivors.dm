/// LV-733 - ROAF survivors.

/datum/equipment_preset/survivor/roaf
	name = "Survivor - ROAF Paratrooper"
	assignment = "ROAF - Paratrooper"
	job_title = JOB_TWE_RAF_RIFLEMAN
	paygrades = list(PAY_SHORT_ROAFE1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_rifleman
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	origin_override = ORIGIN_TWE
	minimap_icon = "roaf_rifleman"
	minimap_background = "background_roaf"
	role_comm_title = "Авт."
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_EXTRA
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
		ACCESS_CIVILIAN_BRIG,
		ACCESS_CIVILIAN_MEDBAY,
		ACCESS_CIVILIAN_COMMAND,
	)

/datum/equipment_preset/survivor/roaf/proc/equip_common_gear(mob/living/carbon/human/new_human, uniform_type, head_type, suit_type, back_type, belt_type, left_pouch_type, right_pouch_type, eyes_type = null, shoes_type = /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf, add_patch = TRUE)
	new_human.equip_to_slot_or_del(new uniform_type(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new shoes_type(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	if(head_type)
		new_human.equip_to_slot_or_del(new head_type(new_human), WEAR_HEAD)
	if(eyes_type)
		new_human.equip_to_slot_or_del(new eyes_type(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new suit_type(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	if(add_patch)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/twe(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new belt_type(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new back_type(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new left_pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new right_pouch_type(new_human), WEAR_R_STORE)

/datum/equipment_preset/survivor/roaf/proc/equip_standard_backpack_contents(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/brown(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/survivor/roaf/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_uniform,
		/obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/sunglasses/aviator,
	)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_BACK)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/roaf/engi
	name = "Survivor - ROAF Combat Engineer"
	assignment = "ROAF - Combat Engineer"
	job_title = JOB_TWE_RAF_ENGI
	paygrades = list(PAY_SHORT_ROAFE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_engi
	minimap_icon = "roaf_engi"
	role_comm_title = "Инж."

/datum/equipment_preset/survivor/roaf/engi/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_support,
		/obj/item/clothing/head/beret/lv733/roaf_boonie,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/welding,
	)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/roaf/medic
	name = "Survivor - ROAF Combat Medical Technician"
	assignment = "ROAF - Combat Medical Technician"
	job_title = JOB_TWE_ROAF_MEDIC
	paygrades = list(PAY_SHORT_ROAFE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_medic
	minimap_icon = "roaf_medic"
	role_comm_title = "Мед."

/datum/equipment_preset/survivor/roaf/medic/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_support,
		/obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf,
		/obj/item/storage/backpack/rmc/medium/medic,
		/obj/item/storage/belt/medical/full/with_defib_and_analyzer,
		/obj/item/storage/pouch/medkit/full_rmc,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/hud/health,
	)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_BACK)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/roaf/pilot
	name = "Survivor - ROAF Pilot"
	assignment = "ROAF - Pilot"
	job_title = JOB_TWE_ROAF_PILOT
	paygrades = list(PAY_SHORT_ROAFO1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_pilot
	minimap_icon = "roaf_pilot"
	role_comm_title = "Пилот"

/datum/equipment_preset/survivor/roaf/pilot/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_pilot,
		/obj/item/clothing/head/beret/lv733/roaf_pilot_hat,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_pilot,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/belt/gun/iasf_para_belt/webley_near_empty,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/flare,
		/obj/item/clothing/glasses/sunglasses/aviator,
		/obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf_pilot,
	)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/roaf/signaller
	name = "Survivor - ROAF Signaller"
	assignment = JOB_TWE_ROAF_SIGNALLER
	job_title = JOB_TWE_ROAF_SIGNALLER
	paygrades = list(PAY_SHORT_ROAFE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_signaller
	minimap_icon = "roaf_signaller"
	role_comm_title = "Радиоразведчик"

/datum/equipment_preset/survivor/roaf/signaller/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_signaller,
		/obj/item/clothing/head/beret/lv733/roaf_boonie,
		/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf,
		/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
	)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator/silver(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/scope(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/survivor/roaf/squad_leader
	name = "Survivor - ROAF Squad Leader"
	assignment = "ROAF - Squad Leader"
	job_title = JOB_TWE_RAF_SQUAD_LEADER
	paygrades = list(PAY_SHORT_ROAFO2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_leader
	minimap_icon = "roaf_sl"
	role_comm_title = "Л-т."

/datum/equipment_preset/survivor/roaf/squad_leader/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_officer,
		/obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret,
		/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
	)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator/silver(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/synth/survivor/roaf_synth
	name = "Survivor - ROAF Support Synthetic"
	assignment = "ROAF - Support Synthetic"
	job_title = JOB_TWE_ROAF_SYNTH
	paygrades = list(PAY_SHORT_ROAFS1 = JOB_PLAYTIME_TIER_0)
	languages = ALL_SYNTH_LANGUAGES
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	origin_override = ORIGIN_TWE
	minimap_icon = "synth"
	minimap_background = "background_roaf"
	role_comm_title = "Синт."
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_EXTRA
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
		ACCESS_CIVILIAN_BRIG,
		ACCESS_CIVILIAN_MEDBAY,
		ACCESS_CIVILIAN_COMMAND,
	)

/datum/equipment_preset/synth/survivor/roaf_synth/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_shooter(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/lv733/roaf_shooter_helmet(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_shooter(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/twe(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/survivor(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/synth/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/roller(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/synthetic(new_human.back), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/whitchler/roaf_commander
	name = "Survivor - ROAF Commander"
	assignment = "ROAF - Commander"
	job_title = JOB_TWE_ROAF_COMMANDER
	paygrades = list(PAY_SHORT_ROAFO3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/roaf_lieutenant
	faction = FACTION_ROAF
	faction_group = FACTION_LIST_SURVIVOR_ROAF
	minimap_icon = "roaf_co"
	minimap_background = "background_roaf"
	role_comm_title = "Коммандер"
	idtype = /obj/item/card/id/gold
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
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/lv733/roaf_pilot_hat(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/lv733/suit_roaf_CO(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/tie/black(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/iasf_para_belt/custom/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/multicolor/fountain(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/brown(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(new_human.back), WEAR_IN_BACK)
