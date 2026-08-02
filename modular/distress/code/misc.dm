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
	slowdown = SLOWDOWN_ARMOR_MEDIUM // МОРКОВКА спасибо
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH // МОРКОВКА спасибо
	armor_bomb = CLOTHING_ARMOR_MEDIUM // МОРКОВКА спасибо
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH // МОРКОВКА спасибо
	storage_slots = 2
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP, /obj/item/clothing/under/marine/veteran/UPP/medic, /obj/item/clothing/under/marine/veteran/UPP/engi, /obj/item/clothing/under/marine/veteran/UPP/SOF_uniform)

/obj/item/clothing/suit/storage/marine/faction/UPP/support
	name = "\improper UL6 personal armor"
	desc = "Standard body armor of the UPP military, the UL6 (Union Light MK6) is a light body armor, slightly weaker than the M3 pattern body armor in service with the USCM, specialized towards ballistics protection. This set of personal armor lacks the iconic neck piece and some of the armor in favor of user mobility."
	storage_slots = 3
	icon_state = "upp_armor_support"
	slowdown = SLOWDOWN_ARMOR_LIGHT // МОРКОВКА спасибо
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH // МОРКОВКА спасибо
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH // МОРКОВКА спасибо
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW // МОРКОВКА спасибо

/obj/item/clothing/suit/storage/marine/faction/UPP/heavy
	name = "\improper UH7 heavy plated armor"
	desc = "An extremely heavy-duty set of body armor in service with the UPP military, the UH7 (Union Heavy MK7) is known for having powerful ballistic protection, alongside a noticeable neck guard, fortified in order to allow the wearer to endure the stresses of the bulky helmet."
	icon_state = "upp_armor_heavy"
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_HEAVY
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_item = MOB_LOCK_ON_EQUIP
	armor_melee = CLOTHING_ARMOR_HIGHPLUS
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
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR|BLOCKGASEFFECT
	flags_item = MOB_LOCK_ON_EQUIP
	anti_hug = 2

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
	max_range = 45
	var/kit_type = /obj/item/mortar_kit/himat
	travel_time = 70
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

	if(istype(item, /obj/item/device/binoculars/range/designator/upp/spec))
		if(!id)
			to_chat(user, SPAN_WARNING("[src] must have an ID before connecting. Use multitool to set ID."))
			return

		var/obj/item/device/binoculars/range/designator/upp/spec/desig = item
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

/obj/item/device/binoculars/range/designator/upp/
	ignore_ceiling_check = FALSE
	icon = 'modular/distress/icons/binoculars.dmi'
	icon_state = "binoculars_upp_alt"
	uses_camo = FALSE
	cas_laser_overlay = "binoculars_laser_civ"
	range_laser_overlay = "binoculars_range_civ"
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/righthand.dmi',
	)

/obj/item/device/binoculars/range/designator/upp/spec
	ignore_ceiling_check = TRUE
	var/list/connected_himats = list()
	var/himat_id = 1
	var/barrage_mode = FALSE
	actions_types = list(/datum/action/item_action/fire_himat, /datum/action/item_action/switch_himat, /datum/action/item_action/himat_barrage)
	var/list/actions_list = list(/datum/action/item_action/fire_himat, /datum/action/item_action/switch_himat, /datum/action/item_action/himat_barrage)

