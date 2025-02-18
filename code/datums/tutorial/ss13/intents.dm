/datum/tutorial/ss13/intents
	name = "Космическая Станция 13 - Интенты."
	desc = "Узнайте, как работает система взаимодействия."
	icon_state = "intents"
	tutorial_id = "ss13_intents_1"
	tutorial_template = /datum/map_template/tutorial/s7x7
	required_tutorial = "ss13_basic_1"

// START OF SCRIPTING

/datum/tutorial/ss13/intents/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()
	message_to_player("Это обучение по <b>интентам</b> в Космической Станции 13. Выделенный UI элемент справа снизу это твой текущий интент.")
	var/datum/hud/human/human_hud = tutorial_mob.hud_used
	add_highlight(human_hud.action_intent)

	addtimer(CALLBACK(src, PROC_REF(require_help)), 4.5 SECONDS)

/datum/tutorial/ss13/intents/proc/require_help()
	tutorial_mob.a_intent_change(INTENT_DISARM)
	message_to_player("Твой интент был изменён с <b>помощи</b>. Поменяй его обратно, нажав <b>[retrieve_bind("select_help_intent")]</b>.")
	update_objective("Верни интент помощи нажав [retrieve_bind("select_help_intent")].")

	RegisterSignal(tutorial_mob, COMSIG_MOB_INTENT_CHANGE, PROC_REF(on_help_intent))

/datum/tutorial/ss13/intents/proc/on_help_intent(datum/source, new_intent)
	SIGNAL_HANDLER

	if(new_intent != INTENT_HELP)
		return

	UnregisterSignal(tutorial_mob, COMSIG_MOB_INTENT_CHANGE)

	var/mob/living/carbon/human/dummy/tutorial/tutorial_dummy = new(loc_from_corner(2, 3))
	add_to_tracking_atoms(tutorial_dummy)

	message_to_player("Первый из интентов это интент <b>помощи</b>. Он используется что бы без вреда трогать других, тушить людей, давать исскуственное дыхание, и похожее. Нажми на <b>Тестовую Куклу</b> что бы похлопать её по спине.")
	update_objective("Нажми на куклу в интенте помощи.")

	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_help_attack))

/datum/tutorial/ss13/intents/proc/on_help_attack(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if((attacked_mob == src) || (tutorial_mob.a_intent != INTENT_HELP))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	tutorial_dummy.status_flags = DEFAULT_MOB_STATUS_FLAGS
	REMOVE_TRAIT(tutorial_dummy, TRAIT_IMMOBILIZED, TRAIT_SOURCE_TUTORIAL)
	tutorial_dummy.anchored = FALSE
	message_to_player("Второй интент это <b>обезоруживание</b>, который можно поставить с <b>[retrieve_bind("select_disarm_intent")]</b>. Обезоруживание используется в основном, что бы толкать людей, из-за чего они могут выронить то что носили или упасть. Толкай <b>Тестовую куклу</b> пока она не упадёт.")
	update_objective("Поменяй свой интент на обезоруживание при помощи [retrieve_bind("select_disarm_intent")] и повали куклу на землю.")

	RegisterSignal(tutorial_dummy, COMSIG_LIVING_APPLY_EFFECT, PROC_REF(on_shove_down))

/datum/tutorial/ss13/intents/proc/on_shove_down(datum/source, datum/status_effect/new_effect)
	SIGNAL_HANDLER

	if(!istype(new_effect, /datum/status_effect/incapacitating/knockdown))
		return

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	UnregisterSignal(tutorial_dummy, COMSIG_LIVING_APPLY_EFFECT)
	tutorial_dummy.rejuvenate()

	message_to_player("Третий интент это <b>захват</b>. Захват используется для того, что бы взять людей спокойно, агресивно, или удушающе. Хватай по нескольку раз, что бы \"обновить\" свой захват. Агресивно возьми <b>Тестовую Куклу</b>.")
	update_objective("Агресивно возьми куклу 2 раза нажав по ней.")


	RegisterSignal(tutorial_dummy, COMSIG_MOB_AGGRESSIVELY_GRABBED, PROC_REF(on_aggrograb))

/datum/tutorial/ss13/intents/proc/on_aggrograb(datum/source, mob/living/carbon/human/choker)
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	UnregisterSignal(tutorial_dummy, COMSIG_MOB_AGGRESSIVELY_GRABBED)

	message_to_player("Последний интент это <b>вред</b>. Вред используется что бы бить людей своим оружием или руками. Ударь <b>Тестовую Куклу</b> пустой рукой.")
	update_objective("Атакуй куклу пустой рукой.")

	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_harm_attack))

/datum/tutorial/ss13/intents/proc/on_harm_attack(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if((attacked_mob == src) || (tutorial_mob.a_intent != INTENT_HARM))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	tutorial_dummy.status_flags = GODMODE

	message_to_player("Отлично. Это все основы которые тебе надо знать. Это обучение закончится скоро.")
	update_objective("")

	tutorial_end_in(5 SECONDS, TRUE)

// END OF SCRIPTING
// START OF SCRIPT HELPERS



// END OF SCRIPT HELPERS

/datum/tutorial/ss13/intents/init_mob()
	. = ..()
	tutorial_mob.forceMove(loc_from_corner(2, 0))
