/obj/item/clothing/under/marine/veteran/imperial_guard
	name = "Imperial Guard Uniform"
	desc = "You are in the Guard now, Son."
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	icon = 'modular/ert/icons/clothing/item/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/ert/icons/clothing/mob/uniform_mob.dmi',
	)
	icon_state = "guard_old"
	worn_state = "guard_s"
	specialty = "imperial guard uniform"
	flags_item = NO_GAMEMODE_SKIN

/obj/item/clothing/suit/storage/marine/veteran/imperial_guard
	name = "flak-armor"
	desc = "You are in the Guard now, Son."
	icon_state = "fharmor"
	icon = 'modular/ert/icons/clothing/item/suits.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/ert/icons/clothing/mob/suits_mob.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	unacidable = TRUE
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN
	storage_slots = 4

/obj/item/clothing/shoes/marine/imperial_guard
	name = "flakboots"
	icon = 'modular/ert/icons/clothing/item/shoes.dmi'
	icon_state = "flakboots"
	item_icons = list(
		WEAR_FEET = 'modular/ert/icons/clothing/mob/shoes_mob2.dmi',
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/head/helmet/marine/imperial_guard
	name = "flakhelmet"
	desc = "You are in the Guard now, Son."
	icon_state = "flakhelmet"
	icon = 'modular/ert/icons/clothing/item/helmets.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/ert/icons/clothing/mob/helmets_mob.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	specialty = "flak-helmet"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/specialist/spacemarine
	name = "Ultramarine power armor"
	desc = "A heavy, rugged set of armor plates for when you really, really need to not die horribly. Slows you down though.\nComes with two injectors in each arm guard."
	icon = 'modular/ert/icons/clothing/item/suits.dmi'
	icon_state = "umpowerarmor"
	item_icons = list(
		WEAR_JACKET = 'modular/ert/icons/clothing/mob/suits_mob.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	storage_slots = 0
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	specialty = "Ultramarine power armor"
	unacidable = TRUE
	flags_atom = NOINTERACT|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/head/helmet/marine/imperial_guard/spacemarine
	name = "Ultramarine power armor helmet"
	desc = "For The Emperor!"
	icon_state = "um_helmet"
	flags_armor_protection = BODY_FLAG_EYES|BODY_FLAG_HEAD|BODY_FLAG_FACE
	flags_cold_protection = BODY_FLAG_EYES|BODY_FLAG_HEAD|BODY_FLAG_FACE
	flags_heat_protection = BODY_FLAG_EYES|BODY_FLAG_HEAD|BODY_FLAG_FACE
	flags_bodypart_hidden = BODY_FLAG_EYES|BODY_FLAG_HEAD|BODY_FLAG_FACE
	flags_inventory = BLOCKSHARPOBJ
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH

/obj/item/clothing/shoes/marine/imperial_guard/spacemarine
	name = "Ultramarine power armour boots"
	desc = "For The Emperor!"
	icon_state = "um_marine"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_bodypart_hidden = BODY_FLAG_FEET
	flags_atom = NOINTERACT|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
