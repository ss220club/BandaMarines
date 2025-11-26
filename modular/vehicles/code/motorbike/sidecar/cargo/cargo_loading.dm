/obj/structure/bed/chair/sidecar/cargo

	//================= loading ===================
	var/obj/crate = null
	var/loaded = FALSE
	var/load_time = 5 SECONDS

/obj/structure/bed/chair/sidecar/cargo/MouseDrop_T(atom/movable/A, mob/user)
	. = ..()

	if(!isturf(A.loc) && !ishuman(A.loc))
		return

	if(user.stat || user.is_mob_restrained())
		return

	if(get_dist(user, src) > 1 || get_dist(src, A) > 1)
		return

	if(!ishuman(user))
		return

	load_object(user, A)

/obj/structure/bed/chair/sidecar/cargo/MouseDrop(atom/over_object)
	.= ..()
	if (istype(over_object, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = over_object
		if (H != usr || H.is_mob_incapacitated() || !Adjacent(H) || !in_range(src, over_object))
			return

		unload_object(H)

/obj/structure/bed/chair/sidecar/cargo/proc/load_object(mob/user, obj/target)
	if(loaded) // проверка на загруженность
		to_chat(user, SPAN_WARNING("\The [src] must be empty in order to load \the [target]!"))
		return

	if(check_object(target, user)) //проверяет состояние загружаемого объекта и его ивентарь на наличие живности
		return

	if(!do_after(user, load_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, src)) // проверка на прерывание
		to_chat(user,SPAN_WARNING("You were interrupted while loading \the [src]!"))
		return

	if(check_object(target, user)) //проверяет состояние загружаемого объекта и его ивентарь на наличие живности после загрузки
		return

	if(loaded) // повторная проверка на загруженность. Может кто-то уже загрузил пока мы тут...
		to_chat(user, SPAN_WARNING("Someone already loaded \the [src]!"))
		return

	crate = target
	crate.forceMove(src)
	loaded = TRUE
	update_overlay()
	update_drag_delay(loaded)

/obj/structure/bed/chair/sidecar/cargo/proc/unload_object(atom/user)
	if(!loaded) // проверка на загруженность
		to_chat(user, SPAN_WARNING("\The [src] is already empty!"))
		return

	if(!do_after(user, load_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, src)) // проверка на прерывание
		to_chat(user,SPAN_WARNING("You were interrupted while unloading \the [src]!"))
		return

	if(!loaded) // повторная проверка на загруженность. Может кто-то уже разгрузил пока мы тут...
		to_chat(user, SPAN_WARNING("Someone already unloaded \the [src]!"))
		return

	crate.forceMove(user.loc)
	crate = null
	loaded = FALSE
	update_overlay()
	update_drag_delay(loaded)

/obj/structure/bed/chair/sidecar/cargo/proc/check_object(atom/movable/A, mob/user)
	//проверяет состояние загружаемого объекта и его ивентарь на наличие живности
	if(istype(A, /obj/structure/closet/crate) || istype(A, /obj/structure/closet/coffin))
		var/obj/structure/closet/C = A
		if(C.anchored)
			to_chat(user, SPAN_WARNING("The [C] is anchored and cannot be loaded into \the [src]!"))
			return TRUE
		for(var/X in C)
			if(ismob(X))
				to_chat(user, SPAN_WARNING("\The [C] cannot be loaded into \the [src], it has a creature inside!"))
				return TRUE
		return FALSE
	return TRUE
