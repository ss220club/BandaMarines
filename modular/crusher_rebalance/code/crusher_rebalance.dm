/mob/living/carbon/xenomorph/crusher
	base_actions = list(
		/datum/action/xeno_action/onclick/toggle_seethrough,
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/release_haul,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/activable/pounce/crushing_onslaught,
		/datum/action/xeno_action/onclick/crusher_stomp,
		/datum/action/xeno_action/onclick/crusher_shield,
	)

/datum/xeno_strain/charger
	actions_to_remove = list(
		/datum/action/xeno_action/onclick/crusher_stomp,
		/datum/action/xeno_action/onclick/crusher_shield,
		/datum/action/xeno_action/activable/pounce/crushing_onslaught,
	)

/datum/action/xeno_action/activable/pounce/crushing_onslaught
	name = "Crushing Onslaught"
	action_icon_state = "ready_charge"
	action_text = "charge"
	macro_path = /datum/action/xeno_action/verb/verb_crushing_onslaught
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1
	xeno_cooldown = 16 SECONDS
	plasma_cost = 20
	// Config options
	distance = 6
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
	// Two-stage activation
	var/charge_slowdown = 3
	var/charge_window = 5 SECONDS
	var/activated_once = FALSE
	var/slowdown_active = FALSE
	var/charge_timeout_timer_id = TIMER_ID_NULL
	var/winding_up = FALSE

/datum/action/xeno_action/verb/verb_crushing_onslaught()
	set category = "Alien"
	set name = "Сrushing Onslaught"
	set hidden = TRUE
	var/action_name = "Сrushing Onslaught"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/activable/pounce/crushing_onslaught/New()
	. = ..()
	pounce_callbacks.Remove(/mob)

/datum/action/xeno_action/activable/pounce/crushing_onslaught/initialize_pounce_pass_flags()
	pounce_pass_flags = PASS_CRUSHER_CHARGE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/Destroy()
	activated_once = TRUE
	charge_reset()
	return ..()

/datum/action/xeno_action/activable/pounce/crushing_onslaught/use_ability(atom/target)
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
		activated_once = TRUE
		xeno.fortify = TRUE

		playsound(xeno, 'sound/effects/alien_footstep_charge1.ogg', 50)
		xeno.visible_message(SPAN_XENODANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] начинает заряжать рывок!"), SPAN_XENODANGER("Мы начинаем заряжать рывок!"))

		xeno.set_face_dir(get_cardinal_dir(xeno, target))
		apply_charge_slowdown()
		pre_windup_effects()
		xeno.xeno_jitter(windup_duration + charge_window)
		apply_cooldown()
		if(!do_after(xeno, windup_duration, INTERRUPT_INCAPACITATED|INTERRUPT_CHANGED_LYING, BUSY_ICON_HOSTILE))
			to_chat(xeno, SPAN_XENODANGER("Мы отменяем подготовку рывка!"))
			winding_up = FALSE
			charge_reset()
			return

		winding_up = FALSE
		to_chat(xeno, SPAN_XENOWARNING("Мы готовы к рывку!"))
		playsound(xeno, 'sound/effects/alien_footstep_charge2.ogg', 50)
		charge_timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(charge_reset)), charge_window, TIMER_STOPPABLE)
		return ..()
	else
		if(charge_timeout_timer_id != TIMER_ID_NULL)
			deltimer(charge_timeout_timer_id)
		if(!execute_charge(target))
			charge_reset()
		return TRUE

//copy of old crusher code START
/datum/action/xeno_action/activable/pounce/crushing_onslaught/pre_windup_effects()
	RegisterSignal(owner, COMSIG_XENO_PRE_CALCULATE_ARMOURED_DAMAGE_PROJECTILE, PROC_REF(check_directional_armor))

	var/mob/living/carbon/xenomorph/xeno_owner = owner
	if(!istype(xeno_owner))
		return

	var/datum/behavior_delegate/crusher_base/crusher_delegate = xeno_owner.behavior_delegate
	if(!istype(crusher_delegate))
		return

	crusher_delegate.is_charging = TRUE
	xeno_owner.update_icons()

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/check_directional_armor(mob/living/carbon/xenomorph/X, list/damagedata)
	SIGNAL_HANDLER
	var/projectile_direction = damagedata["direction"]
	if(X.dir & REVERSE_DIR(projectile_direction))
		// During the charge windup, crusher gets an extra 15 directional armor in the direction its charging
		damagedata["armor"] += frontal_armor

