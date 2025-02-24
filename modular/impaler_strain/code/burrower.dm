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
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
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

/mob/living/carbon/xenomorph/burrow_off()
	if(istype(strain, /datum/xeno_strain/impaler))
		remove_temp_pass_flags(PASS_MOB_THRU|PASS_BUILDING|PASS_UNDER|PASS_BURROWED)
		mob_size = MOB_SIZE_XENO
		layer = initial(layer)
	. = ..()

/mob/living/carbon/xenomorph/proc/process_burrow_impaler(turf/turf = get_turf(src))
	if(!HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		return
	var/obj/effect/alien/weeds/weeds = locate() in turf
	if((!weeds || !ally_of_hivenumber(weeds.hivenumber)) || (stat == UNCONSCIOUS && health < 0) || (stat == DEAD))
		burrow_off()
	if(HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		addtimer(CALLBACK(src, PROC_REF(process_burrow_impaler)), 0.5 SECONDS)
