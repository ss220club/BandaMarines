/mob/living/simple_animal/hostile/retaliate/moth
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
	response_help = "гладит"
	friendly = "трётся"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	see_in_dark = 25
	see_invisible = SEE_INVISIBLE_LIVING
	light_system = MOVABLE_LIGHT
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
	var/sleep_overlay
	var/aggression_value = 0
	var/list/pounce_callbacks = list()
	var/pounce_cooldown_length = 9 SECONDS
	var/bleed_ticks = 0
	var/chance_to_rest = 0
	var/is_retreating = FALSE
	var/retreat_attempts = 0
	COOLDOWN_DECLARE(retreat_cooldown)
	var/tameable = TRUE
	var/datum/weakref/food_target_ref
	var/list/acceptable_foods = list(/obj/item/reagent_container/food/snacks/mre_food, /obj/item/reagent_container/food/snacks/resin_fruit)
	var/is_eating = FALSE
	COOLDOWN_DECLARE(food_cooldown)
	COOLDOWN_DECLARE(growl_message)
	COOLDOWN_DECLARE(calm_cooldown)
	COOLDOWN_DECLARE(pounce_cooldown)
	COOLDOWN_DECLARE(emote_cooldown)

/mob/living/simple_animal/hostile/retaliate/moth/lite
	name = "Огромная моль"
	maxHealth = 1500
	health = 1500

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

/mob/living/simple_animal/hostile/retaliate/moth/Initialize()
	. = ..()

	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE 
	update_sight()
	pounce_callbacks[/mob] = DYNAMIC(/mob/living/simple_animal/hostile/retaliate/moth/proc/pounced_mob_wrapper)

/mob/living/simple_animal/hostile/retaliate/moth/apply_damage(damage, damagetype, def_zone, used_weapon, sharp, edge, force, enviro, chemical = FALSE)
	Retaliate()
	aggression_value = clamp(aggression_value + 5, 0, 30)
	. = ..()
	var/retreat_chance = abs((health / maxHealth * 100) - 100)
	if(prob(retreat_chance) && health <= maxHealth * 0.66 && COOLDOWN_FINISHED(src, retreat_cooldown))
		if(client && !is_retreating)
			is_retreating = TRUE
			speed = MINIMAL_MOVEMENT_INTERVAL
			addtimer(VARSET_CALLBACK(src, speed, MIN_SPEED), 8 SECONDS)
			addtimer(VARSET_CALLBACK(src, is_retreating, FALSE), 8 SECONDS)
		else
			MoveTo(target_mob_ref?.resolve(), 12, TRUE, 4.5 SECONDS)
	if(damage >= 10 && damagetype == BRUTE)
		add_splatter_floor(loc, TRUE)
		bleed_ticks = clamp(bleed_ticks + ceil(damage / 10), 0, 30)

/mob/living/simple_animal/hostile/retaliate/moth/proc/growl(target_mob, ignore_cooldown = FALSE)
	if(!COOLDOWN_FINISHED(src, growl_message) && !ignore_cooldown)
		return
	if(target_mob)
		manual_emote("стрекочет на [target_mob].")
	else
		manual_emote("стрекочет.")
	playsound(loc, 'modular/moff/sound/moth_moth_chitter.ogg', 60)
	COOLDOWN_START(src, growl_message, rand(4, 6) SECONDS)

/mob/living/simple_animal/hostile/retaliate/moth/AddSleepingIcon()
	var/image/sleeping_icon = new('icons/mob/hud/hud.dmi', "slept_icon_centered")
	if(sleep_overlay)
		return
	sleep_overlay = sleeping_icon
	overlays += sleep_overlay
	addtimer(CALLBACK(src, PROC_REF(RemoveSleepingIcon)), 6 SECONDS)

/mob/living/simple_animal/hostile/retaliate/moth/RemoveSleepingIcon()
	if(sleep_overlay)
		overlays -= sleep_overlay
		sleep_overlay = null

/mob/living/simple_animal/hostile/retaliate/moth/stop_moving()
	walk_to(src, 0)

/mob/living/simple_animal/hostile/retaliate/moth/update_transform(instant_update = FALSE)
	if(stat == DEAD)
		icon_state = icon_dead
	else if(body_position == LYING_DOWN)
		if(!HAS_TRAIT(src, TRAIT_INCAPACITATED) && !HAS_TRAIT(src, TRAIT_FLOORED))
			icon_state = "mothroach_sleep"
		else
			icon_state = "mothroach_rest"
	else
		icon_state = icon_living

