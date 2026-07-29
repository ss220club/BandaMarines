// Ремень K9 ISRG - несъёмный, только для ISRG K9, со встроенным детектором движения и слотами под инструмент.

/obj/item/device/motiondetector/isrg_k9_belt
	name = "детектор движения"
	desc = "Встроенный в упряжь K9 детектор движения."

// get_user() у базового детектора требует, чтобы loc был напрямую мобом - у нас детектор лежит
// внутри пояса, поэтому проверяем на уровень выше (пояс -> носитель).
/obj/item/device/motiondetector/isrg_k9_belt/get_user()
	var/atom/holder = loc
	if(ishuman(holder))
		return holder
	if(ishuman(holder?.loc))
		return holder.loc

/obj/item/device/motiondetector/isrg_k9_uniform
	name = "встроенный детектор движения"
	desc = "Детектор движения, встроенный в служебный комбинезон K9."
	iff_signal = FACTION_ISRG

/obj/item/device/motiondetector/isrg_k9_uniform/get_user()
	var/atom/holder = loc
	if(ishuman(holder))
		return holder
	if(ishuman(holder?.loc))
		return holder.loc

/datum/action/item_action/toggle/motion_detector/k9_belt/update_button_icon()
	if(!holder_item)
		return
	var/obj/item/storage/belt/k9_isrg/belt = holder_item
	if(!istype(belt) || !belt.internal_detector)
		return
	if(!belt.internal_detector.active)
		action_icon_state = "motion_detector"
	else
		action_icon_state = "motion_detector_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/toggle/motion_detector/k9_uniform/update_button_icon()
	if(!holder_item)
		return
	var/obj/item/clothing/under/rank/synthetic/synth_k9/isrg/uniform = holder_item
	if(!istype(uniform) || !uniform.internal_detector)
		return
	if(!uniform.internal_detector.active)
		action_icon_state = "motion_detector"
	else
		action_icon_state = "motion_detector_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/obj/item/clothing/under/rank/synthetic/synth_k9/isrg
	name = "\improper служебный комбинезон K9 ISRG"
	desc = "Идентификационный ошейник-комбинезон поискового синтетика K9 со встроенным детектором движения."
	actions_types = list(/datum/action/item_action/toggle/motion_detector/k9_uniform)
	var/obj/item/device/motiondetector/isrg_k9_uniform/internal_detector

/obj/item/clothing/under/rank/synthetic/synth_k9/isrg/Initialize(mapload)
	. = ..()
	internal_detector = new /obj/item/device/motiondetector/isrg_k9_uniform(src)

/obj/item/clothing/under/rank/synthetic/synth_k9/isrg/Destroy()
	QDEL_NULL(internal_detector)
	return ..()

/obj/item/clothing/under/rank/synthetic/synth_k9/isrg/attack_self(mob/user)
	if(internal_detector)
		internal_detector.toggle_active(user, internal_detector.active)
	else
		..()

/obj/item/storage/belt/k9_isrg
	name = "\improper упряжь K9 ISRG"
	desc = "Рабочая упряжь поисковой группы ISRG для K9-синтетика. Крепится намертво, снять её может только специалист."
	icon = 'modular/lv733/icons/isrg_k9/isrg_k9_belt.dmi'
	item_icons = list(
		WEAR_WAIST = 'modular/lv733/icons/isrg_k9/isrg_k9_belt_onmob.dmi',
	)
	icon_state = "utilitybelt"
	item_state = "utility"
	skip_fullness_overlays = TRUE
	storage_slots = 8
	max_storage_space = 16
	max_w_class = SIZE_MEDIUM
	flags_item = NODROP
	flags_inventory = CANTSTRIP
	actions_types = list(/datum/action/item_action/toggle/motion_detector/k9_belt)
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/stack/cable_coil,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/storage/box/m94,
	)
	var/obj/item/device/motiondetector/isrg_k9_belt/internal_detector

/obj/item/storage/belt/k9_isrg/Initialize(mapload)
	. = ..()
	internal_detector = new /obj/item/device/motiondetector/isrg_k9_belt(src)

/obj/item/storage/belt/k9_isrg/Destroy()
	QDEL_NULL(internal_detector)
	return ..()

/obj/item/storage/belt/k9_isrg/fill_preset_inventory()
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src, 30)
	new /obj/item/storage/box/m94(src)
	new /obj/item/storage/box/m94(src)

/obj/item/storage/belt/k9_isrg/attack_self(mob/user)
	if(internal_detector)
		internal_detector.toggle_active(user, internal_detector.active)
	else
		..()

/obj/item/storage/belt/k9_isrg/mob_can_equip(mob/user, slot, disable_warning = 0)
	if(slot == WEAR_WAIST && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!istype(H.species, /datum/species/synthetic/synth_k9/isrg))
			if(!disable_warning)
				to_chat(user, SPAN_WARNING("Эта упряжь подходит только K9-синтетику ISRG."))
			return FALSE
	return ..()
