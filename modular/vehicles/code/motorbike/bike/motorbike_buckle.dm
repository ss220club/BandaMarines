/obj/vehicle/motorbike/do_buckle(mob/living/target, mob/user)
	if(!skillcheck(target, SKILL_VEHICLE, required_skill))
		if(target == user)
			to_chat(user, SPAN_WARNING("Вы без понятия как им управлять!"))
		return FALSE
	if(!do_after(user, buckle_time * user.get_skill_duration_multiplier(SKILL_VEHICLE), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
		return FALSE
	if(..())
		update_stroller(src, TRUE)
		play_start_sound()

/obj/vehicle/motorbike/afterbuckle(mob/M)
	. = ..()
	if(buckled_mob)
		add_vehicle_verbs(M)
		if(stroller)
			stroller.update_bike_permutated(TRUE)
	else
		remove_vehicle_verbs(M)

/obj/vehicle/motorbike/unbuckle()
	if(stroller)	// Выносим сюда, а то неправильно уберет, т.к. моб уже отвязан
		stroller.reset_bike_permutated(TRUE)
	. = ..()

/obj/vehicle/motorbike/set_glide_size(target)
	. = ..()
	if(buckled_mob)
		buckled_mob.set_glide_size(target)
