/obj/vehicle/multitile/humvee
	name = "\improper M2420 JTMV-HWC Heavy Weapon Carrier"
	desc = "Многоцелевой бронетранспортер M2422 JTMV. Легкобронированная машина. Входы сзади и по бокам."

	icon = 'modular/vehicles/icons/humvee/humvee.dmi'
	icon_state = "humvee_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 64
	bound_height = 64

	bound_x = -32
	bound_y = -32

	health = 500

	interior_map = /datum/map_template/interior/modul/humvee
	minimap_icon_state = "humvee"

	passengers_slots =  4
	xenos_slots = 3

	misc_multipliers = list(
		"move" = 0.8, 
		"accuracy" = 1,
		"cooldown" = 1
	)

	entrances = list(
		"right" = list(-2, -1),
		"left" = list(1, -1),
		"back left" = list(1, 0),
		"back right" = list(-2, 0),
	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_SMALL

	movement_sound = 'modular/sounds/sound/vehicles/humvee/humvee_driving.ogg'
	honk_sound = 'modular/sounds/sound/vehicles/humvee/humvee_horn.ogg'

	luminosity = 7

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/humvee_wheels,
	)

	seats = list(
		VEHICLE_DRIVER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
	)

	vehicle_flags = VEHICLE_CLASS_WEAK

	mob_size_required_to_hit = MOB_SIZE_XENO


	//Включает возможность пролезать под Humvee
	var/allow_squeeze_under = TRUE
	//Включает возможность ускорения Humvee
	var/has_overdrive = TRUE

	var/overdrive_next = 0
	var/overdrive_cooldown = 30 SECONDS
	var/overdrive_duration = 3 SECONDS
	var/overdrive_speed_mult = 0.3 // Additive (30% more speed, adds to 80% more speed)

	var/momentum_loss_on_weeds_factor = 0.2

	move_on_turn = TRUE

	var/list/mobs_under = list()
	var/image/under_image
	var/image/normal_image

	var/next_push = 0
	var/push_delay = 0.5 SECONDS


	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION

/obj/vehicle/multitile/humvee/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		// Check if wheels are installed
		if(!(locate(/obj/item/hardpoint/locomotion/humvee_wheels) in hardpoints))
			return FALSE

		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/humvee_turret/T = null
	for(var/obj/item/hardpoint/holder/humvee_turret/TT in hardpoints)
		T = TT
		break
	if(!T)
		return FALSE

	if(direction == GLOB.reverse_dir[T.dir] || direction == T.dir)
		return FALSE

	T.user_rotation(user, turning_angle(T.dir, direction))
	update_icon()

	return TRUE


// Делаем лучше

/obj/vehicle/multitile/humvee/Initialize()
	. = ..()
	under_image = image(icon, src, icon_state, layer = BELOW_MOB_LAYER)
	under_image.alpha = 127

	normal_image = image(icon, src, icon_state, layer = layer)

	icon_state = null

	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(add_default_image))

	for(var/icon in GLOB.player_list)
		add_default_image(SSdcs, icon)

/obj/vehicle/multitile/humvee/BlockedPassDirs(atom/movable/mover, target_dir)
	if(mover in mobs_under) //can't collide with the thing you're buckled to
		return NO_BLOCKED_MOVEMENT

	if(isliving(mover))
		var/mob/living/mob = mover
		if(allow_squeeze_under && (mob.mob_flags & SQUEEZE_UNDER_VEHICLES)) // SQUEEZE_UNDER_VEHICLES это слишком много ксеносов, надо уменьшить пулл
			add_under_humvee(mob)
			return NO_BLOCKED_MOVEMENT

		if(mob.body_position == LYING_DOWN)
			return NO_BLOCKED_MOVEMENT

		if(mob.mob_size >= MOB_SIZE_IMMOBILE && next_push < world.time)
			if(try_move(target_dir, force=TRUE))
				next_push = world.time + push_delay
				return NO_BLOCKED_MOVEMENT

	return ..()


/obj/vehicle/multitile/humvee/pre_movement()
	if(locate(/obj/effect/alien/weeds) in loc)
		move_momentum *= momentum_loss_on_weeds_factor

	. = ..()

	for(var/icon in mobs_under)
		var/mob/mob = icon
		if(!(mob.loc in locs))
			remove_under_humvee(mob)

