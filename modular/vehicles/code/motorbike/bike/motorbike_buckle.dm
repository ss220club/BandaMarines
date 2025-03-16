/obj/vehicle/motorbike/do_buckle(mob/living/target, mob/user)
	if(!skillcheck(target, SKILL_VEHICLE, required_skill))
		if(target == user)
			to_chat(user, SPAN_WARNING("Вы без понятия как им управлять!"))
		return FALSE
	if(..())
		update_stroller(src, TRUE)
