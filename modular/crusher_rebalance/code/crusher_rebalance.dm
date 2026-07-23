/datum/action/xeno_action/activable/pounce/crusher_charge
	distance = 7
	// Two-stage activation
	var/charge_slowdown = 3
	var/charge_window = 5 SECONDS
	var/activated_once = FALSE
	var/slowdown_active = FALSE
	var/charge_timeout_timer_id = TIMER_ID_NULL
	var/winding_up = FALSE

/datum/action/xeno_action/activable/pounce/crusher_charge/New()
	. = ..()
	pounce_callbacks.Remove(/mob)

/datum/action/xeno_action/activable/pounce/crusher_charge/Destroy()
	if(charge_timeout_timer_id != TIMER_ID_NULL)
		deltimer(charge_timeout_timer_id)
		charge_timeout_timer_id = TIMER_ID_NULL
	remove_charge_slowdown()
	charge_end()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(istype(xeno))
		xeno.stop_xeno_jitter()
	return ..()

/datum/action/xeno_action/activable/pounce/crusher_charge/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/xeno = owner

	if(!istype(xeno) || !xeno.check_state())
		return

	if(winding_up)
		return

	if(!activated_once && !action_cooldown_check())
		return

	if(!target || target.layer >= FLY_LAYER || !isturf(xeno.loc))
		return

	if(!activated_once)
		if(!check_and_use_plasma_owner())
			return
		winding_up = TRUE
		playsound(xeno, 'sound/effects/alien_footstep_charge1.ogg', 50)
		xeno.visible_message(SPAN_XENODANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] начинает заряжать рывок!"), SPAN_XENODANGER("Мы начинаем заряжать рывок!"))

		xeno.set_face_dir(get_cardinal_dir(xeno, target))
		apply_charge_slowdown()

		pre_windup_effects()

		xeno.xeno_jitter(windup_duration + charge_window)
		if(!do_after(xeno, windup_duration, INTERRUPT_INCAPACITATED|INTERRUPT_CHANGED_LYING, BUSY_ICON_HOSTILE))
			to_chat(xeno, SPAN_XENODANGER("Мы отменяем подготовку рывка!"))
			remove_charge_slowdown()
			post_windup_effects(interrupted = TRUE)
			xeno.stop_xeno_jitter()
			return
		winding_up = FALSE
		activated_once = TRUE
		apply_cooldown()
		to_chat(xeno, SPAN_XENOWARNING("Мы готовы к рывку!"))
		playsound(xeno, 'sound/effects/alien_footstep_charge2.ogg', 50)
		charge_timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(charge_reset)), charge_window, TIMER_STOPPABLE)
		return ..()
	else
		if(charge_timeout_timer_id != TIMER_ID_NULL)
			deltimer(charge_timeout_timer_id)
		charge_timeout_timer_id = TIMER_ID_NULL
		activated_once = FALSE
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

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_reset()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno) || !activated_once)
		return
	to_chat(xeno, SPAN_XENOWARNING("Мы больше не можем удерживать стойку!"))
	xeno.stop_xeno_jitter()
	remove_charge_slowdown()
	post_windup_effects(interrupted = FALSE)
	charge_timeout_timer_id = TIMER_ID_NULL
	activated_once = FALSE