/mob/living/simple_animal/hostile/retaliate/moth/proc/find_target_on_trait_loss()
	update_transform()
	is_retreating = FALSE
	if(stance > HOSTILE_STANCE_ALERT)
		target_mob_ref = WEAKREF(FindTarget())
		MoveToTarget()

/mob/living/simple_animal/hostile/retaliate/moth/AttackingTarget(inherited_target = target_mob_ref?.resolve())
	return

/mob/living/simple_animal/hostile/retaliate/moth/MouseDrop(atom/over_object)
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

/mob/living/simple_animal/hostile/retaliate/moth/get_scooped(mob/living/carbon/grabber)
	if(stat >= DEAD)
		return
	..()

/mob/living/simple_animal/hostile/retaliate/moth/click(atom/clicked_atom, list/mods)
	var/should_pounce = FALSE

	switch(get_ability_mouse_key())
		if(XENO_ABILITY_CLICK_SHIFT)
			if(mods[SHIFT_CLICK] && mods[LEFT_CLICK])
				should_pounce = TRUE

		if(XENO_ABILITY_CLICK_RIGHT)
			if(mods[RIGHT_CLICK])
				should_pounce = TRUE

		if(XENO_ABILITY_CLICK_MIDDLE)
			if(mods[MIDDLE_CLICK])
				should_pounce = TRUE

	if(should_pounce)
		pounce(clicked_atom)
		return TRUE

	return ..()

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

/mob/living/simple_animal/hostile/retaliate/moth/proc/moth_jumpscare(mob/living/victim)
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

/mob/living/simple_animal/hostile/retaliate/moth/proc/pounced_mob_wrapper(mob/living/pounced_mob)
	pounced_mob(pounced_mob)

/mob/living/simple_animal/hostile/retaliate/moth/proc/break_nearby_lights()
	for(var/obj/structure/machinery/light/L in range(6, src))
		if(L.status != LIGHT_BROKEN)
			L.broken()

/mob/living/simple_animal/hostile/retaliate/moth/proc/pounced_mob(mob/living/pounced_mob)
	if(!pounced_mob || !isliving(pounced_mob))
		break_nearby_lights()
		return

	REMOVE_TRAIT(src, TRAIT_LAUNCHED, LAUNCHED_TRAIT)

	start_pulling(pounced_mob, TRUE, simple_mob = TRUE)
	break_nearby_lights()
	playsound(pounced_mob, pick(moff_kill_list), 100, FALSE)
	playsound(pounced_mob, pick(moff_horror_list), 100, FALSE)

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

/mob/living/simple_animal/hostile/retaliate/moth/proc/pounce(target)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_FLOORED))
		return
	if(!COOLDOWN_FINISHED(src, pounce_cooldown))
		to_chat(src, SPAN_WARNING("Ты не можешь так быстро прыгать! Тебе нужно подождать [COOLDOWN_SECONDSLEFT(src, pounce_cooldown)] секунд."))
		return

	COOLDOWN_START(src, pounce_cooldown, pounce_cooldown_length)
	var/pounce_distance = clamp((get_dist(src, target)), 1, 5)
	manual_emote("прыгает на [target]!")
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, throw_atom), target, pounce_distance, SPEED_FAST, src, null, LOW_LAUNCH, PASS_OVER_THROW_MOB, null, pounce_callbacks)


/mob/living/simple_animal/hostile/retaliate/moth/lite/pounced_mob(mob/living/pounced_mob)
	if(!pounced_mob || !isliving(pounced_mob))
		break_nearby_lights()
		return

	REMOVE_TRAIT(src, TRAIT_LAUNCHED, LAUNCHED_TRAIT)

	start_pulling(pounced_mob, TRUE, simple_mob = TRUE)
	break_nearby_lights()
	playsound(pounced_mob, pick(moff_kill_list), 100, FALSE)
	playsound(pounced_mob, pick(moff_horror_list), 100, FALSE)

	pounced_mob.death()
	moth_jumpscare(pounced_mob)

	MoveTo(pounced_mob, 5, TRUE, 5 SECONDS, TRUE)

	spawn(3 SECONDS)
		if(!src)
			return

		stop_pulling()

		if(pounced_mob && !QDELETED(pounced_mob))
			pounced_mob.spawn_gibs()

