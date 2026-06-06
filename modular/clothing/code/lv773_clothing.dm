// ROAF - survior
// Униформа

#define ROAF_FREQ 1217
#define RADIO_CHANNEL_ROAF "ROAF"

/datum/controller/subsystem/radio/Initialize(start_timeofday)
	. = ..()
	GLOB.radiochannels[RADIO_CHANNEL_ROAF] = ROAF_FREQ

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_pilot
	name = "\improper комбинезон пилота ROAF"
	desc = "A multifunctional pilot jumpsuit with a bluish tint, designed for both space and aerial operations. The jumpsuit is equipped with a safety harness."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_pilot"
	worn_state = "uniform_pilot"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_sniper
	name = "\improper комбинезон оператора ROAF"
	desc = "A multifunctional jumpsuit with numerous pockets and attachment points. It has a gray-beige tone and is often used for raids and combat operations."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_sniper"
	worn_state = "uniform_sniper"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_officer
	name = "\improper офицерская форма ROAF"
	desc = "The ROAF officer uniform features a zippered design. It has a standard blue color, large cargo pockets on the trousers, and insignia on the sleeves. It has proven to be reliable and comfortable when used together with a spacesuit and combat gear."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_service"
	worn_state = "uniform_service"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_shooter
	name = "\improper форма шутера ROAF"
	desc = "This is the ROAF shooter forces uniform. The windbreaker has a yellowish signal tone with reflective elements. It is used for coordination during ship landing and launch operations."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_shooter"
	worn_state = "uniform_shooter"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_support
	name = "\improper многофункциональная форма ROAF No.OA4"
	desc = "This is a multifunctional ROAF uniform. It features the standard blue windbreaker and beige trousers with an attachment and safety harness system. It is often used by operators of engineering and service equipment."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_support"
	worn_state = "uniform_support"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_uniform
	name = "\improper боевая форма ROAF No.OA4"
	desc = "This is a multifunctional ROAF combat uniform. It consists of a standard blue windbreaker and dark green trousers. Safety harnesses are often used in combination with the uniform. It has proven effective when used together with space suits."
	icon = 'modular/clothing/icon/roaf/uniform.dmi'
	item_icons = list(
		WEAR_BODY = 'modular/clothing/onmob/roaf/uniform.dmi',
	)
	icon_state = "icon_classic"
	worn_state = "uniform_classic"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Шляпы