/datum/action/xeno_action/activable/pounce/crusher_charge/proc/execute_charge(atom/target)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return FALSE

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
		to_chat(xeno, SPAN_XENOWARNING("Мы не можем осуществить натиск отсюда!"))
		return FALSE

	if(!xeno.check_state())
		return FALSE

	if(xeno.legcuffed)
		to_chat(xeno, SPAN_XENODANGER("Мы не можем осуществить натиск с этой штукой на ноге!"))
		return FALSE

	if(xeno.layer == XENO_HIDING_LAYER)
		var/datum/action/xeno_action/onclick/xenohide/hide = get_action(xeno, /datum/action/xeno_action/onclick/xenohide)
		if(hide)
			hide.post_attack()

	if(!tracks_target)
		target = get_turf(target)

	if(target.z != xeno.z)
		to_chat(xeno, SPAN_XENODANGER("Мы не можем осуществить туда натиск!"))
		return FALSE

	xeno.set_face_dir(get_cardinal_dir(xeno, target))

	xeno.visible_message(SPAN_XENOWARNING("[capitalize(xeno.declent_ru(NOMINATIVE))] несётся в [target.declent_ru(ACCUSATIVE)]!"), SPAN_XENOWARNING("Мы несёмся в [target.declent_ru(ACCUSATIVE)]!"))

	pre_pounce_effects()

	ADD_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_ABILITY("Crusher Charge"))

	xeno.pounce_distance = get_dist(xeno, target)

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
	if(istype(thrown_atom, /mob/living/carbon/xenomorph))
		xeno = thrown_atom
	UnregisterSignal(xeno, list(COMSIG_MOVABLE_TURF_ENTER, COMSIG_MOVABLE_MOVED))
	xeno.emote("roar")
	REMOVE_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_ABILITY("Crusher Charge"))

	additional_effects_always()
	post_windup_effects(interrupted = FALSE)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_turf_enter(mob/living/carbon/xenomorph/xeno, turf/entering_turf)
	SIGNAL_HANDLER
	if(!istype(xeno) || !istype(entering_turf))
		return NONE

	// Don't override if the turf itself is impassable
	if(entering_turf.density)
		INVOKE_ASYNC(xeno, TYPE_PROC_REF(/mob/living/carbon/xenomorph, handle_collision), entering_turf)
		return NONE

	var/move_dir = get_dir(xeno, entering_turf)

	// Only allow movement if the only blockers are living mobs
	for(var/atom/A in entering_turf)
		if(isliving(A) || !A.can_block_movement)
			continue
		if(isobj(A))
			INVOKE_ASYNC(xeno, TYPE_PROC_REF(/mob/living/carbon/xenomorph, handle_collision), A)
		if(A.BlockedPassDirs(xeno, move_dir))
			return NONE

	return COMPONENT_TURF_ALLOW_MOVEMENT

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/charge_moved(mob/living/carbon/xenomorph/xeno, atom/oldloc, direction, forced)
	SIGNAL_HANDLER
	if(!istype(xeno) || !HAS_TRAIT(xeno, TRAIT_CHARGING))
		return

	// Apply charge collision effects to every mob we moved onto
	for(var/atom/A in xeno.loc)
		if(A == xeno)
			continue
		if(ishuman(A))
			INVOKE_ASYNC(src, PROC_REF(handle_human_collision), A, xeno)
		else if(isxeno(A))
			INVOKE_ASYNC(src, PROC_REF(handle_xeno_collision), A, xeno)
		else if(iscarbon(A))
			INVOKE_ASYNC(src, PROC_REF(handle_carbon_collision), A, xeno)
		else
			INVOKE_ASYNC(src, TYPE_PROC_REF(/mob/living/carbon/xenomorph, handle_collision), A, xeno)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_human_collision(mob/living/carbon/human/human, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(human))
		return
	playsound(human.loc, "punch", 25, TRUE)
	human.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
	xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [human] ([human.ckey])</font>")
	log_attack("[xeno] ([xeno.ckey]) crusher charged [human] ([human.ckey])")

	var/randomized_hit_zone
	randomized_hit_zone = pick (
			GLOB.organ_rel_size["groin"]; "groin",
			GLOB.organ_rel_size["l_arm"]; "l_arm",
			GLOB.organ_rel_size["r_arm"]; "r_arm",
			GLOB.organ_rel_size["l_leg"]; "l_leg",
			GLOB.organ_rel_size["r_leg"]; "r_leg"
		)
	if (prob(70))
		randomized_hit_zone = "chest"
	human.apply_armoured_damage(direct_hit_damage, ARMOR_MELEE, BRUTE, randomized_hit_zone, 5)
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
	step(human, ram_dir)
	step(human, ram_dir)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_xeno_collision(mob/living/carbon/xenomorph/target_xeno, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(target_xeno))
		return
	playsound(target_xeno.loc, "punch", 25, TRUE)

	if(!xeno.ally_of_hivenumber(target_xeno.hivenumber))
		target_xeno.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
		xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [target_xeno] ([target_xeno.ckey])</font>")
		log_attack("[xeno] ([xeno.ckey]) crusher charged [target_xeno] ([target_xeno.ckey])")
		target_xeno.apply_damage(direct_hit_damage * 0.5, BRUTE)

	if(target_xeno.anchored || target_xeno.mob_size == MOB_SIZE_IMMOBILE)
		return

	var/list/ram_dirs = get_perpen_dir(xeno.dir)
	var/ram_dir = pick(ram_dirs)
	var/cur_turf = get_turf(target_xeno)
	var/target_turf = get_step(target_xeno, ram_dir)
	if(LinkBlocked(target_xeno, cur_turf, target_turf))
		ram_dir = REVERSE_DIR(ram_dir)
		target_turf = get_step(target_xeno, ram_dir)
		xeno.visible_message(
			SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает [target_xeno.declent_ru(ACCUSATIVE)] в сторону!"),
			SPAN_DANGER("Вы отбрасываете [target_xeno.declent_ru(ACCUSATIVE)] в сторону!")
		)
		to_chat(target_xeno, SPAN_XENOHIGHDANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает вас в сторону! С дороги!"))
		target_xeno.apply_effect(0.5, WEAKEN)
		target_xeno.throw_atom(target_turf, 1, 3, xeno, TRUE)
	else
		step(target_xeno, ram_dir)
		target_xeno.apply_effect(0.5, WEAKEN)

/datum/action/xeno_action/activable/pounce/crusher_charge/proc/handle_carbon_collision(mob/living/carbon/mob, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(mob))
		return
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
	step(mob, ram_dir)
	step(mob, ram_dir)

/mob/living/carbon/xenomorph/launch_impact(atom/hit_atom)
	if(HAS_TRAIT(src, TRAIT_CHARGING))
		return
	return ..()

/datum/behavior_delegate/crusher_base/melee_attack_additional_effects_target(mob/living/carbon/target)
	..()
	var/datum/action/xeno_action/onclick/crusher_stomp/sAction = get_action(bound_xeno, /datum/action/xeno_action/onclick/crusher_stomp)
	if (!sAction.action_cooldown_check())
		sAction.reduce_cooldown(1.5 SECONDS)
