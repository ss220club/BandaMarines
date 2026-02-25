var/sound = pick('modular/shave_marine/sound/shave_1.ogg', 'modular/shave_marine/sound/shave_2.ogg', 'modular/shave_marine/sound/shave_3.ogg', 'modular/shave_marine/sound/shave_4.ogg', 'modular/shave_marine/sound/shave_5.ogg')
/obj/item/attachable/bayonet
	var/uses = 0
	var/interaction_time = 2 SECONDS
/obj/item/attachable/bayonet/verb/shave()
	set name = "Shave yourself"
	set category = "Object"
	set src in usr
	
	var/mob/living/carbon/human/human_user = usr
	if(!istype(human_user))
		return
		
	var/list/species_facial_hair = GLOB.facial_hair_styles_list
	var/list/species_hair = GLOB.hair_styles_list
	
	if(human_user.species)
		species_facial_hair = list()
		for(var/current_style in GLOB.facial_hair_styles_list)
			var/datum/sprite_accessory/facial_hair/temp_beard_style = GLOB.facial_hair_styles_list[current_style]
			if(!(human_user.species.name in temp_beard_style.species_allowed))
				continue
			if(!temp_beard_style.selectable)
				continue
			species_facial_hair += current_style

	if(human_user.species)
		species_hair = list()
		for(var/current_style in GLOB.hair_styles_list)
			var/datum/sprite_accessory/hair/temp_hair_style = GLOB.hair_styles_list[current_style]
			if(!(human_user.species.name in temp_hair_style.species_allowed))
				continue
			if(!temp_hair_style.selectable)
				continue
			species_hair += current_style

	var/new_beard_style
	var/new_hair_style
	
	if(human_user.gender == MALE && human_user.f_style != "Shaved")
		new_beard_style = tgui_input_list(human_user, "Выберите стиль бороды", "Бритьё", species_facial_hair)
		
	new_hair_style = tgui_input_list(human_user, "Выберите стиль волос", "Стрижка", species_hair)

	if(loc != human_user)
		to_chat(human_user, SPAN_NOTICE("Вы слишком далеко от [src] чтобы стричься."))
		return
		
	if(!new_beard_style && !new_hair_style)
		return
		
	playsound(src, sound, 25, 1)
	
	if(!do_after(human_user, interaction_time, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		return
		
	if(human_user.h_style == "Bald" && human_user.f_style == "Shaved")
		human_user.apply_damage(rand(1, 5), BRUTE, "head", src)
		human_user.apply_effect(4, WEAKEN)
		human_user.emote("pain")
		to_chat(human_user, SPAN_WARNING("Вы попытались что-то срезать с лысины, но порезались ножом и сильно спугались! Вы странный человек..."))
		human_user.hallucination += rand(5, 15)
		return
		
	if(new_beard_style)
		human_user.f_style = new_beard_style
		human_user.visible_message(SPAN_ROSE("[human_user] ровняет растительность на лице своим [src]!"))
		
	if(new_hair_style)
		human_user.h_style = new_hair_style
		human_user.visible_message(SPAN_ROSE("[human_user] ссекает лишние волоски своим [src]!"))
	human_user.update_hair()

/obj/item/attachable/bayonet/unique_action(mob/user)
	var/mob/living/carbon/human/human_user = user
	var/list/viewers = get_mobs_in_view(GLOB.world_view_size, user)
	
	if(!istype(human_user))
		return
		
	if(user.a_intent == INTENT_HELP && user.zone_selected == "mouth")
		if(human_user.gender == MALE && human_user.f_style != "Shaved")
			if(uses < 4)
				playsound(src, sound, 25, 1)
				user.langchat_speech("Ссекает лишние волоски с бороды", viewers, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
				for(var/mob/M in viewers)
					M.show_message(SPAN_ROSE("[capitalize(user.declent_ru(NOMINATIVE))] ссекает лишние волоски с бороды своим [src]!"), SHOW_MESSAGE_VISIBLE)
				uses += 1
				
				if(!do_after(human_user, interaction_time, INTERRUPT_ALL, BUSY_ICON_GENERIC))
					shave_fail(human_user)
					return
			else if(uses >= 4)
				playsound(src, 'modular/shave_marine/sound/shave_fail.ogg', 25, 1)
				user.langchat_speech("Резко срезает остатки своей бороды", viewers, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
				for(var/mob/M in viewers)
					M.show_message(SPAN_WARNING("[capitalize(user.declent_ru(NOMINATIVE))] резко срезает остатки бороды своим [src]! это не круто..."), SHOW_MESSAGE_VISIBLE)
				human_user.f_style = "Shaved"
				human_user.update_hair()
				human_user.apply_damage(rand(1, 5), BRUTE, "head", src)
				human_user.emote("pain")
				to_chat(human_user, SPAN_WARNING("Вы порезали лезвием своё лицо! Наверное глупо было ровнять бороду ножом?"))
				uses = 0
		else
			to_chat(human_user, SPAN_NOTICE("У тебя нет бороды, что ты хочешь ровнять?"))
			
	else if(user.a_intent == INTENT_HELP && user.zone_selected == "head")
		if(human_user.h_style == "Bald")
			human_user.apply_damage(rand(1, 5), BRUTE, "head", src)
			human_user.apply_effect(4, WEAKEN)
			human_user.emote("pain")
			to_chat(human_user, SPAN_WARNING("Вы порезали лезвием свою лысину и сильно испугались! Вы странный человек..."))
			human_user.hallucination += rand(5, 15)
		else
			if(uses < 4)
				playsound(src, sound, 25, 1)
				user.langchat_speech("Ссекает лишние волоски с причёски", viewers, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
				for(var/mob/M in viewers)
					M.show_message(SPAN_ROSE("[capitalize(user.declent_ru(NOMINATIVE))] ссекает лишние волоски с причёски своим [src]!"), SHOW_MESSAGE_VISIBLE)
				uses += 1
				
				if(!do_after(human_user, interaction_time, INTERRUPT_ALL, BUSY_ICON_GENERIC))
					shave_fail(human_user)
					return
			else if(uses >= 4)
				playsound(src, 'modular/shave_marine/sound/shave_fail.ogg', 25, 1)
				user.langchat_speech("Резко срезает остатки своих волос", viewers, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
				for(var/mob/M in viewers)
					M.show_message(SPAN_WARNING("[capitalize(user.declent_ru(NOMINATIVE))] резко срезает остатки волос своим [src]! это не круто..."), SHOW_MESSAGE_VISIBLE)
				human_user.h_style = "Bald"
				human_user.update_hair()
				human_user.apply_damage(rand(1, 5), BRUTE, "head", src)
				human_user.emote("pain")
				to_chat(human_user, SPAN_WARNING("Вы порезали лезвием свою лысину! Наверное глупо было ровнять волосы ножом?"))
				uses = 0
	else 
		to_chat(human_user, SPAN_NOTICE("Ты долго смотришь на нож из-за страха порезаться. Правда боишься?"))
		if(uses >= 1)
			to_chat(human_user, SPAN_WARNING("У тебя кружится голова из-за панического страха лезвий! Ты видишь странное отражение на своём [src]..."))
			for(var/mob/M in viewers)
				M.show_message(SPAN_WARNING("[capitalize(user.declent_ru(NOMINATIVE))] трясётся от страха, глядя на свой [src]!"), SHOW_MESSAGE_VISIBLE)
			human_user.sway_jitter(2,1)
			human_user.hallucination += 90
			uses = 0
			return
		uses = 0
		human_user.hallucination = 0

/obj/item/attachable/bayonet/proc/shave_fail(mob/living/carbon/human/human_user)
	if(!istype(human_user))
		return
	human_user.apply_damage(rand(1, 5), BRUTE, "head", src)
	to_chat(human_user, SPAN_WARNING("Вы резко дёрнули лезвием и порезались!"))
	human_user.emote("pain")
	human_user.hallucination += rand(5, 15)
	uses = 0