/mob/living/simple_animal/hostile/retaliate/moth/start_pulling(atom/movable/clone/AM, lunge, no_msg, simple_mob)
	. = ..()

	if(.)
		update_transform()
		speed = -2

/mob/living/simple_animal/hostile/retaliate/moth/stop_pulling()
	. = ..()
	speed = 0.5
	update_transform()

/mob/living/simple_animal/hostile/retaliate/moth/death(datum/cause_data/cause_data, gibbed = FALSE, deathmessage = "издаёт затихающий стрекот...")
	playsound(loc, 'modular/moff/sound/moth_moth_death.ogg', 100)
	walk(src, 0)
	return ..()

/mob/living/simple_animal/hostile/retaliate/moth/proc/MoveTo(target, distance = 1, retreat = FALSE, time = 6 SECONDS, return_to_combat = FALSE)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_FLOORED))
		return FALSE
	if(resting)
		set_resting(FALSE)
	if(!retreat)
		walk_to(src, target ? target : get_turf(src), distance, move_to_delay)
		return TRUE
	if(!is_retreating)
		is_retreating = TRUE
		stop_automated_movement = TRUE
		stance = HOSTILE_STANCE_ALERT
		walk_away(src, target ? target : get_turf(src), distance, 2.5)
		addtimer(CALLBACK(src, PROC_REF(stop_retreat), return_to_combat), time)
		return TRUE

/mob/living/simple_animal/hostile/retaliate/moth/Destroy()
	return ..()

/mob/living/simple_animal/hostile/retaliate/moth/set_resting(new_resting, silent, instant)
	. = ..()
	if(!resting)
		RemoveSleepingIcon()
	update_transform()

/mob/living/simple_animal/hostile/retaliate/moth/get_examine_text(mob/user)
	. = ..()

	if(stat == DEAD || user == src)
		desc = "Огромная моль."

		if(user == src)
			. += SPAN_NOTICE("\nОтдыхайте на земле чтобы восстанавливать здоровье.")
			. += SPAN_NOTICE("Вы можете напрыгивать на цели с помощью [get_ability_mouse_name()].")
			. += SPAN_NOTICE("Вы будете агрессивно убивать и утаскивать своих жертв.")

	else if((user.faction in faction_group))
		desc = "[initial(desc)] Оно выглядит... дружелюбно?"

	else
		desc = initial(desc)

	if(isxeno(user))
		. += SPAN_DANGER("Один лишь вид этого существа вселяет в вас ужас!")

	return .

/mob/living/simple_animal/hostile/retaliate/moth/proc/process_attack_hand(mob/living/carbon/attacking_mob)
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

/mob/living/simple_animal/hostile/retaliate/moth/proc/try_to_extinguish()
	if(is_retreating || !on_fire || client || stat == DEAD || body_position == LYING_DOWN)
		return
	stance = HOSTILE_STANCE_ALERT
	target_mob_ref = null
	food_target_ref = null
	is_eating = FALSE
	manual_emote("пронзительно жужжит от боли!")
	playsound(src, 'modular/moff/sound/moth_scream_moth.ogg', 70)
	MoveTo(null, 9, TRUE, 4 SECONDS, FALSE)
	COOLDOWN_START(src, calm_cooldown, 4 SECONDS)

/mob/living/simple_animal/hostile/retaliate/moth/IgniteMob()
	. = ..()
	if(on_fire)
		try_to_extinguish()

/mob/living/simple_animal/hostile/retaliate/moth/handle_fire()
	. = ..()
	if(on_fire)
		try_to_extinguish()

