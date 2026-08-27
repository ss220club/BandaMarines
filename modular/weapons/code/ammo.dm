//HP Automag
/obj/item/ammo_magazine/pistol/highpower/automag
	name = "\improper HG-44 'Automag' magazine (.44)"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "highpower_b"
	max_rounds = 13
	default_ammo = /datum/ammo/bullet/revolver

//RMC VP78
/obj/item/ammo_magazine/pistol/vp78/rmc
	name = "\improper L165A1 Squash-Head magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash
	gun_type = /obj/item/weapon/gun/pistol/vp78/rmc
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//Pa76
/obj/item/ammo_magazine/pistol/pa76
	name = "\improper PA76 magazine (7.65x20mm)"
	desc = "A pistol magazine used by the PA76 pistol."
	caliber = "7.65x20mm"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "pa76"
	max_rounds = 7
	default_ammo = /datum/ammo/bullet/pistol/pa76
	gun_type = /obj/item/weapon/gun/pistol/pa76
	ammo_band_icon = "+pa76_band"
	ammo_band_icon_empty = "+pa76_band_e"

/obj/item/ammo_magazine/pistol/pa76/ap
	name = "\improper PA76 armor piercing magazine (7.65x20mm)"
	desc = "A pistol magazine. This one contains armor piercing bullets."
	default_ammo = /datum/ammo/bullet/pistol/pa76/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/datum/ammo/bullet/pistol/pa76
	name = "7.65x20mm bullet"
	damage = 45 //High damage
	penetration = -ARMOR_PENETRATION_TIER_2 //Low AP

/datum/ammo/bullet/pistol/pa76/ap
	name = "7.65x20mm bullet"
	damage = 35 //Reduced damage
	penetration = ARMOR_PENETRATION_TIER_4 //High AP

//RMR6
/obj/item/ammo_magazine/internal/revolver/rmr6
	default_ammo = /datum/ammo/bullet/revolver/rmr6
	caliber = ".357"
	gun_type = /obj/item/weapon/gun/revolver/rmr6

/obj/item/ammo_magazine/revolver/rmr6
	name = "\improper RMR-6 speed loader (.357 Magnum)"
	desc = "A speedloader of 6 Magnum .357 bullets for the RMR-6 and similar brands of revolver."
	default_ammo = /datum/ammo/bullet/revolver/rmr6
	caliber = ".357"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "rmr6"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/rmr6

/datum/ammo/bullet/revolver/rmr6
	name = ".357 magnum revolver bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 55
	penetration = ARMOR_PENETRATION_TIER_4


/obj/item/explosive/grenade/high_explosive/impact/rmc20mm
	name = "\improper L103A1 20mm HE grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A 20mm grenade that explodes upon impact. Less powerful than full-sized grenades."
	icon_state = "grenade_20mm_he"
	item_state = "grenade_hedp"
	explosion_power = 80
	shrapnel_count = 8

/obj/item/explosive/grenade/high_explosive/airburst/rmc20mm
	name = "\improper L104A1 20mm fragmentation grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A 20mm grenade that explodes into shrapnel upon impact."
	icon_state = "grenade_20mm_frag"
	item_state = "grenade_hefa"
	shrapnel_type = /datum/ammo/bullet/shrapnel/heavy
	direct_hit_shrapnel = 12
	explosion_power = 30
	shrapnel_count = 36
	dispersion_angle = 45

/datum/ammo/bullet/shrapnel/heavy
	name = "shrapnel cloud"
	icon_state = "shrapnel_light"
	max_range = 6
	damage = 35
	damage_var_low = -PROJECTILE_VARIANCE_TIER_4
	damage_var_high = PROJECTILE_VARIANCE_TIER_6
	penetration = ARMOR_PENETRATION_TIER_3
	shell_speed = AMMO_SPEED_TIER_3
	shrapnel_chance = 10

