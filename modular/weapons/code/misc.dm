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
/obj/item/weapon/gun/launcher/grenade/m81/m85a1/m79/modified
	name = "\improper modified M79 grenade launcher"
	desc = "A heavy, low-angle grenade launcher. It's been in use since the Vietnam War, though this version has been modified to fire standard USCM 30mm grenades. The wooden furniture is, in fact, an attempt at modernization and is made of painted hardened polykevlon."
	flags_item = TWOHANDED|SMARTGUNNER_BACKPACK_OVERRIDE

/obj/item/weapon/gun/launcher/grenade/m81/m85a1/m79/modified/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/m79/scope = new(src)
	scope.flags_attach_features &= ~ATTACH_REMOVABLE
	scope.Attach(src)
	scope.hidden = TRUE
	update_attachable(scope.slot)

//m79 short
/obj/item/weapon/gun/launcher/grenade/m81/m85a1/m79/modified/sawnoff
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

/obj/item/weapon/gun/launcher/grenade/m81/m85a1/m79/modified/sawnoff/handle_starting_attachment()
	return
