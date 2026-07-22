/datum/map_template/interior/modul/upptank
	name = "UPP Tank"
	prefix = "modular/spn/interior_map/"
	interior_id = "upptank"

/obj/structure/vehicle_locker/tank/upp
	icon = 'modular/spn/icons/intupptank.dmi'
	icon_state = "locker"

/obj/structure/vehicle_locker/tank/upp1
	name = "storage ammunition"
	icon = 'modular/spn/icons/intupptank.dmi'
	icon_state = "storage_ammo"

/obj/structure/vehicle_locker/tank/upp2
	name = "Locker"
	desc = "Small storage unit allowing vehicle crewmen to store their personal possessions. Only vehicle crewmen can access these."
	icon = 'modular/spn/icons/intupptank.dmi'
	icon_state = "small_locker"

/obj/structure/vehicle_locker/tank/upp3
	icon = 'modular/spn/icons/intupptank.dmi'
	icon_state = "small_locker1"

/obj/structure/interior_exit/vehicle/tank/upp
	name = "tank hatch"
	icon = 'modular/spn/icons/intupptank.dmi'
	icon_state = "hatch"

/obj/structure/prop/vehicle/upptank
	name = "UPP Tank chassis"

	icon = 'modular/spn/icons/upptank_chassis.dmi'
	icon_state = "upptank_chassis"
	layer = ABOVE_TURF_LAYER
	mouse_opacity = FALSE