/datum/action/xeno_action/activable/pounce/crushing_onslaught/post_windup_effects(interrupted)
	..()
	UnregisterSignal(owner, COMSIG_XENO_PRE_CALCULATE_ARMOURED_DAMAGE_PROJECTILE)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	if(!istype(xeno_owner))
		return

	var/datum/behavior_delegate/crusher_base/crusher_delegate = xeno_owner.behavior_delegate
	if(!istype(crusher_delegate))
		return

	addtimer(CALLBACK(src, PROC_REF(undo_charging_icon)), 0.5 SECONDS) // let the icon be here for a bit, it looks cool

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/undo_charging_icon()
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	if(!istype(xeno_owner))
		return

	var/datum/behavior_delegate/crusher_base/crusher_delegate = xeno_owner.behavior_delegate
	if(!istype(crusher_delegate))
		return

	crusher_delegate.is_charging = FALSE
	xeno_owner.update_icons()

//copy of old crusher code END

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/apply_charge_slowdown()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(slowdown_active || !istype(xeno))
		return
	xeno.speed_modifier += charge_slowdown
	xeno.recalculate_speed()
	slowdown_active = TRUE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/remove_charge_slowdown()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!slowdown_active || !istype(xeno))
		return
	xeno.speed_modifier -= charge_slowdown
	xeno.recalculate_speed()
	slowdown_active = FALSE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/charge_reset()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno) || !activated_once)
		return
	to_chat(xeno, SPAN_XENOWARNING("Мы больше не удерживаем стойку!"))
	xeno.stop_xeno_jitter()
	remove_charge_slowdown()
	post_windup_effects(interrupted = FALSE)
	if(charge_timeout_timer_id != TIMER_ID_NULL)
		deltimer(charge_timeout_timer_id)
	charge_timeout_timer_id = TIMER_ID_NULL
	activated_once = FALSE
	xeno.fortify = FALSE


