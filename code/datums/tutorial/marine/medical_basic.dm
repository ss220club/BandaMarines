/datum/tutorial/marine/medical_basic
	name = "Морпехи - Медицина (Основы)"
	desc = "Научитесь, что делать с травмами ваших колег на поле боя."
	tutorial_id = "marine_medical_1"
	tutorial_template = /datum/map_template/tutorial/s7x7
	required_tutorial = "marine_basic_1"

// START OF SCRIPTING

/datum/tutorial/marine/medical_basic/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()
	message_to_player("Это базовое обучение по медицине для твоей игры на роли морпеха.")
	addtimer(CALLBACK(src, PROC_REF(brute_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/brute_tutorial()
	message_to_player("Первый тип урона - <b>Ушиб</b>, самый обыкновенный. Это травмы, которые вы получили от ударов, оружий, или пушек.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.adjustBruteLoss(10)
	addtimer(CALLBACK(src, PROC_REF(brute_tutorial_2)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/brute_tutorial_2()
	message_to_player("Вы можете посмотреть есть ли у вас <b>Брут</b> или <b>Ожог</b> урон нажав по себе пустой рукой в интенте помощи.")
	update_objective("Нажми на себя пустой рукой.")
	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_health_examine))

/datum/tutorial/marine/medical_basic/proc/on_health_examine(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if(attacked_mob != tutorial_mob)
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	message_to_player("Отлично. Теперь у тебя есть немного брута. <b>Бикадрин</b> исцеляет брут со временем. Подними <b>бикадриновый автоинъектор</b> и используй его в руке.")
	update_objective("Вкольни в себя бикадриновый инъектор.")
	var/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use/brute_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(brute_injector)
	add_highlight(brute_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_brute_inject))

/datum/tutorial/marine/medical_basic/proc/on_brute_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use, brute_injector)
	remove_highlight(brute_injector)
	message_to_player("Каждая медицина требует время перед тем, как подействует. Следующий тип урона - <b>Ожоги</b>. Его можно получить, если в вас плюнули кислотой, или если вы подгорели.")
	update_objective("")
	var/mob/living/living_mob = tutorial_mob
	living_mob.adjustFireLoss(10)
	addtimer(CALLBACK(src, PROC_REF(burn_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/burn_tutorial()
	message_to_player("<b>Келотан</b> используется что бы вылечить ваши ожоги. Вкольните в себя <b>келотановый автоинъектор</b>.")
	update_objective("Вкольните в себя келотановый инъектор.")
	var/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use/burn_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(burn_injector)
	add_highlight(burn_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_burn_inject))


/datum/tutorial/marine/medical_basic/proc/on_burn_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use, burn_injector)
	remove_highlight(burn_injector)
	message_to_player("Отлично. Когда вы получаете урон, вы также почуствуете <b>боль</b>. Боль замедляет вас и может вырубить, если ее не остановить.")
	update_objective("")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.apply_pain(PAIN_CHESTBURST_STRONG)
	addtimer(CALLBACK(src, PROC_REF(pain_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/pain_tutorial()
	message_to_player("<b>Трамадол</b> используется, что бы уменшить боль. Вкольните в себя <b>трамадоловый автоинъектор</b>.")
	update_objective("Вкольните в себя трамадоловый автоинъектор.")
	var/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use/pain_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(pain_injector)
	add_highlight(pain_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_pain_inject))

/datum/tutorial/marine/medical_basic/proc/on_pain_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use, pain_injector)
	remove_highlight(pain_injector)
	message_to_player("Хорошо. Держите в уме то, что вы можете словить передоз от химикатов, так что не втыкайте в себя одни и те же химикаты много раз. В поле боя у инъекторов есть 3 раза которые можно использовать.")
	update_objective("Не словите передоз! В общем, из-за трёх инъекции одного и того же химиката вы словите передоз.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.apply_pain(-PAIN_CHESTBURST_STRONG) // just to make sure
	addtimer(CALLBACK(src, PROC_REF(bleed_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/bleed_tutorial()
	message_to_player("У вас иногда может пойти <b>кровотечение</b> от таких вещей, как пули или порезы. Потеря крови приведёт к урону <b>воздуха</b> который вызывает смерть.")
	update_objective("")
	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	mob_chest.add_bleeding(damage_amount = 15)
	addtimer(CALLBACK(src, PROC_REF(bleed_tutorial_2)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/bleed_tutorial_2()
	message_to_player("Кровоточащие раны со временем могут затянуться, или затяните их при помощи <b>марлевой повязки</b>. Поднимите повязку и нажмите на себя с прицелом на <b>грудь</b>.")
	update_objective("Замотайте свою грудь, или ждите, пока рана затянется.")
	var/obj/item/stack/medical/bruise_pack/two/bandage = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(bandage)
	add_highlight(bandage)
	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	RegisterSignal(mob_chest, COMSIG_LIMB_STOP_BLEEDING, PROC_REF(on_chest_bleed_stop))

/datum/tutorial/marine/medical_basic/proc/on_chest_bleed_stop(datum/source, external, internal)
	SIGNAL_HANDLER

	// If you exit on this step, your limbs get deleted, which stops the bleeding, which progresses the tutorial despite it ending
	if(!tutorial_mob || QDELETED(src))
		return

	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	UnregisterSignal(mob_chest, COMSIG_LIMB_STOP_BLEEDING)

	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/stack/medical/bruise_pack/two, bandage)
	remove_from_tracking_atoms(bandage)
	remove_highlight(bandage)
	qdel(bandage)

	message_to_player("Хорошо. Иногда из-за пули или взрыва у вас может остаться <b>осколок</b>, который наносит вам урон со временем. Поднимите <b>нож</b> и используйте его в руке что бы вытащить осколок.")
	update_objective("Удалите осколок используя нож в правой руке.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.feels_pain = FALSE

	var/obj/item/attachable/bayonet/knife = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(knife)
	add_highlight(knife)

	var/obj/item/shard/shrapnel/tutorial/shrapnel = new
	shrapnel.on_embed(tutorial_mob, mob_chest, TRUE)

	RegisterSignal(tutorial_mob, COMSIG_HUMAN_SHRAPNEL_REMOVED, PROC_REF(on_shrapnel_removed))

/datum/tutorial/marine/medical_basic/proc/on_shrapnel_removed()
	SIGNAL_HANDLER

	UnregisterSignal(tutorial_mob, COMSIG_HUMAN_SHRAPNEL_REMOVED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/attachable/bayonet, knife)
	remove_highlight(knife)
	message_to_player("Отлично. Это все основы, которые вы должны знать по медицине, это обучение скоро закончится.")
	update_objective("Обучение завершено.")
	tutorial_end_in(5 SECONDS)

// END OF SCRIPTING
// START OF SCRIPT HELPERS

// END OF SCRIPT HELPERS

/datum/tutorial/marine/medical_basic/init_mob()
	. = ..()
	arm_equipment(tutorial_mob, /datum/equipment_preset/tutorial/fed)


/datum/tutorial/marine/medical_basic/init_map()
	new /obj/structure/surface/table/almayer(loc_from_corner(0, 4))
