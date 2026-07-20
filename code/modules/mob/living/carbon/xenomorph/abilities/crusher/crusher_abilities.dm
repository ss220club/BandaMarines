/datum/action/xeno_action/activable/pounce/crusher_charge
	name = "Charge"
	action_icon_state = "ready_charge"
	action_text = "charge"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_charge
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1
	xeno_cooldown = 14 SECONDS
	plasma_cost = 20
	// Config options
	distance = 9
	knockdown = TRUE
	knockdown_duration = 2
	slash = FALSE
	freeze_self = FALSE
	windup = TRUE
	windup_duration = 1.2 SECONDS
	windup_interruptable = FALSE
	should_destroy_objects = TRUE
	throw_speed = SPEED_FAST
	tracks_target = FALSE
	var/direct_hit_damage = 60
	var/frontal_armor = 15
	// Object types that don't reduce cooldown when hit
	var/list/not_reducing_objects = list()
	// Two-stage activation
	var/activated_once = FALSE
	var/atom/stored_target = null
	var/charge_timeout_timer_id = TIMER_ID_NULL


/datum/action/xeno_action/activable/pounce/crusher_charge/New()
	. = ..()
	not_reducing_objects = typesof(/obj/structure/barricade) + typesof(/obj/structure/machinery/defenses)
	// Override collision callbacks to pass through mobs
	pounce_callbacks = list()
	pounce_callbacks[/mob/living/carbon/human] = CALLBACK(src, PROC_REF(handle_human_collision))
	pounce_callbacks[/mob/living/carbon/xenomorph] = CALLBACK(src, PROC_REF(handle_xeno_collision))
	pounce_callbacks[/mob/living/carbon] = CALLBACK(src, PROC_REF(handle_mob_collision))
	pounce_callbacks[/obj] = DYNAMIC(/mob/living/carbon/xenomorph/proc/pounced_obj_wrapper)
	pounce_callbacks[/turf] = DYNAMIC(/mob/living/carbon/xenomorph/proc/pounced_turf_wrapper)

