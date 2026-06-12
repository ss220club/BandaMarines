#define MARINE_CAN_BUY_ROAF_GLOWSTICK "roaf_glowstick"

GLOBAL_LIST_INIT(cm_vending_roaf_glowstick, list(
	list("HELMET ACCESSORY (TAKE 1)", 0, null, null, null),
	list("ROAF Glowstick", 0, /obj/item/attachable/flashlight/glowstick/roaf, MARINE_CAN_BUY_ROAF_GLOWSTICK, VENDOR_ITEM_REGULAR),
))

/obj/structure/machinery/cm_vending/proc/get_products_with_roaf_glowstick(mob/user, list/products)
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!(MARINE_CAN_BUY_ROAF_GLOWSTICK in human_user.vendor_buyable_categories))
			human_user.vendor_buyable_categories[MARINE_CAN_BUY_ROAF_GLOWSTICK] = 1

	return products + GLOB.cm_vending_roaf_glowstick

/obj/structure/machinery/cm_vending/clothing/tl/get_listed_products(mob/user)
	return get_products_with_roaf_glowstick(user, GLOB.cm_vending_clothing_tl)

/obj/structure/machinery/cm_vending/clothing/leader/get_listed_products(mob/user)
	return get_products_with_roaf_glowstick(user, GLOB.cm_vending_clothing_leader)

#undef MARINE_CAN_BUY_ROAF_GLOWSTICK
