/obj/item/weapon/gun/pistol/highpower/aguila
	name = "\improper HG-45 'Aguila' pistol"
	desc = "A semi-automatic Henjin-Garcia design chambered in .45 ACP that is slowly replacing the Office of the Colonial Marshals's Spearhead revolver."
	icon = 'modular/weapons/icons/colony.dmi'
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'

/obj/item/weapon/gun/pistol/highpower/aguila/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/highpower/aguila/black
	name = "\improper HG-45 'Marina' pistol"
	current_mag = /obj/item/ammo_magazine/pistol/highpower/black
	icon_state = "highpower_b"
	item_state = "highpower_b"
	desc = "A semi-automatic Henjin-Garcia design chambered in .45 ACP that is slowly replacing the Office of the Colonial Marshals's Spearhead revolver. Unlike its more common siblings, this variant was marketed and successfully sold in small quantities to the USCM."

/obj/item/weapon/gun/pistol/highpower/aguila/automag
	name = "\improper HG-44 'Automag' pistol"
	desc = "A semi-automatic Henjin-Garcia design chambered in .44 Magnum that was largely discontinued in favour of the HG-45 configuration chambered in .45 ACP."
	current_mag = /obj/item/ammo_magazine/pistol/highpower/automag
	icon_state = "highpower_tac"
	item_state = "highpower_tac"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED

/obj/item/weapon/gun/pistol/highpower/aguila/automag/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_3

/obj/item/weapon/gun/pistol/highpower/aguila/automag/tactical
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED

//PA76 Pistol
/obj/item/weapon/gun/pistol/pa76
	name = "\improper PA76 pistol"
	desc = "Pistolete automatique model 76, is a French pistol model made from SACM engineering company. A rather bit archaic but reliable pistol that is chambered in 7.65mm longue."
	icon = 'modular/weapons/icons/colony.dmi'
	icon_state = "pa76"
	item_state = "pa76"
	fire_sound = "vp70"
	current_mag = /obj/item/ammo_magazine/pistol/pa76
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/pistol/pa76/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 19, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/pa76/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_1
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/pa76/ap
	current_mag = /obj/item/ammo_magazine/pistol/pa76/ap


/obj/item/weapon/gun/pistol/vp78/rmc
	name = "\improper L165A1 service pistol"
	desc = "Service issue pistol to the Royal Marine Commandos. A sleek, modern, semi-automatic handgun specifically designed to chamber specialized 9x19mm explosive squash-head rounds. Based on a Beretta Arms patented design, this Weyland-Yutani modification has earned its place in the hands of the Three World Empire's best soldiers. Can load normal VP78 magazines with no issue too."
	icon = 'modular/weapons/icons/uscm.dmi'
	icon_state = "vp78"
	item_state = "vp78"
	current_mag = /obj/item/ammo_magazine/pistol/vp78/rmc

/obj/item/weapon/gun/pistol/vp78/rmc/unloaded
	current_mag = null

/obj/item/weapon/gun/pistol/mod88/vp70
	name = "\improper VP70 M5 service pistol"
	desc = "Standard issue semi-automatic USCM service pistol. Recently replacing the M4A3, it retains its predecessor's 9mm chambering but offers both a higher magazine capacity and a 3-round burst selector."
	icon = 'modular/weapons/icons/uscm.dmi'
	icon_state = "vp70"
	item_state = "vp70"

/obj/item/weapon/gun/pistol/mod88/vp70/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT //+ BULLET_DAMAGE_MULT_TIER_4

/obj/item/weapon/gun/pistol/mod88/vp70/unloaded
	current_mag = null

/obj/item/weapon/gun/pistol/mod88/vp70/training
	current_mag = /obj/item/ammo_magazine/pistol/mod88/rubber


/obj/item/weapon/gun/revolver/rmr6
	name = "\improper RMR-6 revolver"
	desc = "Revolver Manuhrin model 6 a rather more interesting design by Manuhrin the only one who made revolvers. This one is used by both military and police forces for it's powerful force, versatibility, and tradition. Chambered in .357 magnum."
	icon = 'modular/weapons/icons/colony.dmi'
	icon_state = "rmr6"
	item_state = "rmr6"
	fire_sound = null
	fire_sounds = list('sound/weapons/gun_cmb_1.ogg', 'sound/weapons/gun_cmb_2.ogg')
	reload_sound = 'sound/weapons/handling/pkd_speed_load.ogg'
	cocked_sound = 'sound/weapons/handling/pkd_cock.wav'
	unload_sound = 'sound/weapons/handling/pkd_open_chamber.ogg'
	chamber_close_sound = 'sound/weapons/handling/pkd_close_chamber.ogg'
	hand_reload_sound = 'sound/weapons/gun_revolver_load3.ogg'
	current_mag = /obj/item/ammo_magazine/internal/revolver/rmr6
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/bipod,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/revolver/rmr6/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 21,"rail_x" = 14, "rail_y" = 23, "under_x" = 21, "under_y" = 19, "stock_x" = 24, "stock_y" = 19, "side_rail_x" = 19, "side_rail_y" = 17)

/obj/item/weapon/gun/revolver/rmr6/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil = 0
	recoil_unwielded = 0
