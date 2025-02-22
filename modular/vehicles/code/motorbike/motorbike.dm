/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural"
	var/icon_skin = "classic"
	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7

	move_delay = 1.5
	health = 600
	maxhealth = 600
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.
	var/obj/structure/bed/chair/stroller/stroller = null // привязанная тележка


/obj/vehicle/motorbike/Initialize()
	. = ..()

	stroller = new(src)
	update_stroller()

	overlays.Cut()
	icon_state= initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I

/obj/vehicle/motorbike/Moved(atom/oldloc, direction, Forced)
	. = ..()
	update_stroller()
	message_admins("[ADMIN_FLW(src)] [src] was moved from [oldloc] to [loc] ([direction]) [Forced ? "FORCED" : "NOT FORCED"].")

/obj/vehicle/motorbike/proc/update_stroller()
	if(stroller)
		stroller.update_position(src)

