//UPP TURRET
/obj/item/hardpoint/holder/tank_turret/uppturret
	name = "\improper VT/CZ 'Condor' Turret"
	desc = "VT/CZ 'Condor' Turret complex, developed in the Czech Republic with assistance from Austria and Slovakia. Produced as part of the 'A' upgrade package for the Cheetah 2, the VT/CZ follows the familiar philosophy of most UPP equipment: Modularity. Its' ability to mount a wide array of weapon systems both quickly and easily has allowed the vehicle to see wide application from its' intended air-assault role, to indirect fire, anti-air missions and tank hunting."
	icon = 'modular/distress/icons/upptank.dmi'
	icon_state = "tank_turret_0"
	disp_icon = "tank"
	disp_icon_state = "tank_turret"
	activation_sounds = list('sound/weapons/vehicles/smokelauncher_fire.ogg')
	pixel_x = -48
	pixel_y = -48

	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke
	max_clips = 5
	use_muzzle_flash = FALSE

	// big beefy chonk of metal
	health = 500
	damage_multiplier = 0.05

	accepted_hardpoints = list(
		// primaries
		/obj/item/hardpoint/primary/cannon/p17702,
		// secondaries
		/obj/item/hardpoint/secondary/t60p3m,
		// support
		/obj/item/hardpoint/support/flare_launcher/upptank,
	)

	hdpt_layer = HDPT_LAYER_TURRET
	px_offsets = list(
		"1" = list(0, 3),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

/obj/item/hardpoint/holder/tank_turret/uppturret/get_tgui_info()
	var/list/data = list()

	data += list(list( // turret smokescreen data
		"name" = "VT/CZ Turret Smoke Screen",
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
	

//UPP ARMOR
/obj/item/hardpoint/armor/reactive
	name = "\improper Reactive Armor"
	desc = "A set of explosive reactive armor panels for the tank hull that increases its resistance to shaped charges and kinetic penetrators."

	icon = 'modular/distress/icons/hsupptank.dmi'
	icon_state = "reactive_armor"
	disp_icon = "upptank"
	disp_icon_state = "reactive_armor"

	health = 1000

	type_multipliers = list(
		"explosive" = 0.70,
		"bullet" = 0.70,
		"slash" = 0.70,
		"blunt" = 0.50,
		"all" = 0.9
	)

// UPP Cannon for upp tank
/obj/item/hardpoint/primary/cannon/p17702
	name = "\improper P-177-02 93mm Cannon"
	desc = " Developed in Vietnam as part of a multinational project including China, Cambodia and Laos. This 93mm smoothbore cannon is seen in use with several light UPP vehicles and defensive fortifications. Though it's most notable as the standard gun for the Cheetah 2A. A rugged gun capable of operating in the most inhospitable environments, be it deep-sea trenches, airless moons, alien bogs or impossible jungles."
	icon = 'modular/distress/icons/hsupptank.dmi'
	icon_state = "p17702"
	disp_icon = "upptank"
	disp_icon_state = "p17702"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 500
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/p17702
	max_clips = 4

	px_offsets = list(
		"1" = list(-1, 18),
		"2" = list(0, -38),
		"4" = list(17, 12),
		"8" = list(-18, 12)
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(0, 67),
		"2" = list(-1, -88),
		"4" = list(86, -6),
		"8" = list(-86, -6)
	)

	scatter = 0
	fire_delay = 100

/obj/item/hardpoint/secondary/t60p3m
	name = "\improper T6OP-3M 'Buzzard' RWS"
	desc = "An older, albeit modernized remote machinegun seen in use by the Cheetah 2A. This Russo-Polish developed machinegun features robust autonomous fire capability, and was commonly used to intercept low-threat projectiles, though thanks to the superior active and passive systems in most vehicles, tankists now prefer to simply fire it at infantry and soft targets instead. Known for an annoying tendency for drifting off target in certain high temperature environments."
	icon = 'modular/distress/icons/hsupptank.dmi'
	icon_state = "t60p3m"
	disp_icon = "upptank"
	disp_icon_state = "t60p3m"
	activation_sounds = list('sound/weapons/gun_smartgun1.ogg', 'sound/weapons/gun_smartgun2.ogg', 'sound/weapons/gun_smartgun3.ogg', 'sound/weapons/gun_smartgun4.ogg')

	health = 500
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/t60p3m
	max_clips = 1

	use_muzzle_flash = FALSE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(8, -7),
		"2" = list(-7, -21),
		"4" = list(12, -10),
		"8" = list(-11, 7)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 1

/obj/item/hardpoint/secondary/t60p3m/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

// UPP TANK
/obj/item/hardpoint/support/flare_launcher/upptank
	name = "\improper VT/CZ-Flare Launcher"
	desc = "A support module for Tanks that shoots flares."
	icon = 'modular/distress/icons/hsupptank.dmi'

	icon_state = "turret_slauncher"
	disp_icon = "upptank"
	disp_icon_state = "turret_slauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.15

	activatable = TRUE

	health = 500
	firing_arc = 120

	allowed_seat = VEHICLE_GUNNER

	use_muzzle_flash = FALSE

/obj/item/device/radio/headset/distress/UPP
	name = "UPP headset"
	desc = "A special headset used by UPP military. To access the colony channel, use :o."
	frequency = UPP_FREQ
	icon = 'modular/distress/icons/radio.dmi'
	icon_state = "cam_gear_on"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_UPP
	minimap_flag = MINIMAP_FLAG_UPP
	minimap_type = /datum/action/minimap/marine/upp
	item_icons = list(
		WEAR_L_EAR = 'modular/distress/icons/ears.dmi',
		WEAR_R_EAR = 'modular/distress/icons/ears.dmi',
	)

/obj/item/device/motiondetector/upp
	name = "UDO-58 motion detector"
	desc = "Ustroystvo Dalnego Obnaruzhenia/Long Range Detection Device. A military grade, hand-held motion detection device designed not long after its analogue in the USCM was developed. The device can penetrate most anything and has an approximate range of 28 meters. Can also be utilized to scan vehicle interiors. This one is programmed to operate with UPPAC Naval Infantry IFF."
	icon = 'modular/distress/icons/upp-items.dmi'
	icon_state = "detector"
	item_state = "upp_motion_detector"
	iff_signal = FACTION_UPP

/obj/item/storage/backpack/marine/satchel/rto/upp_net
	name = "\improper R-559 'Bagulnik' Radio Telephone Pack"
	icon = 'modular/distress/icons/backpacks.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi',
		WEAR_BACK = 'modular/distress/icons/back.dmi',
	)
	icon_state = "upp_rto_backpack"
	item_state = "upp_rto_backpack"
	actions_types = list(/datum/action/item_action/rto_pack/use_phone/upp)

/datum/action/item_action/rto_pack/use_phone/upp/New(mob/living/user, obj/item/holder)
    ..()
    button.overlays.Cut()
    var/image/I = image('modular/distress/icons/misc.dmi', button, "upp_rpb_phone")
    button.overlays += I

/datum/ammo/bullet/pkp
	name = "machinegun bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "redtrac"
	

	accuracy = HIT_ACCURACY_TIER_1
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_8
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 14
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_5
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_5