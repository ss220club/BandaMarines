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
	var/charge_slowdown = 3
	// Object types that don't reduce cooldown when hit
	var/list/not_reducing_objects = list()
	// Two-stage activation
	var/charge_window = 5 SECONDS
	var/activated_once = FALSE
	var/slowdown_active = FALSE
	var/atom/stored_target = null
	var/charge_timeout_timer_id = TIMER_ID_NULL

/datum/action/xeno_action/activable/pounce/crusher_charge/New()
	. = ..()
	not_reducing_objects = typesof(/obj/structure/barricade) + typesof(/obj/structure/machinery/defenses)
	pounce_callbacks = list()
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
		if(!check_and_use_plasma_owner())
			return

		xeno.visible_message(SPAN_XENODANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] начинает заряжать рывок!"), SPAN_XENODANGER("Мы начинаем заряжать рывок!"))

		xeno.set_face_dir(get_cardinal_dir(xeno, target))
		apply_charge_slowdown()

		pre_windup_effects()

		xeno.xeno_jitter(windup_duration + charge_window)

		if(!do_after(xeno, windup_duration, INTERRUPT_INCAPACITATED|INTERRUPT_CHANGED_LYING, BUSY_ICON_HOSTILE))
			to_chat(xeno, SPAN_XENODANGER("Мы отменяем зарядку рывка!"))
			remove_charge_slowdown()
			post_windup_effects(interrupted = TRUE)
			xeno.stop_xeno_jitter()
			return

		activated_once = TRUE
		stored_target = target
		apply_cooldown()

		to_chat(xeno, SPAN_XENOWARNING("Рывок заряжен!"))

		charge_timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(charge_timeout)), charge_window, TIMER_STOPPABLE)
		return ..()
	else
		activated_once = FALSE
		if(charge_timeout_timer_id != TIMER_ID_NULL)
			deltimer(charge_timeout_timer_id)
			charge_timeout_timer_id = TIMER_ID_NULL

		return execute_charge(target)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/apply_charge_slowdown()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(slowdown_active || !istype(xeno))
		return
	xeno.speed_modifier += charge_slowdown
	xeno.recalculate_speed()
	slowdown_active = TRUE

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/remove_charge_slowdown()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!slowdown_active || !istype(xeno))
		return
	xeno.speed_modifier -= charge_slowdown
	xeno.recalculate_speed()
	slowdown_active = FALSE

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_timeout()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno) || !activated_once)
		return

	activated_once = FALSE
	charge_timeout_timer_id = TIMER_ID_NULL

	if(!stored_target)
		to_chat(xeno, SPAN_XENOWARNING("Наш рывок потерял цель!"))
		xeno.stop_xeno_jitter()
		remove_charge_slowdown()
		return

	to_chat(xeno, SPAN_XENOWARNING("Время вышло, мы совершаем рывок в изначальную цель!"))
	execute_charge(stored_target)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/execute_charge(atom/target)
	var/mob/living/carbon/xenomorph/xeno = owner

	// Before checks so failed charges also stop the charge-up jitter and slowdown.
	xeno.stop_xeno_jitter()
	remove_charge_slowdown()

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

	xeno.set_face_dir(get_cardinal_dir(xeno, target))

	xeno.visible_message(SPAN_XENOWARNING("[xeno] [action_text][findtext(action_text, "e", -1) || findtext(action_text, "p", -1) ? "s" : "es"] в [target]!"), SPAN_XENOWARNING("Мы [action_text] в [target]!"))

	pre_pounce_effects()

	ADD_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_ABILITY("Crusher Charge"))

	xeno.pounce_distance = get_dist(xeno, target)
	if(xeno.z != target.z)
		xeno.pounce_distance += 2

	// Allow charge to pass through mobs without stopping, but still process collisions with them
	RegisterSignal(xeno, COMSIG_MOVABLE_TURF_ENTER, PROC_REF(charge_turf_enter))
	RegisterSignal(xeno, COMSIG_MOVABLE_MOVED, PROC_REF(charge_moved))

	xeno.throw_atom(target, distance, throw_speed, xeno, launch_type = LOW_LAUNCH, pass_flags = pounce_pass_flags, collision_callbacks = pounce_callbacks, end_throw_callbacks = list(CALLBACK(src, PROC_REF(charge_end))), tracking=TRUE)
	xeno.update_icons()

	return TRUE

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_end(atom/movable/thrown_atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return

	UnregisterSignal(xeno, list(COMSIG_MOVABLE_TURF_ENTER, COMSIG_MOVABLE_MOVED))

	REMOVE_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_ABILITY("Crusher Charge"))

	additional_effects_always()

	post_windup_effects(interrupted = FALSE)

	xeno.update_icons()

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_turf_enter(mob/living/carbon/xenomorph/xeno, turf/entering_turf)
	SIGNAL_HANDLER
	if(!istype(xeno) || !istype(entering_turf))
		return NONE

	// Don't override if the turf itself is impassable
	if(entering_turf.density && entering_turf.turf_flags & TURF_HULL)
		return NONE

	var/move_dir = get_dir(xeno, entering_turf)

	// Only allow movement if the only blockers are living mobs
	for(var/atom/A in entering_turf)
		if(A == xeno || !A.can_block_movement)
			continue
		if(isliving(A))
			continue
		if(A.BlockedPassDirs(xeno, move_dir))
			return NONE

	return COMPONENT_TURF_ALLOW_MOVEMENT

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_moved(mob/living/carbon/xenomorph/xeno, atom/oldloc, direction, forced)
	SIGNAL_HANDLER
	if(!istype(xeno) || !HAS_TRAIT(xeno, TRAIT_CHARGING))
		return

	// Apply charge collision effects to every mob we moved onto
	for(var/mob/living/M in xeno.loc)
		if(M == xeno)
			continue
		if(ishuman(M))
			INVOKE_ASYNC(src, PROC_REF(handle_human_collision), M)
		else if(isxeno(M))
			INVOKE_ASYNC(src, PROC_REF(handle_xeno_collision), M)
		else
			INVOKE_ASYNC(src, PROC_REF(handle_mob_collision), M)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_charge_collision(mob/living/carbon/xenomorph/xeno, atom/target_atom)
	// Only handle mob collisions, let objects/turfs stop the charge
	if(!isliving(target_atom))
		return

	// Call appropriate handler based on mob type
	if(ishuman(target_atom))
		handle_human_collision(target_atom)
	else if(isxeno(target_atom))
		handle_xeno_collision(target_atom)
	else if(isliving(target_atom))
		handle_mob_collision(target_atom)

	// Return signal to continue movement through the mob
	return COMPONENT_LIVING_COLLIDE_HANDLED

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_human_collision(mob/living/carbon/human/human)
	var/mob/living/carbon/xenomorph/xeno = owner

	playsound(human.loc, "punch", 25, TRUE)
	human.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
	xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [human] ([human.ckey])</font>")
	log_attack("[xeno] ([xeno.ckey]) crusher charged [human] ([human.ckey])")

	human.apply_armoured_damage(direct_hit_damage, ARMOR_MELEE, BRUTE, "chest", 5)

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

	if(target_xeno.anchored || isqueen(target_xeno) || IS_XENO_LEADER(target_xeno) || isboiler(target_xeno))
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

// Override launch_impact for xenomorphs to handle crusher charge
/mob/living/carbon/xenomorph/launch_impact(atom/hit_atom)
	// If crusher is charging through mobs, handle collisions differently
	if(HAS_TRAIT(src, TRAIT_CHARGING) && isliving(hit_atom))
		var/datum/action/xeno_action/activable/pounce/crusher_charge/charge_ability = get_action(src, /datum/action/xeno_action/activable/pounce/crusher_charge)
		if(charge_ability)
			// Handle the collision but don't stop throwing
			if(ishuman(hit_atom))
				charge_ability.handle_human_collision(hit_atom)
			else if(isxeno(hit_atom))
				charge_ability.handle_xeno_collision(hit_atom)
			else if(isliving(hit_atom))
				charge_ability.handle_mob_collision(hit_atom)
			// Don't set throwing = FALSE, just return to continue the charge
			return

	// Default behavior for non-crusher-charge impacts
	return ..()
