/datum/action/xeno_action/activable/burrowed_spikes/use_ability(atom/atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return

	if(!action_cooldown_check())
		return

	if(!atom || atom.layer >= FLY_LAYER || !xeno.check_state())
		return

	if(!check_and_use_plasma_owner())
		return

	var/distance = max_distance
	var/damage = base_damage
	if(xeno.fortify)
		distance += reinforced_range_bonus
		damage += reinforced_damage_bonus

	// Get line of turfs
	var/list/turf/target_turfs = list()

	var/facing = Get_Compass_Dir(xeno, atom)
	var/turf/turf = xeno.loc
	var/turf/temp = xeno.loc
	var/list/telegraph_atom_list = list()

	for (var/x in 0 to distance)
		temp = get_step(turf, facing)
		if(facing in GLOB.diagonals) // check if it goes through corners
			var/reverse_face = GLOB.reverse_dir[facing]
			var/turf/back_left = get_step(temp, turn(reverse_face, 45))
			var/turf/back_right = get_step(temp, turn(reverse_face, -45))
			if((!back_left || back_left.density) && (!back_right || back_right.density))
				break
		if(!temp || temp.density || temp.opacity)
			break

		var/blocked = FALSE
		for(var/obj/structure/target_structure in temp)
			if(target_structure.opacity || (istype(target_structure, /obj/structure/barricade) && target_structure.density))
				blocked = TRUE
				break
		if(blocked)
			break

		turf = temp

		if (turf in target_turfs)
			break

		facing = get_dir(turf, atom)
		target_turfs += turf
		telegraph_atom_list += new /obj/effect/xenomorph/xeno_telegraph/brown(turf, 0.25 SECONDS)

	// Extract our 'optimal' turf, if it exists
	if (target_turfs.len >= 2)
		xeno.animation_attack_on(target_turfs[target_turfs.len], 15)

	playsound(xeno.loc, 'modular/impaler_strain/sound/burrower_attack.ogg', 40)
	xeno.visible_message(SPAN_XENODANGER("[xeno] shoots spikes though the ground in front of it!"), SPAN_XENODANGER("You shoot your spikes though the ground in front of you!"))

	// Loop through our turfs, finding any humans there and dealing damage to them
	INVOKE_ASYNC(src, PROC_REF(handle_damage), xeno, target_turfs, telegraph_atom_list, damage)

	apply_cooldown()
	return ..()

/datum/action/xeno_action/activable/burrowed_spikes/proc/handle_damage(mob/living/carbon/xenomorph/xeno, target_turfs, telegraph_atom_list, damage)
	for (var/turf/target_turf in target_turfs)
		telegraph_atom_list += new /obj/effect/xenomorph/ground_spike(target_turf, xeno)
		for (var/mob/living/carbon/targeted_carbon in target_turf)
			if (targeted_carbon.stat == DEAD || HAS_TRAIT(targeted_carbon, TRAIT_NESTED))
				continue

			if(xeno.can_not_harm(targeted_carbon))
				continue
			xeno.flick_attack_overlay(targeted_carbon, "slash")
			targeted_carbon.apply_armoured_damage(damage, ARMOR_MELEE, BRUTE)
			to_chat(targeted_carbon, SPAN_WARNING("You are stabbed with a spike from below!"))
			playsound(get_turf(targeted_carbon), "alien_bite", 50, TRUE)
		for(var/obj/structure/window/framed/target_window in target_turf)
			if(!target_window.unslashable)
				target_window.shatter_window(TRUE)
				playsound(target_turf, "windowshatter", 50, TRUE)
		sleep(chain_separation_delay)


/datum/action/xeno_action/activable/sunken_tail/use_ability(atom/atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return

	if(!action_cooldown_check())
		return

	if(!atom || atom.layer >= FLY_LAYER || !xeno.check_state() || xeno.action_busy)
		return

	if(HAS_TRAIT(xeno, TRAIT_ABILITY_BURROWED))
		to_chat(xeno, SPAN_XENOWARNING("You can't do this while burrowed!"))
		return

	var/distance = max_distance
	var/damage = base_damage
	var/reinforced_modified = FALSE
	if(xeno.fortify)
		distance += reinforced_range_bonus
		damage += reinforced_damage_bonus
		reinforced_modified = TRUE

	if(get_dist(atom, xeno) > distance)
		to_chat(xeno, SPAN_XENOWARNING("[atom] is too far away!"))
		return

	if(!check_clear_path_to_target(xeno, atom, FALSE))
		to_chat(xeno, SPAN_XENOWARNING("Something is blocking our path to [atom]!"))
		return

	if(!check_plasma_owner())
		return

	var/turf/target = get_turf(atom)
	var/list/telegraph_atom_list = list()

	telegraph_atom_list += new /obj/effect/xenomorph/xeno_telegraph/red(target, windup_delay)
	if(!do_after(xeno, windup_delay, INTERRUPT_ALL | BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE))
		apply_cooldown_override(5 SECONDS)
		for(var/obj/effect/tele in telegraph_atom_list)
			qdel(tele)
		return
	use_plasma_owner()
	playsound(xeno.loc, 'modular/impaler_strain/sound/burrower_attack1.ogg', 40)
	xeno.visible_message(SPAN_XENOWARNING("The [xeno] stabs its tail in the ground toward [atom]!"), SPAN_XENOWARNING("You stab your tail into the ground toward [atom]!"))
	INVOKE_ASYNC(src, PROC_REF(handle_damage), xeno, target, damage)
	if(reinforced_modified)
		recursive_spread(target, reinforced_spread_range, reinforced_spread_range, damage, target)
		addtimer(CALLBACK(src, GLOBAL_PROC_REF(playsound), xeno.loc, 'modular/impaler_strain/sound/burrower_attack.ogg', 25), windup_delay)

	apply_cooldown()
	return ..()

/datum/action/xeno_action/activable/sunken_tail/can_use_action()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!xeno)
		return
	if(HAS_TRAIT(xeno, TRAIT_ABILITY_BURROWED))
		return FALSE
	return ..()

/datum/action/xeno_action/activable/sunken_tail/proc/handle_damage(mob/living/carbon/xenomorph/xeno, target_turfs, damage, spike_circle = FALSE)
	new /obj/effect/xenomorph/ground_spike(target_turfs, xeno)
	for (var/mob/living/carbon/targeted_carbon in target_turfs)
		if (targeted_carbon.stat == DEAD || HAS_TRAIT(targeted_carbon, TRAIT_NESTED))
			continue

		if(xeno.can_not_harm(targeted_carbon))
			continue
		xeno.flick_attack_overlay(targeted_carbon, "slash")
		targeted_carbon.apply_armoured_damage(damage, ARMOR_MELEE, BRUTE)
		if(spike_circle)
			to_chat(targeted_carbon, SPAN_WARNING("You are stabbed with a spike from below!"))
		else
			to_chat(targeted_carbon, SPAN_WARNING("You are stabbed with a tail from below!"))
		playsound(get_turf(targeted_carbon), "alien_bite", 50, TRUE)
	for(var/obj/structure/window/framed/target_window in target_turfs)
		if(!target_window.unslashable)
			target_window.shatter_window(TRUE)
			playsound(target_turfs, "windowshatter", 50, TRUE)

/datum/action/xeno_action/activable/sunken_tail/proc/recursive_spread(turf/turf, dist_left, orig_depth, damage, turf/original_turf)
	if(!istype(turf))
		return
	if(!dist_left)
		return
	if(istype(turf, /turf/closed) || istype(turf, /turf/open/space))
		return

	if(turf != original_turf)
		addtimer(CALLBACK(src, PROC_REF(warning_circle), turf, owner), ((windup_delay/2)*(orig_depth - dist_left)))
		addtimer(CALLBACK(src, PROC_REF(handle_damage), owner, turf, (damage - reinforced_damage_bonus), TRUE), (((windup_delay/2)*(orig_depth - dist_left))+5))

	for(var/dirn in GLOB.alldirs)
		recursive_spread(get_step(turf, dirn), dist_left - 1, orig_depth, damage)

/datum/action/xeno_action/activable/sunken_tail/proc/warning_circle(turf/turf, mob/living/carbon/xenomorph/xeno)
	if(!istype(turf))
		return

	new /obj/effect/xenomorph/xeno_telegraph/red(turf, (windup_delay/2))

/datum/action/xeno_action/onclick/ensconce/use_ability()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return

	if(!action_cooldown_check())
		return

	if(!xeno.check_state()|| xeno.action_busy)
		return

	if(HAS_TRAIT(xeno, TRAIT_ABILITY_BURROWED))
		to_chat(xeno, SPAN_XENOWARNING("You can't do this while burrowed!"))
		return

	var/turf/turf = get_turf(xeno)
	var/obj/effect/alien/weeds/weeds = locate() in turf
	if(!weeds || !xeno.ally_of_hivenumber(weeds.hivenumber))
		to_chat(xeno, SPAN_XENOWARNING("You need to do this on weeds!"))
		return

	var/mob/living/carbon/xenomorph/burrower/burrowerfortified = locate() in turf
	if(burrowerfortified != xeno)
		if(burrowerfortified.fortify)
			to_chat(xeno, SPAN_XENOWARNING("There is already another sister burrowed here!"))
			return

	if(!check_plasma_owner())
		return

	apply_cooldown()
	if(!do_after(xeno, windup_delay, INTERRUPT_ALL | BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE))
		return

	if(burrowerfortified != xeno)
		if(burrowerfortified.fortify)
			to_chat(xeno, SPAN_XENOWARNING("There is already another sister burrowed here!"))
			return

	use_plasma_owner()

	playsound(turf, 'sound/effects/burrowing_b.ogg', 25)

	if(!xeno.fortify)
		RegisterSignal(owner, COMSIG_MOB_DEATH, PROC_REF(death_check))
		fortify_switch(xeno, TRUE)
	else
		UnregisterSignal(owner, COMSIG_MOB_DEATH)
		fortify_switch(xeno, FALSE)

	return ..()

/datum/action/xeno_action/onclick/ensconce/can_use_action()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!xeno)
		return
	if(HAS_TRAIT(xeno, TRAIT_ABILITY_BURROWED))
		return FALSE
	return ..()