/mob/living/simple_animal/hostile/retaliate/moth/Life(delta_time)
	SetKnockOut(0)
	SetStun(0)
	SetKnockDown(0)
	if(aggression_value > 0)
		aggression_value--

	var/mob/living/target_mob = target_mob_ref?.resolve()
	if(!client && stance == HOSTILE_STANCE_ALERT && target_mob && !is_retreating && !on_fire)
		target_mob_ref = WEAKREF(FindTarget())
		MoveToTarget()

	if(resting && stat != DEAD)
		health += maxHealth * 0.05
		if(prob(33) && !HAS_TRAIT(src, TRAIT_INCAPACITATED) && !HAS_TRAIT(src, TRAIT_FLOORED))
			AddSleepingIcon()

	if(bleed_ticks)
		var/is_small_pool = FALSE
		if(bleed_ticks < 10)
			is_small_pool = TRUE
		bleed_ticks--
		add_splatter_floor(loc, is_small_pool)

	if(stance == HOSTILE_STANCE_IDLE && !client)
		stop_automated_movement = FALSE
		var/mob/living/carbon/friend = locate(/mob/living/carbon) in get_turf(src)
		if((friend?.faction in faction_group) && resting)
			chance_to_rest = 0

		if(prob(chance_to_rest))
			set_resting(!resting)
			chance_to_rest = 0

		chance_to_rest += rand(1, 2)

	. = ..()

	if(client)
		return
	if(aggression_value == 0 && stance == HOSTILE_STANCE_ATTACKING)
		enemies = list()
		LoseTarget()
		if(COOLDOWN_FINISHED(src, emote_cooldown))
			manual_emote("calms down.")
			COOLDOWN_START(src, calm_cooldown, 4 SECONDS)
			COOLDOWN_START(src, emote_cooldown, 3 SECONDS)


	if(stance > HOSTILE_STANCE_ALERT)
		is_eating = FALSE

	if(stance != HOSTILE_STANCE_IDLE && resting)
		set_resting(FALSE)

	if(target_mob && !is_retreating && target_mob.stat == CONSCIOUS && stance == HOSTILE_STANCE_ATTACKING && COOLDOWN_FINISHED(src, pounce_cooldown) && (prob(75) || get_dist(src, target_mob) <= 5) && (target_mob in view(5, src)))
		pounce(target_mob)

	if(target_mob && is_retreating && stance >= HOSTILE_STANCE_ALERT && destroy_surroundings)
		INVOKE_ASYNC(src, PROC_REF(DestroySurroundings))

	if(target_mob || on_fire)
		return

	if(is_retreating)
		stop_moving()
		stance = HOSTILE_STANCE_IDLE

	var/obj/item/reagent_container/food/snacks/food_target = food_target_ref?.resolve()
	if(tameable && !food_target && COOLDOWN_FINISHED(src, food_cooldown))
		for(var/obj/item/reagent_container/food/snacks/food in view(6, src))
			var/is_meat = locate(/datum/reagent/nutriment/meat) in food.reagents.reagent_list

			if(is_meat || is_type_in_list(food, acceptable_foods))
				food_target_ref = WEAKREF(food)
				if(!food_target)
					continue
				stance = HOSTILE_STANCE_ALERT
				stop_automated_movement = TRUE
				MoveTo(food_target)
				break

	if(stance <= HOSTILE_STANCE_ALERT && !food_target && COOLDOWN_FINISHED(src, calm_cooldown))
		var/intruder_in_sight = FALSE
		for(var/mob/living/carbon/intruder in view(5, src))
			if((intruder.faction in faction_group) || intruder.stat != CONSCIOUS || ismonkey(intruder) || intruder.alpha <= 200)
				continue

			intruder_in_sight = TRUE
			face_atom(intruder)
			stance = HOSTILE_STANCE_ALERT
			stop_automated_movement = TRUE
			if(get_dist(src, intruder) == 3)
				growl(intruder)
			else if(get_dist(src, intruder) <= 2)
				Retaliate()
				COOLDOWN_START(src, pounce_cooldown, 1 SECONDS)
				break

		if(!intruder_in_sight && stance == HOSTILE_STANCE_ALERT)
			stance = HOSTILE_STANCE_IDLE

	if(food_target && !is_eating)
		if(!(food_target in view(5, src)))
			stop_moving()
			lose_food()
		else if(!check_food_loc(food_target) && Adjacent(food_target))
			INVOKE_ASYNC(src, PROC_REF(handle_food), food_target)

/mob/living/simple_animal/hostile/retaliate/moth/proc/handle_food(obj/item/reagent_container/food/snacks/food)
	manual_emote("starts gnawing [food].")
	is_eating = TRUE
	for(var/times_to_eat = rand(4, 6), times_to_eat--)
		sleep(rand(1.7, 2.5) SECONDS)
		if(check_food_loc(food) || stance > HOSTILE_STANCE_ALERT || stat == DEAD)
			return
		face_atom(food)
		playsound(loc,'sound/items/eatfood.ogg', 25, 1)

	for(var/mob/living/carbon/nearest_mob in view(7, src))
		if(nearest_mob != food.last_dropped_by || (nearest_mob.faction in faction_group))
			continue
		face_atom(nearest_mob)
		manual_emote("stares curiously at [nearest_mob].")
		faction_group += nearest_mob.faction_group
		break

	health += maxHealth * 0.15
	qdel(food)
	food_target_ref = null
	is_eating = FALSE
	stance = HOSTILE_STANCE_IDLE
	COOLDOWN_START(src, food_cooldown, 30 SECONDS)

