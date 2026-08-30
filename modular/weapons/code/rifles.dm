/obj/item/weapon/gun/rifle/m41aMK1/navy //m41amk1_navy
	name = "\improper GUU-71/A pulse rifle"
	desc = "A variant of the M41A pulse rifle adopted for use by USASF Security Forces personnel and Master-At-Arms. Features an integrated 30mm grenade launcher and ammo tube that can hold four grenades on backup."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "m41amk1_navy"
	item_state = "m41amk1_navy"
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/stock/rifle/collapsible)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

/obj/item/weapon/gun/rifle/m41aMK1/navy/tactical
	name = "\improper GUU-71/B pulse rifle"
	desc = "A variant of the M41A pulse rifle adopted for use by USASF personnel whose duties take them off ships frequently. Features an integrated 30mm grenade launcher, flash & sound suppressor, and a carry-handle mounted mag-clamp."
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m20a
	name = "\improper M20A pulse rifle"
	desc = "A predecessor to the M41A pulse rifle still utilized by the UA's Colonial Guard and various other organizations. Aside from its 10x24mm chambering, the 'Harrington' rifle is largely considered to be in every metric the polar opposite of the M41A; featuring an obsolete three-round burst mode, lower magazine size, and it uses an integrated shotgun attachment."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "m20a"
	item_state = "m20a"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/m20a
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/m20a,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/flashlight/m20a,
		/obj/item/attachable/attached_gun/grenade/m20a,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_NORMAL
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	starting_attachment_types = list(/obj/item/attachable/stock/m20a,/obj/item/attachable/attached_gun/shotgun/m20a)
	map_specific_decoration = FALSE

/obj/item/weapon/gun/rifle/m20a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 18, "under_y" = 15, "stock_x" = 22, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 16, "special_x" = 16, "special_y" = 16) // SS220 EDIT: Add special slot offset for M20A grenade launcher

/obj/item/weapon/gun/rifle/m20a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9

/obj/item/weapon/gun/rifle/m20a/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null
	starting_attachment_types = list(/obj/item/attachable/stock/m20a,/obj/item/attachable/attached_gun/shotgun/m20a/unloaded)

/obj/item/weapon/gun/rifle/m20a/merc
	name = "\improper M20CW pulse carbine"
	desc = "A heavily modified black market version of the M20A pulse rifle, often used for CQC scenarios where SMGs just aren't cutting it. Comes with an integrated grip instead of an underbarrel shotgun and downsized barrel, alongside the removed stock. It can also now shoot in automatic!"
	icon = 'modular/weapons/icons/rifles.dmi'
	icon_state = "m20a"
	item_state = "m20a"
	base_gun_icon = "m20a"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/sling,
	)
	starting_attachment_types = list(/obj/item/attachable/sling)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m20a/merc/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 14, "under_y" = 15, "stock_x" = 22, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/m20a/merc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_8)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_9
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7

/obj/item/weapon/gun/rifle/m20a/merc/tactical
	starting_attachment_types = list(/obj/item/attachable/sling, /obj/item/attachable/suppressor, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/m20a/merc/unloaded
	current_mag = null

/obj/item/weapon/gun/rifle/m20a/old
	desc = "USCMC assault rifle chambered in 10x24 caseless, complete with an integrated 20mm grenade launcher and an integrated flashlight."
	starting_attachment_types = list(/obj/item/attachable/stock/m20a)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m20a/old/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/m20a/flashlight = new(src)
	flashlight.flags_attach_features &= ~ATTACH_REMOVABLE
	flashlight.Attach(src)
	update_attachable(flashlight.slot)


/obj/item/weapon/gun/rifle/m4ra/pve
	name = "\improper M49A6 battle rifle"
	desc = "The M49A6 is a souped-up M49A, the result of an ARMAT upgrade program that didn't pan out in huge numbers. Its main attraction is the ability to chamber and fire devastating <b>A19 depleted uranium rounds,</b> infamous for their overpenetration abilities and toxic effects on anyone unfortunate enough to survive a hit. The thicker barrel, of course, also has no issue with standard & regular HV ammo."
	desc_lore = "The USCMC was not terribly enthusiastic about unproven hand-held plasma weaponry. Before the XM99A was eventually adopted into use, the USCMC instead sought out a traditional squad-portable, precision, armor-piercing weapon, and contracted ARMAT to upgrade their M49A platform to be capable of firing advanced AP rounds. They succeeded- sort of. <BR> <BR>  The A6 was rejected for several reasons. It's a killer, but also a piece of junk. It kicks hard enough that precision sights simply don't stay zeroed, and its oversized muzzle-device extends an already long barrel-length. Additionally, A19 ammo, already expensive, was driven to absurd highs by the ammunition's specs. Depleted uranium is expensive...and cutting the service life of the M49A's barrel in half is even more expensive. <BR> <BR> Those that were made, however, are still service-ready and were issued where the XM99A was unavailable due to its production only just starting."
	icon = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_obj.dmi'
	icon_state = "m4ra_custom"
	item_state = "m4ra_custom"

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m4ra,
		/obj/item/ammo_magazine/rifle/m4ra/ap,
		/obj/item/ammo_magazine/rifle/m4ra/extended,
		/obj/item/ammo_magazine/rifle/m4ra/rubber,
		/obj/item/ammo_magazine/rifle/m4ra/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/heap,
		/obj/item/ammo_magazine/rifle/m4ra/penetrating,
		/obj/item/ammo_magazine/rifle/m4ra/custom,
		/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m4ra/custom/explosive,
		/obj/item/ammo_magazine/rifle/m4ra/custom/pve,
	)

	current_mag = /obj/item/ammo_magazine/rifle/m4ra/custom/pve

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	map_specific_decoration = FALSE

