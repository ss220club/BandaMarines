/datum/equipment_preset/uscm/imperial_guard
	assignment = JOB_SQUAD_MARINE
	job_title = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag
	role_comm_title = "Imperial Guard"
	faction_group = list(FACTION_MARINE)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	auto_squad_name = SQUAD_FORECON
	ert_squad = TRUE

/datum/equipment_preset/uscm/imperial_guard/New()
	. = ..()
	access = get_access(ACCESS_LIST_UA)

	dress_shoes = list(/obj/item/clothing/shoes/dress)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/uscm/imperial_guard/proc/add_imperial_weapon(mob/living/carbon/human/new_human)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1 , 2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lasgun(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun/extended(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun/extended(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun(new_human), WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/bolter(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_BACK)

// /datum/equipment_preset/uscm/imperial_guard/proc/spawn_random_headgear(mob/living/carbon/human/new_human)
// 	var/i = rand(1,10)
// 	switch(i)
// 		if (1 , 2)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
// 		if (3 , 4)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie(new_human), WEAR_HEAD)
// 		if (5 , 6)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/durag(new_human), WEAR_HEAD)
// 		if (7 , 8)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/boonie(new_human), WEAR_HEAD)
// 		if (9)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)

// /datum/equipment_preset/uscm/imperial_guard/proc/spawn_random_tech_headgear(mob/living/carbon/human/new_human)
// 	var/i = rand(1,4)
// 	switch(i)
// 		if (1 , 2)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/tech(new_human), WEAR_HEAD)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
// 		if (3 , 4)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic/white(new_human), WEAR_HEAD)
// 			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)

// /datum/equipment_preset/uscm/imperial_guard/proc/add_forecon_weapon_pistol(mob/living/carbon/human/new_human)
// 	var/random_pistol = rand(1,5)
// 	switch(random_pistol)
// 		if(1 , 2)
// 			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3(new_human), WEAR_WAIST)
// 			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
// 		if(3 , 4)
// 			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m39/full/extended, WEAR_WAIST)
// 		if(5)
// 			new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector(new_human),WEAR_WAIST)

// /datum/equipment_preset/uscm/forecon/load_status(mob/living/carbon/human/new_human)
// 	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/imperial_guard/standard
	name = "Imperial Guard trooper"
	assignment = JOB_FORECON_RIFLEMAN
	job_title = JOB_SQUAD_MARINE
	role_comm_title = "Imperial Guard"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_standard //change

/datum/equipment_preset/uscm/imperial_guard/standard/load_gear(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/veteran/imperial_guard/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	uniform.attach_accessory(new_human, pouch)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/imperial_guard(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/facepaint/sniper(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/imperial_guard(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/forecon(new_human), WEAR_L_EAR)
	GLOB.character_traits[/datum/character_trait/skills/spotter].apply_trait(new_human)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/imperial_guard(new_human), WEAR_HEAD)

	// spawn_random_headgear(new_human)
	// add_forecon_weapon_pistol(new_human)
	add_imperial_weapon(new_human)

/datum/equipment_preset/uscm/imperial_guard/spacemarine
	name = "Ultramarine"
	assignment = JOB_FORECON_RIFLEMAN
	job_title = JOB_SQUAD_MARINE
	role_comm_title = "Imperial Guard"
	minimap_icon = ""
	skills = /datum/skills/commando/deathsquad/leader //change

/datum/equipment_preset/uscm/imperial_guard/spacemarine/load_gear(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/veteran/imperial_guard/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	uniform.attach_accessory(new_human, pouch)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/imperial_guard/spacemarine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/imperial_guard/spacemarine(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/imperial_guard/spacemarine(new_human), WEAR_HEAD)
	spawn_weapon(/obj/item/weapon/gun/rifle/bolter/hbolter, /obj/item/ammo_magazine/rifle/hbolter, new_human, 0, 3)
