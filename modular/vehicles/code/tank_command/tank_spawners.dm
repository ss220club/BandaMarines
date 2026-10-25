//COMMAND TANK PRESET: no armor, guns or module
/obj/effect/vehicle_spawner/tank/command/spawn_vehicle()
	var/obj/vehicle/multitile/tank/command/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/command/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)

//COMMAND TANK ARMED PRESET: LTB, cupola gun & artillery module
/obj/effect/vehicle_spawner/tank/command/fixed/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break
