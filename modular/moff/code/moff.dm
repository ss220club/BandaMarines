/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth
	name = "Огромная моль"
	desc = "Огромная моль. Куда смотрят её глаза..."
	icon = 'modular/moff/icon/animal.dmi'
	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"
	var/moff_kill_list = list('sound/scp/firstpersonsnap.ogg', 'sound/scp/firstpersonsnap2.ogg', 'sound/scp/firstpersonsnap3.ogg')
	var/moff_horror_list = list('sound/scp/scare1.ogg', 'sound/scp/scare2.ogg', 'sound/scp/scare3.ogg', 'sound/scp/scare4.ogg')
	mob_size = MOB_SIZE_SMALL
	grab_level = GRAB_CHOKE
	icon_size = 32
	pixel_x = 0
	tameable = FALSE
	response_help = "гладит"
	friendly = "трётся"
	see_in_dark = 30
	universal_speak = TRUE
	universal_understand = TRUE
	speak_chance = 2
	speak_emote = "flutters"
	emote_hear = list("машет крыльями.", "тихо жужжит.", "пищит.", "шуршит крыльями.")
	emote_see = list("шевелит усиками.", "порхает крыльями.", "во что-то врезается.", "смотрит пустым взглядом.")
	maxHealth = 2550
	health = 2550
	attack_same = FALSE
	langchat_color = "#9c7463"
	holder_type = /obj/item/holder/moth

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/lite
	name = "Огромная моль"
	maxHealth = 1500
	health = 1500
	tameable = TRUE

/obj/item/holder/moth
	name = "Огромная моль"
	desc = "Огромная моль. Куда смотрят её глаза..."
	icon = 'modular/moff/icon/animal.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/moff/icon/pets_head.dmi',
		WEAR_L_HAND = 'modular/moff/icon/animal_item_lefthand.dmi',
		WEAR_R_HAND = 'modular/moff/icon/animal_item_righthand.dmi'
	)
	flags_equip_slot = SLOT_HEAD
	icon_state = "mothroach_rest"
	item_state = "mothroach"
	item_state_slots = list(WEAR_HEAD = "mothroach")

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/change_tongue_offset(datum/source, olddir, newdir)
	return

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/Initialize()
	. = ..()
	vis_contents -= tongue_icon_holder

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/update_wounds()
	return
	
/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/apply_damage(damage, damagetype, def_zone, used_weapon, sharp, edge, force, enviro, chemical = FALSE)
	Retaliate()
	aggression_value = clamp(aggression_value + 5, 0, 30)
	. = ..()

	if(damage >= 10 && damagetype == BRUTE)
		add_splatter_floor(loc, TRUE)
		bleed_ticks = clamp(bleed_ticks + ceil(damage / 10), 0, 30)

	update_wounds()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/growl(target_mob, ignore_cooldown = FALSE)
	if(!COOLDOWN_FINISHED(src, growl_message) && !ignore_cooldown)
		return
	if(target_mob)
		manual_emote("стрекочет на [target_mob].")
	else
		manual_emote("стрекочет.")
	playsound(loc, 'modular/moff/sound/moth_moth_chitter.ogg', 60)
	COOLDOWN_START(src, growl_message, rand(4, 6) SECONDS)


/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/update_transform(instant_update = FALSE)
	if(stat == DEAD)
		icon_state = icon_dead
	else if(body_position == LYING_DOWN)
		if(!HAS_TRAIT(src, TRAIT_INCAPACITATED) && !HAS_TRAIT(src, TRAIT_FLOORED))
			icon_state = "mothroach_sleep"
		else
			icon_state = "mothroach_rest"
			tongue_icon_holder.alpha = 0
	else
		icon_state = icon_living
	update_wounds()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/AttackingTarget(inherited_target = target_mob_ref?.resolve())
	return

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/MouseDrop(atom/over_object)
	if(!CAN_PICKUP(usr, src))
		return ..()

	var/mob/living/carbon/H = over_object
	if(!istype(H) || !Adjacent(H) || H != usr)
		return ..()

	if(H.a_intent == INTENT_HELP)
		get_scooped(H)
		return
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/get_scooped(mob/living/carbon/grabber)
	if(stat >= DEAD)
		return
	..()

