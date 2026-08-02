/obj/vehicle/multitile/van/upp
	name = "Kheshig-1M"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union."

	icon = 'modular/distress/icons/uppvan.dmi'
	icon_state = "uppvan_base"

	interior_map = /datum/map_template/interior/modul/uppvan

	passengers_slots = 14
	xenos_slots = 2

	light_range = 5
	vehicle_light_range = 7

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/van_wheels/upp,
	)

/obj/vehicle/multitile/van/upp/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/vehicle/multitile/van/upp/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/switch_hardpoint,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/effect/vehicle_spawner/van/upp
	name = "Van Spawner"
	icon = 'modular/distress/icons/uppvan.dmi'
	icon_state = "uppvan_base"
	pixel_x = -16
	pixel_y = -16

/obj/effect/vehicle_spawner/van/upp/Initialize()
	. = ..() 
	spawn_vehicle()
	return INITIALIZE_HINT_QDEL

/obj/effect/vehicle_spawner/van/upp/spawn_vehicle()
	var/obj/vehicle/multitile/van/upp/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()


/obj/effect/vehicle_spawner/van/upp/load_hardpoints(obj/vehicle/multitile/van/upp/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)


/obj/vehicle/multitile/van/upp/medical
	name = "Kheshig-1M-Medical"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed, The cross on the top marks this vehicle as a medical evacuation vehicle."

	icon = 'modular/distress/icons/uppvan.dmi'
	icon_state = "uppvan_medical"

	interior_map = /datum/map_template/interior/modul/uppvan/medical

/obj/effect/vehicle_spawner/van/upp/medical/spawn_vehicle()

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/van/upp/medical
	name = "Medical Van Spawner"
	icon = 'modular/distress/icons/uppvan.dmi'
	icon_state = "uppvan_medical"