/obj/item/device/binoculars/range/designator/upp/spec/attackby(obj/item/item, mob/user)
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
	var/obj/item/device/binoculars/range/designator/upp/spec/desig = holder_item
	var/howmanyhimats = 0
	var/mob/living/carbon/human/H = usr
	if(!skillcheck(H, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && H.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_TRAINED)
		to_chat(H, SPAN_WARNING("You don't seem to know how to use [src]..."))
		return

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
	var/obj/item/device/binoculars/range/designator/upp/spec/desig = holder_item
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
	var/obj/item/device/binoculars/range/designator/upp/spec/desig = holder_item
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

/obj/item/clothing/suit/storage/marine/faction/UPP/commando
	name = "\improper UM5CU personal armor"
	desc = "A modification of the UM5, designed for stealth operations."
	icon_state = "upp_armor_commando"
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_item = MOB_LOCK_ON_EQUIP
	storage_slots = 2

/obj/item/clothing/head/helmet/marine/veteran/UPP/frogmen
	name = "\improper 6B84 light helmet"
	desc = " UPPA reconnaissance new helmet for multiple environments, and used mostly for NVG/IR system placement. Made using fabric-polymer technology, making it much lighter in comparison to the standard issue 6B82, sacrificing overall protection. A tactical datalink and A/V feeds are provided, alongside facilities for an infrared imager complex. Surprisingly comfortable. The fabric utilized for this model is rubbery and colored after the standard paint coating of UPP armor."
	icon = 'modular/distress/icons/misc.dmi'
	icon_state = "upp_helmet_frogmen"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_marine_helmet = HELMET_GARB_OVERLAY
	storage_slots = 2
	flags_item = MOB_LOCK_ON_EQUIP
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
	
/obj/item/device/radio/headset/distress/UPP/cct
	icon = 'icons/obj/items/radio.dmi'
	item_icons = null
	item_state = "headset"
	icon_state = "generic_headset"

/obj/item/pamphlet/skill/HIMAT
	name = "HIMAT Operator instructional pamphlet"
	desc = "A pamphlet used to quickly impart vital knowledge on the use of the HIMAT, among other engineering devices and JTAC practices."
	icon_state = "pamphlet_mortar"
	trait = /datum/character_trait/skills/mortar/HIMAT
	bypass_pamphlet_limit = TRUE

/datum/character_trait/skills/mortar/HIMAT
	trait_name = "HIMAT Training"
	skill = SKILL_ENGINEER
	secondary_skill = SKILL_SPEC_WEAPONS
	skill_cap = SKILL_ENGINEER_NOVICE
	secondary_skill_cap = SKILL_SPEC_TRAINED
	skill_increment = 2

/obj/structure/machinery/cm_vending/gear/spec/upp
	name = "\improper Squad Weapons Specialist Gear Rack"
	desc = "An automated gear rack for Weapons Specialists."
	icon_state = "upp_clothing"
	vendor_role = list(JOB_UPP_SPECIALIST)
	req_access = list(ACCESS_UPP_ARMORY)

/obj/structure/machinery/cm_vending/gear/spec/upp/get_listed_products(mob/user)
	return GLOB.upp_cm_vending_gear_spec

GLOBAL_LIST_EMPTY(upp_specialist_sets_taken)

/obj/structure/machinery/cm_vending/gear/spec/upp/proc/is_specialist_set_taken(typepath)

	if(!ispath(typepath, /obj/item/storage/box/spec))
		return FALSE

	var/obj/item/storage/box/spec/spec_kit = typepath

	var/set_name = initial(spec_kit.kit_name)

	if(set_name in GLOB.upp_specialist_sets_taken)
		return TRUE

	return FALSE


/obj/structure/machinery/cm_vending/gear/spec/upp/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)

	if(action == "vend")

		var/index = params["prod_index"]
		var/list/item = get_listed_products(ui.user)[index]

		if(is_specialist_set_taken(item[3]))
			to_chat(ui.user, SPAN_WARNING("This specialist set has already been taken by another operator."))
			vend_fail()
			return TRUE

	return ..()


/obj/structure/machinery/cm_vending/gear/spec/upp/vendor_successful_vend_one(prod_type, mob/living/carbon/human/user, turf/target_turf, insignas_override, stack_amount)

	. = ..()

	if(!ispath(prod_type, /obj/item/storage/box/spec))
		return

	var/datum/upp_specialist_set/chosen_set

	for(var/datum/upp_specialist_set/path as anything in subtypesof(/datum/upp_specialist_set))
		if(initial(path.kit_typepath) == prod_type)
			var/datum/upp_specialist_set/S = new path
			S.redeem_set(user)
			break

	if(chosen_set)
		chosen_set.redeem_set(user)

	var/obj/item/storage/box/spec/spec_kit = prod_type
	var/set_name = initial(spec_kit.kit_name)

	if(set_name)
		GLOB.upp_specialist_sets_taken[set_name] = TRUE