/obj/item/explosive/grenade/incendiary/airburst/rmc20mm
	name = "\improper L103A1/I 20mm incendiary grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A 20mm grenade that explodes into flaming shrapnel & a pool of incendiary compound upon impact."
	icon_state = "grenade_20mm_inc"
	item_state = "grenade_fire"
	flame_level = BURN_TIME_TIER_1
	burn_level = BURN_LEVEL_TIER_8
	flameshape = FLAMESHAPE_IRREGULAR
	radius = 2
	shrapnel_count = 12
	shrapnel_type = /datum/ammo/bullet/shrapnel/incendiary/heavy

/datum/ammo/bullet/shrapnel/incendiary/heavy	//Maximum warcrimes edition
	accurate_range = 32
	max_range = 8
	shell_speed = AMMO_SPEED_TIER_2
	damage = 20
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/shrapnel/incendiary/heavy/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, reagent = /datum/reagent/napalm/blue)
	))

/obj/item/explosive/grenade/smokebomb/airburst/rmc20mm
	name = "\improper L101A2 20mm nerve-agent grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A 20mm grenade that explodes into a voluminous cloud of nerve gas upon impact."
	icon_state = "grenade_20mm_gas"
	item_state = "grenade_smoke"
	smoke_radius = 3

/obj/item/explosive/grenade/smokebomb/airburst/rmc20mm/New()
	..()
	smoke = new /datum/effect_system/smoke_spread/cn20/xeno
	smoke.attach(src)

/obj/item/explosive/grenade/high_explosive/impact/rmc20mm/holo
	name = "\improper L104A1/H 20mm holo-targetting grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A 20mm grenade that explodes into shrapnel upon impact. The shrapenl of this one douses the target in a chemical compound which aids in target acquisition by sensors."
	icon_state = "grenade_20mm_holo"
	item_state = "grenade_phos"
	explosion_power = 10
	shrapnel_count = 32
	shrapnel_type = /datum/ammo/bullet/shrapnel/hornet_rounds/rmc

/datum/ammo/bullet/shrapnel/hornet_rounds/rmc
	name = "holo-targeting pellet"
	icon_state = "hornet_round"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER
	damage = 10
	holo_stacks = 30
	accuracy = HIT_ACCURACY_TIER_5
	max_range = 6


/obj/item/explosive/grenade/high_explosive/impact/heap/rmc20mm
	name = "\improper L108A1 HESH grenade"
	icon = 'modular/weapons/icons/grenade.dmi'
	desc = "A powerful high-explosive squash-head 20mm grenade that explodes upon impact."
	icon_state = "grenade_20mm_squash"
	item_state = "grenade_training"
	explosion_power = 160

//M20A
/obj/item/ammo_magazine/rifle/m20a
	name = "\improper M20A magazine (10x24mm)"
	icon = 'modular/weapons/icons/uscm_ammo.dmi'
	desc = "A 10mm assault rifle magazine."
	caliber = "10x24mm"
	icon_state = "m20a"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/m20a
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+m20a_band"
	ammo_band_icon_empty = "+m20a_band_e"

/obj/item/ammo_magazine/rifle/m20a/heap
	name = "\improper M20A HEAP magazine (10x24mm)"
	desc = "A 10mm high explosive armor piercing assault rifle magazine."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/m20a/ap
	name = "\improper M20A AP magazine (10x24mm)"
	desc = "A 10mm armor piercing assault rifle magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

//M4RA PvE
/obj/item/ammo_magazine/rifle/m4ra/custom/explosive
	name = "\improper A19 HV explosive magazine (10x28mm)"
	desc = "A magazine of A19 HV explosive rounds for use in the later-model M49A battle rifles. The M49A5 & M49A6 battle rifles are the only guns that can chamber these rounds."
	default_ammo = /datum/ammo/bullet/rifle/m4ra/explosive
	gun_type = /obj/item/weapon/gun/rifle/m4ra_custom
	ammo_band_color = AMMO_BAND_COLOR_EXPLOSIVE

/obj/item/ammo_magazine/rifle/m4ra/custom/pve
	name = "\improper A19 HV depleted uranium magazine (10x28mm)"
	desc = "A magazine of A19 HV wall-penetrating, body-penetrating, toxic 10x28mm rounds. Handloaded by Gateway armorers for use in the M49A6 battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/m4ra/du
	gun_type = /obj/item/weapon/gun/rifle/m4ra/pve
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/datum/ammo/bullet/rifle/m4ra/explosive
	name = "high velocity explosive 10x28 bullet"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 50
	accuracy = HIT_ACCURACY_TIER_2
	penetration = ARMOR_PENETRATION_TIER_5
	damage_armor_punch = 5

