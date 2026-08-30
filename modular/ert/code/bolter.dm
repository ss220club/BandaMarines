/obj/item/weapon/gun/rifle/bolter
	name = "Bolter"
	desc = "For The Imperium of Mankind!"
	icon = 'modular/ert/icons/bolter/bolter.dmi'
	icon_state = "bolter"
	item_state = "bolter"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/assault_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/assault_rifles.dmi',
		WEAR_L_HAND = 'modular/ert/icons/bolter/lefthand.dmi',
		WEAR_R_HAND = 'modular/ert/icons/bolter/righthand.dmi'
	)
	gun_category = GUN_CATEGORY_RIFLE
	flags_equip_slot = SLOT_WAIST
	fire_sound = 'modular/ert/sounds/bolter3.ogg'
	start_automatic = TRUE
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/bolter
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		// /obj/item/attachable/bayonet/upp,
		// /obj/item/attachable/bayonet/co2,
		// /obj/item/attachable/bayonet/antique,
		// /obj/item/attachable/bayonet/custom,
		// /obj/item/attachable/bayonet/wy,
		// /obj/item/attachable/bayonet/custom/red,
		// /obj/item/attachable/bayonet/custom/blue,
		// /obj/item/attachable/bayonet/custom/black,
		// /obj/item/attachable/bayonet/tanto,
		// /obj/item/attachable/bayonet/tanto/blue,
		// /obj/item/attachable/bayonet/rmc_replica,
		// /obj/item/attachable/bayonet/rmc,
		// /obj/item/attachable/reddot,
		// /obj/item/attachable/reflex,
		// /obj/item/attachable/verticalgrip,
		// /obj/item/attachable/angledgrip,
		// /obj/item/attachable/flashlight/grip,
		// /obj/item/attachable/lasersight,
		// /obj/item/attachable/gyro,
		// /obj/item/attachable/flashlight,
		// /obj/item/attachable/flashlight/under_barrel,
		// /obj/item/attachable/bipod,
		// /obj/item/attachable/magnetic_harness,
		// /obj/item/attachable/attached_gun/grenade,
		// /obj/item/attachable/attached_gun/flamer,
		// /obj/item/attachable/attached_gun/flamer/advanced,
		// /obj/item/attachable/attached_gun/shotgun,
		// /obj/item/attachable/attached_gun/extinguisher,
		// /obj/item/attachable/alt_iff_scope,
		// /obj/item/attachable/scope,
		// /obj/item/attachable/scope/mini,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK

/obj/item/weapon/gun/rifle/bolter/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/bolter/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil = RECOIL_AMOUNT_TIER_5 + RECOIL_AMOUNT_TIER_5/10
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/bolter/heavy
	icon_state = "hbolter"
	item_state = "hbolter"
	current_mag = /obj/item/ammo_magazine/rifle/hbolter

/obj/item/weapon/gun/rifle/bolter/heavy/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10 + FIRE_DELAY_TIER_12/4)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil = RECOIL_AMOUNT_TIER_5 + RECOIL_AMOUNT_TIER_5/10
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

/obj/item/ammo_magazine/rifle/bolter
	name = "\improper Bolter magazine (.75)"
	desc = "A bolter magazine."
	caliber = ".75"
	icon = 'modular/ert/icons/bolter/ammo.dmi'
	icon_state = "bolter"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/explosive/bolter
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/bolter

/obj/item/ammo_magazine/rifle/bolter/extended
	name = "\improper Bolter extended magazine (.75)"
	desc = "A Bolter extended magazine."
	icon_state = "bolter_extended"
	max_rounds = 40

/obj/item/ammo_magazine/rifle/hbolter
	name = "heavy bolter box (.75)"
	desc = "A heavy bolter box."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/machineguns.dmi'
	icon_state = "m41ae2"
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/bolter/heavy
	flags_magazine = AMMUNITION_CANNOT_REMOVE_BULLETS|AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER

/datum/ammo/bullet/rifle/explosive/bolter
	name = "bolter round"
	icon = 'modular/ert/icons/projectiles2.dmi'
	icon_state = "bolter"
	damage = 40
	accurate_range = 22
	accuracy = 10
	shell_speed = AMMO_SPEED_TIER_5
	damage_falloff = DAMAGE_FALLOFF_TIER_9