/atom/movable/screen/moth_blackout
	icon = 'icons/effects/ss13_dark_alpha6.dmi'
	icon_state = "0"
	screen_loc = "CENTER"
	layer = 99
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	var/client/player

/atom/movable/screen/moth_jumpscare
	icon = 'modular/moff/icon/animal.dmi'
	icon_state = "mothroach"
	screen_loc = "CENTER"
	layer = 100
	alpha = 255
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	var/client/player

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/proc/moth_jumpscare(mob/living/victim)
	if(!victim?.client)
		return

	var/atom/movable/screen/moth_blackout/blackout = new
	var/atom/movable/screen/moth_jumpscare/moth_face = new

	blackout.player = victim.client
	moth_face.player = victim.client

	victim.client.add_to_screen(blackout)
	victim.client.add_to_screen(moth_face)

	blackout.transform = blackout.transform.Scale(42, 42)
	moth_face.transform = moth_face.transform.Scale(18, 18)

	animate(blackout, alpha = 0, time = 20 SECONDS)
	animate(moth_face, alpha = 0, time = 4 SECONDS)

	spawn(4 SECONDS)
		if(victim.client)
			victim.client.remove_from_screen(moth_face)
		qdel(moth_face)

	spawn(20 SECONDS)
		if(victim.client)
			victim.client.remove_from_screen(blackout)
		qdel(blackout)

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/pounced_mob(mob/living/pounced_mob)
	if(!pounced_mob || !isliving(pounced_mob))
		return

	REMOVE_TRAIT(src, TRAIT_LAUNCHED, LAUNCHED_TRAIT)

	start_pulling(pounced_mob, TRUE, simple_mob = TRUE)

	playsound(pounced_mob, pick(moff_kill_list), 150, FALSE)
	playsound(pounced_mob, pick(moff_horror_list), 150, FALSE)

	pounced_mob.death()
	moth_jumpscare(pounced_mob)
	pounced_mob.chestburst = 2
	pounced_mob.update_burst()

	MoveTo(pounced_mob, 5, TRUE, 5 SECONDS, TRUE)

	spawn(3 SECONDS)
		if(!src)
			return

		stop_pulling()

		if(pounced_mob && !QDELETED(pounced_mob))
			pounced_mob.spawn_gibs()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/lite/pounced_mob(mob/living/pounced_mob)
	if(!pounced_mob || !isliving(pounced_mob))
		return

	REMOVE_TRAIT(src, TRAIT_LAUNCHED, LAUNCHED_TRAIT)

	start_pulling(pounced_mob, TRUE, simple_mob = TRUE)

	playsound(pounced_mob, pick(moff_kill_list), 150, FALSE)
	playsound(pounced_mob, pick(moff_horror_list), 150, FALSE)

	pounced_mob.death()
	moth_jumpscare(pounced_mob)

	MoveTo(pounced_mob, 5, TRUE, 5 SECONDS, TRUE)

	spawn(3 SECONDS)
		if(!src)
			return

		stop_pulling()

		if(pounced_mob && !QDELETED(pounced_mob))
			pounced_mob.spawn_gibs()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/start_pulling(atom/movable/clone/AM, lunge, no_msg, simple_mob)
	. = ..()

	if(.)
		update_transform()
		speed = -2

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/stop_pulling()
	. = ..()
	speed = 0.5
	update_transform()

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/death(datum/cause_data/cause_data, gibbed = FALSE, deathmessage = "издаёт затихающий стрекот...")
	playsound(loc, 'modular/moff/sound/moth_moth_death.ogg', 100)

	. = call(src, /mob/living/simple_animal/death)(cause_data, gibbed, deathmessage)
	if(!.)
		return

	GLOB.giant_lizards_alive -= src
	walk(src, 0)

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/get_examine_text(mob/user)
	. = call(src, /mob/living/simple_animal/get_examine_text)(user)

	if(stat == DEAD || user == src)
		desc = "Огромная моль."

		if(user == src)
			. += SPAN_NOTICE("\nОтдыхайте на земле чтобы восстанавливать 5% своего здоровья каждую секунду.")
			. += SPAN_NOTICE("Вы можете напрыгивать на цели с помощью [get_ability_mouse_name()].")
			. += SPAN_NOTICE("Вы будете агрессивно убивать и утаскивать своих жертв.")

	else if((user.faction in faction_group))
		desc = "[initial(desc)] Оно выглядит... дружелюбно?"

	else
		desc = initial(desc)

	if(isxeno(user))
		. += SPAN_DANGER("Один лишь вид этого существа вселяет в вас первобытный ужас!")

	return .

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/process_attack_hand(mob/living/carbon/attacking_mob)
	if(stat == DEAD)
		return

	if(!(attacking_mob.faction in faction_group) && !is_eating)
		Retaliate()

	if(attacking_mob.a_intent == INTENT_HELP && (attacking_mob.faction in faction_group))
		if(on_fire)
			adjust_fire_stacks(-5, min_stacks = 0)
			playsound(src.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, 7)
			visible_message(SPAN_DANGER("[attacking_mob] tries to put out the fire on [src]!"),
			SPAN_WARNING("You try to put out the fire on [src]!"), null, 5)
			if(fire_stacks <= 0)
				visible_message(SPAN_DANGER("[attacking_mob] has successfully extinguished the fire on [src]!"),
				SPAN_NOTICE("You extinguished the fire on [src]."), null, 5)
			return
		if(!resting)
			chance_to_rest += 15
		if(resting)
			chance_to_rest = 0
			if(COOLDOWN_FINISHED(src, emote_cooldown))
				COOLDOWN_START(src, emote_cooldown, rand(5, 8) SECONDS)
				manual_emote(pick("смотрит в душу [attacking_mob]", "оппархивает [attacking_mob]", "покусывает руку [attacking_mob]"))
				if(prob(50))
					playsound(loc, 'modular/moff/sound/moth_moth_laugh1.ogg', 25)
	if(attacking_mob.a_intent == INTENT_DISARM && prob(25))
		playsound(loc, 'sound/weapons/alien_knockdown.ogg', 25, 1)
		KnockDown(0.4)

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/try_to_extinguish()
	if(is_retreating || !on_fire || client || stat == DEAD || body_position == LYING_DOWN)
		return

	stance = HOSTILE_STANCE_ALERT
	target_mob_ref = null
	food_target_ref = null
	is_eating = FALSE
	manual_emote("пронзительно жужжит от боли!")
	playsound(src, 'modular/moff/sound/moth_scream_moth.ogg', 70)

	MoveTo(null, 9, TRUE, 4 SECONDS, FALSE)
	COOLDOWN_START(src, calm_cooldown, 8 SECONDS)