/obj/item/weapon/gun/rifle/m4ra/pve/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_4)
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_1 //Chunky barrel for better muzzle velocity, but not as good as the custom one
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_3
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/urban/back.dmi'
	)

/obj/item/weapon/gun/rifle/m4ra/pve/handle_starting_attachment()
	..()
	var/obj/item/attachable/m49a_barrel/pve/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.Attach(src)
	update_attachable(integrated.slot)

/obj/item/weapon/gun/rifle/m4ra/pve/unloaded
	current_mag = null
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY

/obj/item/weapon/gun/rifle/r81m1a
	name = "\improper R81M1A pulse rifle"
	desc = "The R81M1A highpower pulse rifle is a very popular weapon within the civilian market, previously rejected by the Royal Marine Commandos due to it's slow rate of fire and mediocre accuracy compared to other rifles in its class. However, it remains a favorite among mercenaries and private military contractors for its high damage output and reliability in harsh conditions. Produced by Orion Defence Systems."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "fal"
	item_state = "fal"
	fire_sound = 'modular/weapons/sounds/gun_fal.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/r81m1

	attachable_allowed = list(
		/obj/item/attachable/bayonet, // Barrel
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/flashlight,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/r81m1a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 46, "muzzle_y" = 20,"rail_x" = 11, "rail_y" = 21, "under_x" = 30, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 24, "side_rail_y" = 18, "special_x" = 30, "special_y" = 16)

/obj/item/weapon/gun/rifle/r81m1a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_7

/obj/item/weapon/gun/rifle/r81m1a/modded
	starting_attachment_types = list(/obj/item/attachable/bayonet, /obj/item/attachable/reflex, /obj/item/attachable/lasersight)

// R81M1B Marksman Rifle
/obj/item/weapon/gun/rifle/r81m1a/m1b
	name = "\improper R81M1B pulse marksman rifle"
	desc = "A marksman variant of the M81M series of pulse rifles, the M81M1B sacrifices some rate of fire and it's automatic firemode for a higher accuracy and longer effective range. Favored by private military contractors and security details operating in high-threat environments. Produced by Orion Defence Systems."
	item_state = "fal"
	icon_state = "fal_sniper"
	base_gun_icon = "fal"
	attachable_allowed = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/r81_sniper, /obj/item/attachable/scope/variable_zoom/fal)
	start_automatic = FALSE

/obj/item/weapon/gun/rifle/r81m1a/m1b/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 17, "rail_y" = 19, "under_x" = 33, "under_y" = 13, "stock_x" = 19, "stock_y" = 16, "side_rail_x" = 28, "side_rail_y" = 18, "special_x" = 36, "special_y" = 19)

/obj/item/weapon/gun/rifle/r81m1a/m1b/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_4)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

// R81M1C Carbine
/obj/item/weapon/gun/rifle/r81m1a/m1c
	name = "\improper R81M1C pulse carbine"
	desc = "A carbine variant of the M81M series of pulse rifles, the M81M1C sacrifices some range and accuracy for a more compact and maneuverable package. Favored by private military contractors and security details operating in urban environments. Produced by Orion Defence Systems."
	item_state = "fal"
	icon_state = "fal_short"
	base_gun_icon = "fal"
	attachable_allowed = list(
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/flashlight,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/r81m1a/m1c/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 21, "under_x" = 30, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 20, "side_rail_y" = 18, "special_x" = 29, "special_y" = 16)

/obj/item/weapon/gun/rifle/r81m1a/m1c/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_8)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_6

/obj/item/weapon/gun/rifle/r81m1a/m1c/modded
	starting_attachment_types = list(/obj/item/attachable/reflex, /obj/item/attachable/lasersight)

