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
		to_chat(user, SPAN_WARNING("[src] должен быть пустым, чтобы загрузить [target]!"))
		return

	if(check_object(target, user)) //проверяет состояние загружаемого объекта и его ивентарь на наличие живности
		return

	if(!do_after(user, load_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, src)) // проверка на прерывание
		to_chat(user,SPAN_WARNING("Вас прервали во время загрузки [src]!"))
		return

	if(check_object(target, user)) //проверяет состояние загружаемого объекта и его ивентарь на наличие живности после загрузки
		return

	if(loaded) // повторная проверка на загруженность. Может кто-то уже загрузил пока мы тут...
		to_chat(user, SPAN_WARNING("Кто-то уже загрузил [src]!"))
		return

	crate = target
	crate.forceMove(src)
	loaded = TRUE
	update_overlay()
	update_drag_delay(loaded)

/obj/structure/bed/chair/sidecar/cargo/proc/unload_object(atom/user)

	if(!loaded) // проверка на загруженность
		to_chat(user, SPAN_WARNING("[src] уже пустой!"))
		return

	if(!do_after(user, load_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, src)) // проверка на прерывание
		to_chat(user,SPAN_WARNING("Вас прервали во время разгрузки [src]!"))
		return

	if(!loaded) // повторная проверка на загруженность. Может кто-то уже разгрузил пока мы тут...
		to_chat(user, SPAN_WARNING("Кто-то уже разгрузил [src]!"))
		return

	crate.forceMove(user.loc)
	crate = null
	loaded = FALSE
	update_overlay()
	update_drag_delay(loaded)

/obj/structure/bed/chair/sidecar/cargo/proc/check_object(atom/movable/A, mob/user) //возвращает true - если объект не подходит и false - если наоборот.
//проверяет состояние загружаемого объекта и его ивентарь на наличие живности
	if(istype(A, /obj/structure/closet/crate) || istype(A, /obj/structure/closet/coffin))
		var/obj/structure/closet/C = A
		if(C.anchored)
			to_chat(user, SPAN_WARNING("[C] закреплен и не может быть загружен в [src]!"))
			return TRUE
		for(var/X in C)
			if(ismob(X))
				to_chat(user, SPAN_WARNING("[C] не может быть загружен в [src], внутри него находится существо!"))
				return TRUE
		return FALSE
	to_chat(user, SPAN_WARNING("Только гробы и ящики могут быть загружены в [src]."))
	return TRUE
