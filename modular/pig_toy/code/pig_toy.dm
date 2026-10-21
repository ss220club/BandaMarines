/obj/item/toy/pig_toy
	name = "pig toy"
	desc = "Игрушечный хряк из мягкого латекса. Внутри игрушки встроен специальный звуковой клапан. Штабной, неси свиней! Морпехи требуют свиней!"
	icon = 'modular/pig_toy/icon/svin.dmi'
	icon_state = "pig"
	w_class = SIZE_SMALL
	COOLDOWN_DECLARE(last_hug_time)
	var/squeak_sound = 'modular/pig_toy/sound/khryu.ogg'
	attack_verb = list("grunted")

/datum/gear/civilian/pig_toy
	display_name = "Pig toy"
	path = /obj/item/toy/pig_toy
	fluff_cost = 2

/obj/item/toy/pig_toy/attack_self(mob/living/user)
	if(!COOLDOWN_FINISHED(src, last_hug_time))
		return
	user.visible_message(SPAN_NOTICE("[capitalize(user.declent_ru(NOMINATIVE))] сжимает [src.declent_ru(ACCUSATIVE)]!"), SPAN_NOTICE("Ты сжимаешь [src.declent_ru(ACCUSATIVE)]. Хрю!"))
	playsound(src, squeak_sound, 15, TRUE)
	COOLDOWN_START(src, last_hug_time, 6 SECONDS)
	..()
