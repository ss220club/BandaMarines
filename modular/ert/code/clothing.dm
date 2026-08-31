/obj/item/clothing/under/marine/veteran/imperial_guard
	name = "Imperial Guard Uniform"
	desc = "You are in the Guard now, Son."
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
	flags_atom = NO_CRYO_STORE|NO_GAMEMODE_SKIN
	storage_slots = 3

/obj/item/clothing/shoes/marine/imperial_guard
	name = "flakboots"
	icon = 'modular/ert/icons/clothing/item/shoes.dmi'
	icon_state = "flakboots"
	item_icons = list(
		WEAR_FEET = 'modular/ert/icons/clothing/mob/shoes_mob.dmi',
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	spawn_item_type = /obj/item/attachable/bayonet/rmc

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

//Commissar
/obj/item/clothing/suit/storage/marine/veteran/imperial_guard/commissar
	name = "commissar trenchcoat"
	desc = "For The Emperor!"
	icon_state = "commissar"
	icon = 'modular/ert/icons/clothing/item/suits.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/ert/icons/clothing/mob/suits_mob.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	unacidable = TRUE
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	storage_slots = 3

/obj/item/clothing/head/helmet/marine/imperial_guard/commissar
	name = "commissar cap"
	desc = "For The Emperor!"
	icon_state = "commissar"
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
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/gloves/marine/veteran/imperial_guard
	name = "combat gloves"
	desc = "For The Emperor!"
	icon_state = "combat_gloves"
	item_state = "combat_gloves"
	icon = 'modular/ert/icons/clothing/item/gloves.dmi'
	item_icons = list(
		WEAR_HANDS = 'modular/ert/icons/clothing/mob/gloves_mob.dmi'
	)
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	unacidable = TRUE
	siemens_coefficient = 0
	adopts_squad_color = FALSE

//Techpriest
/obj/item/clothing/suit/storage/marine/veteran/imperial_guard/techpriest
	name = "techpriest robes"
	desc = "Praise be Omnissiah."
	icon_state = "techpriest"
	icon = 'modular/ert/icons/clothing/item/suits.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/ert/icons/clothing/mob/suits_mob.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	unacidable = TRUE
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	storage_slots = 4
	flags_inventory = CANTSTRIP
	flags_item = NODROP

/obj/item/clothing/head/helmet/marine/imperial_guard/techpriest
	name = "techpriest robe hood"
	desc = "Praise be Omnissiah."
	icon_state = "techpriest"
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
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_inventory = CANTSTRIP
	flags_item = NODROP

/obj/item/clothing/mask/gas/techpriest
	name = "techpriest mask"
	desc = "Praise be Omnissiah."
	item_state = "techpriest"
	icon_state = "techpriest"
	icon = 'modular/ert/icons/clothing/item/mask.dmi'
	item_icons = list(
		WEAR_FACE = 'modular/ert/icons/clothing/mob/mask_mob.dmi'
	)
	vision_impair = VISION_IMPAIR_NONE
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_NONE
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDEALLHAIR
	flags_equip_slot = SLOT_FACE
	flags_inventory = CANTSTRIP|COVEREYES|COVERMOUTH|ALLOWINTERNALS|ALLOWREBREATH|BLOCKGASEFFECT|ALLOWCPR|BLOCKSHARPOBJ
	flags_item = NODROP
	eye_protection = EYE_PROTECTION_WELDING

/obj/item/clothing/gloves/marine/veteran/techpriest
	name = "techpriest gloves"
	desc = "Praise be Omnissiah."
	icon_state = "combat_gloves"
	item_state = "combat_gloves"
	icon = 'modular/ert/icons/clothing/item/gloves.dmi'
	item_icons = list(
		WEAR_HANDS = 'modular/ert/icons/clothing/mob/gloves_mob.dmi'
	)
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	unacidable = TRUE
	siemens_coefficient = 0
	adopts_squad_color = FALSE

//Power Armor
/obj/item/clothing/suit/storage/marine/specialist/spacemarine
	name = "Ultramarine power armor"
	desc = "For The Emperor!"
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
	storage_slots = 3
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	specialty = "Ultramarine power armor"
	unacidable = TRUE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_item = NODROP
	flags_inventory = CANTSTRIP

/obj/item/clothing/suit/storage/marine/specialist/spacemarine/cap
	name = "Ultramarine Captain power armor"
	icon_state = "umpowerarmorcap"
	specialty = "Ultramarine Captain power armor"

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
	eye_protection = EYE_PROTECTION_WELDING
	built_in_visors = list(new /obj/item/device/helmet_visor/leader, new /obj/item/device/helmet_visor/medical/advanced)

/obj/item/clothing/head/helmet/marine/imperial_guard/spacemarine/cap
	name = "Ultramarine Captain power armor helmet"
	icon_state = "um_helmet_cap"

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
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_inventory = CANTSTRIP
	flags_item = NODROP

/obj/item/storage/backpack/marine/spacemarine
	name = "Ultramarine power armour pack"
	desc = "For The Emperor!"
	icon_state = "tacrucksack"
	icon = 'icons/obj/items/clothing/backpack/backpacks_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BACK = 'modular/ert/icons/clothing/mob/back_mob.dmi'
	)
	item_state_slots = list(
		WEAR_BACK = "um_back",
	)
	worn_accessible = FALSE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	xeno_types = null
	flags_item = NODROP
