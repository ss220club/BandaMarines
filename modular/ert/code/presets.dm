/datum/equipment_preset/imperial_guard
	name = "Imperial Guard - Base"
	assignment = "Imperial Guard Soldier"
	job_title = JOB_SQUAD_MARINE
	role_comm_title = "Grd"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_standard //change
	faction = FACTION_NEUTRAL
	faction_group = list(FACTION_MARINE, FACTION_NEUTRAL)
	languages = list(LANGUAGE_ENGLISH)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)

	utility_under = list(/obj/item/clothing/under/marine)
	utility_hat = list(/obj/item/clothing/head/cmcap)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_shoes = list(/obj/item/clothing/shoes/marine)
	utility_extra = list(/obj/item/clothing/head/beret/cm, /obj/item/clothing/head/beret/cm/tan)

	service_under = list(/obj/item/clothing/under/marine/officer/bridge)
	service_over = list(/obj/item/clothing/suit/storage/jacket/marine/service, /obj/item/clothing/suit/storage/jacket/marine/service/mp)
	service_hat = list(/obj/item/clothing/head/cmcap)
	service_shoes = list(/obj/item/clothing/shoes/dress)

	dress_shoes = list(/obj/item/clothing/shoes/dress)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/imperial_guard/New()
	. = ..()
	access = get_access(ACCESS_LIST_UA)

/datum/equipment_preset/imperial_guard/proc/add_imperial_weapon(mob/living/carbon/human/new_human)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1 , 2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lasgun(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun/extended(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun/extended(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lasgun(new_human), WEAR_IN_ACCESSORY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/bolter(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/bolter(new_human), WEAR_IN_ACCESSORY)

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

/datum/equipment_preset/imperial_guard/load_status(mob/living/carbon/human/new_human)
 	new_human.nutrition = NUTRITION_HIGH

/datum/equipment_preset/imperial_guard/standard
	name = "Imperial Guard - Trooper"
	assignment = "Imperial Guard Soldier"
	job_title = JOB_SQUAD_MARINE
	role_comm_title = "Grd"

/datum/equipment_preset/imperial_guard/standard/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/imperial_guard, WEAR_BODY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/imperial_guard(new_human), WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/facepaint/sniper(new_human), WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/imperial_guard(new_human), WEAR_FEET)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/forecon(new_human), WEAR_L_EAR)

	GLOB.character_traits[/datum/character_trait/skills/spotter].apply_trait(new_human)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/imperial_guard(new_human), WEAR_HEAD)

	// spawn_random_headgear(new_human)
	add_imperial_weapon(new_human)

/datum/equipment_preset/imperial_guard/standard/techpriest
	name = "Imperial Guard - Techpriest"
	assignment = JOB_FORECON_RIFLEMAN
	job_title = JOB_SQUAD_ENGI
	skills = /datum/skills/mercenary/elite/engineer //change
	role_comm_title = "Tech"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/imperial_guard/standard/techpriest/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/imperial_guard, WEAR_BODY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/equipped, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/imperial_guard/techpriest(new_human), WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/techpriest(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/imperial_guard(new_human), WEAR_FEET)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/forecon(new_human), WEAR_L_EAR)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_L_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/imperial_guard/techpriest(new_human), WEAR_HEAD)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/ert, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry/mini, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/attachments(new_human), WEAR_IN_BACK)


//Spacemarines
/datum/equipment_preset/imperial_guard/spacemarine
	name = "Ultramarine - Standart Marine"
	assignment = "Ultramarine Rifleman"
	job_title = JOB_SQUAD_MARINE
	role_comm_title = "UltRfr"
	minimap_icon = ""
	skills = /datum/skills/commando/deathsquad/leader //change

/datum/equipment_preset/imperial_guard/spacemarine/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/imperial_guard, WEAR_BODY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/specialist/spacemarine(new_human), WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/spacemarine(new_human), WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/imperial_guard/spacemarine(new_human), WEAR_FEET)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof(new_human), WEAR_L_EAR)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/commando(new_human), WEAR_L_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/imperial_guard/spacemarine(new_human), WEAR_HEAD)

	spawn_weapon(/obj/item/weapon/gun/rifle/bolter/heavy, /obj/item/ammo_magazine/rifle/hbolter, new_human, 0, 3)



//Calls
/datum/emergency_call/imperial_guard
	name = "Imperium Troops (Squad)"
	mob_min = 1
	mob_max = 10
	probability = 5
	shuttle_id = MOBILE_SHUTTLE_ID_ERT1
	home_base = /datum/lazy_template/ert/pizza_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item

/datum/emergency_call/imperial_guard/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], это имперский фрегат класса 'Меч', мы приняли ваш сигнал. Высылаем к вам челнок. Во славу Императора!."
	objectives = "Помогите экипажу [MAIN_SHIP_NAME]. Уничтожьте ксеносов во славу Империума!"

