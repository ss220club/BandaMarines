/obj/item/weapon/gun/m60/m38
	name = "M38 general purpose machinegun"
	desc = "Once-standard USCM GPMG. Chambered in 12x30mm caseless, hard-hitting and extremely reliable."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "m38"
	item_state = "m38"
	base_gun_icon = "m60"
	fire_sound = 'sound/weapons/gun_hpr.ogg'
	current_mag = /obj/item/ammo_magazine/m38
	aim_slowdown = SLOWDOWN_ADS_LMG
	attachable_allowed = list(
		/obj/item/attachable/bipod/m60,
		/obj/item/attachable/stock/m60/m38,
		/obj/item/attachable/flashlight/tactical,
	)
	starting_attachment_types = list(/obj/item/attachable/bipod/m60, /obj/item/attachable/stock/m60/m38, /obj/item/attachable/flashlight/tactical)
//	cover_offset = list("open_x" = -3, "open_y" = 4, "closed_x" = 0, "closed_y" = 0)

/obj/item/weapon/gun/m60/m38/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_10
	fa_max_scatter = 3.5
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_10
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	empty_sound = 'sound/weapons/gun_empty.ogg'

/obj/item/weapon/gun/m60/m38/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 36, "muzzle_y" = 20, "rail_x" = 0, "rail_y" = 0, "under_x" = 30, "under_y" = 14, "stock_x" = 8, "stock_y" = 16, "side_rail_x" = 30, "side_rail_y" = 16)

//RMC GL
/obj/item/weapon/gun/launcher/grenade/m92/rmc
	name = "\improper L164A3 multi-shot grenade launcher"
	desc = "A lightweight support weapon fielded by the Royal Marines. Chambered in small 20mm grenades, it lacks the punch of larger bore grenade launchers, but makes up for that in rate of fire."
	icon = 'modular/weapons/icons/misc.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "rmcgl"
	item_state = "rmcgl"
	fire_sound = 'sound/weapons/gun_ugl_fire.ogg'
	reload_sound = 'sound/weapons/gun_shotgun_open2.ogg'
	unload_sound = 'sound/weapons/gun_shotgun_shell_insert.ogg'
	attachable_allowed = list()
	flags_item = TWOHANDED
	throw_speed = SPEED_VERY_FAST
	force = 15
	GL_has_empty_icon = FALSE
	flags_equip_slot = SLOT_BACK
	map_specific_decoration = FALSE
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	wield_delay = WEAPON_DELAY_NORMAL
	valid_munitions = list(
		/obj/item/explosive/grenade/high_explosive/impact/rmc20mm,
		/obj/item/explosive/grenade/high_explosive/airburst/rmc20mm,
		/obj/item/explosive/grenade/incendiary/airburst/rmc20mm,
		/obj/item/explosive/grenade/smokebomb/airburst/rmc20mm,
		/obj/item/explosive/grenade/high_explosive/impact/rmc20mm/holo,
		/obj/item/explosive/grenade/high_explosive/impact/heap/rmc20mm,
	)
	preload = /obj/item/explosive/grenade/high_explosive/impact/rmc20mm
	starting_attachment_types = list()

	is_lobbing = TRUE
	internal_slots = 8
	direct_draw = TRUE

/obj/item/weapon/gun/launcher/grenade/m92/rmc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)

/obj/item/weapon/gun/launcher/grenade/m92/rmc/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/mini/rmcgl/optic = new(src)
	optic.hidden = TRUE
	optic.flags_attach_features &= ~ATTACH_REMOVABLE
	optic.Attach(src)
	update_attachable(optic.slot)

//m79
/obj/item/weapon/gun/launcher/grenade/m81/m79/modified
	name = "\improper modified M79 grenade launcher"
	desc = "A heavy, low-angle grenade launcher. It's been in use since the Vietnam War, though this version has been modified to fire standard USCM 30mm grenades. The wooden furniture is, in fact, an attempt at modernization and is made of painted hardened polykevlon."
	valid_munitions = list(/obj/item/explosive/grenade/high_explosive, /obj/item/explosive/grenade/high_explosive/impact/heap, /obj/item/explosive/grenade/incendiary, /obj/item/explosive/grenade/smokebomb, /obj/item/explosive/grenade/high_explosive/airburst/buckshot)
	flags_item = TWOHANDED|SMARTGUNNER_BACKPACK_OVERRIDE

/obj/item/weapon/gun/launcher/grenade/m81/m79/modified/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/m79/scope = new(src)
	scope.flags_attach_features &= ~ATTACH_REMOVABLE
	scope.Attach(src)
	scope.hidden = TRUE
	update_attachable(scope.slot)

//m79 short
/obj/item/weapon/gun/launcher/grenade/m81/m79/modified/sawnoff
	name = "\improper sawn-off M79 grenade launcher"
	desc = "A heavy, low-angle grenade launcher, though this one had its stock and half the barrel sawn-off. It's been in use since the Vietnam War, and this version has been modified to fire standard USCM 30mm grenades. The wooden furniture is, in fact, an attempt at modernization and is made of painted hardened polykevlon."
	icon = 'modular/weapons/icons/rifles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'modular/weapons/icons/guns_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/guns_righthand.dmi',
		WEAR_BACK = 'modular/weapons/icons/back.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/suit_slot.dmi'
	)
	icon_state = "m79_short"
	item_state = "m79_short"
	w_class = SIZE_MEDIUM
	flags_equip_slot = SLOT_WAIST
	attachable_allowed = list()
	aim_slowdown = SLOWDOWN_ADS_RIFLE

/obj/item/weapon/gun/launcher/grenade/m81/m79/modified/sawnoff/handle_starting_attachment()
	return
