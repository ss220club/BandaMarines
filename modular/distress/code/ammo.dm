/datum/ammo/grenade_container/smoke/upp
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

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
	icon = 'modular/distress/icons/ammoupp.dmi'
	caliber = "93mm"
	icon_state = "p17702_8"
	w_class = SIZE_LARGE //Heavy
	default_ammo = /datum/ammo/rocket/ltb/p17702
	max_rounds = 8
	gun_type = /obj/item/hardpoint/primary/cannon/p17702

/obj/item/ammo_magazine/hardpoint/p17702/update_icon()
	icon_state = "p17702_[current_rounds]"

/obj/item/ammo_magazine/hardpoint/t60p3m
	name = "T6OP-3M Magazine (10x27mm)"
	desc = "A box of 500, 10x27mm caseless rounds for use in the T6OP-3M heavy machine gun system."
	caliber = "10x27mm"
	icon = 'modular/distress/icons/ammoupp.dmi'
	icon_state = "t60p3m"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/t60p3m

/datum/ammo/bullet/rifle/heavy/tracer
	icon_state = "bullet_red"

