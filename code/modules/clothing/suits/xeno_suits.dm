/obj/item/clothing/suit/storage/marine/xenos
	name = "drone suit"
	desc = "A suit made to resemble a chitinous alien hide. Who the hell made this, and most importantly, why?..."
	icon_state = "drone_suit"
	item_state = "xenos_suit"
	icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 2

/obj/item/clothing/suit/storage/marine/xenos/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(flags_atom & MAP_COLOR_INDEX)
		return
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/suits/xeno_suits.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/xeno_suits.dmi'

/obj/item/clothing/suit/storage/marine/xenos/runner
	name = "runner suit"
	icon_state = "runner_suit"

/obj/item/clothing/suit/storage/marine/xenos/lesser
	name = "lesser drone suit"
	icon_state = "lesser_drone_suit"

/obj/item/clothing/suit/storage/marine/xenos/ravager
	name = "ravager suit"
	icon_state = "ravager_suit"

/obj/item/clothing/suit/storage/marine/xenos/king
	name = "king suit"
	icon_state = "king_suit"

/obj/item/clothing/suit/storage/marine/xenos/queen
	name = "queen suit"
	icon_state = "queen_suit"

/obj/item/clothing/suit/storage/marine/xenos/burrower
	name = "burrower suit"
	icon_state = "burrower_suit"

/obj/item/clothing/suit/storage/marine/xenos/warrior
	name = "warrior suit"
	icon_state = "warrior_suit"

/obj/item/clothing/suit/storage/marine/xenos/defender
	name = "defender suit"
	icon_state = "defender_suit"
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM
	light_power = 4
	light_range = 5

/obj/item/clothing/suit/storage/marine/xenos/crusher
	name = "crusher suit"
	icon_state = "crusher_suit"

/obj/item/clothing/suit/storage/marine/xenos/carrier
	name = "carrier suit"
	icon_state = "carrier_suit"

/obj/item/clothing/suit/storage/marine/xenos/boiler
	name = "boiler suit"
	icon_state = "boiler_suit"

/obj/item/clothing/suit/storage/marine/xenos/spitter
	name = "spitter suit"
	icon_state = "spitter_suit"

/obj/item/clothing/suit/storage/marine/xenos/sentinel
	name = "sentinel suit"
	icon_state = "sentinel_suit"

/obj/item/clothing/suit/storage/marine/xenos/praetorian
	name = "praetorian suit"
	icon_state = "praetorian_suit"

/obj/item/clothing/suit/storage/marine/xenos/lurker
	name = "lurker suit"
	icon_state = "lurker_suit"

/obj/item/clothing/suit/storage/marine/xenos/hivelord
	name = "hivelord suit"
	icon_state = "hivelord_suit"