GLOBAL_LIST_INIT(upp_cm_vending_gear_spec, list(
		list("WEAPONS SPECIALIST SETS (CHOOSE 1)", 0, null, null, null),
		list("HJRA-12 Set", 0, /obj/item/storage/box/spec/upp_sadar, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Minigunner Set", 0, /obj/item/storage/box/spec/heavy_minigun, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Heavy Machinegun Set", 0, /obj/item/storage/box/spec/heavy_machinegun, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("HIMAT Operator Set", 0, /obj/item/storage/box/spec/himat_operator, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
//		list("Pyro Set", 0, /obj/item/storage/box/spec/upp_pyro, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Sniper Set", 0, /obj/item/storage/box/spec/upp_sniper, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),

		list("EXTRA MINIGUN AMMUNITION", 0, null, null, null),
		list("HJRA-12 High-Explosive Rocket", 40, /obj/item/ammo_magazine/rocket/upp, null, VENDOR_ITEM_REGULAR),
		list("HJRA-12 Anti-Tank Rocket", 40, /obj/item/ammo_magazine/rocket/upp/at, null, VENDOR_ITEM_REGULAR),
		list("HJRA-12 Extreme-Intensity Incendiary Rocket", 60, /obj/item/ammo_magazine/rocket/upp/incen, null, VENDOR_ITEM_REGULAR),

		list("EXTRA MINIGUN AMMUNITION", 0, null, null, null),
		list("Rotating ammo drum (7.62x51mm)", 30, /obj/item/ammo_magazine/minigun, null, VENDOR_ITEM_REGULAR),
		
		list("EXTRA MACHINEGUN AMMUNITION", 0, null, null, null),
		list("QYJ-72 ammo box (7.62x54mmR)", 30, /obj/item/ammo_magazine/pkp, null, VENDOR_ITEM_REGULAR),

		list("EXTRA SNIPER AMMUNITION", 0, null, null, null),
		list("VSSK Magazine (12.7x55mm)", 30, /obj/item/ammo_magazine/sniper/svd/vssk, null, VENDOR_ITEM_REGULAR),

		list("EXTRA HIMAT AMMUNITION", 0, null, null, null),
		list("HIMAT HE missile", 20, /obj/item/mortar_shell/himat/explosive, null, VENDOR_ITEM_REGULAR),
		list("HIMAT AP missile", 20, /obj/item/mortar_shell/himat/antipersonnel, null, VENDOR_ITEM_REGULAR),
		list("HIMAT IN missile", 30, /obj/item/mortar_shell/incendiary/himat, null, VENDOR_ITEM_REGULAR),
		list("HIMAT flare missile", 10, /obj/item/mortar_shell/himat/training, null, VENDOR_ITEM_REGULAR),

//		list("EXTRA FLAMETHROWER TANKS", 0, null, null, null),
//		list("Large Incinerator Tank", 30, /obj/item/ammo_magazine/flamer_tank/large, null, VENDOR_ITEM_REGULAR),
//		list("Large Incinerator Tank (B) (Green Flame)", 30, /obj/item/ammo_magazine/flamer_tank/large/B, null, VENDOR_ITEM_REGULAR),
//		list("Large Incinerator Tank (X) (Blue Flame)", 30, /obj/item/ammo_magazine/flamer_tank/large/X, null, VENDOR_ITEM_REGULAR),
	))


/datum/upp_specialist_set
	var/name = ""
	var/role_name = ""
	var/skill_to_give = SKILL_SPEC_DEFAULT
	var/trait_to_give = null
	var/kit_typepath = null
	var/rank_icon = "spec"

/datum/upp_specialist_set/proc/redeem_set(mob/living/carbon/human/user)
	if(!user)
		return FALSE

	if(skill_to_give != SKILL_SPEC_DEFAULT)
		user.skills?.set_skill(SKILL_SPEC_WEAPONS, skill_to_give)

	if(trait_to_give)
		ADD_TRAIT(user, TRAIT_SPEC(trait_to_give), TRAIT_SOURCE_INHERENT)

	user.rank_override = rank_icon
	user.hud_set_squad()

	var/obj/item/card/id/idcard = user.get_idcard()
	if(idcard)
		idcard.set_assignment(role_name)
		user.role_title_override = role_name
		idcard.minimap_icon_override = rank_icon
		user.update_minimap_icon()

	return TRUE

// /datum/specialist_set/upp_pyro
//	name = "Pyro Set"
//	role_name = JOB_UPP_SPECIALIST
//	skill_to_give = SKILL_SPEC_PYRO
//	rank_icon = "spec"
//	kit_typepath = /obj/item/storage/box/spec/upp_pyro

/datum/upp_specialist_set/upp_sniper
	name = "Sniper Set"
	role_name = JOB_UPP_SPECIALIST
	skill_to_give = SKILL_SPEC_SNIPER
	rank_icon = "spec"
	kit_typepath = /obj/item/storage/box/spec/upp_sniper

/datum/upp_specialist_set/upp_sadar
	name = "Sniper Set"
	role_name = JOB_UPP_SPECIALIST
	skill_to_give = SKILL_SPEC_KITTED
	rank_icon = "spec"
	kit_typepath = /obj/item/storage/box/spec/upp_sadar

/datum/upp_specialist_set/heavy_machinegun
	name = "Heavy Machinegun Set"
	role_name = JOB_UPP_SPECIALIST
	skill_to_give = SKILL_SPEC_UPP
	rank_icon = "spec"
	kit_typepath = /obj/item/storage/box/spec/heavy_machinegun
	
/obj/item/storage/box/spec/heavy_machinegun
	name = "\improper PKP equipment case"
	desc = "."
	kit_overlay = "mortar"
	kit_name = "heavy_machinegun"

/obj/item/storage/box/spec/heavy_machinegun/fill_preset_inventory()
	new /obj/item/clothing/suit/storage/marine/faction/UPP/heavy(src)
	new /obj/item/clothing/head/helmet/marine/veteran/UPP/heavy(src)
	new /obj/item/weapon/gun/pkp(src)
	new /obj/item/ammo_magazine/pkp(src)
	new /obj/item/ammo_magazine/pkp(src)
	new /obj/item/ammo_magazine/pkp(src)

/datum/upp_specialist_set/heavy_minigun
	name = "Heavy Minigun Set"
	role_name = JOB_UPP_SPECIALIST
	skill_to_give = SKILL_SPEC_UPP
	rank_icon = "spec"
	kit_typepath = /obj/item/storage/box/spec/heavy_minigun

/obj/item/storage/box/spec/heavy_minigun
	name = "\improper Minigun  equipment case"
	desc = "."
	kit_overlay = "mortar"
	kit_name = "heavy_minigun"

/obj/item/storage/box/spec/heavy_minigun/fill_preset_inventory()
	new /obj/item/clothing/suit/storage/marine/faction/UPP/heavy(src)
	new /obj/item/clothing/head/helmet/marine/veteran/UPP/heavy(src)
	new /obj/item/weapon/gun/minigun/upp(src)
	new /obj/item/ammo_magazine/minigun(src)
	new /obj/item/ammo_magazine/minigun(src)
	new /obj/item/ammo_magazine/minigun(src)

/datum/upp_specialist_set/himat_operator
	name = "HIMAT Operator Set"
	role_name = JOB_UPP_SPECIALIST
	skill_to_give = SKILL_SPEC_TRAINED
	rank_icon = "spec"
	kit_typepath = /obj/item/storage/box/spec/himat_operator

/obj/item/storage/box/spec/himat_operator
	name = "\improper himat operator equipment case"
	desc = "A large case containing a heavy-caliber anti-tank M5 RPG rocket launcher, M3-T light armor, five 84mm rockets and additional pieces of equipment.\nDrag this sprite onto yourself to open it up! NOTE: You cannot put items back inside this case."
	kit_overlay = "mortar"
	kit_name = "himat_operator"

/obj/item/storage/box/spec/himat_operator/fill_preset_inventory()
	new /obj/item/mortar_kit/himat(src)
	new /obj/item/mortar_kit/himat(src)
	new /obj/item/pamphlet/skill/HIMAT(src)
	new /obj/item/storage/belt/gun/mortarbelt(src)
	new /obj/item/storage/belt/gun/mortarbelt(src)
	new /obj/item/device/binoculars/range/designator/upp/spec(src)
	new /obj/item/device/binoculars/range/designator/upp/spec(src)
	new /obj/item/storage/backpack/marine/mortarpack(src)
	new /obj/item/mortar_shell/himat/explosive(src)
	new /obj/item/mortar_shell/himat/explosive(src)
	new /obj/item/mortar_shell/himat/explosive(src)
	new /obj/item/mortar_shell/himat/antipersonnel(src)
	new /obj/item/mortar_shell/himat/antipersonnel(src)
	new /obj/item/mortar_shell/himat/antipersonnel(src)
	new	/obj/item/mortar_shell/incendiary/himat(src)
	new	/obj/item/mortar_shell/incendiary/himat(src)
	new	/obj/item/mortar_shell/incendiary/himat(src)
	new	/obj/item/mortar_shell/himat/training(src)
	new	/obj/item/mortar_shell/himat/training(src)
	new	/obj/item/mortar_shell/himat/training(src)
	new	/obj/item/mortar_shell/himat/training(src)
	new /obj/item/device/multitool/upp(src)
	new /obj/item/tool/wrench(src)

/obj/item/storage/box/spec/upp_sniper
	name = "\improper Sniper equipment case"
	desc = "Type 88 marksman rifle case."
	kit_overlay = "sniper"
	kit_name = "upp_sniper"

/obj/item/storage/box/spec/upp_sniper/fill_preset_inventory()
	// sniper
	new /obj/item/clothing/glasses/night/m42_night_goggles/upp(src)
	new /obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper(src)
	new /obj/item/clothing/head/helmet/marine/ghillie/upp(src)
	new /obj/item/clothing/suit/storage/marine/ghillie/forecon/upp(src)
	new /obj/item/weapon/gun/rifle/sniper/svd/vssk(src)
	new /obj/item/ammo_magazine/sniper/svd/vssk(src)
	new /obj/item/ammo_magazine/sniper/svd/vssk(src)
	new /obj/item/ammo_magazine/sniper/svd/vssk(src)
	new /obj/item/ammo_magazine/sniper/svd/vssk(src)
	new /obj/item/ammo_magazine/sniper/svd/vssk(src)

/obj/item/storage/box/spec/upp_sadar
	name = "\improper HJRA-12 Rocket Launcher case"
	desc = "HJRA-12 Rocket Launcher case."
	kit_overlay = "demo"
	kit_name = "upp_sadar"

/obj/item/storage/box/spec/upp_sadar/fill_preset_inventory()
	new /obj/item/storage/backpack/marine/rocketpack(src)
	new /obj/item/explosive/plastic(src)
	new /obj/item/explosive/plastic(src)
	new	/obj/item/weapon/gun/launcher/rocket/upp(src)
	new /obj/item/ammo_magazine/rocket/upp(src)
	new /obj/item/ammo_magazine/rocket/upp(src)
	new /obj/item/ammo_magazine/rocket/upp(src)
	new /obj/item/ammo_magazine/rocket/upp/at(src)
	new /obj/item/ammo_magazine/rocket/upp/at(src)
	new /obj/item/ammo_magazine/rocket/upp/at(src)
	new /obj/item/ammo_magazine/rocket/upp/incen(src)
	new /obj/item/ammo_magazine/rocket/upp/incen(src)
	new /obj/item/ammo_magazine/rocket/upp/incen(src)
	new /obj/item/device/binoculars/upp(src)

/obj/item/storage/box/spec/upp_pyro
	name = "\improper Pyrotechnician equipment case"
	desc = "."
	kit_overlay = "pyro"
	kit_name = "upp_pyro"

/obj/item/storage/box/spec/upp_pyro/fill_preset_inventory()
	new /obj/item/clothing/suit/storage/marine/M35(src)
	new /obj/item/clothing/head/helmet/marine/pyro(src)
	new /obj/item/storage/large_holster/fuelpack(src)
	new /obj/item/weapon/gun/flamer/m240/spec(src)
	new /obj/item/ammo_magazine/flamer_tank/large(src)
	new /obj/item/storage/pouch/flamertank(src)
	new /obj/item/tool/extinguisher(src)
	new /obj/item/tool/extinguisher/mini(src)


/obj/item/attachable/stock/type23/toz194
	name = "\improper TOZ 194 standard stock"
	desc = "A stamped metal stock with internal recoil springs designed to absorb the ridiculous kick the 8 Gauge shotgun causes when fired. Not recommended to remove."
	icon_state = "toz194_stock"
	pixel_shift_x = 16
	pixel_shift_y = 18
	hud_offset_mod = 2

/obj/item/weapon/gun/shotgun/pump/m37a/toz194
	name = "\improper TOZ 194 riot shotgun"
	desc = "As UPP soldiers frequently reported being outmatched by enemy combatants, UPP High Command commissioned a new pump-action shotgun based on TOZ-87. In late 2094"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/shotguns.dmi'
	icon_state = "toz194"
	item_state = "type23"
	fire_sound = 'sound/weapons/gun_type23.ogg' //not perfect, too small
	current_mag = /obj/item/ammo_magazine/internal/shotgun/type23/toz194
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/shotgun_choke,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/stock/type23/toz194, // Stock
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_INTERNAL_MAG
	flags_equip_slot = SLOT_BACK
	map_specific_decoration = FALSE
	gauge = "8g"
	starting_attachment_types = list(/obj/item/attachable/stock/type23/toz194)

/obj/item/weapon/gun/shotgun/pump/m37a/toz194/Initialize()
	. = ..()
	pump_delay = FIRE_DELAY_TIER_5*2
	additional_fire_group_delay += pump_delay
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/shotgun/pump/m37a/toz194/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 13, "rail_y" = 21, "under_x" = 24, "under_y" = 15, "stock_x" = -1, "stock_y" = 17)

/obj/item/weapon/gun/shotgun/pump/m37a/toz194/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	set_fire_delay(FIRE_DELAY_TIER_SHOTGUN_BASE)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_1

/obj/item/weapon/gun/rifle/sniper/svd/vssk
	name = "\improper VSSK designated sniper rifle"
	desc = "VSSK is a bullpup, straight-pull bolt-action, magazine-fed sniper rifle chambered for the 12.7x55 mm subsonic round. It was developed in around 2102 for the special force units of PoP. Silenced sniper rifle is developed for special operations that require silent firing and penetration. Typical targets for VSSK rifle are cars, terrorists in heavy body armor or behind covers like car bodies or other thick covers"
	icon = 'modular/distress/icons/marksman_rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/distress/icons/marksman_rifles_lefthand.dmi',
		WEAR_R_HAND = 'modular/distress/icons/marksman_rifles_righthand.dmi'
	)

	pixel_x = -6
	hud_offset = -6

	fire_sound = 'sound/weapons/gun_silenced_shot2.ogg'
	current_mag = /obj/item/ammo_magazine/sniper/svd/vssk
	attachable_allowed = list(
		//Muzzle,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp_replica,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		//Under,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/bipod,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_WIELDED_FIRING_ONLY|GUN_SPECIALIST|GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK
	starting_attachment_types = list()
	sniper_beam_type = null

/obj/item/weapon/gun/rifle/sniper/svd/vssk/able_to_fire(mob/living/user)
	. = ..()
	if(!. || !istype(user)) //Let's check all that other stuff first.
		return 0
	if(!skillcheck(user, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("You don't seem to know how to use [src]..."))
		return 0
	if(!skillcheck(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && user.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_SNIPER)
		to_chat(user, SPAN_WARNING("You don't seem to know how to use [src]..."))
		return 0

/obj/item/weapon/gun/rifle/sniper/svd/vssk/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 13, "rail_y" = 19, "under_x" = 26, "under_y" = 14, "stock_x" = 24, "stock_y" = 13, "special_x" = 39, "special_y" = 18)

/obj/item/weapon/gun/rifle/sniper/svd/vssk/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_AMR)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_NONE - SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_1
	damage_falloff_mult = 0

/obj/item/clothing/under/marine/veteran/UPP
	name = "\improper UPP fatigues"
	desc = "A set of UPP fatigues, mass-produced for the armed-forces of the Union of Progressive Peoples. A rare sight, especially in ICC zones. This particular set sports the dark drab pattern of the UPP 17th battalion, 'Smoldering Sons', operating in the sparse UPP frontier in the Anglo-Japanese arm."
	icon_state = "upp_uniform"
	worn_state = "upp_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UPP.dmi'
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/faction/UPP, /obj/item/clothing/suit/gimmick/jason, /obj/item/clothing/suit/storage/snow_suit/soviet, /obj/item/clothing/suit/storage/snow_suit/survivor, /obj/item/clothing/suit/storage/webbing, /obj/item/clothing/suit/storage/webbing/brown, /obj/item/clothing/suit/storage/webbing/black, /obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper, /obj/item/clothing/suit/storage/marine/ghillie/forecon/upp)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	undershirt = TRUE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UPP.dmi'
	)

