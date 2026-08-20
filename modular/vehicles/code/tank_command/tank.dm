/*
** COMMAND TANK
*/
GLOBAL_LIST_EMPTY(command_tank_list)

/obj/vehicle/multitile/tank/command
	name = "M34A3 Hampton Light Command Tank"
	desc = "A giant piece of armor with a big gun and enhanced comms equipment, you know what to do. Entrance in the back."
	desc_lore = "Developed and deployed recently, the A3 model of the M34 light tank is a command variant of the Longstreet. The Hampton fields a bigger fighting compartment to facilitate a 'commander' station, and more robust connections to the command & control network compared to the more commonly seen version."

	interior_map = /datum/map_template/interior/modular/tank_command

	var/sensor_radius = 25 //45 tiles radius
	var/list/minimap_added = list()

	passengers_slots = 5
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 3
	xenos_slots = 4

	move_max_momentum = 6

	dmg_multipliers = list(
		"all" = 1.2,
		"acid" = 1.5,
		"slash" = 0.8,
		"bullet" = 0.5,
		"explosive" = 0.9,
		"blunt" = 0.9,
		"abstract" = 1
	)

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

/obj/vehicle/multitile/tank/command/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN, JOB_ARMY_TANK)
	RRS.total = 2
	role_reserved_slots += RRS

	RRS = new
	RRS.category_name = "Command Staff"
	RRS.roles = JOB_COMMAND_ROLES_LIST
	RRS.total = 1
	role_reserved_slots += RRS

/obj/vehicle/multitile/tank/command/add_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	add_verb(user.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
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
		/obj/vehicle/multitile/proc/name_vehicle,
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

/obj/vehicle/multitile/tank/command/Initialize()
	. = ..()
	START_PROCESSING(SSslowobj, src)
	GLOB.command_tank_list += src

/obj/vehicle/multitile/tank/command/Destroy()
	GLOB.command_tank_list -= src
	STOP_PROCESSING(SSslowobj, src)
	return ..()

/obj/vehicle/multitile/tank/command/process()
	var/turf/tank_turf = get_turf(src)
	if(health == 0 || !visible_in_tacmap || !is_ground_level(tank_turf.z))
		return

	for(var/mob/living/carbon/xenomorph/current_xeno as anything in GLOB.living_xeno_list)
		var/turf/xeno_turf = get_turf(current_xeno)
		if(!is_ground_level(xeno_turf.z))
			continue

		if(get_dist(src, current_xeno) <= sensor_radius)
			if(WEAKREF(current_xeno) in minimap_added)
				continue

			SSminimaps.remove_marker(current_xeno)
			current_xeno.add_minimap_marker(MINIMAP_FLAG_USCM|get_minimap_flag_for_faction(current_xeno.hivenumber))
			minimap_added += WEAKREF(current_xeno)
		else
			if(WEAKREF(current_xeno) in minimap_added)
				SSminimaps.remove_marker(current_xeno)
				current_xeno.add_minimap_marker()
				minimap_added -= WEAKREF(current_xeno)
