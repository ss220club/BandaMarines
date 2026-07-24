/// LV-733 - RAC (Royal Armored Cavalry) survivors.

/datum/equipment_preset/survivor/rac
	name = "Survivor - RAC Rifleman"
	assignment = "RAC - Rifleman"
	job_title = JOB_TWE_RAC_RIFLEMAN
	paygrades = list(PAY_SHORT_RACE1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_rifleman
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	faction = FACTION_RAC
	faction_group = FACTION_LIST_SURVIVOR_RAC
	origin_override = ORIGIN_TWE
	minimap_icon = "roaf_rifleman"
	minimap_background = "background_roaf"
	role_comm_title = "Ряд."
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

/datum/equipment_preset/survivor/rac/proc/equip_common_gear(mob/living/carbon/human/new_human, uniform_type, head_type, suit_type, back_type, belt_type, left_pouch_type, right_pouch_type, eyes_type = null, shoes_type = /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf, add_patch = TRUE, add_helmet_cover = FALSE)
	new_human.equip_to_slot_or_del(new uniform_type(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new shoes_type(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	if(head_type)
		var/obj/item/clothing/head/new_head = new head_type(new_human)
		if(new_human.equip_to_slot_or_del(new_head, WEAR_HEAD) && add_helmet_cover)
			new_head.attach_accessory(null, new /obj/item/clothing/accessory/helmet/cover/rac, TRUE)
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

/datum/equipment_preset/survivor/rac/proc/equip_standard_backpack_contents(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/brown(new_human.back), WEAR_IN_BACK)

/proc/rac_equip_poncho(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/poncho/rac(new_human.back), WEAR_IN_BACK)

/obj/item/clothing/accessory/storage/holster/rac
	worn_accessory_limit = 2

/proc/rac_equip_sidearm(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/rac(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	for(var/i in 1 to 3)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_ACCESSORY)

/datum/equipment_preset/survivor/rac/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_regular,
		/obj/item/clothing/head/helmet/marine/veteran/royal_marine/generic,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/sunglasses/aviator,
		add_helmet_cover = TRUE,
	)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l86_m1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l86_m1(new_human), WEAR_IN_BACK)
	rac_equip_poncho(new_human)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/rac/driver
	name = "Survivor - RAC Tank Driver"
	assignment = "RAC - Tank Driver"
	job_title = JOB_TWE_RAC_DRIVER
	paygrades = list(PAY_SHORT_RACE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_driver
	minimap_icon = "roaf_pilot"
	role_comm_title = "Мех."

/datum/equipment_preset/survivor/rac/driver/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_tanker,
		/obj/item/clothing/head/helmet/marine/veteran/lv733/rac_beret,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_jacket,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
	)
	rac_equip_sidearm(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/rac/engi
	name = "Survivor - RAC Combat Engineer"
	assignment = "RAC - Combat Engineer"
	job_title = JOB_TWE_RAC_ENGI
	paygrades = list(PAY_SHORT_RACE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_engi
	minimap_icon = "roaf_engi"
	role_comm_title = "Инж."

/datum/equipment_preset/survivor/rac/engi/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_technician,
		/obj/item/clothing/head/beanie/royal_marine,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/welding,
	)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l86_m1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l86_m1(new_human), WEAR_IN_JACKET)
	rac_equip_poncho(new_human)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/rac/medic
	name = "Survivor - RAC Motorized Medic"
	assignment = "RAC - Motorized Medic"
	job_title = JOB_TWE_RAC_MEDIC
	paygrades = list(PAY_SHORT_RACE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_medic
	minimap_icon = "roaf_medic"
	role_comm_title = "Мед."

/datum/equipment_preset/survivor/rac/medic/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_regular,
		/obj/item/clothing/head/helmet/marine/veteran/royal_marine/generic,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/medic,
		/obj/item/storage/backpack/rmc/medium/medic,
		/obj/item/storage/belt/medical/full/with_defib_and_analyzer,
		/obj/item/storage/pouch/medkit/full_rmc,
		/obj/item/storage/pouch/survival/full,
		/obj/item/clothing/glasses/hud/health,
		add_helmet_cover = TRUE,
	)
	rac_equip_sidearm(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	rac_equip_poncho(new_human)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/survivor/rac/squad_leader
	name = "Survivor - RAC Tank Commander"
	assignment = "RAC - Tank Commander"
	job_title = JOB_TWE_RAC_SQUAD_LEADER
	paygrades = list(PAY_SHORT_RACO1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_leader
	minimap_icon = "roaf_sl"
	role_comm_title = "К-р танка"

/datum/equipment_preset/survivor/rac/squad_leader/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_tanker,
		/obj/item/clothing/head/helmet/marine/veteran/lv733/rac_beret,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_jacket,
		/obj/item/storage/backpack/lightpack/five_slot,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/pouch/firstaid/full/alternate,
		/obj/item/storage/pouch/survival/full,
	)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator/silver(new_human), WEAR_EYES)
	rac_equip_sidearm(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	equip_standard_backpack_contents(new_human)

/datum/equipment_preset/synth/survivor/rac_synth
	name = "Survivor - RAC Tank Technician Synthetic"
	assignment = "RAC - Tank Technician Synthetic"
	job_title = JOB_TWE_RAC_SYNTH
	paygrades = list(PAY_SHORT_RACS1 = JOB_PLAYTIME_TIER_0)
	languages = ALL_SYNTH_LANGUAGES
	faction = FACTION_RAC
	faction_group = FACTION_LIST_SURVIVOR_RAC
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

/datum/equipment_preset/synth/survivor/rac_synth/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_technician(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/royal_marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/twe(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/survivor(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/synth/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)
	rac_equip_sidearm(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/roller(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/synthetic(new_human.back), WEAR_IN_JACKET)
	rac_equip_poncho(new_human)

/datum/equipment_preset/survivor/whitchler/rac_commander
	name = "Survivor - RAC Platoon Commander"
	assignment = "RAC - Platoon Commander"
	job_title = JOB_TWE_RAC_COMMANDER
	paygrades = list(PAY_SHORT_RACO2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/rac_lieutenant
	faction = FACTION_RAC
	faction_group = FACTION_LIST_SURVIVOR_RAC
	minimap_icon = "roaf_co"
	minimap_background = "background_roaf"
	role_comm_title = "К-р звена"
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

/datum/equipment_preset/survivor/whitchler/rac_commander/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_tanker(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/lv733/rac_beret(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_jacket(new_human), WEAR_JACKET)
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
	rac_equip_sidearm(new_human)
	rac_equip_poncho(new_human)
