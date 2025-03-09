/obj/vehicle/multitile/arm
	name = "\improper АРМ"
	desc = "АРМ-540. Используется на большинствах колоний как грузовое транспортное средство."

	icon = 'modular/arm/icons/arm.dmi'
	icon_state = "arm_base"
	pixel_x = -15
	pixel_y = 0

	bound_width = 64
	bound_height = 64

	health = 800

	interior_map = /datum/map_template/interior/arm

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
		"back_left" = list(1, 2),
		"back_right" = list(0, 2)
	)

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/treads/arm,
	)

	move_max_momentum = 3
	move_momentum_build_factor = 1.8
	move_turn_momentum_loss_factor = 0.6



/obj/vehicle/multitile/arm/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return

	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/name_vehicle,
		))
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/name_vehicle,
	))

/obj/vehicle/multitile/arm/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	SStgui.close_user_uis(M, src)

/obj/effect/vehicle_spawner/arm
	name = "Arm Spawner"
	icon = 'modular/arm/icons/arm.dmi'
	icon_state = "arm_base"

/obj/effect/vehicle_spawner/arm/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/arm/spawn_vehicle()
	var/obj/vehicle/multitile/arm/ARM = new (loc)

	load_misc(ARM)
	handle_direction(ARM)
	ARM.update_icon()

/obj/effect/vehicle_spawner/arm/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/arm/ARM = new (loc)

	load_misc(ARM)
	load_hardpoints(ARM)
	handle_direction(ARM)
	load_damage(ARM)
	ARM.update_icon()

/obj/effect/vehicle_spawner/arm/decrepit/load_hardpoints(obj/vehicle/multitile/arm/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads/arm)

/obj/effect/vehicle_spawner/arm/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/arm/ARM = new (loc)

	load_misc(ARM)
	load_hardpoints(ARM)
	handle_direction(ARM)
	ARM.update_icon()

/obj/effect/vehicle_spawner/arm/fixed/load_hardpoints(obj/vehicle/multitile/arm/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads/arm)

/obj/vehicle/multitile/arm/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE
