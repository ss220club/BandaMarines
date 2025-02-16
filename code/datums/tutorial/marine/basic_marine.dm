/datum/tutorial/marine/basic
	name = "Морпехи - База"
	desc = "Обучение познакомит вас с ролью обычного наземного морпеха."
	tutorial_id = "marine_basic_1"
	tutorial_template = /datum/map_template/tutorial/s8x9/no_baselight
	/// How many items need to be vended from the clothing vendor for the script to continue, if something vends 2 items (for example), increase this number by 2.
	var/clothing_items_to_vend = 8
	/// How many items need to be vended from the gun vendor to continue
	var/gun_items_to_vend = 2
	required_tutorial = "ss13_intents_1"

// START OF SCRIPTING

/datum/tutorial/marine/basic/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	var/obj/item/device/flashlight/flashlight = new(loc_from_corner(2, 3))
	flashlight.anchored = TRUE
	flashlight.set_light_power(4)
	flashlight.set_light_range(12)
	flashlight.icon = null
	flashlight.set_light_on(TRUE)
	add_to_tracking_atoms(flashlight)

	init_mob()
	message_to_player("Это туториал за игру за стрелка морпехов. Покиньте криопод используя клавишу <b>[retrieve_bind("North")]</b> или <b>[retrieve_bind("East")]</b> что бы продолжить.")
	update_objective("Выйдите из криопода используя клавишу [retrieve_bind("North")] или [retrieve_bind("East")].")
	RegisterSignal(tracking_atoms[/obj/structure/machinery/cryopod/tutorial], COMSIG_CRYOPOD_GO_OUT, PROC_REF(on_cryopod_exit))

/datum/tutorial/marine/basic/proc/on_cryopod_exit()
	SIGNAL_HANDLER

	UnregisterSignal(tracking_atoms[/obj/structure/machinery/cryopod/tutorial], COMSIG_CRYOPOD_GO_OUT)
	message_to_player("Отлично. Вы можете заметить жёлтую иконку \"еды\" с правой части вашего экрана. Подойдите к выделенному <b>Автомату с Едой</b> и возьмите <b>Протеиновый Батончик ККМП</b>.")
	update_objective("Возьмите себе батончик из выделенного автомата с едой.")
	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/sorted/marine_food/tutorial, food_vendor)
	add_highlight(food_vendor)
	food_vendor.req_access = list()
	RegisterSignal(food_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND, PROC_REF(on_food_vend))

/datum/tutorial/marine/basic/proc/on_food_vend(datum/source, obj/structure/machinery/cm_vending/vendor, list/itemspec, mob/living/carbon/human/user)
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/sorted/marine_food/tutorial, food_vendor)
	UnregisterSignal(food_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND)
	remove_highlight(food_vendor)
	food_vendor.req_access = list(ACCESS_TUTORIAL_LOCKED)
	message_to_player("Теперь кликните на своего персонажа с <b>Протеиновым Батончиком ККМП</b> в руках пока не съедите его полностью. Если вы случайно поменяли руки, поменяйте их обратно при помощи клавиши <b>[retrieve_bind("swap_hands")]</b>.")
	update_objective("Скушайте Протеиновый Батончик ККМП кликая на себя, пока не съедите его полностью.")
	RegisterSignal(tutorial_mob, COMSIG_MOB_EATEN_SNACK, PROC_REF(on_foodbar_eaten))

/datum/tutorial/marine/basic/proc/on_foodbar_eaten(datum/source, obj/item/reagent_container/food/snacks/eaten_food)
	SIGNAL_HANDLER

	if(!istype(eaten_food, /obj/item/reagent_container/food/snacks/protein_pack) || eaten_food.reagents.total_volume)
		return

	UnregisterSignal(source, COMSIG_MOB_EATEN_SNACK)
	message_to_player("Отлично. Теперь выдвигайтесь к выделенному автомату и возьмите там всё.")
	update_objective("Возьмите всё из автомата.")
	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/clothing/tutorial, clothing_vendor)
	add_highlight(clothing_vendor)
	clothing_vendor.req_access = list()
	RegisterSignal(clothing_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND, PROC_REF(on_clothing_vend))

