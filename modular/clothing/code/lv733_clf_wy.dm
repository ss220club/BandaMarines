// CLF-WP - Colonial Liberation Front of WP - survivor

/obj/item/clothing/under/marine/veteran/clf_wy/officer
	name = "\improper Форма лидера CLF-WP"
	desc = "Потрёпанная полевая форма рядового состава Ячейки CLF-WP, собранная из разномастного снаряжения WY."
	icon = 'modular/clothing/icon/clf_wy/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/clf_wy/uniform.dmi',
	)
	icon_state = "clf_wy_officer"
	worn_state = "clf_wy_officer"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/clf_wy/regular
	name = "\improper Форма повстанца CLF-WP"
	desc = "Потрёпанная полевая форма рядового состава Ячейки CLF-WP, собранная из разномастного снаряжения WY."
	icon = 'modular/clothing/icon/clf_wy/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/clf_wy/uniform.dmi',
	)
	icon_state = "clf_wy_regular"
	worn_state = "clf_wy_regular"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/clf_wy/support
	name = "\improper Форма технаря CLF-WP"
	desc = "Рабочая форма технического и медицинского персонала Ячейки CLF-WP, с усиленными карманами под инструмент."
	icon = 'modular/clothing/icon/clf_wy/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/clf_wy/uniform.dmi',
	)
	icon_state = "clf_wy_support"
	worn_state = "clf_wy_support"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Шлемы

/obj/item/clothing/head/helmet/marine/veteran/clf_wy/officer_helmet
	name = "\improper Шлем лидера CLF-WP"
	desc = "Облегчённый шлем командного состава WY, переделаннй под нужды Ячейки CLF-WP."
	icon = 'modular/clothing/icon/clf_wy/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/clf_wy/head.dmi',
	)
	icon_state = "clf_wy_officer_helmet"
	item_state = "clf_wy_officer_helmet"
	item_state_slots = list(
		WEAR_HEAD = "clf_wy_officer_helmet"
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

/obj/item/clothing/head/helmet/marine/veteran/clf_wy/regular_helmet
	name = "\improper Шлем повстанца CLF-WP"
	desc = "Защитный шлем WY, переделаннй под нужды Ячейки CLF-WP."
	icon = 'modular/clothing/icon/clf_wy/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/clf_wy/head.dmi',
	)
	icon_state = "clf_wy_regular_helmet"
	item_state = "clf_wy_regular_helmet"
	item_state_slots = list(
		WEAR_HEAD = "clf_wy_regular_helmet"
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

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/officer_armor
	name = "\improper Бронежилет лидера CLF-WP"
	desc = "Тактический бронежилет командного состава WY, переделаннй под нужды Ячейки CLF-WP."
	icon = 'modular/clothing/icon/clf_wy/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/clf_wy/suit.dmi'
	)
	icon_state = "clf_wy_officer_armor"
	item_state = "clf_wy_officer_armor"
	item_state_slots = list(
		WEAR_JACKET = "clf_wy_officer_armor"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/clf_wy/raincover
	name = "\improper Плащ-палатка CLF-WP"
	desc = "Дождевик из плотной ткани, используемый рядовым составом Ячейки CLF-WP."
	icon = 'modular/clothing/icon/clf_wy/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/clf_wy/suit.dmi'
	)
	icon_state = "clf_raincover"
	item_state = "clf_raincover"
	item_state_slots = list(
		WEAR_JACKET = "clf_raincover"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW

// Гарнитура

/obj/item/device/radio/headset/distress/clf_wy
	name = "CLF-WP гарнитура"
	desc = "Компактная гарнитура закрытой связи, используемая Ячейкой CLF-WP."
	frequency = CLF_WY_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_CLF_WY
	additional_hud_types = list(MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_IMPORTANT
