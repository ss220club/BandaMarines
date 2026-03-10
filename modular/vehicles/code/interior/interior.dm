// USCM-Van interior
/obj/structure/interior_wall/uscm_van
	name = "van interior wall"
	desc = "An interior wall."
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
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
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
	icon_state = "roof_1"

/obj/structure/interior_exit/vehicle/uscm_van/left
	name = "Van left door"
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
	icon_state = "interior_door"

/obj/structure/interior_exit/vehicle/uscm_van/right
	name = "Van right door"
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
	icon_state = "exterior_door_unique"
	dir = SOUTH

/obj/structure/interior_exit/vehicle/uscm_van/backleft
	name = "Van back exit"
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
	icon_state = "back_2"
	dir = WEST

/obj/structure/interior_exit/vehicle/uscm_van/backright
	name = "Van back exit"
	icon = 'modular/vehicles/icons/uscm_van_interior.dmi'
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
