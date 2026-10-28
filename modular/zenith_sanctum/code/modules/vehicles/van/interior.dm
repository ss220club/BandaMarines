// WY-White Van interior stuff

/obj/structure/interior_wall/white_van
	name = "van interior wall"
	desc = "An interior wall."
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "van_right_1"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = WINDOW_LAYER
	flags_atom = NOINTERACT
	unacidable = TRUE

/obj/effect/vehicle_roof/white_van
	name = "\improper van interior roof"
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "roof_1"

/obj/structure/interior_exit/vehicle/white_van/left
	name = "Van left door"
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "interior_door"

/obj/structure/interior_exit/vehicle/white_van/right
	name = "Van right door"
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "exterior_door_unique"
	dir = SOUTH

/obj/structure/interior_exit/vehicle/white_van/backleft
	name = "Van back exit"
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "back_2"
	dir = WEST

/obj/structure/interior_exit/vehicle/white_van/backright
	name = "Van back exit"
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/interiors/white_van.dmi'
	icon_state = "back_1"
	dir = WEST