// R81M1D Squad Automatic Weapon
/obj/item/weapon/gun/rifle/r81m1a/m1d
	name = "\improper R81M1D pulse squad automatic weapon"
	desc = "A SAW variant of the M81M series of pulse rifles, the M81M1D sacrifices some accuracy for a higher rate of fire and larger magazine capacity, though at the cost of increased recoil. Favored by private military contractors and security details operating in high-threat environments. Produced by Orion Defence Systems."
	item_state = "fal_saw"
	icon_state = "fal_saw"
	base_gun_icon = "fal"
	attachable_allowed = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
	)
	current_mag = /obj/item/ammo_magazine/rifle/r81m1/drum

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_NORMAL
	aim_slowdown = SLOWDOWN_ADS_QUICK
	start_automatic = TRUE

	starting_attachment_types = list(/obj/item/attachable/bipod/r81, /obj/item/attachable/stock/r81_saw, /obj/item/attachable/scope/mini/r81)

/obj/item/weapon/gun/rifle/r81m1a/m1d/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 7, "rail_y" = 16, "under_x" = 32, "under_y" = 13, "stock_x" = 22, "stock_y" = 15, "side_rail_x" = 28, "side_rail_y" = 18, "special_x" = 34, "special_y" = 16)

/obj/item/weapon/gun/rifle/r81m1a/m1d/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_6)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_3
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_6

/obj/item/weapon/gun/rifle/isr
	name = "\improper MK.7 ISR LMG"
	desc = "The Intermediate Support Rifle, or ISR, was developed after contractors operating the MAR platform of firearms complained about its deficiencies. Whilst it is technically just a step above the standard MAR... it's not by much."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "isr"
	item_state = "isr"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/isr
	starting_attachment_types = list(/obj/item/attachable/stock/isr)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/isr,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY
	wield_delay = WEAPON_DELAY_NORMAL
	map_specific_decoration = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/isr/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 12, "rail_y" = 22, "under_x" = 24, "under_y" = 13, "stock_x" = 5, "stock_y" = 20, "side_rail_x" = 20, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/isr/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/isr/modded
	starting_attachment_types = list(/obj/item/attachable/stock/isr, /obj/item/attachable/flashlight, /obj/item/attachable/reddot)

/obj/item/weapon/gun/rifle/fn107
	name = "\improper CAMAS61/78 pulse carbine"
	desc = "To facilitate newer French military development, the CAMAS61/78 was created by Saint etienne in 2159. This was later modified in 2178 for privatized use. It is quite a well known pulse carbine within military circles, commonly being used by many different mercenary and security groups."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "fn107"
	item_state = "fn107"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/fn107
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/fn107,
		/obj/item/attachable/scope/mini,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_NORMAL
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	starting_attachment_types = list(/obj/item/attachable/stock/fn107)
	map_specific_decoration = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/fn107/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 18, "under_y" = 14, "stock_x" = 18, "stock_y" = 14, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/fn107/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_10
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_10
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_1
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/fn107/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null

/obj/item/weapon/gun/rifle/fn107/marksman
	starting_attachment_types = list(/obj/item/attachable/stock/fn107, /obj/item/attachable/scope/mini)

/obj/item/weapon/gun/rifle/fn107/commando
	current_mag = /obj/item/ammo_magazine/rifle/fn107/commando
	starting_attachment_types = list(/obj/item/attachable/stock/fn107, /obj/item/attachable/scope/mini, /obj/item/attachable/lasersight)