/datum/ammo/bullet/rifle/m4ra/explosive/on_hit_mob(mob/M, obj/projectile/P)
	knockback(M, P, 6) // Can knockback out to 1/4th-range
	var/slow_duration = 7
	var/mob/living/L = M
	if(isxeno(M))
		var/mob/living/carbon/xenomorph/target = M
		if(target.mob_size >= MOB_SIZE_BIG)
			slow_duration = 2 // Crushers & such are still a threat, recovering much quicker
		M.adjust_effect(slow_duration, SUPERSLOW)
		burst(get_turf(M),P,damage_type, 2 , 2)
		burst(get_turf(M),P,damage_type, 1 , 2 , 0)
		L.apply_armoured_damage(damage, ARMOR_BULLET, BRUTE, null, penetration)
	else
		M.adjust_effect(slow_duration, SUPERSLOW)
		burst(get_turf(M),P,damage_type, 2 , 2)
		burst(get_turf(M),P,damage_type, 1 , 2 , 0)

/datum/ammo/bullet/rifle/m4ra/explosive/on_near_target(turf/T, obj/projectile/P)
	burst(T,P,damage_type, 2 , 4)
	burst(T,P,damage_type, 1 , 2, 0)
	return 1

/datum/ammo/bullet/rifle/m4ra/du
	name = "high velocity depleted uranium 10x28 bullet"

	damage = 50 //Overall same damage as base rounds, but 15 tox DoT
	penetration = ARMOR_PENETRATION_TIER_10 //DU's a heavy armour-piercing kind of material
	accuracy = HIT_ACCURACY_TIER_4
	scatter = -SCATTER_AMOUNT_TIER_8

/datum/ammo/bullet/rifle/m4ra/du/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/m4ra/du/on_hit_mob(mob/target, obj/projectile/fired_proj)
	target.AddComponent(/datum/component/status_effect/toxic_buildup, toxic_buildup = 15, toxic_buildup_dissipation = 0.3, max_buildup = 75)
	knockback(target, fired_proj, 16) // Can knockback out to 2/3rds-range
	if(target.mob_size >= MOB_SIZE_BIG)
		var/mob/living/L = target
		L.apply_armoured_damage(damage*1.3, ARMOR_BULLET, BRUTE, null, penetration) // As bugs don't take toxin damage, this should give it a little more oomf versus them


//R81M1 mags
/obj/item/ammo_magazine/rifle/r81m1
	name = "\improper R81M1 magazine (9x32mm)"
	desc = "A 9x32mm high-velocity battle rifle magazine."
	caliber = "9x32mm"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "fal"
	bonus_overlay = "fal_overlay"
	default_ammo = /datum/ammo/bullet/rifle/r81m1
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/r81m1a
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+fal_band"
	ammo_band_icon_empty = "+fal_band_e"

/obj/item/ammo_magazine/rifle/r81m1/ap
	name = "\improper R81M1 AP magazine (9x32mm)"
	desc = "A 9x32mm high-velocity battle rifle armor piercing magazine."
	default_ammo = /datum/ammo/bullet/rifle/r81m1/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/r81m1/hp
	name = "\improper R81M1 HP magazine (9x32mm)"
	desc = "A 9x32mm high-velocity battle rifle hollow point magazine."
	default_ammo = /datum/ammo/bullet/rifle/r81m1/hp
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT

/obj/item/ammo_magazine/rifle/r81m1/drum
	name = "\improper R81M1D drum magazine (9x32mm)"
	desc = "A 9x32mm high-velocity drum magazine."
	icon_state = "fal_drum"
	bonus_overlay = "fal_drum_overlay"
	max_rounds = 80
	gun_type = /obj/item/weapon/gun/rifle/r81m1a/m1d

//R81M1
/datum/ammo/bullet/rifle/r81m1
	name = "9x32 high-velocity rifle bullet"
	damage = 50
	accuracy = HIT_ACCURACY_TIER_5