/datum/tutorial/marine/basic/proc/on_clothing_vend(datum/source)
	SIGNAL_HANDLER

	clothing_items_to_vend--
	if(clothing_items_to_vend <= 0)
		TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/clothing/tutorial, clothing_vendor)
		UnregisterSignal(clothing_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND)
		clothing_vendor.req_access = list(ACCESS_TUTORIAL_LOCKED)
		remove_highlight(clothing_vendor)
		message_to_player("Теперь, комната потемнела. Возьмите <b>сигнальный огонь</b> из вашей <b>сумки с сигнальными огнями</b> кликая на неё пустой рукой, и потом используйте его в вашей руке при помощи клавиши<b>[retrieve_bind("activate_inhand")]</b>.")
		update_objective("Кликните на вашу сумку с сигнальными огнями что бы достать оттуда огонь и используйте его в вашей руке что бы он загорелся.")
		var/obj/item/storage/pouch/flare/flare_pouch = locate(/obj/item/storage/pouch/flare) in tutorial_mob.contents
		if(flare_pouch)
			add_highlight(flare_pouch)
		RegisterSignal(tutorial_mob, COMSIG_MOB_ITEM_ATTACK_SELF, PROC_REF(on_flare_light))
		addtimer(CALLBACK(src, PROC_REF(dim_room)), 2.5 SECONDS)

/datum/tutorial/marine/basic/proc/on_flare_light(datum/source, obj/item/used)
	SIGNAL_HANDLER

	if(!istype(used, /obj/item/device/flashlight/flare))
		return

	UnregisterSignal(tutorial_mob, COMSIG_MOB_ITEM_ATTACK_SELF)
	var/obj/item/storage/pouch/flare/flare_pouch = locate(/obj/item/storage/pouch/flare) in tutorial_mob.contents
	if(flare_pouch)
		remove_highlight(flare_pouch)

	message_to_player("Теперь бросьте <b>сигнальный огонь</b> <b>кликая</b> на ближайший тайл, или нажмите на <b>[retrieve_bind("drop_item")]</b>.")
	update_objective("Бросьте сигнальный огонь кликая на ближайший тайл, или уроните его используя клавшишу [retrieve_bind("drop_item")].")
	RegisterSignal(tutorial_mob, COMSIG_MOB_ITEM_DROPPED, PROC_REF(on_flare_throw))

/datum/tutorial/marine/basic/proc/on_flare_throw(datum/source, obj/item/thrown)
	SIGNAL_HANDLER

	if(!istype(thrown, /obj/item/device/flashlight/flare))
		return

	UnregisterSignal(tutorial_mob, COMSIG_MOB_ITEM_DROPPED)
	message_to_player("Хорошо. Теперь комната снова освещена. Пройдите к выделенному автомату и возьмите из него <b>M41A Pulse Rifle MK2</b>, вместе с <b>магазином</b>.")
	update_objective("Достаньте всё из автомата.")
	addtimer(CALLBACK(src, PROC_REF(brighten_room)), 1.5 SECONDS)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial, gun_vendor)
	gun_vendor.req_access = list()
	add_highlight(gun_vendor)
	RegisterSignal(gun_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND, PROC_REF(on_gun_vend))

/datum/tutorial/marine/basic/proc/on_gun_vend(datum/source)
	SIGNAL_HANDLER

	gun_items_to_vend--
	if(gun_items_to_vend <= 0)
		TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial, gun_vendor)
		gun_vendor.req_access = list(ACCESS_TUTORIAL_LOCKED)
		remove_highlight(gun_vendor)
		UnregisterSignal(gun_vendor, COMSIG_VENDOR_SUCCESSFUL_VEND)
		message_to_player("Теперь вставьте <b>магазин</b> в <b>M41A Pulse Rifle</b> просто ударив <b>магазином</b> в вашей руке по <b>Пульсовой Винтовке</b>.Если он в другой руке, смените руки клавишой <b>[retrieve_bind("swap_hands")]</b>.")
		update_objective("Вставьте магазин M41A просто ударив магазином по M41A Pulse Rifle.")
		RegisterSignal(tutorial_mob, COMSIG_MOB_RELOADED_GUN, PROC_REF(on_magazine_insert))

/datum/tutorial/marine/basic/proc/on_magazine_insert(datum/source, atom/attacked, obj/item/attacked_with)
	SIGNAL_HANDLER

	UnregisterSignal(tutorial_mob, COMSIG_MOB_RELOADED_GUN)
	message_to_player("Хорошо. Теперь возьми своё оружие в две руки используя клавишу <b>[retrieve_bind("activate_inhand")]</b>.")
	update_objective("Схвати своё оружие обеими руками используя клавишу [retrieve_bind("activate_inhand")] с винтовкой в твоей активной руке.")
	RegisterSignal(tutorial_mob, COMSIG_MOB_ITEM_ATTACK_SELF, PROC_REF(on_gun_wield))

