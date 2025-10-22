// добавляем грузовик в меню заказа техники
/obj/effect/vehicle_spawner/m35b
	category = "VAN"

/datum/vehicle_order/van/m35b
	name = "M35b Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/m35b/

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	vehicles |= list(
		new /datum/vehicle_order/van/m35b
	)
