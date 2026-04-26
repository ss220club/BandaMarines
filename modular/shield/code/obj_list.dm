/mob/living
	var/list/last_hit_objects = list()

/mob/living/proc/register_hit(atom/movable/AM)
	if(!AM)
		return

	// очищаем старый список
	last_hit_objects.Cut()

	// добавляем только новый объект
	last_hit_objects += AM

/atom/movable/launch_impact(atom/hit_atom)
	. = ..()

	if(ismob(hit_atom))
		var/mob/living/M = hit_atom
		M.register_hit(src)

/mob/living/proc/throw_last_hit(atom/target)
	if(!last_hit_objects || !length(last_hit_objects))
		return

	var/atom/movable/AM = last_hit_objects[1]

	if(!AM || QDELETED(AM))
		last_hit_objects.Cut()
		return

	if(!target)
		return

	var/dir_to_target = get_dir(src, target)

	var/turf/launch_turf = get_step(src, dir_to_target)

	AM.throw_atom(launch_turf, 1, SPEED_AVERAGE, src, FALSE)