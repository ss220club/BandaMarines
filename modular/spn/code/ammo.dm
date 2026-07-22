/datum/ammo/grenade_container/smoke/upp
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

// UPP ROCKETS/MISSILES
/datum/ammo/rocket/ap/hj35_launcher
	icon_state = "hj35_missile"
	max_range = 8

// TANK CANNON
/datum/ammo/rocket/ltb/p17702
	name = "93mmm round"
	icon_state = "p17702"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE

	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 32
	max_range = 32
	damage = 200
	shell_speed = AMMO_SPEED_TIER_3

/obj/item/ammo_magazine/hardpoint/p17702
	name = "P-177-02 93mm Cannon Magazine"
	desc = "A magazine of high-explosive, anti-tank cannon rounds."
	icon = 'modular/spn/icons/ammoupp.dmi'
	caliber = "93mm"
	icon_state = "p17702_8"
	w_class = SIZE_LARGE //Heavy
	default_ammo = /datum/ammo/rocket/ltb/p17702
	max_rounds = 8
	gun_type = /obj/item/hardpoint/primary/cannon/p17702

/obj/item/ammo_magazine/hardpoint/p17702/update_icon()
	icon_state = "p17702_[current_rounds]"

/obj/item/ammo_magazine/hardpoint/Gshk_minigun
	name = "Gshk Minigun Magazine"
	icon = 'modular/spn/icons/ammoupp.dmi'
	desc = "A primary armament minigun magazine."
	caliber = "7.62x51mm" //Correlates to miniguns
	icon_state = "gshk"
	w_class = SIZE_LARGE //Primary weapon ammo should probably all be the same w_class
	default_ammo = /datum/ammo/bullet/tank/minigun
	max_rounds = 500
	gun_type = /obj/item/hardpoint/primary/minigun

/obj/item/ammo_magazine/hardpoint/t60p3m
	name = "T6OP-3M Magazine (10x27mm)"
	desc = "A box of 500, 10x27mm caseless rounds for use in the T6OP-3M heavy machine gun system."
	caliber = "10x27mm"
	icon = 'modular/spn/icons/ammoupp.dmi'
	icon_state = "t60p3m"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/t60p3m

/obj/item/ammo_magazine/hardpoint/hj35launcher
	name = "HJ-35 Launcher Magazine"
	icon = 'modular/spn/icons/ammoupp.dmi'
	desc = "A magazine of laser-guided missiles used in the UPP HJ-35 launcher weapon-system."
	caliber = "rocket" //correlates to any rocket mags
	icon_state = "hj35"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/rocket/ap/tank_towlauncher/hj35_launcher
	max_rounds = 3
	gun_type = /obj/item/hardpoint/secondary/hj35launcher

/datum/ammo/bullet/rifle/heavy/tracer
	icon_state = "bullet_red"

/datum/ammo/rocket/ap/tank_towlauncher/hj35_launcher
	icon_state = "hj35_missile"
	max_range = 16