/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/execute_charge(atom/target)
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
	RegisterSignal(xeno, COMSIG_MOVABLE_MOVED, PROC_REF(charge_move))
	xeno.throw_atom(target, distance, throw_speed, xeno, launch_type = LOW_LAUNCH, pass_flags = pounce_pass_flags, collision_callbacks = pounce_callbacks, end_throw_callbacks = list(CALLBACK(src, PROC_REF(charge_end))), tracking=TRUE)
	xeno.update_icons()

	return TRUE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/charge_end(atom/movable/thrown_atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return
	if(istype(thrown_atom, /mob/living/carbon/xenomorph))
		xeno = thrown_atom
	UnregisterSignal(xeno, list(COMSIG_MOVABLE_TURF_ENTER, COMSIG_MOVABLE_MOVED))
	xeno.emote("roar")
	REMOVE_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_ABILITY("Crusher Charge"))
	charge_reset()

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/find_blocking_atoms(turf/starting_turf, move_dir)
	var/turf/entering_turf = get_step(starting_turf, move_dir)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno) || !istype(starting_turf))
		return NONE

	for(var/atom/A in starting_turf)
		if(!A.can_block_movement || isliving(A))
			continue
		if(A.BlockedExitDirs(xeno, move_dir))
			return A

	for(var/atom/A in entering_turf)
		if(!A.can_block_movement || isliving(A))
			continue
		if(A.BlockedPassDirs(xeno, move_dir))
			return A
	return NONE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/bonk_obstacle(list/collided_obstacle_list, mob/living/carbon/xenomorph/xeno)
	var/bonked_obstacle = pick(collided_obstacle_list)

	if(istype(bonked_obstacle, /obj))
		INVOKE_ASYNC(src, PROC_REF(handle_collision), bonked_obstacle, xeno)
	else if(istype(bonked_obstacle, /turf))
		INVOKE_ASYNC(xeno, TYPE_PROC_REF(/mob/living/carbon/xenomorph/crusher, pounced_turf), bonked_obstacle)

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/charge_turf_enter(mob/living/carbon/xenomorph/xeno, turf/entering_turf)
	SIGNAL_HANDLER
	if(!istype(xeno) || !istype(entering_turf))
		return NONE

	var/move_dir = get_dir(xeno, entering_turf)
	var/atom/collided_obstacle
	if(move_dir & (NORTH|SOUTH) && move_dir & (EAST|WEST))
		var/list/collided_obstacle_list = list()
		var/list/possible_way_turf = list()
		for(var/direction in list(NORTH, WEST, EAST, SOUTH))
			if(move_dir & direction)
				collided_obstacle = find_blocking_atoms(xeno.loc, direction)
				if(istype(collided_obstacle))
					collided_obstacle_list += collided_obstacle
				else
					var/turf/side_turf = get_step(xeno, direction)
					if(!side_turf.density)
						possible_way_turf += side_turf
					else
						collided_obstacle_list += side_turf
		if(length(collided_obstacle_list) == 2)
			bonk_obstacle(collided_obstacle_list, xeno)
			return NONE
		else
			collided_obstacle_list.Cut()
			var/possible_way_dir
			for(var/way_turf in possible_way_turf)
				possible_way_dir = get_dir(way_turf, entering_turf)
				collided_obstacle = find_blocking_atoms(way_turf, possible_way_dir)
				if(!istype(collided_obstacle))
					break
				else
					collided_obstacle_list += collided_obstacle
			if(istype(collided_obstacle))
				bonk_obstacle(collided_obstacle_list, xeno)
				return NONE

	// Don't override if the turf itself is impassable
	if(entering_turf.density)
		bonk_obstacle(list(entering_turf), xeno)
		return NONE

	collided_obstacle = find_blocking_atoms(xeno.loc, move_dir)
	if(!istype(collided_obstacle))
		return COMPONENT_TURF_ALLOW_MOVEMENT
	bonk_obstacle(list(collided_obstacle), xeno)
	return NONE

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/charge_move(mob/living/carbon/xenomorph/xeno, atom/oldloc, direction, forced)
	SIGNAL_HANDLER
	if(!istype(xeno) || !HAS_TRAIT(xeno, TRAIT_CHARGING))
		return

	// Apply charge collision effects to every obj and mob we moved onto
	for(var/atom/A in xeno.loc)
		if(A == xeno)
			continue
		if(A.can_block_movement)
			if(ishuman(A))
				INVOKE_ASYNC(src, PROC_REF(handle_human_collision), A, xeno)
			else if(isxeno(A))
				INVOKE_ASYNC(src, PROC_REF(handle_xeno_collision), A, xeno)
			else if(iscarbon(A))
				INVOKE_ASYNC(src, PROC_REF(handle_carbon_collision), A, xeno)
		else
			INVOKE_ASYNC(src, PROC_REF(handle_collision), A, xeno)

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/handle_human_collision(mob/living/carbon/human/human, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(human) || human.stat == DEAD)
		return
	playsound(human.loc, "punch", 25, TRUE)
	human.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
	xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [human] ([human.ckey])</font>")
	log_attack("[xeno] ([xeno.ckey]) crusher charged [human] ([human.ckey])")

	var/randomized_hit_zone
	randomized_hit_zone = pick (
			303; "chest", //70% for chest
			GLOB.organ_rel_size["groin"]; "groin",
			GLOB.organ_rel_size["l_arm"]; "l_arm",
			GLOB.organ_rel_size["r_arm"]; "r_arm",
			GLOB.organ_rel_size["l_leg"]; "l_leg",
			GLOB.organ_rel_size["r_leg"]; "r_leg"
		)
	human.apply_armoured_damage(direct_hit_damage, ARMOR_MELEE, BRUTE, randomized_hit_zone, 5)
	xeno.visible_message(
		SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] таранит [human.declent_ru(ACCUSATIVE)]!"),
		SPAN_XENODANGER("Вы тараните [human.declent_ru(ACCUSATIVE)]!")
	)

	human.set_effect(knockdown_duration, WEAKEN)
	human.set_effect(knockdown_duration, STUN)
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

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/handle_xeno_collision(mob/living/carbon/xenomorph/target_xeno, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(target_xeno) || HAS_TRAIT_FROM(target_xeno, TRAIT_UNDENSE, LYING_DOWN_TRAIT))
		return

	if(!xeno.ally_of_hivenumber(target_xeno.hivenumber))
		target_xeno.attack_log += text("\[[time_stamp()]\] <font color='orange'>was crusher charged by [xeno] ([xeno.ckey])</font>")
		xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>crusher charged [target_xeno] ([target_xeno.ckey])</font>")
		log_attack("[xeno] ([xeno.ckey]) crusher charged [target_xeno] ([target_xeno.ckey])")
		target_xeno.apply_damage(direct_hit_damage * 0.5, BRUTE)

	if((isqueen(target_xeno) || IS_XENO_LEADER(target_xeno) ||  isboiler(target_xeno))) // boilers because they have long c/d and warmups, get griefed hard if stunned
		var/facing_dir = xeno.dir
		xeno.throw_atom(get_step(xeno, reverse_direction(facing_dir)), 1, 3, target_xeno)
		xeno.face_dir(facing_dir)
		return //antigrief
	if(target_xeno.anchored || target_xeno.mob_size >= MOB_SIZE_IMMOBILE)
		if(!target_xeno.anchored)
			target_xeno.apply_effect(1, WEAKEN)
			target_xeno.throw_atom(get_step(target_xeno, pick(GLOB.cardinals)), 1, 3, target_xeno, TRUE)
		xeno.apply_effect(1, WEAKEN)
		xeno.throw_atom(get_step(xeno, pick(GLOB.cardinals)), 1, 3, target_xeno, TRUE)
		playsound(get_turf(xeno), 'sound/effects/bang.ogg', 25, 0)
		return

	playsound(target_xeno.loc, "punch", 25, TRUE)
	var/list/ram_dirs = get_perpen_dir(xeno.dir)
	var/ram_dir = pick(ram_dirs)
	var/cur_turf = get_turf(target_xeno)
	var/target_turf = get_step(target_xeno, ram_dir)
	xeno.visible_message(
			SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает [target_xeno.declent_ru(ACCUSATIVE)] в сторону!"),
			SPAN_DANGER("Вы отбрасываете [target_xeno.declent_ru(ACCUSATIVE)] в сторону!")
		)
	to_chat(target_xeno, SPAN_XENOHIGHDANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] отбрасывает вас в сторону! С дороги!"))
	if(LinkBlocked(target_xeno, cur_turf, target_turf))
		ram_dir = REVERSE_DIR(ram_dir)
		target_turf = get_step(target_xeno, ram_dir)
	target_xeno.set_effect(0.5, WEAKEN)
	target_xeno.throw_atom(target_turf, 1, 3, xeno, TRUE)

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/handle_carbon_collision(mob/living/carbon/mob, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(mob) || mob.stat == DEAD)
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

	mob.set_effect(knockdown_duration, WEAKEN)
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

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/handle_collision(atom/target, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(target, /obj))
		return

	//Barricade collision
	else if (istype(target, /obj/structure/barricade))
		var/obj/structure/barricade/blockade_in_path = target
		if(blockade_in_path.BlockedExitDirs(xeno, xeno.last_move_dir) || blockade_in_path.BlockedPassDirs(xeno, xeno.last_move_dir))
			xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] врезается в [blockade_in_path.declent_ru(ACCUSATIVE)] и тормозит!"), SPAN_XENOWARNING("Мы врезаемся в [blockade_in_path.declent_ru(ACCUSATIVE)] и тормозим!")) // SS220 EDIT ADDICTION
			blockade_in_path.Collided(xeno)
			. =  FALSE
		. = TRUE

	//Vehicle collision
	else if (istype(target, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/vehicle_in_path = target
		xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] врезается в [vehicle_in_path.declent_ru(ACCUSATIVE)] и тормозит!"), SPAN_XENOWARNING("Мы врезаемся в [vehicle_in_path.declent_ru(ACCUSATIVE)] и тормозим!")) // SS220 EDIT ADDICTION

		vehicle_in_path.Collided(xeno)
		. = FALSE

	//M56d machine gun collision
	else if (istype(target, /obj/structure/machinery/m56d_hmg))
		var/obj/structure/machinery/m56d_hmg/weapon_in_path = target
		xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] таранит [weapon_in_path.declent_ru(ACCUSATIVE)]!"), SPAN_XENODANGER("Мы тараним [weapon_in_path.declent_ru(ACCUSATIVE)]!")) // SS220 EDIT ADDICTION
		playsound(xeno.loc, 'sound/effects/metalhit.ogg', 25, 1)
		weapon_in_path.CrusherImpact()
		. =  FALSE

	//Window collision
	else if (istype(target, /obj/structure/window))
		var/obj/structure/window/window_in_path = target
		if (window_in_path.unacidable)
			. = FALSE
		else
			var/obj/structure/window/framed/window_framed_in_path
			var/window_frame_type
			var/turf/window_loc
			if(istype(window_in_path, /obj/structure/window/framed))
				window_framed_in_path = target
				window_frame_type = window_framed_in_path.window_frame
				window_loc = window_in_path.loc
			window_in_path.health = 0
			window_in_path.healthcheck(user = xeno)
			if(istype(window_framed_in_path))
				if(window_framed_in_path.reinf)
					. = FALSE
				else
					var/obj/structure/window_frame/left_window_frame = locate(window_frame_type) in window_loc
					if(left_window_frame)
						handle_collision(left_window_frame)

			. =  TRUE

	//Window frame collision
	else if (istype(target, /obj/structure/window_frame))
		var/obj/structure/window_frame/window_frame_in_path = target
		if (window_frame_in_path.unacidable)
			. = FALSE
		else
			window_frame_in_path.deconstruct(FALSE)
			playsound(xeno.loc, 'sound/effects/metalhit.ogg', 25, 1)
			. = TRUE

	//Airlocks collision
	else if (istype(target, /obj/structure/machinery/door/airlock))
		var/obj/structure/machinery/door/airlock/airlock_in_path = target

		if(airlock_in_path.density)
			return airlock_in_path.take_damage(airlock_in_path.damage_cap)

	//Grille collision
	else if (istype(target, /obj/structure/grille))
		var/obj/structure/grille/grille_in_path = target
		if(grille_in_path.unacidable)
			. =  FALSE
		else
			playsound(xeno.loc, 'sound/effects/grillehit.ogg', 25, 1)
			grille_in_path.health -=  80 //Usually knocks it down.
			grille_in_path.healthcheck()
			. = TRUE

	//Table collision
	else if (istype(target, /obj/structure/surface/table))
		var/obj/structure/surface/table/table_in_path = target
		table_in_path.Crossed(xeno)
		. = TRUE

	//Turrets, Tesla Coil etc. collision
	else if (istype(target, /obj/structure/machinery/defenses))
		var/obj/structure/machinery/defenses/defenses_in_path = target
		xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] таранит [defenses_in_path.declent_ru(ACCUSATIVE)]!"), SPAN_XENODANGER("Мы тараним [defenses_in_path.declent_ru(ACCUSATIVE)]!")) // SS220 EDIT ADDICTION

		playsound(xeno.loc, 'sound/effects/metalhit.ogg', 25, 1)
		defenses_in_path.update_health(direct_hit_damage)
		. =  FALSE

	//Vending machines collision
	else if (istype(target, /obj/structure/machinery/vending) || istype(target, /obj/structure/machinery/cm_vending))
		var/obj/structure/machinery/vending/vending_in_path = target

		if (vending_in_path.unslashable)
			. = FALSE
		else
			xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] врезается прямо в [vending_in_path.declent_ru(ACCUSATIVE)]!"), SPAN_XENODANGER("Мы врезаемся прямо в [vending_in_path.declent_ru(ACCUSATIVE)]!")) // SS220 EDIT ADDICTION
			playsound(xeno.loc, "slam", 25, 1)
			vending_in_path.tip_over()

			var/impact_range = 1
			var/turf/turfs_charged_at = reverse_direction(xeno.last_move_dir)
			turfs_charged_at = get_step_away(turfs_charged_at, xeno)
			var/launch_speed = 2
			xeno.throw_atom(turfs_charged_at, impact_range, launch_speed)

			. =  FALSE

	//Fences collision
	else if(istype(target, /obj/structure/fence/electrified))
		var/obj/structure/fence/electrified/fence = target
		if (fence.cut)
			. = FALSE
		else
			xeno.visible_message(SPAN_DANGER("[src] врезается прямо в [fence]!"))
			playsound(xeno.loc, 'sound/effects/fencehit.ogg', 25, 1)
			fence.cut_grille()
			. = TRUE

	// Anything else?
	else
		if (isobj(target))
			var/obj/object_in_path = target
			if(!object_in_path.density) // collide with obj that interrupt dash
				return TRUE
			if (object_in_path.unacidable) // can't break unbreakable
				. = FALSE

			//Immovable obj
			else if (object_in_path.anchored)
				xeno.visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] раздавливает [object_in_path.declent_ru(ACCUSATIVE)]!"), SPAN_XENODANGER("Мы раздавливаем [object_in_path.declent_ru(ACCUSATIVE)]!"))
				if(istype(object_in_path, /obj/structure/platform))
					var/obj/structure/platform/platform_in_path = object_in_path
					platform_in_path.broken()
					. = TRUE
				else
					destroy_obj_in_path(object_in_path, xeno)
					. = FALSE

			//Movable obj
			else  //Canisters, crates etc. go flying
				if(object_in_path.buckled_mob)
					object_in_path.unbuckle()
				xeno.visible_message(SPAN_WARNING("[capitalize(declent_ru(NOMINATIVE))] отбрасывает [object_in_path.declent_ru(ACCUSATIVE)] в сторону!"), SPAN_XENOWARNING("Мы отбрасываем [object_in_path.declent_ru(ACCUSATIVE)] в сторону."))

				var/turf/turfs_to_get = xeno.get_diagonal_step(object_in_path, xeno.dir)
				turfs_to_get = get_step_away(turfs_to_get, xeno)

				var/impact_range = pick(1,2)
				var/launch_speed = 2
				var/old_loc = object_in_path.loc
				object_in_path.throw_atom(turfs_to_get, impact_range, launch_speed)

				if(old_loc == object_in_path.loc) //if obj do not move from the way it will be destroyed
					xeno.visible_message(SPAN_WARNING("[object_in_path.declent_ru(ACCUSATIVE)] разбит[genderize_ru(object_in_path.gender, "", "а", "о", "ы")] вдребезги!"), SPAN_XENOWARNING("Мы разбиваем [object_in_path.declent_ru(ACCUSATIVE)]!"))
					destroy_obj_in_path(object_in_path, xeno)
				. = TRUE

	if (!.)
		xeno.update_icons()

