/datum/emote/living/carbon/human/vulpkanin
	keybind_category = CATEGORY_HUMAN_EMOTE

	species_type_allowed_typecache = list(/datum/species/vulpkanin)
	species_type_blacklist_typecache = list(/datum/species/human, /datum/species/synthetic, /datum/species/yautja, /datum/species/monkey, /datum/species/synthetic/synth_k9)

/datum/emote/living/carbon/human/vulpkanin/wagging
	key = "wag"
	message = "начинает вилять хвостом";

/datum/emote/living/carbon/human/vulpkanin/wagging/run_emote(mob/user, params, type_override, intentional)
	if(istype(user, /mob/living/carbon/human))
		. = ..()
		var/mob/living/carbon/human/vulpkanin = user
		message = vulpkanin.tail_wagging ? "начинает вилять хвостом" : "перестал вилять хвостом"
		vulpkanin.tail_wagging = !vulpkanin.tail_wagging
		vulpkanin.update_tail_showing()