/obj/item/clothing/head/beret/lv733/roaf_pilot_hat
	name = "\improper фуражка пилота ROAF"
	desc = "This is the ROAF pilot field cap, featuring the ROAF forces logo. It is not used in combat operations, but is considered an honorable part of the uniform."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
	)
	icon_state = "icon_pilot"
	item_state = "head_pilot"
	item_state_slots = list(
		WEAR_HEAD = "head_pilot"
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

/obj/item/clothing/head/beret/lv733/roaf_boonie
	name = "\improper панама ROAF"
	desc = "This is a ROAF forces boonie hat, featuring a distinctive blue color. It is often used by technicians on the ground to protect the eyes from sunlight or bad weather conditions."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
	)
	icon_state = "icon_hat"
	item_state = "head_hat"
	item_state_slots = list(
		WEAR_HEAD = "head_hat"
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

/obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret
	name = "\improper берет ROAF"
	desc = "This is a ROAF beret with a metal logo on it. It is the most popular and standardized headgear."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
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

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/pilot/lv733/roaf_shooter_helmet
	name = "\improper шлем шутера ROAF"
	desc = "This is the ROAF shooter signal helmet. It has a distinctive yellow color and signaling elements. It is not a combat helmet, but is used to reduce the impact of blows."
	icon = 'modular/clothing/icon/roaf/head.dmi'
	item_icons = list(
		WEAR_HEAD = 'modular/clothing/onmob/roaf/head.dmi',
	)
	icon_state = "icon_shooter"
	item_state = "head_shooter"
	item_state_slots = list(
		WEAR_HEAD = "head_shooter"
	)

// Верхняя одежда

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf
	name = "\improper куртка ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "icon_jacket"
	item_state = "suit_jacket"
	item_state_slots = list(
		WEAR_JACKET = "suit_jacket"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/lv733/suit_roaf_CO
	name = "\improper куртка офицера ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "icon_officer"
	item_state = "suit_officer"
	item_state_slots = list(
		WEAR_JACKET = "suit_officer"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_pilot
	name = "\improper куртка пилота ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "icon_pilot"
	item_state = "suit_pilot"
	item_state_slots = list(
		WEAR_JACKET = "suit_pilot"
	)
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/lv733/suit_roaf_shooter
	name = "\improper жилет парашютера ROAF"
	desc = "An CMB armored vest that protects against some damage."
	icon = 'modular/clothing/icon/roaf/suit.dmi'
	item_icons = list(
		WEAR_JACKET = 'modular/clothing/onmob/roaf/suit.dmi'
	)
	icon_state = "icon_shooter"
	item_state = "suit_shooter"
	item_state_slots = list(
		WEAR_JACKET = "suit_shooter"
	)
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

/obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf
	name = "\improper перчатки ROAF"
	desc = "Non-standard kevlon fiber gloves. They're insulated and heavily armored."
	item_icons = list(
		WEAR_HANDS = 'modular/clothing/onmob/roaf/hands.dmi'
	)
	item_state = "hands_roaf"
	item_state_slots = list(
		WEAR_HANDS = "hands_roaf"
	)
	siemens_coefficient = 0

// Рюкзак

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf
	name = "\improper пончо снайпера ROAF"
	desc = "A specially-designed smock with pockets for all your sniper needs."
	icon = 'modular/clothing/icon/roaf/backpack.dmi'
	item_icons = list(
		WEAR_BACK = 'modular/clothing/onmob/roaf/backpack.dmi'
	)
	icon_state = "icon_backpack"
	item_state = "item_backpack"
	item_state_slots = list(
		WEAR_BACK = "item_backpack"
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN
	flags_item = ITEM_OVERRIDE_NORTHFACE
	actions_types = list(
		/datum/action/item_action/rto_pack/use_phone,
		/datum/action/item_action/specialist/toggle_cloak
	)
	var/obj/structure/transmitter/internal/internal_transmitter
	var/phone_category = RADIO_CHANNEL_ROAF
	var/list/networks_receive = list(FACTION_ROAF, FACTION_MARINE)
	var/list/networks_transmit = list(FACTION_ROAF, FACTION_MARINE)
	var/base_icon = "icon_backpack"
	uniform_restricted = list(/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf) //Need to wear Scout armor and helmet to equip this.
	allow_gun_usage = TRUE
	allowed_stealth_shooting = FALSE
	camo_alpha = 50
	unacidable = TRUE
	explo_proof = TRUE
	worn_accessible = TRUE

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/post_skin_selection()
	base_icon = icon_state

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/Initialize()
	. = ..()
	internal_transmitter = new(src)
	internal_transmitter.relay_obj = src
	internal_transmitter.phone_category = phone_category
	internal_transmitter.enabled = FALSE
	internal_transmitter.networks_receive = networks_receive
	internal_transmitter.networks_transmit = networks_transmit
	RegisterSignal(internal_transmitter, COMSIG_TRANSMITTER_UPDATE_ICON, PROC_REF(check_for_ringing))
	GLOB.radio_packs += src
	update_icon()

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/Destroy()
	GLOB.radio_packs -= src
	QDEL_NULL(internal_transmitter)
	return ..()

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/update_icon()
	. = ..()
	icon_state = base_icon
	item_state = "item_backpack"

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/proc/check_for_ringing()
	SIGNAL_HANDLER
	update_icon()

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/forceMove(atom/dest)
	. = ..()
	if(!internal_transmitter)
		return
	if(isturf(dest))
		internal_transmitter.set_tether_holder(src)
	else
		internal_transmitter.set_tether_holder(loc)

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/pickup(mob/user)
	. = ..()
	autoset_phone_id(user)

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/equipped(mob/user, slot)
	. = ..()
	autoset_phone_id(user)

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/dropped(mob/user)
	. = ..()
	autoset_phone_id(null)

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/proc/autoset_phone_id(mob/user)
	if(!internal_transmitter)
		return
	if(!user)
		internal_transmitter.phone_id = "[src]"
		internal_transmitter.enabled = FALSE
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.comm_title)
			internal_transmitter.phone_id = "[human_user.comm_title] [human_user]"
		else if(human_user.job)
			internal_transmitter.phone_id = "[human_user.job] [human_user]"
		else
			internal_transmitter.phone_id = "[human_user]"

		if(human_user.assigned_squad)
			internal_transmitter.phone_id += " ([human_user.assigned_squad.name])"
	else
		internal_transmitter.phone_id = "[user]"
	internal_transmitter.enabled = TRUE

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/proc/use_phone(mob/user)
	if(internal_transmitter)
		internal_transmitter.attack_hand(user)

/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/attackby(obj/item/W, mob/user)
	if(internal_transmitter && internal_transmitter.attached_to == W)
		internal_transmitter.attackby(W, user)
	else
		. = ..()

/datum/action/item_action/rto_pack/use_phone/action_activate()
	. = ..()
	for(var/obj/item/storage/backpack/marine/satchel/scout_cloak/poncho_roaf/radio_backpack in owner)
		radio_backpack.use_phone(owner)
		return

// Обувь

/obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf
	name = "\improper сапоги ROAF"
	desc = "Standard issue combat boots for combat scenarios or combat situations. Used by the three world empires royal units."
	item_icons = list(
		WEAR_FEET = 'modular/clothing/onmob/roaf/shoes.dmi'
	)
	item_state = "shoes_roaf"
	item_state_slots = list(
		WEAR_FEET = "shoes_roaf"
	)

/obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf_pilot
	name = "\improper сапоги пилота ROAF"
	desc = "Standard issue combat boots for combat scenarios or combat situations. Used by the three world empires royal pilots units."
	item_icons = list(
		WEAR_FEET = 'modular/clothing/onmob/roaf/shoes.dmi'
	)
	item_state = "shoes_pilot"
	item_state_slots = list(
		WEAR_FEET = "shoes_pilot"
	)

// Гарнитура

/obj/item/device/encryptionkey/roaf
	name = "\improper ROAF radio encryption key"
	icon_state = "sl_key"
	channels = list(RADIO_CHANNEL_ROAF = TRUE)

/obj/item/device/radio/headset/distress/roaf
	name = "ROAF Headset"
	desc = "A sleek headset used by the ROAF. Low profile enough to fit under any headgear."
	frequency = ROAF_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/roaf)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_ROAF
	additional_hud_types = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_IMPORTANT
