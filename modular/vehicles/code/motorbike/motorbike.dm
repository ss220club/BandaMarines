/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural"
	var/icon_skin = "classic"
	var/icon_destroyed = "destroyed"

	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.

	move_delay = 1.5
	health = 500
	maxhealth = 500
	var/obj/structure/bed/chair/stroller/stroller = null // привязанная тележка

/obj/vehicle/motorbike/Initialize()
	. = ..()
	stroller = new(src, skin)
	update_stroller(TRUE)
	update_overlay()

/obj/vehicle/motorbike/proc/update_overlay()
	overlays.Cut()
	icon_state= initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I

// ==========================================
// ========== Движение с коляской ==========

/obj/vehicle/motorbike/Moved(atom/oldloc, direction, Forced)
	. = ..()
	update_stroller()

/obj/vehicle/motorbike/proc/update_stroller(force_update = FALSE)
	if(stroller)
		stroller.update_position(src, force_update)

// ==========================================
// ========== Присоединяем коляску ==========

/obj/vehicle/motorbike/attackby(obj/item/O as obj, mob/user as mob)
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		if(stroller)
			stroller.disconnect()
			stroller = null
		else
			if(!try_connect(user))
				return ..()
		to_chat(user, SPAN_NOTICE("Вы [anchored ? "присоединили" : "отсоединили"] коляску."))
		return TRUE
	. = ..()

// Пытаемся приконектить объект
/obj/vehicle/motorbike/proc/try_connect()
	stroller = get_before_connect()
	if(!stroller)
		return FALSE
	connect()
	return TRUE

// Ищем и выдаем нужный объект для коннекта
/obj/vehicle/motorbike/proc/get_before_connect(mob/user)
	for(var/obj/structure/bed/chair/stroller/S in range(1))
		if(S.health <= S.maxhealth)
			to_chat(user, SPAN_DANGER("[S] повреждена и требует ремонта."))
			return FALSE
		return S

// Завершаем конект в коляске
/obj/vehicle/motorbike/proc/connect()
	stroller.connect()

// ==========================================
