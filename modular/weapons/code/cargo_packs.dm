/obj/structure/machinery/cm_vending/sorted/cargo_guns/populate_product_list(scale)
	. = ..()
	LAZYINSERT(listed_products, list(list("R4T Scout Rifle", (1), /obj/item/storage/box/guncase/r4t_scout, VENDOR_ITEM_REGULAR)), 13)

/datum/gear/weapon/rmr6
	display_name = "RMR-6 revolver"
	path = /obj/item/storage/box/fluff_gun/rmr6
	slot = WEAR_R_HAND

/obj/item/storage/box/fluff_gun/rmr6
	name = "RMR-6 storing case"
	desc = "A small case containing a RMR-6, a Revolver Manuhrin model 6. It was most likely privately bought by a marine, or specially ordered by an officer."
	can_hold = list(/obj/item/weapon/gun/revolver/rmr6, /obj/item/ammo_magazine/revolver/rmr6)

/obj/item/storage/box/fluff_gun/rmr6/fill_preset_inventory()
	new /obj/item/weapon/gun/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)
	new /obj/item/ammo_magazine/revolver/rmr6(src)


/datum/gear/weapon/pa76
	display_name = "PA76 pistol"
	path = /obj/item/storage/box/fluff_gun/pa76
	slot = WEAR_R_HAND

/obj/item/storage/box/fluff_gun/pa76
	name = "PA76 storing case"
	desc = "A small case containing a PA76, a Pistolete automatique model 76, is a French pistol model made from SACM engineering company."
	can_hold = list(/obj/item/weapon/gun/pistol/pa76, /obj/item/ammo_magazine/pistol/pa76)

/obj/item/storage/box/fluff_gun/pa76/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)
	new /obj/item/ammo_magazine/pistol/pa76(src)


/datum/gear/weapon/l165
	display_name = "L165A1 service pistol"
	path = /obj/item/storage/box/fluff_gun/l165
	slot = WEAR_R_HAND

/obj/item/storage/box/fluff_gun/l165
	name = "L165A1 pistol storing case"
	desc = "A small case containing a L165A1, a service issue pistol to the Royal Marine Commandos. It was most likely given as a reward for service in RMC, or stolen and sold on a black market. Who knows.."
	can_hold = list(/obj/item/weapon/gun/pistol/vp78/rmc, /obj/item/ammo_magazine/pistol/vp78)

/obj/item/storage/box/fluff_gun/l165/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)


/datum/gear/weapon/vp70
	display_name = "VP70 M5 service pistol"
	path = /obj/item/storage/box/fluff_gun/vp70
	slot = WEAR_R_HAND

/obj/item/storage/box/fluff_gun/vp70
	name = "VP70 M5 pistol storing case"
	desc = "A small case containing a VP70 M5 service pistol, a semi-automatic USCM service pistol. This 'Limited' edition comes with stock and some extended magazines. Good deal from generous company."
	can_hold = list(/obj/item/weapon/gun/pistol/mod88/vp70, /obj/item/ammo_magazine/pistol/mod88, /obj/item/attachable/stock/mod88)

/obj/item/storage/box/fluff_gun/vp70/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/mod88/vp70(src)
	new /obj/item/attachable/stock/mod88(src)
	new /obj/item/ammo_magazine/pistol/mod88/normalpoint/extended(src)
	new /obj/item/ammo_magazine/pistol/mod88/normalpoint/extended(src)
	new /obj/item/ammo_magazine/pistol/mod88/normalpoint/extended(src)
	new /obj/item/ammo_magazine/pistol/mod88/normalpoint/extended(src)
	new /obj/item/ammo_magazine/pistol/mod88/normalpoint/extended(src)