/datum/action/xeno_action/onclick/ensconce/proc/fortify_switch(mob/living/carbon/xenomorph/xeno, fortify_state)
	if(xeno.fortify == fortify_state)
		return

	for(var/datum/action/act as anything in xeno.actions)
		act.update_button_icon()

	var/turf/turf = get_turf(xeno)

	if(fortify_state)
		button.icon_state = "template_active"
		to_chat(xeno, SPAN_XENOWARNING("You dig in halfway into the weeds."))
		playsound(turf, 'modular/impaler_strain/sound/burrowing_s.ogg', 25)
		xeno.armor_deflection_buff += armor_deflection_buff
		xeno.armor_explosive_buff += armor_explosive_buff
		xeno.add_traits(list(TRAIT_UNDENSE, TRAIT_IMMOBILIZED), TRAIT_SOURCE_ABILITY("Ensconce"))
		xeno.anchored = TRUE
		xeno.small_explosives_stun = FALSE
		xeno.client?.change_view(reinforced_vision_range, xeno)
		xeno.mob_size = MOB_SIZE_IMMOBILE //knockback immune
		xeno.mob_flags &= ~SQUEEZE_UNDER_VEHICLES
		xeno.fortify = TRUE
		xeno.update_icons()
		process_ensconce(xeno)
	else
		button.icon_state = "template"
		to_chat(xeno, SPAN_XENOWARNING("You resume your normal stance."))
		playsound(turf, 'sound/effects/burrowoff.ogg', 25)
		xeno.armor_deflection_buff -= armor_deflection_buff
		xeno.armor_explosive_buff -= armor_explosive_buff
		xeno.remove_traits(list(TRAIT_UNDENSE, TRAIT_IMMOBILIZED), TRAIT_SOURCE_ABILITY("Ensconce"))
		xeno.anchored = FALSE
		xeno.small_explosives_stun = TRUE
		xeno.client?.change_view(7, xeno)
		xeno.mob_size = MOB_SIZE_XENO //no longer knockback immune
		xeno.mob_flags |= SQUEEZE_UNDER_VEHICLES
		xeno.fortify = FALSE
		xeno.update_icons()

/datum/action/xeno_action/onclick/ensconce/proc/death_check()
	SIGNAL_HANDLER

	UnregisterSignal(owner, COMSIG_MOB_DEATH)
	fortify_switch(owner, FALSE)

/datum/action/xeno_action/onclick/ensconce/proc/process_ensconce(mob/living/carbon/xenomorph/xeno)
	var/turf/turf = get_turf(xeno)
	var/obj/effect/alien/weeds/weeds = locate() in turf
	if(!xeno.fortify)
		return
	if(!weeds || !xeno.ally_of_hivenumber(weeds.hivenumber) || (xeno.stat == UNCONSCIOUS && xeno.health < 0))
		fortify_switch(xeno, FALSE)
		UnregisterSignal(xeno, COMSIG_MOB_DEATH)
	if(xeno.fortify)
		addtimer(CALLBACK(src, PROC_REF(process_ensconce), xeno), 1 SECONDS)
