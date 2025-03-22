
/obj/vehicle/motorbike/Collide(atom/A)
	if(!seats[VEHICLE_DRIVER])
		return FALSE

	if(istype(A, /obj/structure/barricade/plasteel))
		return ..()

	if(istype(A, /turf/closed/wall) || \
	   istype(A, /obj/structure/barricade/sandbags) || \
	   istype(A, /obj/structure/barricade/metal) || \
	   istype(A, /obj/structure/barricade/deployable) || \
	   istype(A, /obj/structure/machinery/cryopod)) //Can no longer runover cryopods

		return FALSE

	if(!ismob(A))
		return ..()
	var/mob/M = A

	var/mod = 0
	var/bike_collide = TRUE
	switch(M.mob_size)
		if(MOB_SIZE_SMALL)
			bike_collide = FALSE
			mod = 2
		if(MOB_SIZE_HUMAN)
			mod = 1
		if(MOB_SIZE_XENO_VERY_SMALL)
			bike_collide = FALSE
			mod = 1.2
		if(MOB_SIZE_XENO_SMALL)
			mod = 0.75
		if(MOB_SIZE_XENO)
			mod = 0.5
		if(MOB_SIZE_BIG)
			mod = 0
		if(MOB_SIZE_IMMOBILE)
			mod = 0

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(isyautja(C))
			mod = 0.25
		if(mod)
			collide_mob(A, C, 1, 25 * mod, 4 * mod, 12 * mod, 30 * mod, try_broke_bones = TRUE)

	else if(isliving(M) && !iscarbon(M))
		var/mob/living/L = M
		L.adjustBruteLoss(25)

	if(!bike_collide)
		playsound(src.loc, 'sound/effects/bone_break7.ogg', 25, 1)
		buckled_mob.visible_message(SPAN_DANGER("[buckled_mob] на [name] переехал [A]!"))
		return ..()

	playsound(src.loc, 'sound/effects/bang.ogg', 25, 1)

	if(!blooded)
		blooded = TRUE
		update_overlay()

	var/mob/living/carbon/occupant = buckled_mob
	unbuckle()
	collide_mob(A, occupant, 3, 25 / mod, 4 / mod, 6 / mod, 12 / mod, TRUE)

	if(stroller && stroller.buckled_mob)
		var/mob/living/carbon/second_occupant = stroller.buckled_mob
		collide_mob(A, second_occupant, 0, 15 / mod, 8 / mod, 15 / mod, 30 / mod)

	occupant.visible_message(SPAN_DANGER("[occupant] на [name] врезался в [A]!"))
	. = ..()

/obj/vehicle/motorbike/proc/collide_mob(atom/A, mob/living/carbon/M,
			throw_range = 0, damage_value = 15,
			stun_value = 4, weaken_value = 6, stutter_value = 12,
			try_broke_bones = FALSE, chance_fracture = 50)
	if(!throw_range)
		M.throw_atom(A, throw_range, SPEED_FAST)

	damage_value = round(damage_value)
	stun_value = round(stun_value)
	weaken_value = round(weaken_value)
	stutter_value = round(stutter_value)

	var/def_zone = rand_zone()
	M.apply_damage(damage_value, BRUTE, def_zone)
	M.apply_effect(stun_value, STUN)
	M.apply_effect(weaken_value, WEAKEN)
	M.apply_effect(stutter_value, STUTTER)

	if(!ishuman(M))
		return

	if(!try_broke_bones)
		return
	var/obj/limb/L = M.get_limb(def_zone)
	if(L && (L.status & LIMB_BROKEN))
		L.fracture(chance_fracture)
