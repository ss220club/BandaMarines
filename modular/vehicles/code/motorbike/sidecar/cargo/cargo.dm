/obj/structure/bed/chair/sidecar/cargo
	name = "Мотоциклетная грузовая коляска"
	desc = "Создана для перевозки ящиков. В эту коляску встроены темные технологии. Она принимает только предметы похожие на ящики"

	//======= Для отображения в игре ==============
	icon_state = "moto_ural_sidecar_cargo_classic"
	icon_base = "moto_ural_sidecar_cargo"
	//=============================================

	//========= Какие то параметры XDD ============
	// пока ничего менять не надо. :)
	//=============================================

	//======== Защита, здоровье и ремонт ==========
	// пока ничего менять не надо. :)
	//=============================================

	//=============== Перемещение =================
	drag_delay_heavy = 5 // Тяжеленько. Внутри тяжелый ящик? Значит скорость упадет.
	//=============================================

	//=========== Смещение при коннекте ===========
	pixel_east = list(2, -18)
	//=============================================

	//================= loading ===================
	var/obj/crate = null
	var/loaded = FALSE
	var/load_time = 5 SECONDS
	//=============================================

/obj/structure/bed/chair/sidecar/cargo/update_overlay()
	.=..()
	// Если загружен, то отображаем покрывало на коляске
	if(loaded)
		icon_state = "[icon_base]_[icon_skin]_loaded"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-layer", layer = layer_above) //over mobs //отвечает за отображение по слоям
	overlays += I

/obj/structure/bed/chair/sidecar/cargo/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/sidecar/cargo(src.loc, icon_skin) //заменить в дочке на нужный путь создания объекта
		deconstruct(FALSE)
		QDEL_NULL(src)

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

	if(istype(A, /obj/structure/closet/crate))
		var/obj/structure/closet/crate/C = null
		C = A

		if(C.anchored)
			to_chat(user, SPAN_WARNING("The [C] is anchored and cannot be loaded into \the [src]!"))
			return
		for(var/X in C)
			if(ismob(X))
				to_chat(user, SPAN_WARNING("\The [C] cannot be loaded into \the [src], it has a creature inside!"))
				return
		load_object(user, A)

	if(istype(A, /obj/structure/closet/coffin))
		var/obj/structure/closet/coffin/C = null
		C = A

		if(C.anchored)
			to_chat(user, SPAN_WARNING("The [C] is anchored and cannot be loaded into \the [src]!"))
			return
		for(var/X in C)
			if(ismob(X))
				to_chat(user, SPAN_WARNING("\The [C] cannot be loaded into \the [src], it has a creature inside!"))
				return
		load_object(user, A)


/obj/structure/bed/chair/sidecar/cargo/MouseDrop(atom/over_object)
	.= ..()
	if (istype(over_object, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = over_object
		if (!H==usr || H.is_mob_incapacitated() || !Adjacent(H) || !in_range(src, over_object))
			return

		unload_object(H)

/obj/structure/bed/chair/sidecar/cargo/proc/load_object(mob/user, obj/target)
	if(loaded) // проверка на загруженность
		to_chat(user, SPAN_WARNING("\The [src] must be empty in order to load \the [target]!"))
		return

	if(!do_after(user, load_time, INTERRUPT_ALL, BUSY_ICON_GENERIC, src)) // проверка на прерывание
		to_chat(user,SPAN_WARNING("You were interrupted while loading \the [src]!"))
		return

	if(loaded) // повторная проверка на загруженность. Может кто-то уже загрузил пока мы тут...
		to_chat(user, SPAN_WARNING("Someone already loaded \the [src]!"))
		return

	crate = target
	crate.forceMove(src)
	loaded = TRUE
	update_overlay()
	update_drag_delay()

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
	update_drag_delay()
