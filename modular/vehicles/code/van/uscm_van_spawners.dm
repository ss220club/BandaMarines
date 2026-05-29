// PRESETS SPAWNERS

//uscm_van
/obj/effect/vehicle_spawner/uscm_van
	name = "M577-T Mule"
	icon = 'modular/vehicles/icons/uscm_van.dmi'
	icon_state = "van_base"

/obj/effect/vehicle_spawner/uscm_van/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/uscm_van/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/VAN = new (loc)

	load_misc(VAN)
	handle_direction(VAN)
	VAN.update_icon()

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uscm_van/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uscm_van/decrepit/load_hardpoints(obj/vehicle/multitile/uscm_van/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uscm_van/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uscm_van/fixed/load_hardpoints(obj/vehicle/multitile/uscm_van/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)


//uscm_van/med
/obj/effect/vehicle_spawner/uscm_van/med
	name = "M577-M Husky Spawner"
	icon = 'modular/vehicles/icons/uscm_van_med.dmi'
	icon_state = "van_base"

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/uscm_van/med/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/med/MED_VAN = new (loc)

	load_misc(MED_VAN)
	handle_direction(MED_VAN)
	MED_VAN.update_icon()

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uscm_van/med/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/med/MED_VAN = new (loc)

	load_misc(MED_VAN)
	load_hardpoints(MED_VAN)
	handle_direction(MED_VAN)
	load_damage(MED_VAN)
	MED_VAN.update_icon()

/obj/effect/vehicle_spawner/uscm_van/med/decrepit/load_hardpoints(obj/vehicle/multitile/uscm_van/med/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uscm_van/med/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uscm_van/med/MED_VAN = new (loc)

	load_misc(MED_VAN)
	load_hardpoints(MED_VAN)
	handle_direction(MED_VAN)
	MED_VAN.update_icon()

/obj/effect/vehicle_spawner/uscm_van/med/fixed/load_hardpoints(obj/vehicle/multitile/uscm_van/med/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)
