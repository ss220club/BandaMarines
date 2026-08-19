/obj/item/hardpoint/secondary/m56cupola/aev
	name = "\improper Pintle-Mounted M56 RWS"
	desc = "A remotely-controlled weapon system for armored engineering vehicles using a modified M56."
	disp_icon_state = "m56pintle"

	allowed_seat = VEHICLE_GUNNER

	firing_arc = 150

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola/aev
	max_clips = 5

	muzzle_flash_pos = list(
		"1" = list(8, -1),
		"2" = list(-7, -21),
		"4" = list(13, -10),
		"8" = list(-11, 1)
	)

	scatter = 2

/obj/item/hardpoint/support/smoke_launcher
	name = "\improper M-39P Smoke Discharger"
	desc = "A support module for ATVs that shoots M60 incendiary smoke grenades to deter hitchhikers."
	icon = 'modular/vehicles/icons/aev/apc_hardpoints.dmi'

	icon_state = "slauncher"
	disp_icon = "apc"
	disp_icon_state = "slauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	activatable = TRUE

	health = 1500
	firing_arc = 120

	allowed_seat = VEHICLE_GUNNER

	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke/incen
	max_clips = 3

	use_muzzle_flash = FALSE

	fire_delay = 1.0 SECONDS

/obj/item/hardpoint/support/smoke_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/support/smoke_launcher/aev
	name = "\improper M-39Q Smoke Discharger"
	desc = "A support module for AEVs that shoots M60 incendiary smoke grenades to deter hitchhikers."
	icon = 'modular/vehicles/icons/aev/aev_hardpoints.dmi'

	icon_state = "slauncher_0"
	disp_icon = "tank"

	firing_arc = 150
	ammo = new /obj/item/ammo_magazine/hardpoint/turret_smoke/incen
	max_clips = 5

	scatter = 3
	gun_firemode = GUN_FIREMODE_BURSTFIRE
	gun_firemode_list = list(
		GUN_FIREMODE_BURSTFIRE,
	)
	burst_amount = 2
	burst_delay = 1.0 SECONDS

/obj/item/hardpoint/support/smoke_launcher/aev/try_fire(atom/target, mob/living/user, params)
	var/turf/L
	var/turf/R
	switch(owner.dir)
		if(NORTH)
			L = locate(owner.x - 2, owner.y + 4, owner.z)
			R = locate(owner.x + 2, owner.y + 4, owner.z)
		if(SOUTH)
			L = locate(owner.x + 2, owner.y - 4, owner.z)
			R = locate(owner.x - 2, owner.y - 4, owner.z)
		if(EAST)
			L = locate(owner.x + 4, owner.y + 2, owner.z)
			R = locate(owner.x + 4, owner.y - 2, owner.z)
		else
			L = locate(owner.x - 4, owner.y + 2, owner.z)
			R = locate(owner.x - 4, owner.y - 2, owner.z)

	if(shots_fired)
		target = R
	else
		target = L

	return ..()