/obj/vehicle/multitile/humvee/proc/add_under_humvee(mob/living/living)
	if(living in mobs_under)
		return

	mobs_under += living
	RegisterSignal(living, COMSIG_PARENT_QDELETING, PROC_REF(remove_under_humvee))
	RegisterSignal(living, COMSIG_MOB_LOGGED_IN, PROC_REF(add_client))
	RegisterSignal(living, COMSIG_MOVABLE_MOVED, PROC_REF(check_under_humvee))

	if(living.client)
		add_client(living)

/obj/vehicle/multitile/humvee/proc/remove_under_humvee(mob/living/living)
	SIGNAL_HANDLER
	mobs_under -= living

	if(living.client)
		living.client.images -= under_image
		add_default_image(SSdcs, living)

	UnregisterSignal(living, list(
		COMSIG_PARENT_QDELETING,
		COMSIG_MOB_LOGGED_IN,
		COMSIG_MOVABLE_MOVED,
	))

/obj/vehicle/multitile/humvee/proc/check_under_humvee(mob/mob, turf/oldloc, direction)
	SIGNAL_HANDLER
	if(!(mob.loc in locs))
		remove_under_humvee(mob)

/obj/vehicle/multitile/humvee/proc/add_client(mob/living/living)
	SIGNAL_HANDLER
	living.client.images += under_image
	living.client.images -= normal_image

/obj/vehicle/multitile/humvee/proc/add_default_image(subsystem, mob/mob)
	SIGNAL_HANDLER
	mob.client.images += normal_image

/obj/vehicle/multitile/humvee/Destroy()
	for(var/icon in mobs_under)
		remove_under_humvee(icon)

	for(var/mob/mob in GLOB.player_list)
		if(mob?.client)
			mob.client.images -= normal_image

	QDEL_NULL(lighting_holder)

	return ..()

/obj/vehicle/multitile/humvee/attackby(obj/item/O, mob/user)
	if(user.z != z)
		return ..()

	if(iswelder(O) && health >= initial(health))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("Вам нужно больше сварочного топлива!"))
			return
		var/obj/item/hardpoint/hardpoint_to_repair
		for(var/obj/item/hardpoint/potential_hardpoint in hardpoints)
			if(potential_hardpoint.health < initial(potential_hardpoint.health))
				hardpoint_to_repair = potential_hardpoint
				break

		if(hardpoint_to_repair)
			hardpoint_to_repair.handle_repair(O, user)
			update_icon()
			return

	. = ..()


/obj/vehicle/multitile/humvee/handle_click(mob/living/user, atom/A, list/mods)
	if(mods[SHIFT_CLICK] && !mods[ALT_CLICK])
		if(!has_overdrive)
			return
		if(overdrive_next > world.time)
			to_chat(user, SPAN_WARNING("Пока нельзя активировать ускорение! Подождите [round((overdrive_next - world.time) / 10, 0.1)] секунд."))
			return

		misc_multipliers["move"] -= overdrive_speed_mult
		addtimer(CALLBACK(src, PROC_REF(reset_overdrive)), overdrive_duration)

		overdrive_next = world.time + overdrive_cooldown
		to_chat(user, SPAN_NOTICE("Вы активировали ускорение."))
		playsound(src, 'sound/vehicles/box_van_overdrive.ogg', 75, FALSE)
		return

	return ..()

/obj/vehicle/multitile/humvee/proc/reset_overdrive()
	misc_multipliers["move"] += overdrive_speed_mult

/obj/vehicle/multitile/humvee/get_projectile_hit_boolean(obj/projectile/P)
	if(src == P.original) //clicking on the humvee itself will hit it.
		var/hitchance = P.get_effective_accuracy()
		if(prob(hitchance))
			return TRUE
	return FALSE

/obj/vehicle/multitile/humvee/Collide(atom/A)
	if(!seats[VEHICLE_DRIVER])
		return FALSE

	if(istype(A, /obj/structure/barricade/plasteel))
		return ..()

	if(istype(A, /turf/closed/wall) || \
		istype(A, /obj/structure/barricade/sandbags) || \
		istype(A, /obj/structure/barricade/metal) || \
		istype(A, /obj/structure/barricade/deployable) || \
		istype(A, /obj/structure/machinery/cryopod)) //Can no longer runover cryopods

		return FALSE

	return ..()
