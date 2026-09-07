// USCM-Van interior
/obj/structure/interior_wall/uscm_van
	name = "van interior wall"
	desc = "An interior wall."
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "exterior_2"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = TURF_LAYER
	flags_atom = NOINTERACT
	unacidable = TRUE

/obj/effect/vehicle_roof/uscm_van
	name = "\improper van interior roof"
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "roof_1"

/obj/structure/interior_exit/vehicle/uscm_van/left
	name = "Van left door"
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "interior_door"

/obj/structure/interior_exit/vehicle/uscm_van/right
	name = "Van right door"
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "exterior_door_unique"
	dir = SOUTH

/obj/structure/interior_exit/vehicle/uscm_van/backleft
	name = "Van back exit"
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "back_2"
	dir = WEST

/obj/structure/interior_exit/vehicle/uscm_van/backright
	name = "Van back exit"
	icon = 'modular/vehicles/icons/uscm_van/uscm_van_interior.dmi'
	icon_state = "back_1"
	dir = WEST


// Med-Van interior
/obj/structure/interior_wall/uscm_van/med
	name = "van interior wall"
	desc = "An interior wall."
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "exterior_2"

/obj/effect/vehicle_roof/uscm_van/med
	name = "\improper van interior roof"
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "roof_1"

/obj/structure/interior_exit/vehicle/uscm_van/med/left
	name = "Van left door"
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "interior_door"

/obj/structure/interior_exit/vehicle/uscm_van/med/right
	name = "Van right door"
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "exterior_door_unique"
	dir = SOUTH

/obj/structure/interior_exit/vehicle/uscm_van/med/backleft
	name = "Van back exit"
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "back_2"
	dir = WEST

/obj/structure/interior_exit/vehicle/uscm_van/med/backright
	name = "Van back exit"
	icon = 'icons/obj/vehicles/interiors/pizza_van_interior.dmi'
	icon_state = "back_1"
	dir = WEST


// Humvee interior
/obj/structure/interior_exit/vehicle/humvee
	name = "interior exit"
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "exit_door"
	density = FALSE

/obj/structure/interior_exit/vehicle/humvee/left
	entrance_id = "left"
	icon_state = "exit_door1"
	layer = LATTICE_LAYER

/obj/structure/interior_exit/vehicle/humvee/right
	entrance_id = "right"
	alpha = 50

/obj/structure/interior_exit/vehicle/humvee/left2
	entrance_id = "rear left"
	icon_state = "exit_door1"
	layer = LATTICE_LAYER

/obj/structure/interior_exit/vehicle/humvee/right2
	entrance_id = "rear right"
	alpha = 50

/obj/structure/interior_exit/vehicle/humvee/back/left
	entrance_id = "rear left"
	icon_state = "carrier_backdoor1"

/obj/structure/interior_exit/vehicle/humvee/back/right
	entrance_id = "rear right"
	icon_state = "carrier_backdoor2"

/obj/structure/interior_exit/vehicle/humvee/back/medical/left
	entrance_id = "rear left"
	icon_state = "medical_backdoor1"

/obj/structure/interior_exit/vehicle/humvee/back/medical/right
	entrance_id = "rear right"
	icon_state = "medical_backdoor2"

/obj/structure/prop/vehicle/humvee
	name = "Humvee chassis"

	icon = 'modular/vehicles/icons/humvee/humvee_chassis.dmi'
	icon_state = "humvee_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE
	density = FALSE
	opacity = TRUE

/obj/structure/prop/vehicle/humvee/medical
	icon_state = "humvee_chassis_medical"

/obj/structure/prop/vehicle/humvee/transport
	icon_state = "humvee_chassis_transport"

/obj/structure/prop/vehicle/humvee/apc
	icon_state = "humvee_chassis"


/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "car_seat"
	color = "blue"

/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/humvee/on_load(datum/interior/interior)
	var/obj/structure/bed/chair/comfy/vehicle/gunner/humvee/S = new(loc)
	S.layer = layer
	S.vehicle = interior.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)


/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "car_seat"
	color = "red"
	var/buckling_x = -3
	var/buckling_y = 1

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor/humvee/on_load(datum/interior/interior)
	var/obj/structure/bed/chair/comfy/vehicle/driver/humvee/S = new(loc)
	S.vehicle = interior.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.update_icon()
	S.alpha = alpha
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)


/obj/effect/landmark/interior/spawn/weapons_loader/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "weapons_loader"
	color = "#00920c"

/obj/effect/landmark/interior/spawn/weapons_loader/humvee/on_load(datum/interior/interior)
	var/obj/structure/weapons_loader/humvee/R = new(loc)
	R.layer = layer
	R.pixel_x = pixel_x
	R.pixel_y = pixel_y
	R.vehicle = interior.exterior
	R.setDir(dir)
	R.update_icon()

	qdel(src)


/obj/effect/landmark/interior/spawn/interior_viewport/humvee
	icon = 'modular/vehicles/icons/humvee/general_humvee.dmi'
	icon_state = "viewport_door"

/obj/effect/landmark/interior/spawn/interior_viewport/humvee/on_load(datum/interior/interior)
	var/obj/structure/interior_viewport/humvee/viewport = new(loc)
	viewport.vehicle = interior.exterior
	viewport.pixel_x = pixel_x
	viewport.pixel_y = pixel_y
	viewport.alpha = alpha
	viewport.icon = icon
	viewport.icon_state = icon_state
	viewport.layer = layer
	qdel(src)
