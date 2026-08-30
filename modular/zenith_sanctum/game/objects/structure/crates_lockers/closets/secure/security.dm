/obj/structure/closet/secure_closet/marshal/alt
	icon_state = "secure_alt_locked_warrant"
	icon_closed = "secure_alt_unlocked_warrant"
	icon_locked = "secure_alt_locked_warrant"
	icon_opened = "secure_alt_open_warrant"
	icon_broken = "secure_alt_locked_warrant"
	icon_off = "secure_alt_closed_warrant"

/obj/structure/closet/secure_closet/wy/goon
	icon_state = "secure_alt2_locked_warrant"
	icon_closed = "secure_alt2_unlocked_warrant"
	icon_locked = "secure_alt2_locked_warrant"
	icon_opened = "secure_alt2_open_warrant"
	icon_broken = "secure_alt2_locked_warrant"
	icon_off = "secure_alt2_closed_warrant"

/obj/structure/closet/secure_closet/wy/goon/Initialize()
	. = ..()
	new /obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate(src)
	new /obj/item/clothing/under/marine/veteran/pmc/corporate(src)
	new /obj/item/storage/backpack/lightpack/five_slot(src)
	new /obj/item/storage/belt/gun/m4a3/wy(src)
	new /obj/item/clothing/shoes/marine/corporate(src)

/obj/structure/closet/secure_closet/marshal/alt/Initialize()
	. = ..()
	new /obj/item/clothing/suit/storage/CMB(src)
	new /obj/item/clothing/under/CM_uniform(src)
	new /obj/item/storage/backpack/security(src)
	new /obj/item/storage/belt/security(src)
	new /obj/item/clothing/shoes/jackboots(src)
