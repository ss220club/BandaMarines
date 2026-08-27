//MP47A2 Modernised/pulse MP27

/obj/item/weapon/gun/smg/mp47a2
	name = "\improper MP47A2 pulse submachinegun"
	desc = "A much pricier, modernised version of the original MP27 design, though now having been modified into a caseless pulse weapon. High accuracy and stopping power, but at the cost of a reduced magazine capacity and lack of an automatic firemode."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "mp47a2"
	item_state = "mp47a2"
	fire_sound = 'sound/weapons/smg_light.ogg'
	current_mag = /obj/item/ammo_magazine/smg/mp47a2
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Barrel
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/flashlight,
		)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	aim_slowdown = SLOWDOWN_ADS_NONE
	start_automatic = FALSE

/obj/item/weapon/gun/smg/mp47a2/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 20,"rail_x" = 14, "rail_y" = 21, "under_x" = 23, "under_y" = 16, "stock_x" = 28, "stock_y" = 17, "side_rail_x" = 23, "side_rail_y" = 20)

/obj/item/weapon/gun/smg/mp47a2/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/smg/mp47a2/tactical
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)

/obj/item/weapon/gun/smg/fp9000/tactical
	name = "\improper FN FP9000-X TAC Submachinegun"
	desc = "A variation on the standard FP9000 design, with it's internal mechanisms improved and given a new color scheme to sell at extortionate prices by Highfire Manufacturing. Whilst not as good as the official FP9000/2, it's still able to hold it's own and has a much more managable spread."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "fp9000_tactical"
	item_state = "fp9000_tactical"
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
	random_spawn_under = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/smg/fp9000/tactical/set_gun_config_values()
	..()
	set_burst_amount(BURST_AMOUNT_TIER_1)
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
