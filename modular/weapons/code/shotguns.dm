//XM51
/obj/item/weapon/gun/rifle/xm51/lethal
	name = "\improper M1771 shotgun"
	icon = 'modular/weapons/icons/rifles.dmi'
	desc = "Full designation: Model 1771 Cobra Max Tactical. Magazine-fed, pump-action shotgun designed by ARMAT Battlefield Systems meant for civilian and law-enforcement use. Failed its short USCM trials due to unreliability and was ridiculed heavily for having a 'tryhard' name."
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "xm50"
	item_state = "xm50"
	current_mag = /obj/item/ammo_magazine/rifle/xm51/lethal
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/xm51,
		/obj/item/attachable/stock/xm51/military,
	)

/obj/item/weapon/gun/rifle/xm51/withstock
	starting_attachment_types = list(/obj/item/attachable/stock/xm51)

/obj/item/weapon/gun/rifle/xm51/military
	name = "\improper XM51 shotgun"
	desc = "Magazine-fed, pump-action shotgun designed by ARMAT Battlefield Systems, also known as M1771 Cobra Max Tactical. This one is painted with a fresh coat of Humbrol 170."
	icon_state = "xm50_military"
	item_state = "xm50_military"

/obj/item/weapon/gun/rifle/xm51/military/withstock
	starting_attachment_types = list(/obj/item/attachable/stock/xm51/military)

/obj/item/weapon/gun/shotgun/p79s
	name = "\improper P79S semi-automatic shotgun"
	desc = "A somewhat older semi-automatic shotgun design, chambered in 10 gauge shells. Though not as common as more modern automatic ones, the P79S is still in use with various mercenary and police forces due to its reliability and stopping power. Its internal tube magazine can store 6 shells. Produced by Orion Defence Systems."
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon = 'modular/weapons/icons/rifles.dmi'
	icon_state = "p79s"
	item_state = "p79s"
	fire_sound = 'sound/weapons/gun_shotgun_automatic.ogg'
	flags_equip_slot = SLOT_BACK
	current_mag = /obj/item/ammo_magazine/internal/shotgun/p79s
	attachable_allowed = list(
		/obj/item/attachable/stock/p79s,
	)

/obj/item/weapon/gun/shotgun/p79s/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/shotgun/p79s/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 11, "rail_y" = 21, "under_x" = 22, "under_y" = 14, "stock_x" = 18, "stock_y" = 14, "side_rail_x" = 23, "side_rail_y" = 17, "special_x" = 20, "special_y" = 16)

/obj/item/weapon/gun/shotgun/p79s/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_5
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	starting_attachment_types = list(/obj/item/attachable/stock/p79s)

/obj/item/weapon/gun/shotgun/p79s/get_examine_text(mob/user)
	. = ..()
	if(in_chamber) . += "It has a chambered round."

/obj/item/weapon/gun/shotgun/p79s/unloaded
	current_mag = /obj/item/ammo_magazine/internal/shotgun/p79s/unloaded

/obj/item/weapon/gun/shotgun/p79s/slug
	current_mag = /obj/item/ammo_magazine/internal/shotgun/p79s/slug

/obj/item/ammo_magazine/internal/shotgun/p79s
	caliber = "12g"
	max_rounds = 8
	current_rounds = 8

/obj/item/ammo_magazine/internal/shotgun/p79s/slug
	default_ammo = /datum/ammo/bullet/shotgun/slug

/obj/item/ammo_magazine/internal/shotgun/p79s/unloaded
	current_rounds = 0