/datum/emergency_call/imperial_guard/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы Коммисар Имперской Гвардии!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/standard, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("Вы полевой апотекарий Имперской Гвардии!"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/medic, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else if(heavies < max_heavies && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(mob.client, JOB_SQUAD_SPECIALIST))
		heavies++
		to_chat(mob, SPAN_ROLE_HEADER("Вы тяжелый пулеметчик Имперской Гвардии!"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/heavy, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("Вы техножрец Имперской Гвардии!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/standard/techpriest, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы стрелок Имперской Гвардии!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Задачи:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/imperial_guard/print_backstory(mob/living/carbon/human/M)
	to_chat(M, SPAN_BOLD("Вы родились [pick(70;"на мире-улье", 20;"на борту пустотного корабля", 10;"в цитадели мира-кузни")] и всю жизнь верно служили Богу-Императору."))
	to_chat(M, SPAN_BOLD("Вы несете верную службу на борту имперского фрегата, готовые отдать жизнь за Империум."))
	to_chat(M, SPAN_BOLD("Один из миров в вашем секторе подвергся атаке ксеносов и вы отправились на помощь."))
	to_chat(M, SPAN_BOLD("После катастрофического прыжка через Варп и гибели Навигатора ваш корабль выбросило в неизвестный и пугающе тихий сектор космоса."))
	to_chat(M, SPAN_BOLD("Астрономикон угас, но вокс-станции перехватили слабый аварийный сигнал бедствия на примитивной частоте от судна 'USS Алмаер'."))
	to_chat(M, SPAN_BOLD("В передаче звучит автоматический маяк 'Колониальной морской пехоты' с отчаянной просьбой о немедленной поддержке и эвакуации."))
	to_chat(M, SPAN_BOLD("Капитан отдал приказ подойти к судну и отправить абордажную команду на выручку выжившим людям."))
	to_chat(M, SPAN_BOLD("Вы не знаете, кто такие морпехи Объединенной Америки, но их отчаяние перед лицом скверны вам предельно ясно."))
	to_chat(M, SPAN_BOLD("Приготовьтесь войти на борт 'USS Алмаер'. Уничтожьте любых ксеносов во славу Императора и узнайте куда вы попали."))

/datum/emergency_call/imperial_guard/platoon
	name = "Imperium Troops (Platoon)"
	mob_min = 8
	mob_max = 25
	probability = 0
	max_smartgunners = 0

/datum/emergency_call/imperial_guard/spacemarines
	name = "Spacemarines (Deathsquad)"
	mob_max = 8
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT1
	home_base = /datum/lazy_template/ert/pizza_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_smartgunners = 2

/datum/emergency_call/imperial_guard/spacemarines/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], это ударный фрегат Адептус Астартес, мы приняли ваш сигнал. Высылаем к вам челнок. Во славу Императора!."

/datum/emergency_call/imperial_guard/spacemarines/print_backstory(mob/living/carbon/human/M)
	to_chat(M, SPAN_BOLD("Вы были отобраны среди лучших рекрутов [pick(70;"дикого мира", 20;"мира смерти", 10;"феодального мира")] и возвышены до звания Адептус Астартес."))
	to_chat(M, SPAN_BOLD("Вы — боевой брат Ордена, генетически усовершенствованный ангел смерти и карающая десница Императора."))
	to_chat(M, SPAN_BOLD("После катастрофического Варп-шторма ваш ударный крейсер потерял связь с Астрономиконом и был выброшен в неизведанную пустоту."))
	to_chat(M, SPAN_BOLD("Системы ауспекса засекли слабый сигнал бедствия на примитивной частоте от поврежденного судна 'USS Алмаер'."))
	to_chat(M, SPAN_BOLD("В передаче звучит автоматический маяк 'Колониальной морской пехоты' с отчаянной просьбой о немедленной поддержке и эвакуации."))
	to_chat(M, SPAN_BOLD("Сержант отдал приказ снарядить абордажные торпеды и подняться на борт корабля смертных."))
	to_chat(M, SPAN_BOLD("Кем бы ни были эти потерянные люди, долг Астартес — принести им спасение и сокрушить врагов человечества."))
	to_chat(M, SPAN_BOLD("Проверьте болтер и благословите силовой доспех. Вы вступаете на борт 'USS Алмаер'."))

/datum/emergency_call/imperial_guard/spacemarines/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы сержант ударного отряда Астартес!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/spacemarine, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("Вы тяжелый пулеметчик ударного отряда Астартес!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/spacemarine, TRUE, TRUE) // DO NOT FORGET TO CHANGE
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы боевой брат ударного отряда Астартес!"))
		arm_equipment(mob, /datum/equipment_preset/imperial_guard/spacemarine, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Задачи:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/necoarc
	name = "Fun - Necoarc (A LOT)"
	mob_max = 30
	mob_min = 1
	probability = 0
	objectives = "guran nyaaa~~!"
	hostility = TRUE
	shuttle_id = MOBILE_SHUTTLE_ID_ERT1
	home_base = /datum/lazy_template/ert/pizza_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item

/datum/emergency_call/necoarc/New()
	. = ..()
	arrival_message = "UUUUUUUHHHHNIIIAAAAA!!!!"

/datum/emergency_call/necoarc/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	arm_equipment(H, /datum/equipment_preset/fun/necoarc, FALSE, TRUE)

/datum/equipment_preset/fun/necoarc/load_race(mob/living/carbon/human/new_human, client/mob_client)
	new_human.set_species(/datum/species/monkey/necoarc)

/datum/equipment_preset/fun/necoarc
	name = "Fun - Necoarc Marine"
	skills = /datum/skills/necoarc
	assignment = "Necoarc Marine"
	job_title = "Necoarc Marine"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_MONKEY
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/fun/necoarc/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/monkey(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/heap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive(new_human), WEAR_IN_JACKET)
