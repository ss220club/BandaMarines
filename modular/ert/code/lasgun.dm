/obj/item/weapon/gun/rifle/lasgun
	name = "Imperial Lasgun"
	desc = "For The Imperium of Mankind!"
	icon = 'modular/ert/icons/lasgun/lasgun.dmi'
	icon_state = "lasgun"
	item_state = "lasgun"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/assault_rifles.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/assault_rifles.dmi',
		WEAR_L_HAND = 'modular/ert/icons/lasgun/lefthand.dmi',
		WEAR_R_HAND = 'modular/ert/icons/lasgun/righthand.dmi'
	)
	muzzle_flash = "muzzle_laser"
	muzzle_flash_color = COLOR_LASER_RED
	gun_category = GUN_CATEGORY_RIFLE
	flags_equip_slot = SLOT_WAIST
	fire_sound = 'modular/ert/sounds/lasgun1.ogg'
	start_automatic = TRUE
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/lasgun
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

/obj/item/weapon/gun/rifle/lasgun/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/lasgun/set_gun_config_values()
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

/obj/item/ammo_magazine/rifle/lasgun
	name = "\improper Lasgun magazine (LAS)"
	desc = "A lasgun energy pack."
	caliber = "LAS"
	icon = 'modular/ert/icons/lasgun/ammo.dmi'
	icon_state = "las"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/energy/lasgun
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/lasgun
	ammo_band_icon = "+las_band"
	ammo_band_icon_empty = "+las_band_e"

/obj/item/ammo_magazine/rifle/lasgun/extended
	name = "\improper Lasgun extended magazine (LAS)"
	desc = "A lasgun energy pack."
	icon_state = "las_extended"
	max_rounds = 60
	bonus_overlay_icon = 'modular/ert/icons/lasgun/ammo.dmi'
	bonus_overlay = "las_ex"

/datum/ammo/energy/lasgun
	name = "laser bolt"
	icon = 'modular/ert/icons/projectiles2.dmi'
	icon_state = "lasbolt"
	flags_ammo_behavior = AMMO_ENERGY
	damage = 40
	accurate_range = 5
	effective_range_max = 7
	max_range = 10
	shell_speed = AMMO_SPEED_TIER_5
	scatter = SCATTER_AMOUNT_TIER_8
	accuracy = HIT_ACCURACY_TIER_6
	damage_falloff = DAMAGE_FALLOFF_TIER_8

/datum/ammo/energy/lasgun/on_hit_mob(mob/living/M, obj/projectile/P)
	..()
	if(prob(10))
		M.fire_act()
