/obj/item/clothing/under/marine/veteran/UPP/cbrn
	name = "\improper комплект РХБЗ СПН"
	desc = "Защитный комплект РХБЗ, предназначенный для работы в условиях химического, биологического, радиологического или ядерного заражения. Ресурс защитных свойств костюма ограничен интенсивностью и длительностью контакта с заражённой средой."
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	icon = 'modular/distress/icons/cbrn/icons/upp_cbrn_uniform.dmi'
	icon_state = "upp_cbrn_uniform"
	worn_state = "upp_cbrn_uniform"
	flags_jumpsuit = NO_FLAGS
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_VERYLOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGHPLUS
	fire_intensity_resistance = BURN_LEVEL_TIER_1
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	item_icons = list(
		WEAR_BODY = 'modular/distress/icons/cbrn/onmob/upp_cbrn_uniform_onmob.dmi',
	)
	actions_types = list(/datum/action/item_action/specialist/upp_cbrn_hood_toggle)

	/// Whether the cosmetic hood overlay is currently raised.
	var/hood_enabled = FALSE
	/// Icon file/state used for the cosmetic hood overlay.
	var/hood_icon = 'modular/distress/icons/cbrn/onmob/upp_cbrn_hood_onmob.dmi'
	var/hood_icon_state = "upp_cbrn_hood"
	/// Reference to the overlay image currently applied to the wearer, so it can be removed precisely.
	var/image/hood_overlay_ref

	/// Whether the chest stripe is tinted to the wearer's squad colour, same as marine gloves (marine_gloves.dm).
	var/adopts_squad_color = TRUE
	/// The dmi where the grayscale squad stripe overlay is contained.
	var/squad_overlay_icon = 'modular/distress/icons/cbrn/onmob/upp_cbrn_stripe.dmi'

/obj/item/clothing/under/marine/veteran/UPP/cbrn/get_mob_overlay(mob/living/carbon/human/current_human, slot, default_bodytype = "Default")
	var/image/ret = ..()
	if(!ret || slot != WEAR_BODY)
		return ret

	if(adopts_squad_color && current_human?.assigned_squad?.equipment_color)
		var/image/stripe_overlay = image(squad_overlay_icon, icon_state = "upp_cbrn_stripe")
		stripe_overlay.color = current_human.assigned_squad.equipment_color
		stripe_overlay.alpha = current_human.assigned_squad.armor_alpha
		ret.overlays += stripe_overlay

	return ret

/obj/item/clothing/under/marine/veteran/UPP/cbrn/unequipped(mob/user, slot)
	. = ..()
	if(slot != WEAR_BODY)
		return
	if(hood_overlay_ref)
		user.overlays -= hood_overlay_ref
		hood_overlay_ref = null
	hood_enabled = FALSE

/obj/item/clothing/under/marine/veteran/UPP/cbrn/proc/hood_toggle(mob/living/carbon/human/user)
	if(!istype(user) || user.w_uniform != src)
		return

	hood_enabled = !hood_enabled
	playsound(user.loc, "armorequip", 25, 1)

	if(hood_enabled)
		// The human head overlay is rendered at layer -18. -17.5 keeps the hood above it.
		hood_overlay_ref = image(icon = hood_icon, icon_state = hood_icon_state, layer = -17.5)
		user.overlays += hood_overlay_ref
		to_chat(user, SPAN_NOTICE("Вы поднимаете капюшон костюма РХБЗ."))
	else
		if(hood_overlay_ref)
			user.overlays -= hood_overlay_ref
			hood_overlay_ref = null
		to_chat(user, SPAN_NOTICE("Вы опускаете капюшон костюма РХБЗ."))

/datum/action/item_action/specialist/upp_cbrn_hood_toggle
	name = "Капюшон РХБЗ"
	ability_primacy = SPEC_PRIMARY_ACTION_2

/datum/action/item_action/specialist/upp_cbrn_hood_toggle/New(obj/item/clothing/under/marine/veteran/UPP/cbrn/armor, obj/item/holder)
	..()
	button.overlays.Cut()
	button.overlays += image(armor.hood_icon, armor, armor.hood_icon_state)

/datum/action/item_action/specialist/upp_cbrn_hood_toggle/action_activate()
	. = ..()
	var/obj/item/clothing/under/marine/veteran/UPP/cbrn/armor = holder_item
	if(istype(armor))
		armor.hood_toggle(owner)

// UPP CBRN (РХБЗ) gloves — modular copy of the root M3 MOPP gloves (code/modules/clothing/gloves/marine_gloves.dm).

/obj/item/clothing/gloves/marine/veteran/upp/cbrn
	name = "\improper перчатки РХБЗ СПН"
	desc = "Защитные перчатки из обработанного венлара, рассчитанные на работу в условиях химического, биологического, радиологического или ядерного заражения. Сохраняют достаточную подвижность пальцев для обслуживания оружия и инструментов."
	icon = 'modular/distress/icons/cbrn/icons/upp_cbrn_gloves.dmi'
	icon_state = "upp_cbrn_gloves"
	item_icons = list(
		WEAR_HANDS = 'modular/distress/icons/cbrn/onmob/upp_cbrn_gloves_onmob.dmi',
	)
	armor_bio = CLOTHING_ARMOR_HIGHPLUS
	armor_rad = CLOTHING_ARMOR_HIGHPLUS
