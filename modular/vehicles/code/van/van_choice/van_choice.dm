// добавляем грузовик в меню заказа техники
/obj/effect/vehicle_spawner/uscm_van
	category = "VAN"

/datum/vehicle_order/van/uscm_van
	name = "M35b Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/uscm_van/fixed

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	vehicles |= list(
		new /datum/vehicle_order/van/uscm_van
	)
