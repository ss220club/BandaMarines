#define SPECIES_ISRG_SYNTH_K9 "ISRG Synthetic K9"

/datum/species/synthetic/synth_k9/isrg
	name = SPECIES_ISRG_SYNTH_K9
	icobase = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	deform = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	blood_mask = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	blood_color = BLOOD_COLOR_HUMAN
	flags = IS_WHITELISTED|NO_BREATHE|NO_CLONE_LOSS|NO_POISON|IS_SYNTHETIC|NO_CHEM_METABOLIZATION|NO_NEURO|NO_OVERLAYS

/datum/species/synthetic/synth_k9/isrg/handle_post_spawn(mob/living/carbon/human/spawned_k9)
	. = ..()
	RegisterSignal(spawned_k9, COMSIG_HUMAN_EQUIPPED_ITEM, PROC_REF(on_equipped_item))

/datum/species/synthetic/synth_k9/isrg/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	UnregisterSignal(H, COMSIG_HUMAN_EQUIPPED_ITEM)

/datum/species/synthetic/synth_k9/isrg/proc/on_equipped_item(mob/living/carbon/human/wearer, obj/item/equipped_item, slot)
	SIGNAL_HANDLER
	if(slot != WEAR_FEET)
		return
	to_chat(wearer, SPAN_WARNING("Лапам не подходит [equipped_item] - обувь тут же соскальзывает."))
	wearer.drop_inv_item_on_ground(equipped_item)