/mob/living/simple_animal/hostile/retaliate/moth/proc/handle_food_client(obj/item/reagent_container/food/snacks/food)
	manual_emote("starts gnawing [food].")
	playsound(loc,'sound/items/eatfood.ogg', 25, 1)
	is_eating = TRUE
	if(!do_after(src, 4 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY))
		is_eating = FALSE
		return

	is_eating = FALSE
	if(!Adjacent(food))
		return

	playsound(loc,'sound/items/eatfood.ogg', 25, 1)
	health += maxHealth * 0.10
	qdel(food)

/mob/living/simple_animal/hostile/retaliate/moth/proc/check_food_loc(obj/food)
	if(!ismob(food.loc))
		return

	var/mob/living/food_holder = food.loc
	stop_moving()
	COOLDOWN_START(src, food_cooldown, 15 SECONDS)
	food_target_ref = null
	is_eating = FALSE
	if(get_dist(src, food_holder) <= 2 && !(food_holder.faction in faction_group))
		Retaliate()
		return TRUE

	growl(food.loc)
	stance = HOSTILE_STANCE_IDLE
	return TRUE

/mob/living/simple_animal/hostile/retaliate/moth/proc/lose_food()
	stance = HOSTILE_STANCE_IDLE
	food_target_ref = null
	is_eating = FALSE
	COOLDOWN_START(src, food_cooldown, 15 SECONDS)

/mob/living/simple_animal/hostile/retaliate/moth/ListTargets(dist = 9)
	if(!length(enemies))
		return list()
	var/list/see = orange(src, dist)
	var/list/seen_enemies = list()
	for(var/thing in see)
		if(WEAKREF(thing) in enemies)
			seen_enemies += thing
	return seen_enemies

/mob/living/simple_animal/hostile/retaliate/moth/evaluate_target(mob/living/target)
	if(!..())
		return FALSE
	if(ismonkey(target))
		return FALSE
	return target

/mob/living/simple_animal/hostile/retaliate/moth/SA_attackable(target_mob)
	if(isliving(target_mob))
		var/mob/living/target = target_mob
		if(target.stat == DEAD || target.alpha <= 200 || !isturf(target.loc))
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/moth/Retaliate(pack_attack = FALSE)
	var/mob/living/target_mob = target_mob_ref?.resolve()
	if(stat == DEAD || get_dist(src, target_mob) < 6 || on_fire)
		return
	aggression_value = clamp(aggression_value + 5, 0, 15)

	. = ..()

	target_mob = FindTarget()
	target_mob_ref = WEAKREF(target_mob)
	if(!target_mob_ref)
		return

	growl(target_mob)
	MoveToTarget()

/mob/living/simple_animal/hostile/retaliate/moth/proc/stop_retreat(return_to_combat = FALSE)
	is_retreating = FALSE
	if(on_fire)
		resist_fire()
		return
	if(!return_to_combat)
		if(retreat_attempts >= 2)
			target_mob_ref = WEAKREF(FindTarget())
			MoveToTarget()
			retreat_attempts = 0
			COOLDOWN_START(src, retreat_cooldown, 20 SECONDS)
			return
		for(var/mob/living/carbon/hostile_mob in view(7, src))
			if(hostile_mob.faction in faction_group)
				continue
			MoveTo(hostile_mob, 10, TRUE, 2 SECONDS, FALSE)
			retreat_attempts++
			return
		retreat_attempts = 0
		LoseTarget()
	else
		target_mob_ref = WEAKREF(FindTarget())
		MoveToTarget()

/datum/emote/living/moth
	mob_type_allowed_typecache = list(/mob/living/simple_animal/hostile/retaliate/moth)

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

/mob/living/simple_animal/hostile/retaliate/moth/sadar
	name = "Огромная моль"
	desc = "Огромная моль. Ох чёрт, у неё ракетница!"
	icon = 'modular/moff/icon/animal_sadar.dmi'

/mob/living/simple_animal/hostile/retaliate/moth/sadar/pounce(atom/target)
	fire_rocket(target)

/mob/living/simple_animal/hostile/retaliate/moth/sadar/proc/fire_rocket(atom/target)
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
