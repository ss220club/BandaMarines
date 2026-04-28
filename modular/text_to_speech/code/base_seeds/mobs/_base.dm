// Fallback values for TTS voices

/mob/living/add_tts_component()
	AddComponent(/datum/component/tts_component)

/mob/living/silicon/add_tts_component()
	AddComponent(/datum/component/tts_component, null, list(/datum/singleton/sound_effect/robot))

/mob/living/carbon/add_tts_component()
	var/random_tts_seed_key = SStts220.pick_tts_seed_by_gender(gender)
	var/datum/tts_seed/random_tts_seed = SStts220.tts_seeds[random_tts_seed_key]
	AddComponent(/datum/component/tts_component, random_tts_seed)

/mob/living/remove_tts_component()
	var/datum/component/tts_component/tts_component = GetComponent(/datum/component/tts_component)
	if(tts_component)
		tts_component.RemoveComponent()

/mob/living/carbon/Initialize()
	. = ..()
	tts_seed = get_tts_seed()

/datum/equipment_preset/load_preset(mob/living/carbon/human/new_human, randomise = FALSE, count_participant = FALSE, client/mob_client, show_job_gear = TRUE)
	. = ..()
	if(remove_tts)
		new_human.remove_tts_component()
		return

	if(!randomise)
		return

	new_human.add_tts_component()
	new_human.tts_seed = new_human.get_tts_seed()
	INVOKE_ASYNC(new_human, TYPE_PROC_REF(/mob/living/carbon, change_tts_seed_ask))