/datum/action/xeno_action/activable/pounce/crusher_charge/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/xeno = owner

	if(!istype(xeno) || !xeno.check_state())
		return

	if(!activated_once && !action_cooldown_check())
		return

	if(!target || target.layer >= FLY_LAYER || !isturf(xeno.loc))
		return

	if(!activated_once)
		// First click - start charging with windup
		if(!check_and_use_plasma_owner())
			return

		xeno.visible_message(SPAN_XENODANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] начинает заряжать рывок!"), SPAN_XENODANGER("Мы начинаем заряжать рывок!"))

		// Lock direction and immobilize during charge
		xeno.set_face_dir(get_cardinal_dir(xeno, target))
		ADD_TRAIT(xeno, TRAIT_IMMOBILIZED, TRAIT_SOURCE_ABILITY("Crusher Charge"))
		xeno.anchored = TRUE

		// Camera shake during charging
		shake_camera(xeno, windup_duration * 0.1, windup_duration * 0.1)

		// Perform the windup with visual indicator
		if(!do_after(xeno, windup_duration, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE))
			to_chat(xeno, SPAN_XENODANGER("Мы отменяем зарядку рывка!"))
			REMOVE_TRAIT(xeno, TRAIT_IMMOBILIZED, TRAIT_SOURCE_ABILITY("Crusher Charge"))
			xeno.anchored = FALSE
			return

		REMOVE_TRAIT(xeno, TRAIT_IMMOBILIZED, TRAIT_SOURCE_ABILITY("Crusher Charge"))
		xeno.anchored = FALSE

		activated_once = TRUE
		stored_target = target
		apply_cooldown()

		to_chat(xeno, SPAN_XENOWARNING("Рывок заряжен! Выберите направление в течение 5 секунд!"))

		// Set timeout - if no second click in 5 seconds, charge at the first target
		charge_timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(charge_timeout)), 5 SECONDS, TIMER_STOPPABLE)
		return ..()
	else
		// Second click - execute charge at new target immediately (no windup)
		activated_once = FALSE
		if(charge_timeout_timer_id != TIMER_ID_NULL)
			deltimer(charge_timeout_timer_id)
			charge_timeout_timer_id = TIMER_ID_NULL

		// Call execute_charge to perform the actual charge
		return execute_charge(target)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_timeout()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno) || !activated_once)
		return

	activated_once = FALSE
	charge_timeout_timer_id = TIMER_ID_NULL

	if(!stored_target)
		to_chat(xeno, SPAN_XENOWARNING("Наш рывок потерял цель!"))
		return

	to_chat(xeno, SPAN_XENOWARNING("Время вышло, мы совершаем рывок в изначальную цель!"))
	execute_charge(stored_target)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/execute_charge(atom/target)
	var/mob/living/carbon/xenomorph/xeno = owner

	if(!target)
		return FALSE

	while(istype(target, /turf/open_space))
		target = SSmapping.get_turf_below(target)

	if(target.layer >= FLY_LAYER)
		return FALSE

	if(!isturf(xeno.loc))
		to_chat(xeno, SPAN_XENOWARNING("Мы не можем осуществить [action_text] отсюда!"))
		return FALSE

	if(!xeno.check_state())
		return FALSE

	if(xeno.legcuffed)
		to_chat(xeno, SPAN_XENODANGER("Мы не можем [action_text] с этой штукой на ноге!"))
		return FALSE

	if(xeno.layer == XENO_HIDING_LAYER)
		var/datum/action/xeno_action/onclick/xenohide/hide = get_action(xeno, /datum/action/xeno_action/onclick/xenohide)
		if(hide)
			hide.post_attack()

	if(!tracks_target)
		target = get_turf(target)

	if(target.z != xeno.z)
		var/maximum_z = max(target.z, xeno.z)
		var/list/turf/path = get_line(locate(xeno.x, xeno.y, maximum_z), locate(target.x, target.y, maximum_z))
		for(var/turf/turf_in_path in path)
			while(istype(turf_in_path, /turf/open_space))
				turf_in_path = SSmapping.get_turf_below(turf_in_path)

			if(turf_in_path.density && turf_in_path.turf_flags & TURF_HULL)
				to_chat(xeno, SPAN_WARNING("You can't jump over an object in your path."))
				return FALSE

			for(var/obj/structure/cur_obj in turf_in_path.contents)
				if(cur_obj.density && cur_obj.unslashable && cur_obj.unacidable)
					to_chat(xeno, SPAN_WARNING("You can't jump over an object in your path."))
					return FALSE

		if(!do_after(xeno, 0.5 SECONDS, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE))
			return FALSE

	if(target.z != xeno.z && xeno.mob_size >= MOB_SIZE_BIG)
		if(!do_after(xeno, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			return FALSE

	// No windup here - charge was already done during first click
	xeno.set_face_dir(get_cardinal_dir(xeno, target))

	xeno.visible_message(SPAN_XENOWARNING("[xeno] [action_text][findtext(action_text, "e", -1) || findtext(action_text, "p", -1) ? "s" : "es"] в [target]!"), SPAN_XENOWARNING("Мы [action_text] в [target]!"))

	pre_pounce_effects()

	xeno.pounce_distance = get_dist(xeno, target)
	if(xeno.z != target.z)
		xeno.pounce_distance += 2
	xeno.throw_atom(target, distance, throw_speed, xeno, launch_type = LOW_LAUNCH, pass_flags = pounce_pass_flags, collision_callbacks = pounce_callbacks, tracking=TRUE)
	xeno.update_icons()

	additional_effects_always()

	return TRUE

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_human_collision(mob/living/carbon/human/human)
	var/mob/living/carbon/xenomorph/xeno = owner

	playsound(human.loc, "punch", 25, TRUE)
	human.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
	xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [human] ([human.ckey])</font>")
	log_attack("[xeno] ([xeno.ckey]) crusher charged [human] ([human.ckey])")

	human.take_overall_armored_damage(direct_hit_damage, ARMOR_MELEE, BRUTE, null, 10)

	xeno.visible_message(
		SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] таранит [human.declent_ru(ACCUSATIVE)]!"),
		SPAN_XENODANGER("Вы тараните [human.declent_ru(ACCUSATIVE)]!")
	)

	human.apply_effect(knockdown_duration, WEAKEN)
	animation_flash_color(human)
	if(human.client)
		shake_camera(human, 2, 3)

	var/list/ram_dirs = get_perpen_dir(xeno.dir)
	var/ram_dir = pick(ram_dirs)
	var/cur_turf = get_turf(human)
	var/target_turf = get_step(human, ram_dir)
	if(LinkBlocked(human, cur_turf, target_turf))
		ram_dir = REVERSE_DIR(ram_dir)
	step(human, ram_dir, 2)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_xeno_collision(mob/living/carbon/xenomorph/target_xeno)
	var/mob/living/carbon/xenomorph/xeno = owner

	playsound(target_xeno.loc, "punch", 25, TRUE)

	if(!xeno.ally_of_hivenumber(target_xeno.hivenumber))
		target_xeno.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
		xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [target_xeno] ([target_xeno.ckey])</font>")
		log_attack("[xeno] ([xeno.ckey]) crusher charged [target_xeno] ([target_xeno.ckey])")
		target_xeno.apply_damage(direct_hit_damage * 0.5, BRUTE)

	if(target_xeno.anchored)
		return

	if(isqueen(target_xeno) || IS_XENO_LEADER(target_xeno) || isboiler(target_xeno))
		return

	var/list/ram_dirs = get_perpen_dir(xeno.dir)
	var/ram_dir = pick(ram_dirs)
	var/cur_turf = get_turf(target_xeno)
	var/target_turf = get_step(target_xeno, ram_dir)
	if(LinkBlocked(target_xeno, cur_turf, target_turf))
		xeno.emote("roar")
		xeno.visible_message(
			SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает [target_xeno.declent_ru(ACCUSATIVE)] в сторону!"),
			SPAN_DANGER("Вы отбрасываете [target_xeno.declent_ru(ACCUSATIVE)] в сторону!")
		)
		to_chat(target_xeno, SPAN_XENOHIGHDANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает вас в сторону! С дороги!"))
		target_xeno.apply_effect(0.5, WEAKEN)
		target_xeno.throw_atom(get_turf(target_xeno), 1, 3, xeno, TRUE)
	else
		step(target_xeno, ram_dir, 2)
		target_xeno.apply_effect(0.5, WEAKEN)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_mob_collision(mob/living/carbon/mob)
	var/mob/living/carbon/xenomorph/xeno = owner

	playsound(mob.loc, "punch", 25, TRUE)
	mob.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
	xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [mob] ([mob.ckey])</font>")
	log_attack("[xeno] ([xeno.ckey]) crusher charged [mob] ([mob.ckey])")

	mob.take_overall_damage(direct_hit_damage)

	xeno.visible_message(
		SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] таранит [mob.declent_ru(ACCUSATIVE)]!"),
		SPAN_XENODANGER("Вы тараните [mob.declent_ru(ACCUSATIVE)]!")
	)

	mob.apply_effect(knockdown_duration, WEAKEN)
	animation_flash_color(mob)
	if(mob.client)
		shake_camera(mob, 2, 3)

	var/list/ram_dirs = get_perpen_dir(xeno.dir)
	var/ram_dir = pick(ram_dirs)
	var/cur_turf = get_turf(mob)
	var/target_turf = get_step(mob, ram_dir)
	if(LinkBlocked(mob, cur_turf, target_turf))
		ram_dir = REVERSE_DIR(ram_dir)
	step(mob, ram_dir, 2)

/datum/action/xeno_action/activable/pounce/crusher_charge/initialize_pounce_pass_flags()
	pounce_pass_flags = PASS_CRUSHER_CHARGE

/datum/action/xeno_action/onclick/crusher_stomp
	name = "Stomp"
	action_icon_state = "stomp"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_stomp
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2
	xeno_cooldown = 18 SECONDS
	plasma_cost = 30

	var/damage = 65

	var/distance = 2
	var/effect_type_base = /datum/effects/xeno_slow/superslow
	var/effect_duration = 1 SECONDS

/datum/action/xeno_action/onclick/crusher_stomp/charger
	name = "Crush"
	action_icon_state = "stomp"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_charger_stomp
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_3
	plasma_cost = 25
	damage = 75
	distance = 3
	xeno_cooldown = 12 SECONDS


/datum/action/xeno_action/onclick/crusher_shield
	name = "Defensive Shield"
	action_icon_state = "empower"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_charge
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_3
	plasma_cost = 50
	xeno_cooldown = 26 SECONDS
	var/shield_amount = 200
	var/explosion_immunity_dur = 2.5 SECONDS
	var/shield_dur = 7 SECONDS

/datum/action/xeno_action/activable/fling/charger
	name = "Headbutt"
	action_icon_state = "ram"
	macro_path = /datum/action/xeno_action/verb/verb_fling
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_4
	xeno_cooldown = 10 SECONDS
	plasma_cost = 10
	// Configurables
	fling_distance = 3
	stun_power = 0
	weaken_power = 0
	slowdown = 8


/datum/action/xeno_action/onclick/charger_charge
	name = "Toggle Charging"
	action_icon_state = "ready_charge"
	plasma_cost = 0 // manually applied in the proc
	macro_path = /datum/action/xeno_action/verb/verb_crusher_toggle_charging
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1

	// Config vars
	var/max_momentum = 8
	var/steps_to_charge = 4
	var/speed_per_momentum = XENO_SPEED_FASTMOD_TIER_5 + XENO_SPEED_FASTMOD_TIER_1//2
	var/plasma_per_step = 3 // charger has 400 plasma atm, this gives a good 100 tiles of crooshing

	// State vars
	var/activated = FALSE
	var/steps_taken = 0
	var/charge_dir
	var/noise_timer = 0

	//How much shield you gain on max momentum
	var/shield_amount = 100
	// How long the max momentum shield lasts
	var/shield_timeout = 4
	// If the shield is active or not
	var/shield_active = FALSE

	/// The last time the crusher moved while charging
	var/last_charge_move
	/// Dictates speed and damage dealt via collision, increased with movement
	var/momentum = 0


/datum/action/xeno_action/onclick/charger_charge/proc/handle_position_change(mob/living/carbon/xenomorph/xeno, body_position)
	SIGNAL_HANDLER
	if(body_position == LYING_DOWN)
		handle_movement(xeno)

/datum/action/xeno_action/onclick/charger_charge/proc/handle_movement(mob/living/carbon/xenomorph/Xeno, atom/oldloc, dir, forced)
	SIGNAL_HANDLER
	if(Xeno.pulling)
		if(!momentum)
			steps_taken = 0
			return
		else
			Xeno.stop_pulling()

	if(Xeno.is_mob_incapacitated())
		if(!momentum)
			return
		var/distance_to_throw = get_ranged_target_turf(Xeno, charge_dir, momentum/2)
		INVOKE_ASYNC(Xeno, TYPE_PROC_REF(/atom/movable, throw_atom), distance_to_throw, momentum/2, SPEED_FAST, null, TRUE)
		stop_momentum()
		return
	if(!isturf(Xeno.loc))
		stop_momentum()
		return
	// Don't build up charge if you move via getting propelled by something
	if(Xeno.throwing)
		stop_momentum()
		return

	var/do_stop_momentum = FALSE

	// Need to be constantly moving in order to maintain charge
	if(world.time > last_charge_move + 0.5 SECONDS)
		do_stop_momentum = TRUE
	if(dir != charge_dir)
		charge_dir = dir
		do_stop_momentum = TRUE

	if(do_stop_momentum)
		stop_momentum()
	if(Xeno.plasma_stored <= plasma_per_step)
		stop_momentum()
		return
	last_charge_move = world.time
	steps_taken++
	if(steps_taken < steps_to_charge)
		return
	if(momentum < max_momentum)
		momentum++
		ADD_TRAIT(Xeno, TRAIT_CHARGING, TRAIT_SOURCE_XENO_ACTION_CHARGE)
		Xeno.update_icons()
		if(momentum == max_momentum)
			Xeno.emote("roar")
	//X.use_plasma(plasma_per_step) // take if you are in toggle charge mode
	if(momentum > 0)
		Xeno.use_plasma(plasma_per_step) // take plasma when you have momentum

	noise_timer = noise_timer ? --noise_timer : 3
	if(noise_timer == 3)
		playsound(Xeno, 'sound/effects/alien_footstep_charge1.ogg', 50)

	for(var/mob/living/carbon/human/Mob in Xeno.loc)
		if(Mob.body_position == LYING_DOWN && Mob.stat != DEAD)
			Xeno.visible_message(SPAN_DANGER("[capitalize(Xeno.declent_ru(NOMINATIVE))] переезжает [Mob.declent_ru(ACCUSATIVE)]!"),
				SPAN_DANGER("Мы переезжаем [Mob.declent_ru(ACCUSATIVE)]!")
			)
			var/ram_dir = pick(get_perpen_dir(Xeno.dir))
			var/dist = 1
			if(momentum == max_momentum)
				dist = momentum * 0.25
			step(Mob, ram_dir, dist)
			Mob.take_overall_armored_damage(momentum * 6)
			INVOKE_ASYNC(Mob, TYPE_PROC_REF(/mob/living/carbon/human, emote),"pain")
			shake_camera(Mob, 7,3)
			animation_flash_color(Mob)

	Xeno.recalculate_speed()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	if(new_dir != charge_dir)
		charge_dir = new_dir
		if(momentum)
			stop_momentum()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_river(datum/source, covered)
	SIGNAL_HANDLER
	if(!covered)
		stop_momentum()

/datum/action/xeno_action/onclick/charger_charge/proc/update_speed(mob/living/carbon/xenomorph/Xeno)
	SIGNAL_HANDLER
	Xeno.speed += momentum * speed_per_momentum

/datum/action/xeno_action/onclick/charger_charge/proc/stop_momentum(datum/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/Xeno = owner
	if(momentum == max_momentum)
		Xeno.visible_message(SPAN_DANGER("[capitalize(Xeno.declent_ru(NOMINATIVE))] тормозит!")) // SS220 EDIT ADDICTION

	REMOVE_TRAIT(Xeno, TRAIT_CHARGING, TRAIT_SOURCE_XENO_ACTION_CHARGE)
	steps_taken = 0
	momentum = 0
	Xeno.recalculate_speed()
	Xeno.update_icons()

/datum/action/xeno_action/onclick/charger_charge/proc/lose_momentum(amount)
	if(amount >= momentum)
		stop_momentum()
	else
		momentum -= amount
		var/mob/living/carbon/xenomorph/Xeno = owner
		Xeno.recalculate_speed()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_collision(mob/living/carbon/xenomorph/Xeno, atom/tar)
	SIGNAL_HANDLER
	if(!momentum)
		stop_momentum()
		return

	var/result = tar.handle_charge_collision(Xeno, src)
	switch(result)
		if(XENO_CHARGE_TRY_MOVE)
			if(step(Xeno, charge_dir))
				return COMPONENT_LIVING_COLLIDE_HANDLED

/datum/action/xeno_action/onclick/charger_charge/proc/start_charging(datum/source)
	SIGNAL_HANDLER
	steps_taken = steps_to_charge


/datum/action/xeno_action/activable/tumble
	name = "Tumble"
	action_icon_state = "tumble"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_tumble
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2

	plasma_cost = 25
	xeno_cooldown = 10 SECONDS

/datum/action/xeno_action/activable/tumble/proc/on_end_throw(start_charging)
	var/mob/living/carbon/xenomorph/Xeno = owner
	Xeno.flags_atom &= ~DIRLOCK
	if(start_charging)
		SEND_SIGNAL(Xeno, COMSIG_XENO_START_CHARGING)


/datum/action/xeno_action/activable/tumble/proc/handle_mob_collision(mob/living/carbon/Mob)
	var/mob/living/carbon/xenomorph/Xeno = owner
	Xeno.visible_message(SPAN_XENODANGER("[capitalize(Xeno.declent_ru(NOMINATIVE))] делает взмах хвостом в сторону, сбивая с ног [Mob.declent_ru(ACCUSATIVE)]!"), SPAN_XENODANGER("Мы делаем взмах хвостом в сторону, сбивая с ног [Mob.declent_ru(ACCUSATIVE)]!")) // SS220 EDIT ADDICTION
	var/turf/target_turf = get_turf(Mob)
	playsound(Mob,'sound/weapons/alien_claw_block.ogg', 50, 1)
	Mob.apply_damage(15,BRUTE)
	if(ishuman(Mob))
		var/mob/living/carbon/human/Human = Mob
		Xeno.throw_carbon(Human, distance = 1)
		Human.apply_effect(1, WEAKEN)
	else
		Mob.apply_effect(1, WEAKEN)
	if(!LinkBlocked(Xeno, get_turf(Xeno), target_turf))
		Xeno.forceMove(target_turf)
