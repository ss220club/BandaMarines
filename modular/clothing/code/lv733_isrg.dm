// ISRG - Imperial Search and Recovery Group

/obj/item/clothing/under/marine/veteran/isrg/dress
	name = "\improper Парадная форма ISRG"
	desc = "Усиленная форма командного состава ISRG, используется для координации поисковой группы."
	icon = 'modular/clothing/icon/isrg/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/isrg/uniform.dmi',
	)
	icon_state = "isrg_uniform"
	worn_state = "isrg_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/isrg/field
	name = "\improper Полевая форма ISRG"
	desc = "Практичная полевая форма состава поисковой группы ISRG."
	icon = 'modular/clothing/icon/isrg/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/isrg/uniform.dmi',
	)
	icon_state = "isrg_support"
	worn_state = "isrg_support"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Головные уборы

/obj/item/clothing/head/beret/isrg/dress
	name = "\improper Берет ISRG"
	desc = "Берет с эмблемой ISRG."
	icon = 'modular/clothing/icon/isrg/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/isrg/head.dmi',
	)
	icon_state = "isrg_beret"
	item_state = "isrg_beret"
	item_state_slots = list(
		WEAR_HEAD = "isrg_beret"
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

/obj/item/clothing/head/helmet/marine/veteran/isrg/field_helmet
	name = "\improper Шлем ISRG"
	desc = "Полевой шлем поисковой группы ISRG."
	icon = 'modular/clothing/icon/isrg/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/isrg/head.dmi',
	)
	icon_state = "isrg_helmet"
	item_state = "isrg_helmet"
	item_state_slots = list(
		WEAR_HEAD = "isrg_helmet"
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
	built_in_visors = list(new /obj/item/device/helmet_visor)

// Верхняя одежда

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/dress
	name = "\improper Китель ISRG"
	desc = "Китель командного состава ISRG."
	icon = 'modular/clothing/icon/isrg/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/isrg/suit.dmi'
	)
	icon_state = "isrg_jacket"
	item_state = "isrg_jacket"
	item_state_slots = list(
		WEAR_JACKET = "isrg_jacket"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest
	name = "\improper Разгрузочный жилет ISRG"
	desc = "Практичный разгрузочный жилет поисковой группы ISRG."
	icon = 'modular/clothing/icon/isrg/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/isrg/suit.dmi'
	)
	icon_state = "isrg_west"
	item_state = "isrg_west"
	item_state_slots = list(
		WEAR_JACKET = "isrg_west"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW

	light_power = 3
	light_range = 3
	light_color = LIGHT_COLOR_HALOGEN
	light_system = MOVABLE_LIGHT
	actions_types = list(/datum/action/item_action/toggle/lamp)
	var/list/armor_overlays = list()
	var/flags_isrg_lamp = ARMOR_LAMP_OVERLAY
	var/lamp_icon = "lamp"
	var/lamp_light_color = LIGHT_COLOR_HALOGEN
	var/atom/movable/marine_light/light_holder

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/Initialize(mapload)
	. = ..()
	light_holder = new(src)
	update_icon()

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/Destroy()
	QDEL_NULL(light_holder)
	return ..()

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/update_icon(mob/user)
	overlays -= armor_overlays["lamp"]
	armor_overlays["lamp"] = null
	if(flags_isrg_lamp & ARMOR_LAMP_OVERLAY)
		var/image/I
		if(flags_isrg_lamp & ARMOR_LAMP_ON)
			I = image('icons/obj/items/clothing/suits/misc_ert.dmi', src, "[lamp_icon]-on")
		else
			I = image('icons/obj/items/clothing/suits/misc_ert.dmi', src, "[lamp_icon]-off")
		armor_overlays["lamp"] = I
		overlays += I
	if(user)
		user.update_inv_wear_suit()

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != WEAR_JACKET)
		return FALSE
	return TRUE

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/attack_self(mob/user)
	..()
	if(!isturf(user.loc))
		to_chat(user, SPAN_WARNING("You cannot turn the light [light_on ? "off" : "on"] while in [user.loc].")) //To prevent some lighting anomalies.
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return
	turn_light(user, !light_on)

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/isrg/vest/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_range(initial(light_range))
	set_light_power(floor(initial(light_power) * 0.5))
	set_light_color(lamp_light_color)
	set_light_on(toggle_on)
	flags_isrg_lamp ^= ARMOR_LAMP_ON

	light_holder.set_light_flags(LIGHT_ATTACHED)
	light_holder.set_light_range(initial(light_range))
	light_holder.set_light_power(initial(light_power))
	light_holder.set_light_color(initial(light_color))
	light_holder.set_light_on(toggle_on)

	if(!toggle_on)
		playsound(src, 'sound/handling/click_2.ogg', 50, 1)
	playsound(src, 'sound/handling/suitlight_on.ogg', 50, 1)
	update_icon(user)

	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()

// Маски

