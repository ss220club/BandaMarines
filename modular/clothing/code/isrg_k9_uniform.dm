/// Motion detector built directly into the ISRG K9 identification uniform.
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
	icon = 'modular/clothing/icon/isrg/isrg_k9_dogtag.dmi'
	icon_state = "icon"
	worn_state = "icon"
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/species/synth_k9/onmob/synth_k9_overlays.dmi',
	)
	item_state_slots = list(
		WEAR_BODY = "k9_dogtags",
	)
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