/datum/emote/living/giant_lizard
	mob_type_allowed_typecache = list(/mob/living/simple_animal/hostile/retaliate/giant_lizard)
	mob_type_blacklist_typecache = list(/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth)

/datum/emote/living/moth
	mob_type_allowed_typecache = list(/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth)

/datum/emote/living/moth/growl
	key = "growl"
	message = "стрекочет."
	sound = 'modular/moff/sound/moth_moth_laugh1.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/moth/hiss
	key = "hiss"
	message = "пронзительно жужжит."
	sound = 'modular/moff/sound/moth_scream_moth.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/sadar
	name = "Огромная моль"
	desc = "Огромная моль. Ох чёрт у неё ракетница!"
	icon = 'modular/moff/icon/animal_sadar.dmi'

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/sadar/pounce(atom/target)
	fire_rocket(target)

/mob/living/simple_animal/hostile/retaliate/giant_lizard/moth/sadar/proc/fire_rocket(atom/target)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_FLOORED))
		return

	if(!COOLDOWN_FINISHED(src, pounce_cooldown))
		return

	if(!target)
		return
	face_atom(target)
	COOLDOWN_START(src, pounce_cooldown, pounce_cooldown_length)
	manual_emote("стреляет из ракетницы в [target]!")
	var/obj/projectile/P = new /obj/projectile(src, src, src)

	var/datum/ammo/rocket/ap/ammo = new
	P.generate_bullet(ammo, 0, 0)

	P.fire_at(target, src, src)
