/obj/item/weapon/gun/rifle/l86_m1
	name = "\improper L86-M1"
	desc = "Тестoвый прототип L86 для регулырной армии TWE."
	icon = 'modular/lv733/icons/l86_m1/l86_m1.dmi'
	icon_state = "l86kai"
	item_state = "l86kai"
	item_icons = list(
		WEAR_BACK = 'modular/lv733/icons/l86_m1/l86_m1_back.dmi',
		WEAR_J_STORE = 'modular/lv733/icons/l86_m1/l86_m1_suit_store.dmi',
		WEAR_L_HAND = 'modular/lv733/icons/l86_m1/l86_m1_lefthand.dmi',
		WEAR_R_HAND = 'modular/lv733/icons/l86_m1/l86_m1_righthand.dmi',
	)
	map_specific_decoration = FALSE
	fire_sound = 'sound/weapons/gun_ar10.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/l86_m1
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bipod,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/flare_launcher,
	)
	starting_attachment_types = list(/obj/item/attachable/attached_gun/flare_launcher)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WEAPON_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	pixel_x = -5
	hud_offset = -5

/obj/item/weapon/gun/rifle/l86_m1/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/rifle/l86_m1/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 21, "under_x" = 30, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "special_x" = 37, "special_y" = 16)

/obj/item/weapon/gun/rifle/l86_m1/set_gun_config_values()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_8
	accuracy_mult += HIT_ACCURACY_MULT_TIER_2
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_10

/obj/item/weapon/gun/rifle/l86_m1/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff, FACTION_ISRG)
	))

/obj/item/ammo_magazine/rifle/l86_m1
	name = "\improper Магазин L86-M1"
	desc = "Магазин на 10x24mm для L86-M1."
	icon = 'modular/lv733/icons/l86_m1/l86_m1_mag.dmi'
	icon_state = "l86kai_mag"
	caliber = "10x24mm"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/l86_m1
	max_rounds = 22
	gun_type = /obj/item/weapon/gun/rifle/l86_m1

/obj/item/ammo_magazine/rifle/l86_m1/ap
	name = "\improper Бронебойный магазин L86-M1"
	desc = "Бронебойный магазин на 10x24mm для L86-M1."
	icon = 'modular/lv733/icons/l86_m1/l86_m1_mag_ap.dmi'
	icon_state = "l86kai_mag_ap"
	default_ammo = /datum/ammo/bullet/rifle/l86_m1/ap
	max_rounds = 12

/datum/ammo/bullet/rifle/l86_m1
	name = "l86-m1 rifle bullet"
	damage = 38
	accuracy = HIT_ACCURACY_TIER_5

/datum/ammo/bullet/rifle/l86_m1/ap
	name = "armor-piercing l86-m1 rifle bullet"
	damage = 32
	penetration = ARMOR_PENETRATION_TIER_8
