/obj/item/weapon/gun/smartgun/isrg
	name = "\improper T3 «Райко»"
	desc = "Смартган T3 «Райко», используемый группой ISRG. Облегчённая версия под собственный барабанный магазин."
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko.dmi'
	icon_state = "t3_raiko"
	item_state = "t3_raiko"
	item_icons = list(
		WEAR_BACK = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_suit_store.dmi',
		WEAR_L_HAND = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_righthand.dmi',
	)
	gun_faction = FACTION_ISRG
	current_mag = /obj/item/ammo_magazine/smartgun/isrg
	ammo_primary_def = /datum/ammo/bullet/smartgun/isrg
	ammo_secondary_def = /datum/ammo/bullet/smartgun/isrg/armor_piercing
	ammo_primary_alt = /datum/ammo/bullet/smartgun/isrg/alt
	ammo_secondary_alt = /datum/ammo/bullet/smartgun/isrg/armor_piercing/alt
	has_cover = FALSE

/obj/item/weapon/gun/smartgun/isrg/muzzle_flash(angle, mob/user)
	if(flags_gun_features & GUN_SILENCED || isnull(angle))
		return
	if(!istype(user) || !isturf(user.loc))
		return

	var/prev_light = light_range
	if(!light_on && (light_range <= muzzle_flash_lum))
		set_light_range(muzzle_flash_lum)
		set_light_on(TRUE)
		set_light_color(COLOR_VIVID_RED)
		addtimer(CALLBACK(src, PROC_REF(reset_light_range), prev_light), 0.5 SECONDS)

	var/image/I = image('modular/weapons/icons/t3_raiko_smartgun/t3_raiko_muzzle.dmi', user, "t3_raiko_muzzle_flash", user.dir == NORTH ? ABOVE_LYING_MOB_LAYER : FLOAT_LAYER)
	var/matrix/rotate = matrix()
	if(iscarbonsizexeno(user))
		var/mob/living/carbon/xenomorph/xeno = user
		I.pixel_x = xeno.xeno_inhand_item_offset
	rotate.Translate(0, 5)
	rotate.Turn(angle)
	I.transform = rotate
	I.flick_overlay(user, 3)

/obj/item/ammo_magazine/smartgun/isrg
	name = "\improper T3 drum"
	desc = "Барабанный магазин на 380 патронов для смартгана T3 «Райко»."
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_mag.dmi'
	icon_state = "t3_raiko_mag"
	bonus_overlay = null
	max_rounds = 380
	gun_type = /obj/item/weapon/gun/smartgun/isrg

/datum/ammo/bullet/smartgun/isrg
	name = "T3 smartgun tracer bullet"
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_bullet.dmi'
	icon_state = "t3_raiko_bullet"
	damage = 34
	accuracy = HIT_ACCURACY_TIER_5

/datum/ammo/bullet/smartgun/isrg/alt
	name = "T3 smartgun bullet"
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_bullet.dmi'
	icon_state = "t3_raiko_bullet_alt"
	damage_falloff = DAMAGE_FALLOFF_TIER_6
	effective_range_max = 7

/datum/ammo/bullet/smartgun/isrg/armor_piercing
	name = "\improper AP T3 smartgun tracer bullet"
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_bullet.dmi'
	icon_state = "t3_raiko_bullet_ap"
	damage = 26
	accuracy = HIT_ACCURACY_TIER_3
	penetration = ARMOR_PENETRATION_TIER_8
	damage_armor_punch = 1

/datum/ammo/bullet/smartgun/isrg/armor_piercing/alt
	name = "\improper AP T3 smartgun bullet"
	icon = 'modular/weapons/icons/t3_raiko_smartgun/t3_raiko_bullet.dmi'
	icon_state = "t3_raiko_bullet_ap_alt"
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	effective_range_max = 6
