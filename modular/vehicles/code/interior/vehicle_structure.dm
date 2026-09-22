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

//tank command
/obj/structure/machinery/computer/cameras/almayer/vehicle/tank
	name = "Vehicle Cam-View Terminal"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport"

/obj/structure/interior_viewport/terminal
	name = "External Cameras Terminal"
	desc = "A terminal hooked up to the various sensors of the M579 ADS-C, featuring plenty of flashing buttons and whooping alarms alongside a more rudimentary external-view system."
	icon_state = "viewport_terminal"
	icon = 'modular/vehicles/icons/aev/general.dmi'

/obj/structure/interior_viewport/terminal/tank
	name = "Command & Control Terminal"
	desc = "A terminal hooked up to the various sensors of the M579 ADS-C, featuring plenty of flashing buttons and whooping alarms alongside a more rudimentary external-view system."

/obj/structure/bed/chair/comfy/vehicle/commander
	name = "commanders's seat"
	desc = "Military-grade seat for armored vehicle commander with some controls, switches and indicators."
	var/image/over_image = null
	required_skill = SKILL_VEHICLE_CREWMAN

/obj/structure/bed/chair/comfy/vehicle/commander/do_buckle(mob/target, mob/user)
	required_skill = vehicle.required_skill
	if(!skillcheck(target, SKILL_VEHICLE, required_skill))
		if(target == user)
			to_chat(user, SPAN_WARNING("You have no idea how to command this thing!"))
		return FALSE

	if(vehicle)
		vehicle.vehicle_faction = target.faction

	return ..()
