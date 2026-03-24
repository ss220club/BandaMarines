// armor
/obj/item/hardpoint/armor/humvee_snowplow
	name = "\improper Отвал"
	desc = "Расчищает путь в снегу для союзников. Похоже, на этом его применение не заканчивается."

	icon_state = "snowplow"
	disp_icon = "humvee"
	disp_icon_state = "snowplow"

	health = 250
	activatable = 1

/obj/item/hardpoint/armor/humvee_snowplow/livingmob_interact(mob/living/M)
	var/turf/targ = get_step(M, owner.dir)
	targ = get_step(M, owner.dir)
	targ = get_step(M, owner.dir)
	M.throw_atom(targ, 4, SPEED_FAST, src, 1)
	M.apply_damage(50 + rand(25, 25), BRUTE)

/obj/item/hardpoint/armor/humvee_snowplow/on_move(turf/old, turf/new_turf, move_dir)
	if(health <= 0)
		return

	if(dir != move_dir)
		return

	var/turf/ahead = get_step(new_turf, move_dir)

	var/list/turfs_ahead = list(ahead, get_step(ahead, turn(move_dir, 90)), get_step(ahead, turn(move_dir, -90)))
	for(var/turf/open/auto_turf/snow/S in turfs_ahead)
		if(!S.bleed_layer)
			continue
		new /obj/item/stack/snow(S, S.bleed_layer)
		S.changing_layer(0)


// turret
/obj/item/hardpoint/holder/humvee_turret
	name = "\improper Дистанционно управляемая турель M24-JTMV"
	desc = "Центральный элемент M2420 JTMV-HWC. Разработан для быстрой установки и демонтажа различных модулей вооружения JTMV. Имеет встроенную систему развертывания дымовой завесы."

	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'
	icon_state = "humveeturret" // _0
	disp_icon = "humvee" 
	disp_icon_state = "humveeturret"
	activation_sounds = list('sound/weapons/vehicles/smokelauncher_fire.ogg')

	density = TRUE //come on, it's huge

	activatable = TRUE

	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke
	max_clips = 2
	use_muzzle_flash = FALSE

	w_class = SIZE_MASSIVE
	density = TRUE
	anchored = TRUE

	allowed_seat = VEHICLE_DRIVER

	slot = HDPT_TURRET

	// big beefy chonk of metal
	health = 250
	damage_multiplier = 0.05

	accepted_hardpoints = list(
		/obj/item/hardpoint/primary/humvee_cannon,
		/obj/item/hardpoint/secondary/humvee_flare_launcher,
		/obj/item/hardpoint/secondary/humvee_launcher,
	)

	hdpt_layer = HDPT_LAYER_TURRET
	px_offsets = list(
		"1" = list(0, 4),
		"2" = list(0, 15),
		"4" = list(-6, 16),
		"8" = list(6, 16)
	)

	var/gyro = FALSE

	// How long the windup is before the turret rotates
	var/rotation_windup = 0.3 SECONDS
	// Used during the windup
	var/rotating = FALSE

	scatter = 3
	gun_firemode = GUN_FIREMODE_BURSTFIRE
	gun_firemode_list = list(
		GUN_FIREMODE_BURSTFIRE,
	)
	burst_amount = 2
	burst_delay = 1.0 SECONDS
	extra_delay = 13.0 SECONDS

/obj/item/hardpoint/holder/humvee_turret/update_icon()
	var/broken = (health <= 0)
	icon_state = "humveeturret_[broken]"

	/*
	if(health <= initial(health))
		var/image/damage_overlay = image(icon, icon_state = "damaged_turret")
		damage_overlay.alpha = 255 * (1 - (health / initial(health)))
		overlays += damage_overlay
	*/
	..()


/obj/item/hardpoint/holder/humvee_turret/get_icon_image(x_offset, y_offset, new_dir)
	var/icon_state_suffix = "0"
	if(health <= 0)
		icon_state_suffix = "1"

	var/image/I = image(icon = disp_icon, icon_state = "[disp_icon_state]_[icon_state_suffix]", pixel_x = x_offset, pixel_y = y_offset, dir = new_dir)
	/*
	if(health <= initial(health))
		var/image/damage_overlay = image(icon, icon_state = "damaged_turret")
		damage_overlay.alpha = 255 * (1 - (health / initial(health)))
		I.overlays += damage_overlay
	*/
	return I

