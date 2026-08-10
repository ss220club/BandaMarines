

/obj/item/weapon/gun/minigun/upp/distress
	aim_slowdown = 3
	unacidable = 1
	force = 60
	COOLDOWN_DECLARE(attack_cooldown)
	var/cooldown_time = 10 SECONDS
	

/obj/item/weapon/gun/minigun/upp/distress/attack(mob/living/target, mob/living/user)
	. = ..()
	if(. && (COOLDOWN_FINISHED(src, attack_cooldown)))
		COOLDOWN_START(src, attack_cooldown, cooldown_time)
		target.throw_atom(get_step(target, user.dir), 3, SPEED_AVERAGE, user, FALSE)
		target.emote("pain")
		target.apply_effect(0.5, WEAKEN)
		target.apply_effect(3, SLOW)
		target.apply_effect(3, DAZE)

/obj/item/weapon/gun/pkp/distress
	unacidable = 1
	aim_slowdown = 3
	force = 70
	COOLDOWN_DECLARE(attack_cooldown)
	var/cooldown_time = 10 SECONDS
	current_mag = /obj/item/ammo_magazine/pkp/distress

/obj/item/weapon/gun/pkp/distress/attack(mob/living/target, mob/living/user)
	. = ..()
	if(. && (COOLDOWN_FINISHED(src, attack_cooldown)))
		COOLDOWN_START(src, attack_cooldown, cooldown_time)
		target.throw_atom(get_step(target, user.dir), 3, SPEED_AVERAGE, user, FALSE)
		target.emote("pain")
		target.apply_effect(0.5, WEAKEN)
		target.apply_effect(3, SLOW)
		target.apply_effect(3, DAZE)
	
/obj/item/weapon/gun/rifle/type71/distress
	aim_slowdown = 1
	wield_delay = WEAPON_DELAY_NORMAL
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

/obj/item/weapon/gun/rifle/type71/distress/set_gun_config_values()
	..()
	fire_delay = 3.33
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = 1.10
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/type71/carbine/distress
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
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
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/alt_iff_scope,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)

/obj/item/weapon/gun/rifle/type71/carbine/distress/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	damage_mult = 0.67
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/type71/carbine/commando/distress
	wield_delay = WEAPON_DELAY_SLOW

/obj/item/weapon/gun/rifle/type71/carbine/commando/distress/set_gun_config_values()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	set_fire_delay(FIRE_DELAY_TIER_1)
	set_burst_delay(FIRE_DELAY_TIER_3)
	scatter = SCATTER_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/ak4047/distress
	wield_delay = WEAPON_DELAY_NORMAL
