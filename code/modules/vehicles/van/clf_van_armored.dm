/obj/vehicle/multitile/clf_van_armored
	name = "CLF Technical m56d"
	desc = "A repurposed civilian truck, plastered with CLF emblems and insignias. Armor plates have been attached on all sides, including the front windows.A colony van, uparmored and with a mounted M56 Cupola on the top. Bulletholes riddle the vehicle."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/CLF_van_armored.dmi'
	icon_state = "van_base_armored"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/clf_van_armored

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
		"back_left" = list(1, 2),
		"back_right" = list(0, 2)
	)

	vehicle_flags = VEHICLE_CLASS_WEAK

	passengers_slots = 8
	xenos_slots = 2

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
	)

	vehicle_flags = VEHICLE_CLASS_LIGHT

	light_range = 5

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/van_wheels,
		/obj/item/hardpoint/primary/van_mg,
	)

	seats = list(
		VEHICLE_DRIVER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
	)


	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	misc_multipliers = list(
		"move" = 0.6,
		"accuracy" = 1,
		"cooldown" = 1
	)

/obj/vehicle/multitile/clf_van_armored/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
			/obj/vehicle/multitile/proc/activate_horn,
		))

/obj/vehicle/multitile/clf_van_armored/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
			/obj/vehicle/multitile/proc/activate_horn,
		))

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/van/clf_armored
	name = "CLF Armored van"
	icon = 'icons/obj/vehicles/CLF_van_armored.dmi'
	icon_state = "van_armored_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/van_armored/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/van_armored/spawn_vehicle()
	var/obj/vehicle/multitile/van_armored/ARM_VAN = new (loc)

	load_misc(ARM_VAN)
	load_hardpoints(ARM_VAN)
	handle_direction(ARM_VAN)
	ARM_VAN.update_icon()

//PRESET: only wheels installed
/obj/effect/vehicle_spawner/van_armored/load_hardpoints(obj/vehicle/multitile/van/armored/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/van_armored/decrepid/spawn_vehicle()
	var/obj/vehicle/multitile/van_armored/ARM_VAN = new (loc)

	load_misc(ARM_VAN)
	load_hardpoints(ARM_VAN)
	handle_direction(ARM_VAN)
	load_damage(ARM_VAN)
	ARM_VAN.update_icon()

//PRESET: MG
/obj/effect/vehicle_spawner/van_armored/mg/load_hardpoints(obj/vehicle/multitile/apc/arc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/primary/van_mg)