/obj/item/clothing/under/marine/veteran/UPP/gorka
	name = "\improper UPP gorka"
	icon = 'modular/distress/icons/gorkaicon.dmi'
	icon_state = "gorka_upp"
	worn_state = "gorka_upp"
	item_icons = list(
		WEAR_BODY = 'modular/distress/icons/gorka.dmi'
	)

/obj/item/clothing/glasses/night/m42_night_goggles/upp
	hud_type = 4

/obj/item/clothing/head/helmet/marine/ghillie/upp
	name = "\improper V65 Sniper helmet"
	desc = "A lightweight V65 helmet used by UPP snipers with V65 Thermal Cloak."
	icon = 'modular/distress/icons/sniperw.dmi'
	icon_state = "sniper_coif"
	item_state = "sniper_coif"
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	flags_marine_helmet = NO_FLAGS
	built_in_visors = null
	start_down_visor_type = null
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP, /obj/item/clothing/suit/storage/marine/ghillie/forecon/upp)
	flags_item = MOB_LOCK_ON_EQUIP
	specialty = "V65 cloak"
	actions_types = null
	item_icons = list(
		WEAR_HEAD = 'modular/distress/icons/sniper.dmi',
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/ghillie/forecon/upp
	name = "UPP Thermal armor"
	desc = "UPP Thermal armor worn to protect against the elements and chemical spills, used by sniper units with V65 Thermal Cloak."
	icon_state = "sniper_armor"
	item_state = "sniper_armor"
	icon = 'modular/distress/icons/sniperw.dmi'
	camouflage_break = 15
	camouflage_enter_delay = 15
	full_camo_alpha = 5
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP)
	item_icons = list(
		WEAR_JACKET = 'modular/distress/icons/sniper.dmi'
	)
	flags_atom = MOB_LOCK_ON_EQUIP|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper
	name = "\improper V65 Thermal Cloak"
	desc = "A thermo-optic camouflage cloak commonly used by UPP sniper units."
	actions_types = list(/datum/action/item_action/specialist/toggle_cloak_upp)
	icon = 'modular/distress/icons/sniperw.dmi'
	icon_state = "sniper_cape"
	item_state = "sniper_cape"
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP, /obj/item/clothing/head/helmet/marine/ghillie/upp, /obj/item/clothing/suit/storage/marine/ghillie/forecon/upp)
	item_icons = list(
		WEAR_BACK = 'modular/distress/icons/sniper.dmi'
	)
	max_storage_space = 14
	camo_alpha = 8

/obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper/verb/camouflageupp()
	set name = "Activate Cloak UPP"
	set desc = "Activate your cloak's camouflage."
	set category = "Scout"
	set src in usr
	if(!usr || usr.is_mob_incapacitated(TRUE))
		return

	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/H = usr
	if(!skillcheck(H, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && H.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_SNIPER)
		to_chat(H, SPAN_WARNING("You don't seem to know how to use [src]..."))
		return

	if(H.back != src)
		to_chat(H, SPAN_WARNING("You must be wearing the [fluff_item] to activate it!"))
		return

	if(!istype(H.head, /obj/item/clothing/head/helmet/marine/ghillie/upp))
		to_chat(H, SPAN_WARNING("You must be wearing the V65 Sniper helmet!"))
		return

	if(!istype(H.wear_suit, /obj/item/clothing/suit/storage/marine/ghillie/forecon/upp))
		to_chat(H, SPAN_WARNING("You must be wearing the UPP Thermal armor!"))
		return

	if(camo_active)
		deactivate_camouflage(H)
		return

	if(cloak_cooldown > world.time)
		to_chat(H, SPAN_WARNING("Your [fluff_item] is malfunctioning and can't be enabled right now!"))
		return

	RegisterSignal(H, COMSIG_GRENADE_PRE_PRIME, PROC_REF(cloak_grenade_callback))
	RegisterSignal(H, list(COMSIG_HUMAN_EXTINGUISH,  COMSIG_MOB_HAULED, COMSIG_MOB_UNHAULED), PROC_REF(wrapper_fizzle_camouflage))
	RegisterSignal(H, COMSIG_MOB_EFFECT_CLOAK_CANCEL, PROC_REF(deactivate_camouflage))

	camo_active = TRUE
	ADD_TRAIT(H, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_BACK))
	H.visible_message(SPAN_DANGER("[capitalize(H.declent_ru(NOMINATIVE))] vanishes into thin air!"), SPAN_NOTICE("You activate your [fluff_item]'s camouflage."), max_distance = 4)
	playsound(H.loc, camo_on_sound, 15, TRUE)
	H.unset_interaction()

	H.alpha = camo_alpha
	H.FF_hit_evade = 1000
	if(!allowed_stealth_shooting)
		H.allow_gun_usage = allow_gun_usage

	var/datum/mob_hud/security/advanced/SA = GLOB.huds[MOB_HUD_SECURITY_ADVANCED]
	SA.remove_from_hud(H)
	var/datum/mob_hud/xeno_infection/XI = GLOB.huds[MOB_HUD_XENO_INFECTION]
	XI.remove_from_hud(H)

	anim(H.loc, H, 'icons/mob/mob.dmi', null, "cloak", null, H.dir)
	cloak_cooldown = world.time + 0.8 SECONDS
	return TRUE

/datum/action/item_action/specialist/toggle_cloak_upp
    ability_primacy = SPEC_PRIMARY_ACTION_2

/datum/action/item_action/specialist/toggle_cloak_upp/New(mob/living/user, obj/item/holder)
    ..()
    name = "Toggle Cloak UPP"
    button.name = name
    update_button_icon()

/datum/action/item_action/specialist/toggle_cloak_upp/update_button_icon()
    var/obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper/SC = holder_item

    if(SC.camo_active)
        action_icon_state = "invisibility"
    else
        action_icon_state = "invisibility_off"

    button.overlays.Cut()
    button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/specialist/toggle_cloak_upp/can_use_action()
    var/mob/living/carbon/human/H = owner
    if(istype(H) && !H.is_mob_incapacitated() && holder_item == H.back)
        return TRUE

/datum/action/item_action/specialist/toggle_cloak_upp/action_activate()
    . = ..()

    var/obj/item/storage/backpack/marine/satchel/scout_cloak/upp/weak/sniper/SC = holder_item
    SC.camouflageupp()
    update_button_icon()