/obj/item/clothing/mask/balaclava/isrg
	name = "\improper Балаклава ISRG"
	desc = "Тканевая балаклава."
	icon = 'modular/clothing/icon/isrg/balaklava.dmi'
	item_icons = list(
		WEAR_FACE = 'modular/clothing/onmob/isrg/balaklava.dmi'
	)
	icon_state = "isrg_mask"
	item_state = "isrg_mask"
	item_state_slots = list(
		WEAR_FACE = "isrg_mask"
	)

/obj/item/clothing/mask/gas/isrg
	name = "\improper Противогаз ISRG"
	desc = "Защитный противогаз, часть стандартного снаряжения ISRG."
	icon = 'modular/clothing/icon/isrg/balaklava.dmi'
	item_icons = list(
		WEAR_FACE = 'modular/clothing/onmob/isrg/balaklava.dmi'
	)
	icon_state = "isrg_gasmask"
	item_state = "isrg_gasmask"
	item_state_slots = list(
		WEAR_FACE = "isrg_gasmask"
	)

// Пояс (база и наполнение - как у WY Security)

/obj/item/storage/belt/security/MP/full/isrg
	name = "\improper Пояс ISRG"
	desc = "Тактический пояс поисковой группы ISRG."
	icon = 'modular/clothing/icon/isrg/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'modular/clothing/onmob/isrg/belts.dmi'
	)
	icon_state = "isrg_belt"
	item_state = "isrg_belt"
	item_state_slots = list(
		WEAR_WAIST = "isrg_belt"
	)

// Пояс рядового состава - 2 магазина Mirai-7 (максимум) + медикаменты (база - как у стандартного медицинского пояса)

/obj/item/storage/belt/medical/isrg
	name = "\improper Пояс ISRG"
	desc = "Тактический пояс поисковой группы ISRG, совмещающий подсумок под магазины Mirai-7 и медицинские принадлежности."
	icon = 'modular/clothing/icon/isrg/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'modular/clothing/onmob/isrg/belts.dmi'
	)
	icon_state = "isrg_belt"
	item_state = "isrg_belt"
	item_state_slots = list(
		WEAR_WAIST = "isrg_belt"
	)
	storage_slots = 6
	max_storage_space = 16
	var/max_mirai7_mags = 2
	can_hold = list(
		/obj/item/ammo_magazine/smg/mirai7,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/smg/mirai7,
	)

/obj/item/storage/belt/medical/isrg/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE)
	if(istype(W, /obj/item/ammo_magazine/smg/mirai7))
		var/current_mags = 0
		for(var/obj/item/ammo_magazine/smg/mirai7/mag in contents)
			current_mags++
		if(current_mags >= max_mirai7_mags)
			if(!stop_messages)
				to_chat(user, SPAN_WARNING("В [declent_ru(PREPOSITIONAL)] уже максимум магазинов."))
			return FALSE
	return ..()

/obj/item/storage/belt/medical/isrg/full/fill_preset_inventory()
	new /obj/item/ammo_magazine/smg/mirai7(src)
	new /obj/item/ammo_magazine/smg/mirai7(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)

// Пояс смартганнера - пистолет + барабанные магазины Т3 «Райко»

/obj/item/storage/belt/gun/smartgunner/isrg
	name = "\improper Пояс ISRG"
	desc = "Тактический пояс поисковой группы ISRG для переноски пистолета и барабанных магазинов Т3 «Райко»."
	icon = 'modular/clothing/icon/isrg/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'modular/clothing/onmob/isrg/belts.dmi'
	)
	icon_state = "isrg_belt"
	item_state = "isrg_belt"
	item_state_slots = list(
		WEAR_WAIST = "isrg_belt"
	)

/obj/item/storage/belt/gun/smartgunner/isrg/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m4a3())
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/smartgun/isrg(src)
	new /obj/item/ammo_magazine/smartgun/isrg(src)

// Рюкзак

/obj/item/storage/backpack/satchel/sec/isrg
	name = "\improper Рюкзак ISRG"
	desc = "Лёгкий тактический рюкзак поисковой группы ISRG."
	icon = 'modular/clothing/icon/isrg/backpack.dmi'
	item_icons = list(
		WEAR_BACK = 'modular/clothing/onmob/isrg/backpack.dmi'
	)
	icon_state = "isrg_backpack"
	item_state = "isrg_backpack"
	item_state_slots = list(
		WEAR_BACK = "isrg_backpack"
	)

/obj/item/storage/backpack/marine/k9_synth/medicalpack/isrg
	name = "\improper M210-I portable K9 medical backpack"
	desc = "Медицинская упряжь K9 поисковой группы ISRG, приспособленная для переноски медикаментов."
	icon = 'modular/lv733/icons/isrg_k9/isrg_k9_pack.dmi'
	icon_override = 'modular/lv733/icons/isrg_k9/isrg_k9_pack.dmi'
	icon_state = "isrg_medicalpack"

// Гарнитура

/obj/item/device/radio/headset/distress/isrg
	name = "ISRG гарнитура"
	desc = "Компактная гарнитура закрытой связи, используемая поисковой группой ISRG."
	frequency = ISRG_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_ISRG
	additional_hud_types = list(MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_IMPORTANT
