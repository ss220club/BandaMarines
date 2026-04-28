/mob/living/Collide(atom/movable/moving_atom)

	var/mob/living/target = moving_atom

	if(!istype(target))
		return ..()

	if(target.get_readied_shield() && ((src.dir == get_dir(src, target) && target.dir == get_dir(target, src)) || (get_dir(target, src) == turn(target.dir, 180))))
		return FALSE

	return ..()