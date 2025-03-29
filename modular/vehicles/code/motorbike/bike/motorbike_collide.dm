
/obj/vehicle/motorbike/Collide(atom/A)
	if(!seats[VEHICLE_DRIVER])
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
			mod = 0.9
		if(MOB_SIZE_XENO)
			mod = 0.7
		if(MOB_SIZE_BIG)
			mod = 0.3
		if(MOB_SIZE_IMMOBILE)
			mod = 0

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(isyautja(C))
			mod = 0.25
		if(mod)
			collide_mob(A, C, 1, 17 * mod, 2 * mod, 10 * mod, try_broke_bones = TRUE)
		if(isxeno(M))
			attack_alien(M)
	else if(isliving(M) && !iscarbon(M))
		var/mob/living/L = M
		L.adjustBruteLoss(20)

	if(!bike_collide)
		playsound(src.loc, 'sound/effects/bone_break7.ogg', 25, 1)
		buckled_mob.visible_message(SPAN_DANGER("[buckled_mob] на [name] переехал [A]!"))
		return ..()

	playsound(src.loc, 'sound/effects/bang.ogg', 25, 1)

	if(!blooded)
		blooded = TRUE
		update_overlay()

	mod += 0.15	// Кто столкнулся - тот дольше и в стане, га-га-га. Последствия "антихам"
	var/mob/living/carbon/occupant = buckled_mob
	unbuckle()
	if(mod)
		collide_mob(A, occupant, 3, 17 / mod, 2 / mod, 12 / mod, TRUE)

	if(stroller && stroller.buckled_mob)
		var/mob/living/carbon/second_occupant = stroller.buckled_mob
		if(mod)	// Ну а тот кто в коляске получает двойной звездюль... Но зато остается в коляске.
			collide_mob(A, second_occupant, 0, 15 / mod, 3 / mod, 15 / mod)

	occupant.visible_message(SPAN_DANGER("[occupant] на [name] врезался в [A]!"))
	. = ..()

/obj/vehicle/motorbike/proc/collide_mob(atom/A, mob/living/carbon/M,
			throw_range = 0, damage_value = 15,
			weaken_value = 2, stutter_value = 12,
			try_broke_bones = FALSE, chance_fracture = 50)
	if(!throw_range)
		M.throw_atom(A, throw_range, SPEED_FAST, src, TRUE)

	damage_value = round(damage_value)
	weaken_value = round(weaken_value)
	stutter_value = round(stutter_value)

	weaken_value = clamp(weaken_value, 1, 4)

	var/def_zone = rand_zone()
	M.apply_damage(damage_value, BRUTE, def_zone)
	M.apply_effect(weaken_value, STUN)
	M.apply_effect(weaken_value, WEAKEN)
	M.apply_effect(stutter_value, STUTTER)

	if(!ishuman(M))
		return

	if(!try_broke_bones)
		return
	var/obj/limb/L = M.get_limb(def_zone)
	if(L && (L.status & LIMB_BROKEN))
		L.fracture(chance_fracture)