//MASM55 Medium Machinegun
/obj/item/weapon/gun/rifle/masm55
	name = "\improper MASM55 Medium Machinegun"
	desc = "Though many groups and factions throughout modern day have switched to either Smartguns or LMGs, the MASM55 is still used for heavy suppression and are commonly found within the hands of Mercenaries. Created by Saint Etienne during 2155 due to the older French MGs were subpar, it has a radiator cooler for more stable fire."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "masm"
	item_state = "masm"
	reload_sound = 'sound/weapons/handling/hpr_reload.ogg'
	unload_sound = 'sound/weapons/handling/hpr_unload.ogg'
	fire_sound = "gun_pulse"
	current_mag = /obj/item/ammo_magazine/rifle/masm
	attachable_allowed = list(
		/obj/item/attachable/bipod/masm,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_SLOW
	aim_slowdown = SLOWDOWN_ADS_LMG
	starting_attachment_types = list(/obj/item/attachable/bipod/masm)
	map_specific_decoration = FALSE
	start_automatic = TRUE
	w_class = SIZE_HUGE
	gun_category = GUN_CATEGORY_HEAVY

/obj/item/weapon/gun/rifle/masm55/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 32, "under_y" = 12, "stock_x" = 18, "stock_y" = 13, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/masm55/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = BURST_AMOUNT_TIER_4
	burst_delay = FIRE_DELAY_TIER_10
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	recoil = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9

/obj/item/weapon/gun/rifle/masm55/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null

//FPSA/76 DMR
/obj/item/weapon/gun/rifle/fpsa
	name = "\improper FPSA/76 Pulse DMR"
	desc = "A domestically produced rifle developed and manufactured by Saint Etienne, 2176. Primarily meant for use by French Armed Forces, it has nonetheless made an impressive impact on the foreign market. The rifle boasts an effective engagement range of over a 1000m, and is chambered in 7.5x50mm high-velocity caseless."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "fpsa"
	item_state = "fpsa"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/fpsa
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/fpsa,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/variable_zoom/integrated,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_NORMAL
	aim_slowdown = SLOWDOWN_ADS_QUICK
	starting_attachment_types = list(/obj/item/attachable/stock/fpsa)
	map_specific_decoration = FALSE
	start_automatic = FALSE

/obj/item/weapon/gun/rifle/fpsa/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 23,"rail_x" = 12, "rail_y" = 21, "under_x" = 16, "under_y" = 18, "stock_x" = 14, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/fpsa/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_8
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_8
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/fpsa/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null

/obj/item/weapon/gun/rifle/sniper/M42A/silenced
	name = "\improper M42A2 SSR"
	desc = "The M42A2 Suppressed Scoped Rifle (SSR for short), is a heavy sniper rifle manufactured by Armat Systems. Modified with an integral suppressor, it has a scope system and fires armor penetrating rounds out of a 15-round magazine.\n'Peace Through Superior Firepower'"
	starting_attachment_types = list(/obj/item/attachable/supsniperbarrel)

/obj/item/weapon/gun/rifle/sniper/rmc
	name = "\improper L64A3 designated marksman rifle"
	desc = "A lightweight designated marksman rifle developed by Howatomo Precision Machining for the Royal Marines. Comes with a toggleable trigger-interlock safety to minimize friendly fire accidents."
	desc_lore = "Designed to provide commandos with responsive long range reach past what the old F903 could manage. A continuous-charge HESH payload removes the requirement for traditional armor piercing steel core ammunition, and improves damage retention at extended range. Faster cycle rate of the breech and a light trigger gives fast and precise followup shots even at thousand meter distances."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "rmcdmr"
	item_state = "rmcdmr"
	unacidable = TRUE
	aiming_time = 0.6 SECONDS
	aimed_shot_cooldown_delay = 1.2 SECONDS
	fire_sound = "gun_rmcdmr"
	reload_sound = 'modular/weapons/sounds/gun_rmcdmr_reload.ogg'
	unload_sound = 'modular/weapons/sounds/gun_rmcdmr_unload.ogg'
	current_mag = /obj/item/ammo_magazine/sniper/rmc
	wield_delay = WEAPON_DELAY_FAST
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	zoomdevicename = "scope"
	attachable_allowed = list(/obj/item/attachable/bipod)
	starting_attachment_types = list(/obj/item/attachable/stock/rmcdmr)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER
	map_specific_decoration = FALSE
	flags_item = TWOHANDED
	var/iff_enabled = TRUE

/obj/item/weapon/gun/rifle/sniper/rmc/Initialize(mapload, ...)
	LAZYADD(actions_types, /datum/action/item_action/rmcdmr/toggle_lethal_mode)
	. = ..()

/obj/item/weapon/gun/rifle/sniper/rmc/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/mini/rmcdmr/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/rifle/sniper/rmc/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 39, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 22, "stock_y" = 11)

/obj/item/weapon/gun/rifle/sniper/rmc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_8)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_9
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/sniper/rmc/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff)
	))
	AddComponent(/datum/component/iff_fire_prevention)

//---ability actions--\\

/datum/action/item_action/rmcdmr/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/sniper/rmc/smartrifle = holder_item
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/user = owner
	if(user.is_mob_incapacitated() || smartrifle.get_active_firearm(user, FALSE) != holder_item)
		return

/datum/action/item_action/rmcdmr/update_button_icon()
	return

/datum/action/item_action/rmcdmr/toggle_lethal_mode/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle IFF"
	action_icon_state = "iff_toggle_on"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/rmcdmr/toggle_lethal_mode/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/sniper/rmc/smartrifle = holder_item
	smartrifle.toggle_iff(usr)
	if(smartrifle.iff_enabled)
		action_icon_state = "iff_toggle_on"
	else
		action_icon_state = "iff_toggle_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

// -- ability actions procs -- \\

/obj/item/weapon/gun/rifle/sniper/rmc/proc/toggle_iff(mob/user)
	iff_enabled = !iff_enabled
	to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] You [iff_enabled? "enable": "disable"] the IFF on [src]."))
	playsound(loc,'sound/machines/click.ogg', 25, 1)

	if(iff_enabled)
		add_bullet_trait(BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff))
	else
		remove_bullet_trait("iff")
	SEND_SIGNAL(src, COMSIG_GUN_ALT_IFF_TOGGLED, iff_enabled)
