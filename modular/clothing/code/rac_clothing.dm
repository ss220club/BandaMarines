// RAC - Royal Armored Cavalry

// Униформа

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_tanker
	name = "\improper Форма танкиста RAC"
	desc = "Комбинезон танкового экипажа Royal Armored Cavalry. Плотная ткань устойчива к маслу и гари."
	icon = 'modular/clothing/icon/rac/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/uniform.dmi',
	)
	icon_state = "uniform_classic"
	worn_state = "uniform_classic"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_technician
	name = "\improper Форма техника RAC"
	desc = "Рабочая форма технического персонала Royal Armored Cavalry, обслуживающего бронетехнику."
	icon = 'modular/clothing/icon/rac/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/uniform.dmi',
	)
	icon_state = "uniform_support"
	worn_state = "uniform_support"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_rifleman
	name = "\improper Полевая форма стрелка RAC"
	desc = "Полевая форма мотопехоты Royal Armored Cavalry, сопровождающей танковые звенья."
	icon = 'modular/clothing/icon/rac/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/uniform.dmi',
	)
	icon_state = "uniform_shooter"
	worn_state = "uniform_shooter"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Шлем/берет

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/lv733/rac_tank_helmet
	name = "\improper Танковый шлем RAC"
	desc = "Мягкий танковый шлем экипажа Royal Armored Cavalry со встроенной гарнитурой связи."
	icon = 'modular/clothing/icon/rac/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/rac/head.dmi',
	)
	icon_state = "icon_shooter"
	item_state = "head_shooter"
	item_state_slots = list(
		WEAR_HEAD = "head_shooter"
	)

/obj/item/clothing/head/helmet/marine/veteran/lv733/rac_beret
	name = "\improper Берет танкиста RAC"
	desc = "Чёрный берет танковых экипажей Royal Armored Cavalry с эмблемой звена."
	icon = 'modular/clothing/icon/rac/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/rac/head.dmi',
	)
	icon_state = "icon_beret"
	item_state = "head_beret"
	item_state_slots = list(
		WEAR_HEAD = "head_beret"
	)
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT

// Верхняя одежда

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest
	name = "\improper Жилет танкиста RAC"
	desc = "Разгрузочный жилет танкового экипажа Royal Armored Cavalry."
	icon = 'modular/clothing/icon/rac/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/rac/suit.dmi'
	)
	icon_state = "icon_shooter"
	item_state = "suit_shooter"
	item_state_slots = list(
		WEAR_JACKET = "suit_shooter"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_jacket
	name = "\improper Куртка танкиста RAC"
	desc = "Утеплённая куртка танкового экипажа Royal Armored Cavalry."
	icon = 'modular/clothing/icon/rac/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/rac/suit.dmi'
	)
	icon_state = "icon_jacket"
	item_state = "suit_jacket"
	item_state_slots = list(
		WEAR_JACKET = "suit_jacket"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/poncho/rac
	name = "\improper Пончо мотопехоты RAC"
	desc = "Плащ-пончо мотопехотинцев Royal Armored Cavalry."
	icon_state = "classicponcho"

// Чехол на шлем

/obj/item/clothing/accessory/helmet/cover/rac
	name = "\improper Чехол на шлем RAC"
	desc = "Матерчатый чехол на танковый шлем Royal Armored Cavalry, скрывающий блики на броне."
	icon = 'modular/clothing/icon/rac/helmet_cover.dmi'
	icon_state = "rac_helmet_cover"
	accessory_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/rac/helmet_cover.dmi',
	)
	item_icons = list(
		WEAR_AS_GARB = 'modular/clothing/onmob/rac/helmet_cover.dmi',
	)
	item_state_slots = list(
		WEAR_HEAD = "rac_helmet_cover",
		WEAR_AS_GARB = "rac_helmet_cover",
	)
