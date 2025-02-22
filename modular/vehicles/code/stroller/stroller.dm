// стул на колесиках
/obj/structure/bed/chair/stroller
	name = "Коляска"
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural_stroller"
	var/icon_skin = "classic"
	var/icon_destroyed = "destroyed"
	desc = "Для детишек."
	density = FALSE	// При коннекте - У нас уже есть колизия с мотоциклом
	anchored = TRUE	// При коннекте - Нехай трогать и перемещать
	health = 800 // Тележка прочнее мотоцикла. Увы, но это просто кусок металла.
	maxhealth = 800
	can_buckle = TRUE

	var/obj/connected

/obj/structure/bed/chair/stroller/Initialize()
	. = ..()
	update_overlay()
	if(buckled_mob)
		buckled_mob.setDir(dir)

/obj/structure/bed/chair/stroller/proc/update_overlay()
	overlays.Cut()
	icon_state = initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = layer_above) //over mobs
	overlays += I

/obj/structure/bed/chair/stroller/New(loc)
	. = ..()
	if(isobj(loc))
		connected = loc
	if(connected)
		connect()
	else
		disconnect()

/obj/structure/machinery/faxmachine/attackby(obj/item/O as obj, mob/user as mob)
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		if(connected)
			disconnect()
		else
			connect()
		to_chat(user, SPAN_NOTICE("Вы [anchored ? "присоединили" : "отсоединили"] коляску."))
	. = ..()

/obj/structure/bed/chair/stroller/proc/connect()
	density = initial(density)
	anchored = initial(anchored)
	drag_delay = FALSE

/obj/structure/bed/chair/stroller/proc/disconnect()
	density = !density
	anchored = !anchored
	drag_delay = initial(drag_delay)
