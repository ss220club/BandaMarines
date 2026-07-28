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

/obj/item/clothing/suit/storage/marine/faction/UPP
	name = "\improper UM5 personal armor"
	desc = "Standard body armor of the UPP military, the UM5 (Union Medium MK5) is a medium body armor, roughly on par with the M3 pattern body armor in service with the USCM, specialized towards ballistics protection. Unlike the M3, however, the plate has a heavier neckplate. This has earned many UA members to refer to UPP soldiers as 'tin men'."
	icon_state = "upp_armor"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UPP.dmi'
	)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	storage_slots = 2
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP, /obj/item/clothing/under/marine/veteran/UPP/medic, /obj/item/clothing/under/marine/veteran/UPP/engi, /obj/item/clothing/under/marine/veteran/UPP/SOF_uniform)

/obj/item/clothing/suit/storage/marine/faction/UPP/support
	name = "\improper UL6 personal armor"
	desc = "Standard body armor of the UPP military, the UL6 (Union Light MK6) is a light body armor, slightly weaker than the M3 pattern body armor in service with the USCM, specialized towards ballistics protection. This set of personal armor lacks the iconic neck piece and some of the armor in favor of user mobility."
	storage_slots = 3
	icon_state = "upp_armor_support"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGH

/obj/item/clothing/suit/storage/marine/faction/UPP/heavy
	name = "\improper UH7 heavy plated armor"
	desc = "An extremely heavy-duty set of body armor in service with the UPP military, the UH7 (Union Heavy MK7) is known for having powerful ballistic protection, alongside a noticeable neck guard, fortified in order to allow the wearer to endure the stresses of the bulky helmet."
	icon_state = "upp_armor_heavy"
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_HEAVY
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS

/obj/item/clothing/head/helmet/marine/veteran/UPP/heavy
	name = "\improper UH7 helmet"
	desc = "Like the UM4, this helmet is very resistant to ballistic damage, but both its flaws and benefits have been doubled. The few UPP Zhergeants that have lived past age 30 have all needed to retire from terminal neck problems caused from the stress of wearing this helmet."
	icon_state = "upp_helmet_heavy"
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

/obj/item/device/motiondetector/upp
	name = "UDO-58 motion detector"
	desc = "Ustroystvo Dalnego Obnaruzhenia/Long Range Detection Device. A military grade, hand-held motion detection device designed not long after its analogue in the USCM was developed. The device can penetrate most anything and has an approximate range of 28 meters. Can also be utilized to scan vehicle interiors. This one is programmed to operate with UPPAC Naval Infantry IFF."
	icon = 'modular/distress/icons/upp-items.dmi'
	icon_state = "detector"
	item_state = "upp_motion_detector"
	iff_signal = FACTION_UPP
	
/obj/item/device/multitool/upp
	icon = 'modular/distress/icons/misc.dmi'
	icon_state = "multitool_upp"
	item_state = "multitool_upp"
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi'
	)
	
/obj/item/phone/upp
	icon = 'modular/distress/icons/misc.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi'
	)
	icon_state = "upp_rpb_phone"

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

/obj/item/storage/backpack/marine/satchel/rto/upp_net/Initialize()
	. = ..()

	internal_transmitter.phone_type = /obj/item/phone/upp
/datum/action/item_action/rto_pack/use_phone/upp/New(mob/living/user, obj/item/holder)
    ..()
    button.overlays.Cut()
    var/image/I = image('modular/distress/icons/misc.dmi', button, "upp_rpb_phone")
    button.overlays += I

/obj/structure/mortar/himat
	name = "M112 HIMAT"
	icon = 'modular/distress/icons/mortar.dmi'
	desc = "A man-portable two-stage missile launcher. While capable of being fired manually, what truly sets this apart from standard boom-tubes is it's onboard fire-control systems. While deployed on a baseplate and supporting bipod stand it will attempt to link with any local USCM sensor matrix, allowing it to automatically track, identify and request to fire upon hostile targets in range."
	icon_state = "himat"
	max_range = 70
	var/kit_type = /obj/item/mortar_kit/himat
	travel_time = 60
	var/obj/item/mortar_shell/loaded_shell = null
	var/id

/obj/structure/mortar/himat/Initialize()
	. = ..()
	icon_state = "himat"

