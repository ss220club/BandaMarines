/obj/item/ammo_magazine/pistol/highpower/automag
	name = "\improper HG-44 'Automag' magazine (.44)"
	icon = 'modular/weapons/icons/colony_ammo.dmi'
	icon_state = "highpower_b"
	max_rounds = 13
	default_ammo = /datum/ammo/bullet/revolver

/obj/item/ammo_magazine/pistol/vp78/rmc
	name = "\improper L165A1 Squash-Head magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash
	gun_type = /obj/item/weapon/gun/pistol/vp78/rmc
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

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



/obj/item/ammo_magazine/pistol/vp70
	name = "\improper VP70 Magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x19mm"
	icon_state = "vp70"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/vp70
	ammo_band_icon = "+vp70_band"
	ammo_band_icon_empty = "+vp70_band_e"
	ammo_band_color = null

/obj/item/ammo_magazine/pistol/vp70/ap
	name = "\improper VP70 AP magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap
	caliber = "9x19mm"
	icon_state = "vp70"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/vp70
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/vp70/extended // Unused
	name = "\improper vp70 extended magazine (9x19mm)"
	icon_state = "vp70_mag_ex"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x19mm"

/obj/item/ammo_magazine/pistol/vp70/toxin
	name = "\improper vp70 toxic magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/vp70/penetrating
	name = "\improper vp70 wall-penetrating magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/vp70/incendiary
	name = "\improper vp70 incendiary magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/vp70/rubber
	name = "\improper vp70 rubber magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER



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