// no picking this big beast up
/obj/item/hardpoint/holder/humvee_turret/attack_hand(mob/user)
	return

/obj/item/hardpoint/holder/humvee_turret/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/powerloader_clamp))
		var/obj/item/powerloader_clamp/PC = I
		if(!PC.linked_powerloader)
			qdel(PC)
			return TRUE

		if(health < 1)
			visible_message(SPAN_WARNING("\The [src] под воздействием полученных повреждений превращается в бесполезную кучу металлолома!"))
			qdel(src)
			return TRUE

		PC.grab_object(user, src, "vehicle_module", 'sound/machines/hydraulics_2.ogg')
		update_icon()
		return TRUE
	..()


/obj/item/hardpoint/holder/humvee_turret/get_tgui_info()
	var/list/data = list()

	data += list(list( // turret smokescreen data
		"name" = "Turret Smoke Screen",
		"health" = health <= 0 ? null : floor(get_integrity_percent()),
		"uses_ammo" = TRUE,
		"current_rounds" = ammo.current_rounds / 2,
		"max_rounds"= ammo.max_rounds / 2,
		"mags" = LAZYLEN(backup_clips),
		"max_mags" = max_clips,
	))

	for(var/obj/item/hardpoint/H in hardpoints)
		data += list(H.get_tgui_info())

	return data

//gyro ON locks the turret in one direction, OFF will make turret turning when tank turns
/obj/item/hardpoint/holder/humvee_turret/proc/toggle_gyro(mob/user)
	if(health <= 0)
		to_chat(user, SPAN_WARNING("\The [src] системы стабилизации вышли из строя!"))
		return

	gyro = !gyro
	to_chat(user, SPAN_NOTICE("Вы переключаете \the [src] гироскопический стабилизатор [gyro ? "ON" :"OFF"]."))

/obj/item/hardpoint/holder/humvee_turret/proc/user_rotation(mob/user, deg)
	// no rotating a broken turret
	if(health <= 0)
		return

	if(rotating)
		return

	rotating = TRUE
	to_chat(user, SPAN_NOTICE("Вы начинаете вращать башню в сторону [dir2text(turn(dir,deg))]."))

	if(!do_after(user, rotation_windup, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		rotating = FALSE
		return
	rotating = FALSE

	rotate(deg, TRUE)

/obj/item/hardpoint/holder/humvee_turret/rotate(deg, override_gyro = FALSE)
	if(gyro && !override_gyro)
		return

	..(deg)

/obj/item/hardpoint/holder/humvee_turret/try_fire(atom/target, mob/living/user, params)
	var/turf/L
	var/turf/R
	switch(owner.dir)
		if(NORTH)
			L = locate(owner.x - 2, owner.y + 4, owner.z)
			R = locate(owner.x + 2, owner.y + 4, owner.z)
		if(SOUTH)
			L = locate(owner.x + 2, owner.y - 4, owner.z)
			R = locate(owner.x - 2, owner.y - 4, owner.z)
		if(EAST)
			L = locate(owner.x + 4, owner.y + 2, owner.z)
			R = locate(owner.x + 4, owner.y - 2, owner.z)
		else
			L = locate(owner.x - 4, owner.y + 2, owner.z)
			R = locate(owner.x - 4, owner.y - 2, owner.z)

	if(shots_fired)
		target = R
	else
		target = L

	return ..()

// APC cannons
/obj/item/hardpoint/primary/humvee_cannon
	name = "\improper Автопушка M24-RC1"
	desc = "Одноствольная дистанционно управляемая автопушка для бронемашины M2420 JTMV-HWC. Стреляет 10x28-мм вольфрамовыми снарядами. Эффективна против пехоты и легкобронированной техники."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	icon_state = "humveecannon"
	disp_icon = "humvee"
	disp_icon_state = "humveecannon"
	activation_sounds = list('modular/sounds/sound/vehicles/humvee/humvee_cannon.ogg')

	damage_multiplier = 0.2

	health = 240
	firing_arc = 90

	origins = list(0, 0)

	ammo = new /obj/item/ammo_magazine/hardpoint/humvee_cannon
	max_clips = 2

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(-17, -6),
		"2" = list(-16, -58),
		"4" = list(12, -31),
		"8" = list(-44, -32)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_BURSTFIRE
	gun_firemode_list = list(
		GUN_FIREMODE_BURSTFIRE,
	)
	burst_amount = 3
	burst_delay = 0.25 SECONDS
	extra_delay = 0.6 SECONDS

/obj/item/hardpoint/primary/humvee_cannon/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))


