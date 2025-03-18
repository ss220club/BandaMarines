// ==========================================
// =============== Усаживание ===============

/obj/structure/bed/chair/stroller/buckle_mob(mob/living/carbon/human/mob, mob/user)
	if(!do_after(mob, buckle_time * user.get_skill_duration_multiplier(SKILL_VEHICLE), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
		return FALSE
	if(mob.mob_size == MOB_SIZE_XENO && (mob.a_intent == INTENT_GRAB || mob.stat == DEAD))	// Мы можем посадить небольшого ксеноса, если он будет помогать лапками в граб интенте. Как на кровати.
	else if(mob.mob_size == MOB_SIZE_XENO_SMALL && (mob.a_intent == INTENT_HELP || mob.a_intent == INTENT_GRAB || mob.stat == DEAD))	// мы сможем украсть руню или ящерку, если они не особо сопротивляться будут
	else if(mob.mob_size <= MOB_SIZE_XENO_VERY_SMALL)	// Lesser Drones, Люди
		do_buckle(mob, user)
		if(mob.loc == src.loc && buckling_sound && mob.buckled)
			playsound(src, buckling_sound, 20)
		return TRUE
	. = ..()

/obj/structure/bed/chair/stroller/do_buckle(mob/living/target, mob/user)
	if(..())
		update_buckle_mob()
		update_drag_delay()
		update_mob_gun_signal()

/obj/structure/bed/chair/stroller/unbuckle()
	reload_buckle_mob()
	if(connected)
		push_to_left_side(buckled_mob)
	update_drag_delay()
	update_mob_gun_signal(TRUE)
	. = ..()

// ==========================================
// =============== Обновление ===============

/obj/structure/bed/chair/stroller/proc/update_buckle_mob()
	if(!buckled_mob)
		return
	buckled_mob.pixel_x = get_buckled_mob_pixel_x()
	buckled_mob.pixel_y = get_buckled_mob_pixel_y()
	buckled_mob.setDir(dir)
	buckled_mob.density = FALSE
	if(dir == WEST)
		buckled_mob.layer = layer_west
	else
		buckled_mob.layer = initial(buckled_mob.layer)
	if(mounted)
		update_gun_dir()

/obj/structure/bed/chair/stroller/set_glide_size(target)
	. = ..()
	if(buckled_mob)
		buckled_mob.set_glide_size(target)
