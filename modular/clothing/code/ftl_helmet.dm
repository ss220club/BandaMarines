#define FTL_HELMET_ICON 'modular/clothing/icon/ftl_helmet.dmi'
#define FTL_HELMET_ONMOB_ICON 'modular/clothing/onmob/head/ftl_helmet.dmi'

/obj/item/clothing/head/helmet/marine/rto/ftl
	name = "m12 closed pattern dust helmet"
	icon = FTL_HELMET_ICON
	icon_state = "ftl_jungle"
	specialty = "M12 pattern fireteam leader"
	item_icons = list(
		WEAR_HEAD = FTL_HELMET_ONMOB_ICON,
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/rto/ftl/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(type != expected_type)
		return FALSE

	icon = FTL_HELMET_ICON
	item_icons[WEAR_HEAD] = FTL_HELMET_ONMOB_ICON

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			icon_state = "ftl_snow"
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			icon_state = "ftl_desert"
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			icon_state = "ftl_classic"
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		else
			icon_state = "ftl_urban"
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

	return TRUE

#undef FTL_HELMET_ICON
#undef FTL_HELMET_ONMOB_ICON
