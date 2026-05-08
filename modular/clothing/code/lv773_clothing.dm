// ROAF - survior
// Униформа

/obj/item/clothing/uniform/lv773/roaf_pilot
	name = "\improper костюм пилота ROAF"
	desc = "A pair of grey slacks and a white button-down shirt with a dark-grey tie and golden epaulettes signifying rank; a standard uniform for a commercial grade Weyland-Yutani affiliated Pilot."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/suit.dmi',
	)
	icon_state = "uniform_pilot"
	worn_state = "uniform_pilot"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/uniform/lv773/roaf_sniper
	name = "\improper комбинезон снайпера ROAF"
	desc = "A pair of grey slacks and a white button-down shirt with a dark-grey tie and golden epaulettes signifying rank; a standard uniform for a commercial grade Weyland-Yutani affiliated Pilot."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/suit.dmi',
	)
	icon_state = "uniform_sniper"
	worn_state = "uniform_sniper"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Шляпы

/obj/item/clothing/head/lv773/head_roaf_pilot
	name = "\improper фуражка пилота ROAF"
	desc = "A dark cap inscribed with the powerful letters of 'MARSHAL' representing justice, authority, and protection in the outer rim. The laws of the Earth stretch beyond the Sol."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
	)
	icon_state = "head_roaf_pilot"
	item_state = "head_roaf_pilot"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/lv773/head_roaf_hat
	name = "\improper панама ROAF"
	desc = "A dark cap inscribed with the powerful letters of 'MARSHAL' representing justice, authority, and protection in the outer rim. The laws of the Earth stretch beyond the Sol."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
	)
	icon_state = "head_roaf_hat"
	item_state = "head_roaf_hat"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

// Верхняя одежда

/obj/item/clothing/suit/armor/vest/lv773/suit_roaf
	name = "\improper куртка ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "suit_roaf"
	item_state = "suit_roaf"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/armor/vest/lv773/suit_roaf_pilot
	name = "\improper куртка пилота ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "suit_roaf_pilot"
	item_state = "suit_roaf_pilot"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

// Перчатки

/obj/item/clothing/gloves/marine/veteran/lv773/hands_roaf
	name = "\improper перчатки ROAF"
	desc = "Non-standard kevlon fiber gloves. They're insulated and heavily armored."
	icon = 'modular/clothing/icon/roaf/hands.dmi'
	item_icons = list(
		WEAR_HANDS = 'modular/clothing/onmob/roaf/hands.dmi'
	)
	icon_state = "hands_roaf"
	item_state = "hands_roaf"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	adopts_squad_color = FALSE

// Рюкзак

/obj/item/storage/backpack/marine/smock/lv773/hands_roaf
	name = "\improper пончо снайпера ROAF"
	desc = "A specially-designed smock with pockets for all your sniper needs."
	icon = 'modular/clothing/icon/roaf/backpack.dmi'
	item_icons = list(
		WEAR_BACK = 'modular/clothing/onmob/roaf/backpack.dmi'
	)
	icon_state = "backpack_roaf_sniper"
	item_state = "backpack_roaf_sniper"
	worn_accessible = TRUE
	xeno_types = null

// Обувь

/obj/item/clothing/shoes/marine/lv773/shoes_roaf
	name = "\improper сапоги ROAF"
	desc = "Standard issue combat boots for combat scenarios or combat situations. Used by the three world empires royal marines commando units."
	icon = 'modular/clothing/icon/roaf/shoes.dmi'
	item_icons = list(
		WEAR_FEET = 'modular/clothing/onmob/roaf/shoes.dmi'
	)
	icon_state = "shoes_roaf"
	item_state = "shoes_roaf"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
	)
	flags_atom = NO_NAME_OVERRIDE

/obj/item/clothing/shoes/marine/lv773/shoes_roaf_pilot
	name = "\improper сапоги пилота ROAF"
	desc = "Standard issue combat boots for combat scenarios or combat situations. Used by the three world empires royal marines commando units."
	icon = 'modular/clothing/icon/roaf/shoes.dmi'
	item_icons = list(
		WEAR_FEET = 'modular/clothing/onmob/roaf/shoes.dmi'
	)
	icon_state = "shoes_roaf_pilot"
	item_state = "shoes_roaf_pilot"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
	)
	flags_atom = NO_NAME_OVERRIDE

// Гарнитура

/obj/item/device/radio/headset/distress/roaf
	name = "ROAF Headset"
	desc = "A sleek headset used by the IASF. Low profile enough to fit under any headgear."
	frequency = RMC_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_ROAF
	additional_hud_types = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_ROAF, MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_IMPORTANT