/datum/ammo/bullet/rifle/r81m1/ap
	name = "9x32 high-velocity AP rifle bullet"
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_3

/datum/ammo/bullet/rifle/r81m1/hp
	name = "9x32 high-velocity HP rifle bullet"
	damage = 60
	penetration = -ARMOR_PENETRATION_TIER_3
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_5

//MP47a2
/obj/item/ammo_magazine/smg/mp47a2
	name = "\improper MP47A2 magazine (10x20mm)"
	desc = "A 10x20mm magazine for the MP47A2."
	caliber = "10x20mm"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "mp47a2"
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/smg/mp47a2
	default_ammo = /datum/ammo/bullet/smg/mp47a2

/datum/ammo/bullet/smg/mp47a2
	name = "high-velocity submachinegun bullet"
	damage = 35
	accurate_range = 5
	effective_range_max = 7
	penetration = ARMOR_PENETRATION_TIER_3
	shell_speed = AMMO_SPEED_TIER_5
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	scatter = SCATTER_AMOUNT_TIER_7
	accuracy = HIT_ACCURACY_TIER_3

//ISR
/obj/item/ammo_magazine/rifle/isr
	name = "\improper ISR box magazine (9.2x34mm)"
	desc = "A 9.2x34mm box magazine for the ISR LMG."
	caliber = "9.2x34mm"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "isr"
	item_state = "isr"
	default_ammo = /datum/ammo/bullet/rifle/isr
	max_rounds = 80
	gun_type = /obj/item/weapon/gun/rifle/isr

/datum/ammo/bullet/rifle/isr
	name = "heavy 9.2x34mm bullet"
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_1

//FN107
/obj/item/ammo_magazine/rifle/fn107
	name = "\improper CAMAS61/78 magazine (7.5x28mm)"
	desc = "An 7.5mm magazine for the CAMAS61/78 Carbine, commonly used by FIL."
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "fn107"
	item_state = "fn107"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/fn107
	max_rounds = 100
	gun_type = /obj/item/weapon/gun/rifle/fn107

/obj/item/ammo_magazine/rifle/fn107/commando
	name = "\improper CAMAS61/78 AP Tracer magazine (7.5x28mm)"
	desc = "An 7.5mm AP Tracer magazine for the CAMAS61/78 Carbine, commonly used by FIL."
	default_ammo = /datum/ammo/bullet/rifle/fn107/commando
	ammo_band_icon = "+fn107_band"
	ammo_band_icon_empty = "+fn107_band_e"
	ammo_band_color = AMMO_BAND_COLOR_AP

//MASM55 Medium Machinegun
/obj/item/ammo_magazine/rifle/masm
	name = "\improper MASM55 box magazine (12x30mm)"
	desc = "A large 12mm box magazine for the MASM55, commonly used by the FIL."
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "masm"
	item_state = "masm"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/rifle/masm
	max_rounds = 120
	gun_type = /obj/item/weapon/gun/rifle/masm55

//FPSA DMR
/obj/item/ammo_magazine/rifle/fpsa
	name = "\improper FPSA/76 DMR magazine (7.5x50mm)"
	desc = "A standard caseless magazine for the FPSA/76 Pulse DMR, often used by mercenary and french armed forces."
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "fpsa"
	item_state = "fpsa"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/fpsa
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/fpsa

/obj/item/ammo_magazine/rifle/fpsa/commando
	name = "\improper FPSA/76 DMR AP Tracer magazine (7.5x50mm)"
	desc = "A standard caseless AP tracer magazine for the FPSA/76 Pulse DMR, often used by FIL special forces."
	default_ammo = /datum/ammo/bullet/rifle/fpsa/commando
	ammo_band_icon = "+fpsa_band"
	ammo_band_icon_empty = "+fpsa_band_e"
	ammo_band_color = AMMO_BAND_COLOR_AP


/datum/ammo/bullet/rifle/fn107
	name = "7.5x28 bullet"
	damage = 35

