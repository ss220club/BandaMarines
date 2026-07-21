/datum/equipment_preset/survivor/clf_wy
	name = "CLF-WP Rebel"
	assignment = "CLF-WP - Rebel"
	job_title = JOB_CLF_WY_REBEL
	paygrades = list(PAY_SHORT_CLFWYE1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/clf_wy_rebel
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	faction = FACTION_CLF_WY
	faction_group = FACTION_LIST_SURVIVOR_CLF_WY
	origin_override = ORIGIN_CIVILIAN
	minimap_icon = "rifleman"
	minimap_background = "leader"
	role_comm_title = "Повст."
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

/datum/equipment_preset/survivor/clf_wy/proc/equip_common_gear(mob/living/carbon/human/new_human, uniform_type, head_type, suit_type, back_type, belt_type, left_pouch_type, right_pouch_type, eyes_type = null, shoes_type = null)
	new_human.equip_to_slot_or_del(new uniform_type(new_human), WEAR_BODY)
	if(shoes_type)
		new_human.equip_to_slot_or_del(new shoes_type(new_human), WEAR_FEET)
	else
		spawn_rebel_shoes(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	if(head_type)
		new_human.equip_to_slot_or_del(new head_type(new_human), WEAR_HEAD)
	if(eyes_type)
		new_human.equip_to_slot_or_del(new eyes_type(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/clf_wy(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new suit_type(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/black(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new belt_type(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new back_type(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new left_pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new right_pouch_type(new_human), WEAR_R_STORE)

/datum/equipment_preset/survivor/clf_wy/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/clf_wy/regular,
		/obj/item/clothing/head/helmet/marine/veteran/clf_wy/regular_helmet,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/raincover,
		/obj/item/storage/backpack/lightpack,
		/obj/item/storage/belt/shotgun/full/random,
		/obj/item/device/flashlight,
		/obj/item/storage/pouch/firstaid/ert,
	)
	spawn_rebel_rifle(new_human, 2)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/clf_wy/engi
	name = "CLF-WP Engineer"
	assignment = "CLF-WP - Engineer"
	job_title = JOB_CLF_WY_ENGI
	paygrades = list(PAY_SHORT_CLFWYE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/clf_wy_engi
	minimap_icon = "engi"
	role_comm_title = "Инж."

/datum/equipment_preset/survivor/clf_wy/engi/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/clf_wy/support,
		/obj/item/clothing/head/helmet/marine/veteran/clf_wy/regular_helmet,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/raincover,
		/obj/item/storage/backpack/marine/engineerpack/ert,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/pouch/construction/low_grade_full,
		/obj/item/storage/pouch/firstaid/ert,
		/obj/item/clothing/glasses/welding,
	)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack(new_human.back), WEAR_IN_BACK)
	spawn_rebel_rifle(new_human, 2)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/clf_wy/medic
	name = "CLF-WP Medic"
	assignment = "CLF-WP - Medic"
	job_title = JOB_CLF_WY_MEDIC
	paygrades = list(PAY_SHORT_CLFWYE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/clf_wy_medic
	minimap_icon = "medic"
	role_comm_title = "Мед."

/datum/equipment_preset/survivor/clf_wy/medic/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/clf_wy/support,
		/obj/item/clothing/head/helmet/marine/veteran/clf_wy/regular_helmet,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/raincover,
		/obj/item/storage/backpack/lightpack,
		/obj/item/storage/belt/medical/full/with_defib_and_analyzer,
		/obj/item/device/flashlight,
		/obj/item/storage/pouch/magazine/large,
		/obj/item/clothing/glasses/hud/health,
	)
	spawn_rebel_rifle(new_human, 2)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/clf_wy/leader
	name = "CLF-WP Cell Leader"
	assignment = "CLF-WP - Cell Leader"
	job_title = JOB_CLF_WY_LEADER
	paygrades = list(PAY_SHORT_CLFWYO1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/clf_wy_leader
	minimap_icon = "leader"
	role_comm_title = "Л-р."

/datum/equipment_preset/survivor/clf_wy/leader/load_gear(mob/living/carbon/human/new_human)
	equip_common_gear(
		new_human,
		/obj/item/clothing/under/marine/veteran/clf_wy/officer,
		/obj/item/clothing/head/helmet/marine/veteran/clf_wy/officer_helmet,
		/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/officer_armor,
		/obj/item/storage/backpack/lightpack,
		/obj/item/storage/belt/marine,
		/obj/item/device/flashlight,
		/obj/item/storage/pouch/firstaid/ert,
		/obj/item/clothing/glasses/sunglasses/aviator/silver,
		/obj/item/clothing/shoes/combat,
	)
	spawn_rebel_rifle(new_human, 2)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

/datum/equipment_preset/synth/survivor/clf_wy_synth
	name = "CLF-WP Synthetic"
	assignment = "CLF-WP - Synthetic"
	job_title = JOB_CLF_WY_SYNTH
	paygrades = list(PAY_SHORT_CLFWYS1 = JOB_PLAYTIME_TIER_0)
	languages = ALL_SYNTH_LANGUAGES
	faction = FACTION_CLF_WY
	faction_group = FACTION_LIST_SURVIVOR_CLF_WY
	origin_override = ORIGIN_CIVILIAN
	minimap_icon = "synth"
	minimap_background = "leader"
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

/datum/equipment_preset/synth/survivor/clf_wy_synth/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/clf_wy/regular(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/clf_wy/regular_helmet(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/clf_wy(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/raincover(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/black(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/survivor(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/synth/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/synthetic(new_human.back), WEAR_IN_JACKET)

/datum/equipment_preset/survivor/whitchler/clf_wy_curator
	name = "CLF-WP Curator"
	assignment = "CLF-WP - Curator"
	job_title = JOB_CLF_WY_CURATOR
	paygrades = list(PAY_SHORT_CLFWYO2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/survivor/clf_wy_curator
	faction = FACTION_CLF_WY
	faction_group = FACTION_LIST_SURVIVOR_CLF_WY
	origin_override = ORIGIN_CIVILIAN
	minimap_icon = "co"
	minimap_background = "leader"
	role_comm_title = "Куратор"
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

/datum/equipment_preset/survivor/whitchler/clf_wy_curator/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/clf_wy/officer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/clf_wy/officer_helmet(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/clf_wy(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/officer_armor(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/black(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/dragon_katana/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/multicolor/fountain(new_human), WEAR_IN_R_STORE)