/datum/action/xeno_action/activable/pounce/crushing_onslaught/proc/destroy_obj_in_path(obj/object_in_path, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		xeno = owner
	if(!istype(xeno) || !istype(object_in_path))
		return
	if(length(object_in_path.contents)) // So the contents of containers dont delete themselves as well
		var/turf/turf_for_obj = get_turf(xeno)
		for(var/atom/movable/stuff_to_move in object_in_path.contents) stuff_to_move.forceMove(turf_for_obj)
	playsound(xeno.loc, "punch", 25, 1)
	qdel(object_in_path)

/mob/living/carbon/xenomorph/launch_impact(atom/hit_atom) // wall bonk
	if(HAS_TRAIT(src, TRAIT_CHARGING))
		return
	return ..()

/mob/living/carbon/xenomorph/crusher/pounced_turf(turf/pounced_turf)
	visible_message(SPAN_DANGER("[capitalize(declent_ru(NOMINATIVE))] врезается в [pounced_turf.declent_ru(ACCUSATIVE)] и тормозит!"), SPAN_XENOWARNING("Мы врезаемся в [pounced_turf.declent_ru(ACCUSATIVE)] и тормозим!")) // SS220 EDIT ADDICTION
	pounced_turf.ex_act(EXPLOSION_THRESHOLD_VLOW, , create_cause_data(caste_type, src))
	..(pounced_turf)

//copy of old code with the edit of skills that get CD reduction
/datum/behavior_delegate/crusher_base/melee_attack_additional_effects_target(mob/living/carbon/target) //Stomp get CD reduction as Charge and Shield
	if (!isxeno_human(target))
		return

	new /datum/effects/xeno_slow(target, bound_xeno, ttl = 2 SECONDS)

	var/damage = bound_xeno.melee_damage_upper * aoe_slash_damage_reduction

	var/base_cdr_amount = 1.5 SECONDS
	var/cdr_amount = base_cdr_amount
	for (var/mob/living/carbon/aoe_targets in orange(1, target))
		if (aoe_targets.stat == DEAD)
			continue

		if(!isxeno_human(aoe_targets) || bound_xeno.can_not_harm(aoe_targets))
			continue

		if (HAS_TRAIT(aoe_targets, TRAIT_NESTED))
			continue

		cdr_amount += 0.5 SECONDS

		to_chat(aoe_targets, SPAN_XENODANGER("[bound_xeno] атакует [aoe_targets]!")) // SS220 EDIT ADDICTION
		to_chat(bound_xeno, SPAN_XENODANGER("Мы атакуем [aoe_targets]!")) // SS220 EDIT ADDICTION

		bound_xeno.flick_attack_overlay(aoe_targets, "slash")

		aoe_targets.last_damage_data = create_cause_data(initial(bound_xeno.name), bound_xeno)
		//Logging, including anti-rulebreak logging
		if(aoe_targets.status_flags & XENO_HOST && aoe_targets.stat != DEAD)
			//Host might be rogue, needs further investigation
			aoe_targets.attack_log += text("\[[time_stamp()]\] <font color='orange'>was slashed by [key_name(bound_xeno)] while they were infected</font>")
			bound_xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>slashed [key_name(aoe_targets)] while they were infected</font>")
		else //Normal xenomorph friendship with benefits
			aoe_targets.attack_log += text("\[[time_stamp()]\] <font color='orange'>was slashed by [key_name(bound_xeno)]</font>")
			bound_xeno.attack_log += text("\[[time_stamp()]\] <font color='red'>slashed [key_name(aoe_targets)]</font>")
		log_attack("[key_name(bound_xeno)] slashed [key_name(aoe_targets)]")
		aoe_targets.apply_armoured_damage(get_xeno_damage_slash(aoe_targets, damage), ARMOR_MELEE, BRUTE, bound_xeno.zone_selected)

	var/datum/action/xeno_action/onclick/crusher_shield/shAction = get_action(bound_xeno, /datum/action/xeno_action/onclick/crusher_shield)
	if (!shAction.action_cooldown_check())
		shAction.reduce_cooldown(base_cdr_amount)

	var/datum/action/xeno_action/onclick/crusher_stomp/stAction = get_action(bound_xeno, /datum/action/xeno_action/onclick/crusher_stomp)
	if (!stAction.action_cooldown_check())
		stAction.reduce_cooldown(base_cdr_amount)

	var/datum/action/xeno_action/activable/pounce/crushing_onslaught/cAction = get_action(bound_xeno, /datum/action/xeno_action/activable/pounce/crushing_onslaught)
	if (!cAction.action_cooldown_check())
		cAction.reduce_cooldown(cdr_amount)
