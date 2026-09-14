/obj/item/toy/plush/moth
	name = "moth plushie"
	desc = "Плюшевая игрушка, изображающая очаровательного человека-мотылька. Милый пушистый жучок, которого так и хочется обнять!"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "moffplush"
	var/moff_sound_list = list('modular/moff/sound/moth_moth_chitter.ogg', 'modular/moff/sound/moth_moth_death.ogg', 'modular/moff/sound/moth_moth_flutter.ogg', 'modular/moff/sound/moth_moth_laugh1.ogg', 'modular/moff/sound/moth_scream_moth.ogg')
	var/moff_kill_list = list('sound/scp/firstpersonsnap.ogg', 'sound/scp/firstpersonsnap2.ogg', 'sound/scp/firstpersonsnap3.ogg')
	var/moff_horror_list = list('sound/scp/scare1.ogg', 'sound/scp/scare2.ogg', 'sound/scp/scare3.ogg', 'sound/scp/scare4.ogg')
	attack_verb = list("flutters", "flaps")
	
/datum/gear/toy/moth
	display_name = "Moth plush"
	path = /obj/item/toy/plush/moth
	fluff_cost = 6

/obj/item/toy/plush/moth/attack_self(mob/living/user)
	if(!COOLDOWN_FINISHED(src, last_hug_time))
		return
	user.visible_message(SPAN_NOTICE("[capitalize(user.declent_ru(NOMINATIVE))] крепко обнимает [src.declent_ru(ACCUSATIVE)]!"), SPAN_NOTICE("Ты крепко обнимаешь [src.declent_ru(ACCUSATIVE)]."))
	playsound(src, pick(moff_sound_list), 15, TRUE)
	COOLDOWN_START(src, last_hug_time, 6 SECONDS)

/obj/item/toy/plush/moth/strange
	var/suicide_count = 0

/obj/item/toy/plush/moth/strange/attack_self(mob/living/user)
	if(!COOLDOWN_FINISHED(src, last_hug_time))
		return

	user.visible_message(
		SPAN_WARNING("[capitalize(user.declent_ru(NOMINATIVE))] заглядывает [src.declent_ru(DATIVE)] в глаза... что-то заглядывает в ответ...")
	)
	playsound(src, pick(moff_sound_list), 35, TRUE)
	if(!do_after(user, 2.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		user.visible_message(
			SPAN_NOTICE("[capitalize(user.declent_ru(NOMINATIVE))] решает, что жизнь важнее обнимашек.")
		)
		return

	suicide_count++
	var/datum/cause_data/cause_data = create_cause_data("suicide by [initial(name)]", user)
	user.last_damage_data = cause_data

	if(suicide_count < 3)
		desc = "Плюшевая игрушка, изображающая странного человека-мотылька. После того как она погубила [suicide_count] [suicide_count == 1 ? "человека" : "людей"], её уже не назовёшь такой уж милой..."
	else if(suicide_count < 4)
		desc = "Плюшевая игрушка, изображающая нечто в облике человека-мотылька. Она погубила [suicide_count] людей. Не стоит смотреть ей в глаза слишком долго..."
	else
		user.visible_message(
			SPAN_HIGHDANGER("[src.declent_ru(NOMINATIVE)] Вспыхивает ярким пламенем!")
		)
		playsound(src, 'modular/moff/sound/moth_scream_moth.ogg', 30, TRUE)
		var/turf/T = get_turf(src)
		var/datum/reagent/napalm/ut/R = new()
		R.durationfire = BURN_TIME_INSTANT
		new /obj/flamer_fire(T, cause_data, R, 0)
		qdel(src)
		return

	user.visible_message(
		SPAN_HIGHDANGER("[capitalize(user.declent_ru(NOMINATIVE))] крепко обнимает [src.declent_ru(ACCUSATIVE)] и та начинает пожирать [user.ru_p_them()]!")
	)
	playsound(src, pick(moff_kill_list), 130, TRUE)
	playsound(src, pick(moff_horror_list), 130, TRUE)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/limb/L = H.get_limb("head")
		if(L)
			L.droplimb(cause_data)
	user.death(cause_data)

	COOLDOWN_START(src, last_hug_time, 2.5 SECONDS)
