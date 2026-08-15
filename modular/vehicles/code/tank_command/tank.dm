/*
** COMMAND TANK
*/
/obj/vehicle/multitile/tank/command
	name = "M34A3 Hampton Light Command Tank"
	desc = "A giant piece of armor with a big gun and enhanced comms equipment, you know what to do. Entrance in the back."
	desc_lore = "Developed and deployed recently, the A3 model of the M34 light tank is a command variant of the Longstreet. The Hampton fields a bigger fighting compartment to facilitate a 'commander' station, and more robust connections to the command & control network compared to the more commonly seen version."

	interior_map = /datum/map_template/interior/modular/tank_command

	passengers_slots = 5
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 3
	xenos_slots = 4

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

/obj/vehicle/multitile/tank/command/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M34A3 \"[nickname]\" Command Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] M34A3 Command Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/command/add_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	add_verb(user.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/vehicle/multitile/tank/command/remove_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	remove_verb(user.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/switch_hardpoint,
	))
	SStgui.close_user_uis(user, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))
