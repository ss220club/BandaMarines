/datum/equipment_preset/load_preset(mob/living/carbon/human/new_human, randomise = FALSE, count_participant = FALSE, client/mob_client, show_job_gear = TRUE)
	. = ..()
	if(remove_tts)
		new_human.remove_tts_component()
		return

	handle_tts(new_human, randomise)

/datum/equipment_preset/proc/handle_tts(mob/living/carbon/human/new_human, randomise)
	if(randomise)
		new_human.add_tts_component()
		new_human.tts_seed = new_human.get_tts_seed()
		INVOKE_ASYNC(new_human, TYPE_PROC_REF(/mob/living/carbon, change_tts_seed_ask))

/datum/equipment_preset/yautja/handle_tts(mob/living/carbon/human/new_human, randomise)
	if(randomise)
		return ..()
	// Non-WL will have to choose tts, slot TTS will be a backup
	new_human.client.prefs.give_tts_seed(new_human)
	if(!new_human.client.prefs.tts_seed_predator)
		return ..()

/datum/equipment_preset/synth/handle_tts(mob/living/carbon/human/new_human, randomise)
	if(randomise)
		return ..()
	new_human.client.prefs.give_tts_seed(new_human)