/datum/tutorial/marine/basic/proc/on_gun_wield(datum/source, obj/item/used)
	SIGNAL_HANDLER

	if(!istype(used, /obj/item/weapon/gun/rifle/m41a))
		return

	UnregisterSignal(tutorial_mob, COMSIG_MOB_ITEM_ATTACK_SELF)
	message_to_player("Теперь, стреляй в выделенного <b>Ксеноморфа</b> пока он не умрёт.")
	update_objective("Стреляй в ксеноморфа пока он не умрёт.")
	var/mob/living/carbon/xenomorph/drone/tutorial/xeno_dummy = new(loc_from_corner(4, 5))
	add_to_tracking_atoms(xeno_dummy)
	add_highlight(xeno_dummy, COLOR_VIVID_RED)
	RegisterSignal(xeno_dummy, COMSIG_MOB_DEATH, PROC_REF(on_xeno_death))
	RegisterSignal(tutorial_mob, COMSIG_MOB_GUN_EMPTY, PROC_REF(on_magazine_empty)) // I'd like to prevent unwilling softlocks as much as I can

/// Non-contiguous part of the script, called if the user manages to run out of ammo in the gun without the xeno dying
/datum/tutorial/marine/basic/proc/on_magazine_empty(obj/item/weapon/gun/empty_gun)
	SIGNAL_HANDLER

	UnregisterSignal(tutorial_mob, COMSIG_MOB_GUN_EMPTY)
	message_to_player("У твоего оружия закончились патроны. Возьми ещё из <b>Weaponry Vendor</b> и убей <b>Ксеноморфа</b>.")
	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial, gun_vendor)
	gun_vendor.req_access = list()
	gun_vendor.load_ammo() // 99 magazines, to make sure that the xeno dies

/datum/tutorial/marine/basic/proc/on_xeno_death(datum/source)
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/xenomorph/drone/tutorial, xeno_dummy)
	UnregisterSignal(xeno_dummy, COMSIG_MOB_DEATH)
	UnregisterSignal(tutorial_mob, COMSIG_MOB_GUN_EMPTY)
	remove_highlight(xeno_dummy)
	addtimer(CALLBACK(src, PROC_REF(disappear_xeno)), 2.5 SECONDS)
	message_to_player("Очень хорошо. Это конец туториала, включи следующий туториал, что бы узнать основы <b>Медицины</b>. Ты скоро вернёшься на экран лобби.")
	update_objective("")
	tutorial_end_in(7.5 SECONDS, TRUE)


// END OF SCRIPTING
// START OF SCRIPT HELPERS

/datum/tutorial/marine/basic/proc/dim_room()
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/device/flashlight, flashlight)
	flashlight.set_light_on(FALSE)

/datum/tutorial/marine/basic/proc/brighten_room()
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/device/flashlight, flashlight)
	flashlight.set_light_on(TRUE)

/datum/tutorial/marine/basic/proc/disappear_xeno()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/xenomorph/drone/tutorial, xeno_dummy)
	animate(xeno_dummy, time = 5 SECONDS, alpha = 0)
	remove_from_tracking_atoms(xeno_dummy)
	QDEL_IN(xeno_dummy, 5.5 SECONDS)

// END OF SCRIPT HELPERS

/datum/tutorial/marine/basic/init_mob()
	. = ..()
	arm_equipment(tutorial_mob, /datum/equipment_preset/tutorial)

	TUTORIAL_ATOM_FROM_TRACKING(/obj/structure/machinery/cryopod/tutorial, tutorial_pod)
	tutorial_pod.go_in_cryopod(tutorial_mob, TRUE, FALSE)


/datum/tutorial/marine/basic/init_map()
	var/obj/structure/machinery/cryopod/tutorial/tutorial_pod = new(bottom_left_corner)
	add_to_tracking_atoms(tutorial_pod)
	var/obj/structure/machinery/cm_vending/sorted/marine_food/tutorial/food_vendor = new(loc_from_corner(0, 2))
	add_to_tracking_atoms(food_vendor)
	var/obj/structure/machinery/cm_vending/clothing/tutorial/clothing_vendor = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(clothing_vendor)
	var/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial/gun_vendor = new(loc_from_corner(0, 5))
	add_to_tracking_atoms(gun_vendor)
