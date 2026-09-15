/obj/structure/bed/chair/vehicle/passager
	name = "passenger seat"
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "car_seat"
	unacidable = TRUE
	unslashable = TRUE
	explo_proof = TRUE
	can_rotate = FALSE

/obj/structure/bed/chair/comfy/vehicle/driver/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "car_seat"


// Кресло стрелка с обновлением иконки
/obj/structure/bed/chair/comfy/vehicle/gunner/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "car_seat"

	required_skill = SKILL_VEHICLE_SMALL
	var/mouse_pointer = 'icons/effects/mouse_pointer/rifle_mouse.dmi'

/obj/structure/bed/chair/comfy/vehicle/gunner/humvee/proc/update_mouse_pointer(mob/user, enable)
	if(!user?.client)
		return
	if(!user.client?.prefs?.custom_cursors)
		return

	if(enable)
		user.client.mouse_pointer_icon = mouse_pointer
	else
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)

/obj/structure/bed/chair/comfy/vehicle/gunner/humvee/afterbuckle(mob/M)
	. = ..()

	if(!M?.client)
		return

	if(M.buckled == src)
		update_mouse_pointer(M, TRUE)
	else
		update_mouse_pointer(M, FALSE)


// Структуры для хамви
/obj/structure/vehicle_locker/med/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'

/obj/structure/machinery/cm_vending/sorted/medical/blood/vehicle/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'

/obj/structure/interior_viewport/humvee
	name = "humvee window"
	desc = "Nothing beats the good old sheet of glass."
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "viewport_door"

/obj/structure/weapons_loader/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	density = FALSE
	opacity = TRUE

