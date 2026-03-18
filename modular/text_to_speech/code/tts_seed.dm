/atom/proc/add_tts_component()
	return

/atom/proc/remove_tts_component()
	return

/mob
	var/datum/tts_seed/tts_seed
	var/tmp/tts_disabled = FALSE

/atom/Initialize(mapload, ...)
	. = ..()
	add_tts_component()

/mob/living/carbon/proc/change_tts_seed_ask()
	set waitfor = FALSE
	change_tts_seed(src)

/atom/proc/cast_tts(mob/listener, message, atom/location, is_local = TRUE, is_radio = FALSE, list/additional_effects = list(), traits = TTS_TRAIT_RATE_FASTER, preSFX, postSFX, tts_seed_override, tts_channel_override, check_deafness)
	if(ismob(src))
		var/mob/speaker = src
		if(speaker.tts_disabled)
			return
	if(!GetComponent(/datum/component/tts_component))
		add_tts_component()
	if(!GetComponent(/datum/component/tts_component))
		return
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_CAST, listener, message, location, is_local, is_radio, additional_effects, traits, preSFX, postSFX, tts_seed_override, tts_channel_override, check_deafness)

// TODO: Do it better?
/atom/proc/get_tts_seed()
	var/datum/component/tts_component/tts_component = GetComponent(/datum/component/tts_component)
	if(tts_component)
		return tts_component.tts_seed

/atom/proc/get_tts_effects(list/additional_effects)
	var/datum/component/tts_component/tts_component = GetComponent(/datum/component/tts_component)
	return tts_component.get_effects(additional_effects)

/atom/proc/change_tts_seed(mob/chooser, overrides, list/new_sound_effects)
	if(!get_tts_seed())
		if(alert(chooser, "Отсутствует TTS компонент. Создать?", "Изменение TTS", "Да", "Нет") == "Нет")
			return
		AddComponent(/datum/component/tts_component, /datum/tts_seed/silero/angel)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_SEED_CHANGE, chooser, overrides, new_sound_effects)

/atom/proc/tts_effects_add(list/effects)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_TRAIT_ADD, effects)

/atom/proc/tts_effects_remove(list/effects)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_TRAIT_REMOVE, effects)
