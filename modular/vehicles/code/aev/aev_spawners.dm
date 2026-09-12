/obj/effect/vehicle_spawner/aev
	name = "AEV Spawner"
	icon = 'modular/vehicles/icons/aev/aev.dmi'
	icon_state = "aev_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/aev/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/aev/spawn_vehicle()
	var/obj/vehicle/multitile/tank/aev/AEV = new(loc)

	load_misc(AEV)
	load_hardpoints(AEV)
	handle_direction(AEV)
	AEV.update_icon()

	return AEV

/obj/effect/vehicle_spawner/aev/fixed/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/armor/snowplow)
	V.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/aev)
	V.add_hardpoint(new /obj/item/hardpoint/primary/aev_launcher)