/obj/structure/mortar/himat/attackby(obj/item/item, mob/user)
	if(istype(item, /obj/item/mortar_shell))
		var/obj/item/mortar_shell/mortar_shell = item
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE))
			to_chat(user, SPAN_WARNING("You don't have the training to fire [src]."))
			return
		if(busy)
			to_chat(user, SPAN_WARNING("Someone else is currently using [src]."))
			return

		var/area/our_area = get_area(src)
		if(ship_side && (CEILING_IS_PROTECTED(our_area.ceiling, CEILING_PROTECTION_TIER_2)))
			var/crash_occurred = (SSticker?.mode?.is_in_endgame)
			if(crash_occurred)
				travel_time = 0.5 SECONDS
			else
				to_chat(user, SPAN_RED("You realize how bad of an idea this is and quickly stop."))
				return
		if(!loaded_shell)
			user.visible_message(SPAN_NOTICE("[user] starts loading \a [mortar_shell.name] into [src]."),
			SPAN_NOTICE("You start loading \a [mortar_shell.name] into [src]."))
			playsound(loc, 'sound/weapons/gun_mortar_reload.ogg', 50, 1)
			busy = TRUE
			var/success = do_after(user, 1.5 SECONDS, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE)
			busy = FALSE
			if(success)
				user.visible_message(SPAN_NOTICE("[user] loads \a [mortar_shell.name] into [src]."),
				SPAN_NOTICE("You load \a [mortar_shell.name] into [src]."))
				user.drop_inv_item_to_loc(mortar_shell, src)
				busy = FALSE
				mortar_shell.cause_data = create_cause_data(initial(mortar_shell.name), user, src)
				mortar_shell.forceMove(src)
				loaded_shell = mortar_shell

	if(HAS_TRAIT(item, TRAIT_TOOL_WRENCH))
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE))
			to_chat(user, SPAN_WARNING("You don't have the training to undeploy [src]."))
			return
		if(fixed)
			to_chat(user, SPAN_WARNING("[src]'s supports are bolted and welded into the floor. It looks like it's going to be staying there."))
			return
		if(busy)
			to_chat(user, SPAN_WARNING("Someone else is currently using [src]."))
			return
		if(firing)
			to_chat(user, SPAN_WARNING("[src]'s barrel is still steaming hot. Wait a few seconds and stop firing it."))
			return
		if(loaded_shell)
			to_chat(user, SPAN_WARNING("[src] is loaded with a missile, unload it first."))
			return
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		user.visible_message(SPAN_NOTICE("[user] starts undeploying [src]."), \
				SPAN_NOTICE("You start undeploying [src]."))
		if(do_after(user, 4 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			user.visible_message(SPAN_NOTICE("[user] undeploys [src]."), \
				SPAN_NOTICE("You undeploy [src]."))
			playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
			var/obj/item/mortar_kit/mortar = new kit_type(loc)
			mortar.name = src.name
			qdel(src)

	if(HAS_TRAIT(item, TRAIT_TOOL_SCREWDRIVER))
		if(do_after(user, 1 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			user.visible_message(SPAN_NOTICE("[user] toggles the targeting computer on [src]."), \
				SPAN_NOTICE("You toggle the targeting computer on [src]."))
			computer_enabled = !computer_enabled
			playsound(loc, 'sound/machines/switch.ogg', 25, 1)

	if(HAS_TRAIT(item, TRAIT_TOOL_MULTITOOL))
		var/new_id = tgui_input_text(user, "Select ID (4 characters)", "HIMAT ID", id)
		if(!new_id || !istext(new_id))
			return
	
		if(length(new_id) != 4)
			to_chat(src, SPAN_NOTICE("ID must be 4 characters long."))
			return
		id = new_id

	if(istype(item, /obj/item/device/binoculars/range/designator/upp))
		if(!id)
			to_chat(user, SPAN_WARNING("[src] must have an ID before connecting. Use multitool to set ID."))
			return

		var/obj/item/device/binoculars/range/designator/upp/desig = item
		if(src in desig.connected_himats)
			to_chat(user, SPAN_WARNING("[src] is already connected to this designator."))
			return
		desig.connected_himats += src
		to_chat(user, SPAN_WARNING("[src] successfully connected. ID: [id]."))


/obj/structure/mortar/himat/handle_shell(turf/target, obj/item/mortar_shell/shell)
	if(!loaded_shell)
		return FALSE

	var/turf/mortar_turf = get_turf(src)
	mortar_turf.ceiling_debris_check(2)
	playsound(loc, 'sound/weapons/gun_rocketlauncher.ogg', 50, 1)
	visible_message("[icon2html(src, viewers(src))] [SPAN_DANGER("The [name] fires!")]")

	for(var/mob/mob in range(6, src))
		shake_camera(mob, 3, 1)
		if(ishuman(mob) && !HAS_TRAIT(mob, TRAIT_EAR_PROTECTION))
			var/mob/living/carbon/human/human = mob
			human.SetEarDeafness(max(human.ear_deaf, 15))
			to_chat(human, SPAN_WARNING("Augh!! \The [src]'s launch blast resonates extremely loudly in your ears! You probably should have worn some sort of ear protection..."))
	firing = TRUE
	flick(icon_state + "_fire", src)
	spawn(travel_time+rand(1, 10))
	..()
	loaded_shell = null
	return TRUE

/obj/structure/mortar/himat/attack_hand(mob/user)
	if(loaded_shell)
		visible_message(SPAN_NOTICE("[user] begins removing [loaded_shell] from [src]."))
		if(do_after(user, 5 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			loaded_shell.forceMove(get_turf(src))
			loaded_shell = null
			visible_message(SPAN_NOTICE("[user] removes [loaded_shell] from [src]."))

/obj/item/mortar_kit/himat
	name = "\improper M112 HIMAT"
	icon = 'modular/distress/icons/mortar.dmi'
	desc = "Folded up and ready to be carried HIMAT missile launcher. Can be worn on your back."
	icon_state = "himat_carry"
	flags_equip_slot = SLOT_BACK
	mortar_type = /obj/structure/mortar/himat
	item_icons = list(
		WEAR_BACK = 'modular/distress/icons/back.dmi',
	)

/obj/item/device/binoculars/upp
	icon = 'modular/distress/icons/binoculars.dmi'
	icon_state = "binoculars_upp"
	uses_camo = FALSE
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi',
	)

/obj/item/device/binoculars/range/designator/upp
	ignore_ceiling_check = TRUE
	icon = 'modular/distress/icons/binoculars.dmi'
	icon_state = "binoculars_upp_alt"
	uses_camo = FALSE
	cas_laser_overlay = "binoculars_laser_civ"
	range_laser_overlay = "binoculars_range_civ"
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi',
	)
	var/list/connected_himats = list()
	var/himat_id = 1
	var/barrage_mode = FALSE
	actions_types = list(/datum/action/item_action/fire_himat, /datum/action/item_action/switch_himat, /datum/action/item_action/himat_barrage)
	var/list/actions_list = list(/datum/action/item_action/fire_himat, /datum/action/item_action/switch_himat, /datum/action/item_action/himat_barrage)

/obj/item/device/binoculars/range/designator/upp/attackby(obj/item/item, mob/user)
	if(HAS_TRAIT(item, TRAIT_TOOL_MULTITOOL))
		to_chat(user, SPAN_WARNING("You begin flushing connection data..."))
		if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			connected_himats.Cut()
		to_chat(user, SPAN_WARNING("You successfully flush connection data."))

/datum/action/item_action/fire_himat/New(Target, obj/item/holder)
	. = ..()
	name = "Fire HIMATs"
	action_icon_state = "designator_mortar"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('modular/distress/icons/misc.dmi', button, action_icon_state)

/datum/action/item_action/fire_himat/action_activate()
	. = ..()
	var/obj/item/device/binoculars/range/designator/upp/desig = holder_item
	var/howmanyhimats = 0
	if(!desig.range_mode && desig.laser && desig.connected_himats.len)
		if(desig.barrage_mode)
			for(var/obj/structure/mortar/himat/himat in desig.connected_himats)
				if(himat.handle_shell(get_turf(desig.laser), himat.loaded_shell))
					howmanyhimats++
			to_chat(usr, SPAN_NOTICE("Command sent. Fired: [howmanyhimats] shells."))
		else
			if(desig.himat_id > length(desig.connected_himats))
				desig.himat_id = 1
			if(!length(desig.connected_himats))
				return
			var/obj/structure/mortar/himat/himat = desig.connected_himats[desig.himat_id]
			if(himat && himat.handle_shell(get_turf(desig.laser), himat.loaded_shell))
				to_chat(usr, SPAN_NOTICE("Command sent. Fired: HIMAT [himat.id]."))

/datum/action/item_action/switch_himat/New(Target, obj/item/holder)
	. = ..()
	name = "Switch HIMAT"
	action_icon_state = "designator_swap_mortar"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('modular/distress/icons/misc.dmi', button, action_icon_state)

/datum/action/item_action/switch_himat/action_activate()
	. = ..()
	var/obj/item/device/binoculars/range/designator/upp/desig = holder_item
	if(!length(desig.connected_himats))
		to_chat(usr, SPAN_NOTICE("No HIMAT IDs found! Please connect to a HIMAT."))
		return
	desig.himat_id++
	if(desig.himat_id > desig.connected_himats.len)
		desig.himat_id = 1
	var/obj/structure/mortar/himat/selected_himat = desig.connected_himats[desig.himat_id]
	to_chat(usr, SPAN_NOTICE("Selected HIMAT ID: [selected_himat.id]"))

/datum/action/item_action/himat_barrage/New(Target, obj/item/holder)
	. = ..()
	name = "Switch Barrage Mode"
	action_icon_state = "designator_one_weapon"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('modular/distress/icons/misc.dmi', button, action_icon_state)

/datum/action/item_action/himat_barrage/action_activate()
	. = ..()
	var/obj/item/device/binoculars/range/designator/upp/desig = holder_item
	desig.barrage_mode = !desig.barrage_mode
	button.overlays.Cut()
	if(desig.barrage_mode)
		action_icon_state = "designator_all_weapons"
		to_chat(usr, SPAN_NOTICE("Barrage mode: ON"))
	else
		action_icon_state = "designator_one_weapon"
		to_chat(usr, SPAN_NOTICE("Barrage mode: OFF"))
	button.overlays += image('modular/distress/icons/misc.dmi', button, action_icon_state)

/obj/item/clothing/accessory/helmet/cover/frogmen_veil
	name = "Frogmen tactical veil"
	icon = 'modular/distress/icons/misc.dmi'
	desc = "A net veil, most of the times used by special forces to break up the silhouette of the soldier at long ranges. And also it's very creepy to see one when fighting on the other side."
	icon_state = "veil_frogmen"
	item_state_slots = "veil_frogmen"
	flags_obj = OBJ_IS_HELMET_GARB
	worn_accessory_slot = ACCESSORY_SLOT_HELM_C
	worn_accessory_limit = 1
	accessory_icons = list(
		WEAR_HEAD = 'modular/distress/icons/helmet_garb.dmi',
	)
	item_icons = list(
		WEAR_AS_GARB = 'modular/distress/icons/helmet_garb.dmi',
	)

/obj/item/clothing/head/helmet/marine/veteran/UPP/frogmen
	name = "\improper 6B84 light helmet"
	desc = " UPPA reconnaissance new helmet for multiple environments, and used mostly for NVG/IR system placement. Made using fabric-polymer technology, making it much lighter in comparison to the standard issue 6B82, sacrificing overall protection. A tactical datalink and A/V feeds are provided, alongside facilities for an infrared imager complex. Surprisingly comfortable. The fabric utilized for this model is rubbery and colored after the standard paint coating of UPP armor."
	icon = 'modular/distress/icons/misc.dmi'
	icon_state = "upp_helmet_frogmen"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_marine_helmet = HELMET_GARB_OVERLAY
	storage_slots = 2
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR
	item_icons = list(
		WEAR_HEAD = 'modular/distress/icons/helmet.dmi'
	)

/obj/structure/machinery/cm_vending/sorted/marine_food/upp
	name = "\improper food dispenser"
	desc = "An food dispenser, capable of distributing food containing all the essential vitamins and nutrients anyone could ever need."

/obj/item/reagent_container/food/drinks/tea/upp
	name = "\improper insulated container"
	desc = "A small, reusable, insulated container for holding liquids with a sip lid."
	icon_state = "tea_upp"
	item_state = "coffee"
	center_of_mass = "x=16;y=14"

/obj/item/reagent_container/food/drinks/tea/upp/Initialize()
	. = ..()
	reagents.add_reagent("tea", 30)

/obj/item/reagent_container/food/drinks/water
	name = "\improper insulated container"
	desc = "A small, reusable, insulated container for holding liquids with a sip lid."
	icon_state = "tea_upp"
	item_state = "coffee"
	center_of_mass = "x=16;y=14"

/obj/item/reagent_container/food/drinks/water/Initialize()
	. = ..()
	reagents.add_reagent("water", 30)

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal6
	name = "\improper UPP Prepared Meal (Luncheon)"
	desc = "A prepackaged meal for UPP troops with two scoops of slightly dried out rice, a square of some kind of luncheon meat, two carrot sticks, and a 'fruit' bar."
	icon_state = "upp_luncheon"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal6/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal7
	name = "\improper UPP Prepared Meal (Shrimp)"
	desc = "A prepackaged meal for UPP troops that sports a greasy rice patty with bits of fake imitation shrimp and egg flavoring. Smells quite off. On the side there's a slightly soggy spring roll."
	icon_state = "upp_shrimp"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal7/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal8
	name = "\improper UPP Prepared Meal (Cuban)"
	desc = "A prepackaged meal for UPP troops containing Cuban rice with bland-ish eggs pieces, tomato sauce, potato salad, and a dry biscuit."
	icon_state = "upp_cuban"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal8/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal9
	name = "\improper UPP Prepared Meal (Meatballs)"
	desc = "A prepackaged meal for UPP troops containing marinated Königsberger Klopse meatballs, a creamy sauce, some spinach, and a scoop of rice. One of the better options out of the pre-packaged meals and is rarely ever in stock."
	icon_state = "upp_meatballs"

/obj/item/reagent_container/food/snacks/mre_pack/upp/meal9/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	bitesize = 3

/obj/structure/machinery/cm_vending/sorted/marine_food/upp/populate_product_list(scale)
	listed_products = list(
		list("PREPARED MEALS", -1, null, null),
		list("UPP Prepared Meal (Luncheon)", 15, /obj/item/reagent_container/food/snacks/mre_pack/upp/meal6, VENDOR_ITEM_REGULAR),
		list("UPP Prepared Meal (Shrimp)", 15, /obj/item/reagent_container/food/snacks/mre_pack/upp/meal7, VENDOR_ITEM_REGULAR),
		list("UPP Prepared Meal (Cuban Rice)", 15, /obj/item/reagent_container/food/snacks/mre_pack/upp/meal8, VENDOR_ITEM_REGULAR),
		list("UPP Prepared Meal (Meatballs)", 15, /obj/item/reagent_container/food/snacks/mre_pack/upp/meal9, VENDOR_ITEM_REGULAR),
		list("UPP Survival Ration", 50, /obj/item/storage/box/mre/upp, VENDOR_ITEM_REGULAR),
		list("DRINKS", -1, null, null),
		list("Water", 10, /obj/item/reagent_container/food/drinks/water, VENDOR_ITEM_REGULAR),
		list("Tea", 10, /obj/item/reagent_container/food/drinks/tea/upp, VENDOR_ITEM_REGULAR),
	)

/obj/structure/machinery/cm_vending/sorted/tech/electronics_storage/antag/upp
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null
	listed_products = list(
		list("TOOLS", -1, null, null),
		list("Cable Coil", 5, /obj/item/stack/cable_coil/random, VENDOR_ITEM_REGULAR),
		list("Multitool", 5, /obj/item/device/multitool/upp, VENDOR_ITEM_REGULAR),

		list("CIRCUITBOARDS", -1, null, null),
		list("Airlock Circuit Board", 4, /obj/item/circuitboard/airlock, VENDOR_ITEM_REGULAR),
		list("APC Circuit Board", 4, /obj/item/circuitboard/apc, VENDOR_ITEM_REGULAR),

		list("BATTERIES", -1, null, null),
		list("High-Capacity Power Cell", 1, /obj/item/cell/high, VENDOR_ITEM_REGULAR),
		list("Low-Capacity Power Cell", 3, /obj/item/cell, VENDOR_ITEM_REGULAR),
	)

/obj/item/storage/belt/utility/full/upp/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/device/multitool/upp(src)

/obj/item/storage/pouch/firstaid/ert/upp
	icon = 'modular/distress/icons/misc.dmi'
	icon_state = "softpack_upp"
	storage_slots = 7

/obj/item/storage/pouch/firstaid/ert/upp/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new	/obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/splint(src)

/obj/structure/machinery/computer/supply_drop_console/upp
	req_access = list(ACCESS_UPP_ARMORY)
	drop_cooldown = 500
	faction = FACTION_UPP

/obj/item/roller/medevac/upp
	rollertype = /obj/structure/bed/medevac_stretcher/upp
	name = "UPP medevac stretcher"
	desc = "UPP version of collapsed medevac stretcher that can be carried around."

/obj/structure/bed/medevac_stretcher/upp
	foldabletype = /obj/item/roller/medevac/upp
	name = "UPP medevac stretcher"
	faction = FACTION_UPP
