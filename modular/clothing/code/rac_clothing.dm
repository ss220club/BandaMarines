// RAC - Royal Armored Cavalry

// Униформа

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_tanker
	name = "\improper Форма танкиста RAC"
	desc = "Комбинезон танкового экипажа Royal Armored Cavalry. Плотная ткань устойчива к маслу и гари."
	icon = 'modular/clothing/icon/rac/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/uniform.dmi',
	)
	icon_state = "uniform_tank"
	worn_state = "uniform_tank"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_technician
	name = "\improper Техническая форма RAC"
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

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/rac_regular
	name = "\improper Полевая форма RAC"
	desc = "Полевая форма мотопехоты Royal Armored Cavalry, сопровождающей танковые звенья."
	icon = 'modular/clothing/icon/rac/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/uniform.dmi',
	)
	icon_state = "uniform_regular"
	worn_state = "uniform_regular"
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
	desc = "Мягкий танковый шлем экипажа Royal Armored Cavalry."
	icon = 'modular/clothing/icon/rac/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/rac/head.dmi',
	)
	icon_state = "icon_tank"
	item_state = "head_tank"
	item_state_slots = list(
		WEAR_HEAD = "head_tank"
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
	name = "\improper Жилет инженера RAC"
	desc = "Разгрузочный жилет технического экипажа Royal Armored Cavalry."
	icon = 'modular/clothing/icon/rac/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/rac/suit.dmi'
	)
	icon_state = "icon_eng"
	item_state = "suit_eng"
	item_state_slots = list(
		WEAR_JACKET = "suit_eng"
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
	// Встроенный фонарь, как на броне морпехов
	light_power = 3
	light_range = 4
	light_color = LIGHT_COLOR_TUNGSTEN
	light_system = MOVABLE_LIGHT
	actions_types = list(/datum/action/item_action/toggle/lamp/rac)
	var/lamp_icon = "lamp"
	var/lamp_light_color = LIGHT_COLOR_TUNGSTEN
	var/lamp_overlay_icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	var/image/lamp_overlay

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/attack_self(mob/user)
	..()
	if(!isturf(user.loc))
		to_chat(user, SPAN_WARNING("Нельзя переключить свет, находясь в [user.loc]."))
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return
	turn_light(user, !light_on)

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != WEAR_JACKET)
		return FALSE
	return TRUE

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_range(initial(light_range))
	set_light_power(floor(initial(light_power) * 0.5))
	set_light_color(lamp_light_color)
	set_light_on(toggle_on)
	playsound(src, 'sound/handling/suitlight_on.ogg', 50, 1)
	update_icon(user)
	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/update_icon(mob/user)
	overlays -= lamp_overlay
	lamp_overlay = image(lamp_overlay_icon, src, "[lamp_icon]-[light_on ? "on" : "off"]")
	overlays += lamp_overlay
	if(user)
		user.update_inv_wear_suit()

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_vest/medic
	name = "\improper Жилет медика RAC"
	desc = "Медицинский разгрузочный жилет Royal Armored Cavalry."
	icon_state = "icon_med"
	item_state = "suit_med"
	item_state_slots = list(
		WEAR_JACKET = "suit_med"
	)

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/rac_jacket
	name = "\improper Куртка танкиста RAC"
	desc = "Утеплённая куртка танкового экипажа Royal Armored Cavalry."
	icon = 'modular/clothing/icon/rac/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/rac/suit.dmi'
	)
	icon_state = "icon_tank"
	item_state = "suit_tank"
	item_state_slots = list(
		WEAR_JACKET = "suit_tank"
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

// Полноценная броня RMC для группы реагирования (ERT) RAC - настоящая вместимость карманов, не сурв-жилет
/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert
	name = "\improper Жилет RAC"
	desc = "Разгрузочный жилет группы реагирования Royal Armored Cavalry на базе брони RMC."
	icon = 'modular/clothing/icon/rac/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/rac/suit.dmi'
	)
	icon_state = "icon_eng"
	item_state = "suit_eng"
	item_state_slots = list(
		WEAR_JACKET = "suit_eng"
	)

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/wy)
	AddElement(/datum/element/corp_label/armat)

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert/medic
	name = "\improper Жилет медика RAC"
	desc = "Медицинский разгрузочный жилет группы реагирования Royal Armored Cavalry на базе брони RMC."
	icon_state = "icon_med"
	item_state = "suit_med"
	item_state_slots = list(
		WEAR_JACKET = "suit_med"
	)

/obj/item/clothing/accessory/poncho/rac
	name = "\improper Пончо мотопехоты RAC"
	desc = "Плащ-пончо мотопехотинцев."
	icon = 'modular/clothing/icon/rac/ponchos.dmi'
	icon_state = "w_poncho"
	inv_overlay_icon = 'modular/clothing/icon/rac/ponchos.dmi'
	accessory_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/rac/ponchos.dmi',
		WEAR_JACKET = 'modular/clothing/onmob/rac/ponchos.dmi',
	)

// Чехол на шлем

/obj/item/clothing/accessory/helmet/cover/rac
	name = "\improper Чехол на шлем RAC"
	desc = "Сетчатый чехол на шлем ТШЕ, скрывающий блики."
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

// Кнопка фонаря на жилете RAC (без привязки к типу брони морпехов)

/datum/action/item_action/toggle/lamp/rac/update_button_icon()
	var/obj/item/I = holder_item
	if(!I.light_on)
		action_icon_state = "armor_light"
	else
		action_icon_state = "armor_light_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)
