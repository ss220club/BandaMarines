/obj/vehicle/motorbike/do_buckle(mob/living/target, mob/user)
	if(!skillcheck(target, SKILL_VEHICLE, required_skill))
		if(target == user)
			to_chat(user, SPAN_WARNING("Вы без понятия как им управлять!"))
		return FALSE
	if(..())
		update_stroller(src, TRUE)
		play_start_sound()

/obj/vehicle/motorbike/afterbuckle(mob/M)
	. = ..()
	if(buckled_mob)
		add_vehicle_verbs(M)
	else
		remove_vehicle_verbs(M)

/obj/vehicle/motorbike/set_glide_size(target)
	. = ..()
	if(buckled_mob)
		buckled_mob.set_glide_size(target)
