// PRESETS SPAWNERS

//humvee
/obj/effect/vehicle_spawner/humvee
	name = "M2420v1 JTMV-HWC"
	icon = 'modular/vehicles/icons/humvee/humvee.dmi'
	icon_state = "humvee_base"

/obj/effect/vehicle_spawner/humvee/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/humvee/spawn_vehicle()
	var/obj/vehicle/multitile/modul/humvee/HUMVEE = new (loc)

	load_misc(HUMVEE)
	load_hardpoints(HUMVEE)
	handle_direction(HUMVEE)
	HUMVEE.update_icon()

/obj/effect/vehicle_spawner/humvee/load_hardpoints(obj/vehicle/multitile/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/humvee_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/humvee_turret)

//humvee med
/obj/effect/vehicle_spawner/humvee/medical
	name = "Санитарный автомобиль M2421 JTMV"
	icon = 'modular/vehicles/icons/humvee/humvee_medical.dmi'
	icon_state = "humvee_base"

/obj/effect/vehicle_spawner/humvee/medical/spawn_vehicle()
	var/obj/vehicle/multitile/modul/humvee/medical/HUMVEE_MED = new (loc)

	load_misc(HUMVEE_MED)
	load_hardpoints(HUMVEE_MED)
	handle_direction(HUMVEE_MED)
	HUMVEE_MED.update_icon()

/obj/effect/vehicle_spawner/humvee/medical/load_hardpoints(obj/vehicle/multitile/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/humvee_wheels)

//humvee transport
/obj/effect/vehicle_spawner/humvee/transport
	name = "Грузовой автомобиль M2422 JTMV"
	icon = 'modular/vehicles/icons/humvee/humvee_transport.dmi'
	icon_state = "humvee_base"

/obj/effect/vehicle_spawner/humvee/transport/spawn_vehicle()
	var/obj/vehicle/multitile/modul/humvee/transport/HUMVEE_TRANSPORT = new (loc)

	load_misc(HUMVEE_TRANSPORT)
	load_hardpoints(HUMVEE_TRANSPORT)
	handle_direction(HUMVEE_TRANSPORT)
	HUMVEE_TRANSPORT.update_icon()

/obj/effect/vehicle_spawner/humvee/transport/load_hardpoints(obj/vehicle/multitile/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/humvee_wheels)

//humvee apc
/obj/effect/vehicle_spawner/humvee/apc
	name = "Бронеавтомобиль M2420 JTMV-HWC"
	icon = 'modular/vehicles/icons/humvee/humvee.dmi'
	icon_state = "humvee_base"

/obj/effect/vehicle_spawner/humvee/apc/spawn_vehicle()
	var/obj/vehicle/multitile/modul/humvee/apc/HUMVEE_APC = new (loc)

	load_misc(HUMVEE_APC)
	load_hardpoints(HUMVEE_APC)
	handle_direction(HUMVEE_APC)
	HUMVEE_APC.update_icon()

/obj/effect/vehicle_spawner/humvee/apc/load_hardpoints(obj/vehicle/multitile/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/humvee_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/humvee_turret)
