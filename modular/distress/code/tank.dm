/obj/vehicle/multitile/tank/upptank
	name = "Cheetah 2A Light Tank"
	desc = "A giant piece of state-approved armor with a big gun, you know what to do. Entrance in the back."
	desc_lore = "The Cheetah 2A is an assault tank designed to be rapidly deployed from light dropcraft in daring raids and first strike operations. The Cheetah 2A is relatively new in comparison to most UPP vehicles seen on the Frontier, but has already earned a fair reputation as a reliable workhorse, that is able to bring some cutting edge technology to the fight. While the project was based in Germany, the Cheetah 2A has a truly progressive development history, seeing influences from nearly all UPP member states."

	icon = 'modular/distress/icons/upptank.dmi'
	icon_state = "tank_base"
	interior_map = /datum/map_template/interior/modul/upptank

	light_range = 4

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/uppturret,
		/obj/item/hardpoint/support/weapons_sensor,
		/obj/item/hardpoint/support/overdrive_enhancer,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/armor/reactive,
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
	)

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 4,
		"slash" = 0.35,
		"bullet" = 0.45,
		"explosive" = 0.65,
		"blunt" = 0.4,
		"abstract" = 1
	)

/obj/vehicle/multitile/tank/upptank/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] Cheetah 2A \"[nickname]\" Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] Cheetah 2A Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/upptank/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/upptank
	name = "UPP Tank Spawner"
	icon = 'modular/distress/icons/upptank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/upptank/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)


/obj/effect/vehicle_spawner/upptank/spawn_vehicle()
	var/obj/vehicle/multitile/tank/upptank/TANK = new(loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/upptank/load_hardpoints(obj/vehicle/multitile/tank/upptank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)

	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

//PRESET: default hardpoints, MG secondaries
/obj/effect/vehicle_spawner/upptank/fixed/load_hardpoints(obj/vehicle/multitile/tank/upptank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