/datum/ammo/bullet/rifle/fn107/commando
	name = "armor piercing 7.5x28 bullet"
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/rifle/masm
	name = "12x30 bullet"
	damage = 50 //Medium machinegun, high damage
	penetration = ARMOR_PENETRATION_TIER_2 //Tiny bit of AP just because the others don't have AP. And it's a god damn MMG

/datum/ammo/bullet/rifle/fpsa
	name = "7.5x50mm bullet"
	damage = 45
	penetration = ARMOR_PENETRATION_TIER_2
	effective_range_max = 16
	accurate_range = 24
	max_range = 32

/datum/ammo/bullet/rifle/fpsa/commando
	name = "armor piercing 7.5x50mm bullet"
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_5

//M38
/obj/item/ammo_magazine/m38
	name = "M38 belt box (12x30mm caseless)"
	desc = "Heavy high-capacity belt box for M38 GPMG."
	caliber = "12x30"
	w_class = SIZE_MEDIUM
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "m60"

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/m38
	max_rounds = 150
	reload_delay = 4
	gun_type = /obj/item/weapon/gun/m60/m38
	ammo_band_icon = "+m60_band"
	ammo_band_icon_empty = "+m60_band_e"

/obj/item/ammo_magazine/m38/heap
	name = "M38 HEAP belt box (12x30mm caseless)"
	desc = "Heavy high-capacity belt box for M38 GPMG filled with high-explosive armor piercing rounds."
	default_ammo = /datum/ammo/bullet/m38/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP


/datum/ammo/bullet/m38
	name = "12x30 bullet"
	damage = 65
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	icon_state = "bullet_red"
	penetration = ARMOR_PENETRATION_TIER_6
	accuracy = HIT_ACCURACY_TIER_1
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 10
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	accurate_range = 14

/datum/ammo/bullet/m38/heap
	name = "high-explosive armor-piercing 12x30 bullet"
	damage = 80
	penetration = ARMOR_PENETRATION_TIER_9

//RMC DMR magazine
/obj/item/ammo_magazine/sniper/rmc
	name = "\improper L64A3 squash-head magazine (8.88x51mm Caseless)"
	desc = "A magazine of L10A7 squash-head match-grade 8.88x51mm ammo. An aimed shot with it will deal significant damage."
	caliber = "8.88x51mm"
	icon = 'modular/weapons/icons/twe_ammo.dmi'
	icon_state = "rmcdmr"
	w_class = SIZE_MEDIUM
	max_rounds = 25
	default_ammo = /datum/ammo/bullet/rifle/heavy/rmcdmr
	gun_type = /obj/item/weapon/gun/rifle/sniper/rmc
	ammo_band_icon = "+rmcdmr_band"
	ammo_band_icon_empty = "+rmcdmr_band_e"
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

/datum/ammo/bullet/rifle/heavy/rmcdmr
	name = "8.88x51 squash-head bullet"
	damage = 60
	penetration = ARMOR_PENETRATION_TIER_6
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_7
	effective_range_max = 24

/datum/ammo/bullet/rifle/heavy/rmcdmr/on_hit_mob(mob/M,obj/projectile/P)
	if((P.projectile_flags & PROJECTILE_BULLSEYE) && M == P.original)
		var/slow_duration = 7
		var/mob/living/L = M
		if(isxeno(M))
			var/mob/living/carbon/xenomorph/target = M
			if(target.mob_size >= MOB_SIZE_BIG)
				slow_duration = 4
		M.adjust_effect(slow_duration, SUPERSLOW)
		L.apply_armoured_damage(damage*1.5, ARMOR_BULLET, BRUTE, null, penetration)
		to_chat(P.firer, SPAN_WARNING("Bullseye!"))

//Xm51 lethal
/obj/item/ammo_magazine/rifle/xm51/lethal
	name = "\improper XM51 magazine (12g)"
	desc = "A 12 gauge shotgun magazine."
	caliber = "12g"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/xm51
	transfer_handful_amount = 6

/obj/item/ammo_magazine/rifle/xm51/lethal/slug
	name = "\improper XM51 magazine (12g slug)"
	desc = "A 12 gauge shotgun magazine."
	caliber = "12g"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/shotgun/slug
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/xm51
	transfer_handful_amount = 6
