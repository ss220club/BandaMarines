/datum/map_template/interior/modul/upptank
	name = "UPP Tank"
	prefix = "modular/distress/interior_map/"
	interior_id = "upptank"

/area/interior/vehicle/upptank
	name = "\improper UPP tank interior"
	icon_state = "tank"

/obj/structure/vehicle_locker/tank/upp
	icon = 'modular/distress/icons/intupptank.dmi'
	icon_state = "locker"

/obj/structure/vehicle_locker/tank/upp1
	name = "storage ammunition"
	icon = 'modular/distress/icons/intupptank.dmi'
	icon_state = "storage_ammo"

/obj/structure/vehicle_locker/tank/upp2
	name = "Locker"
	desc = "Small storage unit allowing vehicle crewmen to store their personal possessions. Only vehicle crewmen can access these."
	icon = 'modular/distress/icons/intupptank.dmi'
	icon_state = "small_locker"

/obj/structure/vehicle_locker/tank/upp3
	icon = 'modular/distress/icons/intupptank.dmi'
	icon_state = "small_locker1"

/obj/structure/interior_exit/vehicle/tank/upp
	name = "tank hatch"
	icon = 'modular/distress/icons/intupptank.dmi'
	icon_state = "hatch"

/obj/structure/prop/vehicle/upptank
	name = "UPP Tank chassis"

	icon = 'modular/distress/icons/upptank_chassis.dmi'
	icon_state = "upptank_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE
	
/obj/effect/landmark/interior/spawn/weapons_loader/upp
	icon = 'modular/distress/icons/intupptank.dmi'

/datum/map_template/interior/modul/uppvan
    name = "UPP Van"
    prefix = "modular/distress/interior_map/"
    interior_id = "uppvan"

/datum/map_template/interior/modul/uppvan/medical
	name = "UPP Van Medical"
	interior_id = "uppvan_medical"

/area/interior/vehicle/uppvan
	name = "\improper UPP van interior"
	icon_state = "upp_van"

/area/interior/vehicle/uppvan/medical
	name = "\improper UPP van medical interior"
	icon_state = "upp_van_medical"
	
/obj/item/hardpoint/locomotion/van_wheels/upp
	name = "UPP Van wheels"
	desc = "Integral to the movement of the upp van"
	icon = 'modular/distress/icons/van.dmi'

	icon_state = "upp_tires"
	disp_icon = "van"
	disp_icon_state = "wheels"

	slot = HDPT_WHEELS

	health = 800

	move_delay = VEHICLE_SPEED_FASTER


/obj/structure/prop/vehicle/uppvan
	name = "UPP Van chassis"

	icon = 'modular/distress/icons/uppvan_chassis.dmi'
	icon_state = "uppvan_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE

/obj/structure/prop/vehicle/uppvan/turret
	name = "UPP Van with turret chassis"

	icon = 'modular/distress/icons/uppvan_chassis.dmi'
	icon_state = "uppvant_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE

/obj/structure/prop/vehicle/uppvan_logistics
	name = "UPP Van logistics chassis"

	icon = 'modular/distress/icons/uppvan_chassis.dmi'
	icon_state = "uppvan_logistics_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE

/obj/structure/interior_exit/vehicle/uppvan/left
	name = "Van left door"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "interior_door"

/obj/structure/interior_exit/vehicle/uppvan/right
	name = "Van right door"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "exterior_door_unique"
	dir = SOUTH

/obj/structure/interior_exit/vehicle/uppvan/backleft
	name = "Van back exit"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "back_2"
	dir = WEST

/obj/structure/interior_exit/vehicle/uppvan/backright
	name = "Van back exit"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "back_1"
	dir = WEST


//Landmark for spawning windows
/obj/effect/landmark/interior/spawn/interior_viewport/simple/uppvan
	name = "simple vehicle viewport spawner"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "viewport_simple"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"

/obj/structure/interior_viewport/simple/uppvan
	name = "viewport"
	desc = "Hey, I can see my base from here!"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "viewport_simple"

/obj/effect/landmark/interior/spawn/interior_viewport/simple/uppvan/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/simple/uppvan/V = new(loc)

	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.layer = layer
	V.alpha = alpha

	qdel(src)

//Landmark for van's windshield
/obj/effect/landmark/interior/spawn/interior_viewport/simple/uppvanfront
	name = "viewport"
	desc = "Hey, I can see my base from here!"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "viewport_simple_front"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"
	alpha = 80

/obj/structure/interior_viewport/simple/uppvanfront
	name = "viewport"
	desc = "Hey, I can see my base from here!"
	icon = 'modular/distress/icons/intuppvan.dmi'
	icon_state = "viewport_simple_front"


/obj/effect/landmark/interior/spawn/interior_viewport/simple/uppvanfront/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/simple/uppvanfront/V = new(loc)

	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.alpha = alpha
	V.icon = icon

	qdel(src)