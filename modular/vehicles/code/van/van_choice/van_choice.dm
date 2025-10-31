// добавляем грузовик в меню заказа техники
/obj/effect/vehicle_spawner/uscm_van
	category = "VAN"

/obj/effect/vehicle_spawner/uscm_van/med
	category = "VAN"

/datum/vehicle_order/van/uscm_van
	name = "M577-C Mule Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/uscm_van/fixed

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	vehicles |= list(
		new /datum/vehicle_order/van/uscm_van
	)

/datum/vehicle_order/van/uscm_van/med
	name = "M577-M Husky Personnel Med Transport"
	ordered_vehicle = /obj/effect/vehicle_spawner/uscm_van/med/fixed

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	vehicles |= list(
		new /datum/vehicle_order/van/uscm_van/med
	)