/obj/item/hardpoint/primary/humvee_hatch
	name = "\improper Люк M24-JTMV"
	desc = "Простой люк для M24-JTMV. Может быть снят для установки различного дополнительного оборудования."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	icon_state = "humveehatch"
	disp_icon = "humvee"
	disp_icon_state = "humveehatch"

	health = 200

// flare_launcher
/obj/item/hardpoint/secondary/humvee_flare_launcher
	name = "\improper Сигнальная ракетница M-77F"
	desc = "Вспомогательный модуль для M24-JTMV, предназначенный для запуска осветительных огней."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	icon_state = "humveelauncher"
	disp_icon = "humvee"
	disp_icon_state = "humveelauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.1

	activatable = TRUE

	health = 220
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/flare_launcher
	max_clips = 3

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_laser"

	muzzle_flash_pos = list(
		"1" = list(-27, -28),
		"2" = list(-5, -37),
		"4" = list(-12, -19),
		"8" = list(-21, -42)
	)

	scatter = 6
	fire_delay = 3.0 SECONDS

/obj/item/hardpoint/secondary/humvee_flare_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	)) 

// Thermobaric launcher
/obj/item/hardpoint/secondary/humvee_launcher
	name = "\improper Реактивный огнемёт M24-JTMV"
	desc = "Вспомогательное оружие поддержки пехоты для M24-JTMV, стреляющее термобарическеми ракетами."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	icon_state = "humveelauncher"
	disp_icon = "humvee"
	disp_icon_state = "humveelauncher"
	activation_sounds = list('sound/weapons/gun_rocketlauncher.ogg')

	health = 200
	firing_arc = 60

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_laser"

	ammo = new /obj/item/ammo_magazine/hardpoint/humvee_launcher
	max_clips = 1

	muzzle_flash_pos = list(
		"1" = list(-27, -28),
		"2" = list(-5, -37),
		"4" = list(-12, -19),
		"8" = list(-21, -42)
	)

	scatter = 4
	fire_delay = 40.0 SECONDS

// lights
/obj/item/hardpoint/support/humvee_overhead_lights
	name = "\improper Навесные прожекторы JTMV"
	desc = "Навесные прожекторы для JTMV. На тот случай, когда вам действительно нужно поднять себе настроение."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	icon_state = "overlight"
	disp_icon = "humvee"
	disp_icon_state = "overlight"

	slot = HDPT_SUPPORT
	hdpt_layer = HDPT_LAYER_SUPPORT

	health = 200

	var/light_range_upgrade = 10
	var/light_power_upgrade = 8

/obj/item/hardpoint/support/humvee_overhead_lights/proc/turn_off_lights()
	var/obj/vehicle/multitile/modul/humvee_owner = owner
	if(!istype(humvee_owner))
		return

	humvee_owner.lighting_holder.set_light_range(humvee_owner.vehicle_light_range)
	humvee_owner.lighting_holder.set_light_power(humvee_owner.vehicle_light_power)

/obj/item/hardpoint/support/humvee_overhead_lights/on_install(obj/vehicle/multitile/vehicle)
	. = ..()
	vehicle.lighting_holder.set_light_range(light_range_upgrade)
	vehicle.lighting_holder.set_light_power(light_power_upgrade)

/obj/item/hardpoint/support/humvee_overhead_lights/on_uninstall(obj/vehicle/multitile/vehicle)
	. = ..()
	turn_off_lights()

/obj/item/hardpoint/support/humvee_overhead_lights/on_destroy()
	. = ..()
	var/obj/vehicle/multitile/modul/humvee_owner = owner
	if(!istype(humvee_owner))
		return
	turn_off_lights()


// humvee_wheels
/obj/item/hardpoint/locomotion/humvee_wheels
	name = "\improper Колеса M24-JTMV"
	desc = "Неотъемлемая часть движения M24-JTMV."
	icon = 'modular/vehicles/icons/humvee/humvee_hardpoints.dmi'

	damage_multiplier = 0.15

	icon_state = "tires"
	disp_icon = "humvee"
	disp_icon_state = "humvee_wheels"

	health = 250

	move_delay = VEHICLE_SPEED_SUPERFAST
	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.5
