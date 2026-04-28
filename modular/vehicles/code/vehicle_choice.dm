// добавляем грузовик в меню заказа техники
/obj/effect/vehicle_spawner/uscm_van
	category = "VAN"

/obj/effect/vehicle_spawner/uscm_van/med
	category = "VAN"

/datum/vehicle_order/van/uscm_van
	name = "Грузовой фургон M35-T"
	ordered_vehicle = /obj/effect/vehicle_spawner/uscm_van/fixed

/datum/vehicle_order/van/uscm_van/med
	name = "Санитарный фургон M35-M"
	ordered_vehicle = /obj/effect/vehicle_spawner/uscm_van/med/fixed

// добавляем хамер в меню заказа техники
/obj/effect/vehicle_spawner/humvee
	category = "HWC"

/obj/effect/vehicle_spawner/humvee/medical
	category = "VAN"

/obj/effect/vehicle_spawner/humvee/transport
	category = "VAN"

/datum/vehicle_order/humvee
	name = "M2420 JTMV-HWC Heavy Weapon Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/humvee

/datum/vehicle_order/humvee/medical
	name = "Санитарный автомобиль M2421 JTMV-Ambulance"
	ordered_vehicle = /obj/effect/vehicle_spawner/humvee/medical

/datum/vehicle_order/humvee/transport
	name = "Вспомогательный автомобиль M2422 JTMV-Utility"
	ordered_vehicle = /obj/effect/vehicle_spawner/humvee/transport

/datum/vehicle_order/humvee/apc
	name = "Бронеавтомобиль M2420 JTMV-HWC"
	ordered_vehicle = /obj/effect/vehicle_spawner/humvee/apc

/datum/vehicle_order/humvee/has_vehicle_lock()
	return

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	vehicles |= list(
		new /datum/vehicle_order/humvee/apc,
		new /datum/vehicle_order/humvee/transport,
		new /datum/vehicle_order/humvee/medical,
		new /datum/vehicle_order/van/uscm_van,
		new /datum/vehicle_order/van/uscm_van/med
	)

