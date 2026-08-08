/obj/item/weapon/gun/smg/mirai7
	name = "\improper Mirai-7 submachinegun"
	desc = "Пистолет-пулемёт Mirai-7, используемый поисковой группой ISRG. Собственный калибр 10x20mm — магазины других СМГ к нему не подходят."
	icon = 'modular/lv733/icons/mirai7/mirai7.dmi'
	icon_state = "mirai7"
	item_state = "mirai7"
	item_icons = list(
		WEAR_BACK = 'modular/lv733/icons/mirai7/mirai7_back.dmi',
		WEAR_J_STORE = 'modular/lv733/icons/mirai7/mirai7_suit_store.dmi',
		WEAR_L_HAND = 'modular/lv733/icons/mirai7/mirai7_lefthand.dmi',
		WEAR_R_HAND = 'modular/lv733/icons/mirai7/mirai7_righthand.dmi',
	)
	map_specific_decoration = FALSE
	fire_sound = 'sound/weapons/gun_uzi.ogg'
	current_mag = /obj/item/ammo_magazine/smg/mirai7
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/stock/smg,
		/obj/item/attachable/stock/smg/collapsible,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/gyro,
		/obj/item/attachable/stock/smg/collapsible/brace,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/stock/smg/collapsible)

/obj/item/weapon/gun/smg/mirai7/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/smg/mirai7/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 20,"rail_x" = 14, "rail_y" = 22, "under_x" = 21, "under_y" = 16, "stock_x" = 24, "stock_y" = 15)

/obj/item/weapon/gun/smg/mirai7/set_gun_config_values()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_4
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_5
	fa_max_scatter = SCATTER_AMOUNT_TIER_10 + 0.5

/obj/item/ammo_magazine/smg/mirai7
	name = "\improper Mirai-7 magazine (10x20mm)"
	desc = "Магазин на 10x20mm для Mirai-7. Магазины других СМГ этого калибра к нему не подходят."
	caliber = "10x20mm"
	icon = 'modular/lv733/icons/mirai7/mirai7_mag_extended.dmi'
	icon_state = "mirai7_extended"
	bonus_overlay = "mirai7_ex"
	ammo_band_icon = "+mirai7_band"
	ammo_band_icon_empty = "+mirai7_band_e"
	w_class = SIZE_MEDIUM
	max_rounds = 72
	default_ammo = /datum/ammo/bullet/smg/m39
	gun_type = /obj/item/weapon/gun/smg/mirai7

/obj/item/ammo_magazine/smg/mirai7/ap
	name = "\improper Mirai-7 AP magazine (10x20mm)"
	desc = "Бронебойный магазин на 10x20mm для Mirai-7."
	icon = 'modular/lv733/icons/mirai7/mirai7_mag_ap.dmi'
	icon_state = "mirai7_ap"
	ammo_band_icon = "+mirai7_band"
	ammo_band_icon_empty = "+mirai7_band_e"
	default_ammo = /datum/ammo/bullet/smg/ap
	gun_type = /obj/item/weapon/gun/smg/mirai7
