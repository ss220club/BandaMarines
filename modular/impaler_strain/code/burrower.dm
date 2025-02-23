/datum/caste_datum/burrower/New()
	. = ..()
	available_strains += /datum/xeno_strain/impaler

/mob/living/carbon/xenomorph/burrower
	icon_xeno = 'modular/impaler_strain/icons/burrower.dmi'

/mob/living/carbon/xenomorph/burrower/can_take_strain(reset)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		to_chat(src, SPAN_WARNING("You must be unburrowed to do that."))
		return FALSE
	. = ..()

/mob/living/carbon/xenomorph/burrower/ex_act(severity)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED) && !istype(strain, /datum/xeno_strain/impaler))
		return
	else if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		var/powerfactor_value = round(severity * 0.05, 1)
		powerfactor_value = min(powerfactor_value,20)
		if(powerfactor_value > 0)
			KnockOut(powerfactor_value/5)
			Slow(powerfactor_value)
			Superslow(powerfactor_value/2)
		return
	. = ..()
/*
/mob/living/carbon/xenomorph/burrower/attack_hand(mob/user)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED) && !istype(strain, /datum/xeno_strain/impaler))
		return
	return call(src, /mob/living/carbon/xenomorph::get_projectile_hit_chance())(user)

/mob/living/carbon/xenomorph/burrower/attackby(obj/item/W, mob/living/user, list/mods)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED) && !istype(strain, /datum/xeno_strain/impaler))
		return
	return call(src, /mob/living/carbon/xenomorph::get_projectile_hit_chance())(W, user, mods)

/mob/living/carbon/xenomorph/burrower/get_projectile_hit_chance(obj/projectile/P)
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED) && !istype(strain, /datum/xeno_strain/impaler))
		return 0
	return call(src, /mob/living/carbon/xenomorph::get_projectile_hit_chance())(P)
*/
/mob/living/carbon/xenomorph/burrow()
	if(!check_state())
		return

	if(used_burrow || tunnel || is_ventcrawling || action_busy)
		return

	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return

	var/area/current_area = get_area(current_turf)
	if(current_area.flags_area & AREA_NOTUNNEL)
		to_chat(src, SPAN_XENOWARNING("There's no way to burrow here."))
		return

	if(istype(current_turf, /turf/open/floor/almayer/research/containment) || istype(current_turf, /turf/closed/wall/almayer/research/containment))
		to_chat(src, SPAN_XENOWARNING("We can't escape this cell!"))
		return

	if(clone) //Prevents burrowing on stairs
		to_chat(src, SPAN_XENOWARNING("We can't burrow here!"))
		return

	if(caste_type && GLOB.xeno_datum_list[caste_type])
		caste = GLOB.xeno_datum_list[caste_type]

	used_burrow = TRUE

	if(istype(strain, /datum/xeno_strain/impaler))
		if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
			burrow_off()
			return
		if(fortify)
			to_chat(src, SPAN_XENOWARNING("You can't do this in this stance!"))
			used_burrow = FALSE
			return
		var/obj/effect/alien/weeds/weeds = locate() in current_turf
		if(!weeds || !ally_of_hivenumber(weeds.hivenumber))
			to_chat(src, SPAN_XENOWARNING("You need to burrow on weeds!"))
			used_burrow = FALSE
			return
		to_chat(src, SPAN_XENOWARNING("You begin burrowing yourself into the weeds."))
		if(!do_after(src, 1.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
			used_burrow = FALSE
			return
		add_temp_pass_flags(PASS_MOB_THRU|PASS_BUILDING|PASS_UNDER|PASS_BURROWED)
		invisibility = 101
		alpha = 100
		anchored = TRUE
		mob_size = MOB_SIZE_BIG
		if(caste.fire_immunity == FIRE_IMMUNITY_NONE)
			RegisterSignal(src, COMSIG_LIVING_PREIGNITION, PROC_REF(fire_immune))
			RegisterSignal(src, list(
					COMSIG_LIVING_FLAMER_CROSSED,
					COMSIG_LIVING_FLAMER_FLAMED,
			), PROC_REF(flamer_crossed_immune))
		add_traits(list(TRAIT_ABILITY_BURROWED, TRAIT_UNDENSE), TRAIT_SOURCE_ABILITY("Burrow"))
		playsound(loc, 'sound/effects/burrowing_b.ogg', 25)
		update_icons()
		addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
		process_burrow_impaler()
		return

	to_chat(src, SPAN_XENOWARNING("We begin burrowing ourselves into the ground."))
	if(!do_after(src, 1.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
		return
	// TODO Make immune to all damage here.
	to_chat(src, SPAN_XENOWARNING("We burrow ourselves into the ground."))
	invisibility = 101
	alpha = 100
	anchored = TRUE
	if(caste.fire_immunity == FIRE_IMMUNITY_NONE)
		RegisterSignal(src, COMSIG_LIVING_PREIGNITION, PROC_REF(fire_immune))
		RegisterSignal(src, list(
				COMSIG_LIVING_FLAMER_CROSSED,
				COMSIG_LIVING_FLAMER_FLAMED,
		), PROC_REF(flamer_crossed_immune))
	add_traits(list(TRAIT_ABILITY_BURROWED, TRAIT_UNDENSE, TRAIT_IMMOBILIZED), TRAIT_SOURCE_ABILITY("Burrow"))
	playsound(src.loc, 'sound/effects/burrowing_b.ogg', 25)
	update_icons()
	addtimer(CALLBACK(src, PROC_REF(do_burrow_cooldown)), (caste ? caste.burrow_cooldown : 5 SECONDS))
	burrow_timer = world.time + 90 // How long we can be burrowed
	process_burrow()

/mob/living/carbon/xenomorph/burrow_off()
	if(istype(strain, /datum/xeno_strain/impaler))
		remove_temp_pass_flags(PASS_MOB_THRU|PASS_BUILDING|PASS_UNDER|PASS_BURROWED)
		mob_size = MOB_SIZE_XENO
	. = ..()

/mob/living/carbon/xenomorph/proc/process_burrow_impaler(turf/turf = get_turf(src))
	if(!HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	var/obj/effect/alien/weeds/weeds = locate() in turf
	if((!weeds || !ally_of_hivenumber(weeds.hivenumber)) || (stat == UNCONSCIOUS && health < 0) || (stat == DEAD))
		burrow_off()
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		addtimer(CALLBACK(src, PROC_REF(process_burrow_impaler)), 0.5 SECONDS)
