/obj/effect/vehicle_spawner
	var/category

/obj/effect/vehicle_spawner/tank
	category = "TANK"

/obj/effect/vehicle_spawner/tank/command
	category = "TANK"

/obj/effect/vehicle_spawner/aev
	category = "AEV"

/datum/vehicle_order/tank/command
	name = "M34A3 Hampton Light Command Tank"
	ordered_vehicle = /obj/effect/vehicle_spawner/tank/command

/datum/vehicle_order/aev
	name = "M34E1 Buckner Armored Engineering Vehicle"
	ordered_vehicle = /obj/effect/vehicle_spawner/aev

/obj/effect/vehicle_spawner/apc
	category = "APC"

/obj/effect/vehicle_spawner/apc_med
	category = "APC"

/obj/effect/vehicle_spawner/apc_cmd
	category = "APC"

/datum/vehicle_order/apc/plain
	name = "M577 Armored Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/apc/plain

/datum/vehicle_order/apc/med/plain
	name = "M577-MED Armored Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/apc_med/plain

/datum/vehicle_order/apc/cmd/plain
	name = "M577-CMD Armored Personnel Carrier"
	ordered_vehicle = /obj/effect/vehicle_spawner/apc_cmd/plain

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
		new /datum/vehicle_order/van/uscm_van/med,
		new /datum/vehicle_order/apc/plain,
		new /datum/vehicle_order/apc/med/plain,
		new /datum/vehicle_order/apc/cmd/plain,
		new /datum/vehicle_order/tank/command,
		new /datum/vehicle_order/aev,
	)
