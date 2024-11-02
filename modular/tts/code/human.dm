/mob
	/// Text to speech voice. Set to null if no voice.
	var/tts_voice
	/// Text to speech filter. Filter that gets applied when passed in.
	var/tts_voice_filter = ""
	/// Text to speech pitch. Used to determine the pitch of the voice.
	var/tts_voice_pitch = 0

/mob/living
	var/speaking_noise

/mob/living/carbon/human/Login()
	. = ..()
	if(!tts_voice && SStts.tts_enabled && species.has_tts_voice)
		tts_voice = pick(SStts.available_speakers)

/mob/living/carbon/xenomorph
	tts_voice_filter = TTS_FILTER_XENO

/mob/living/carbon/xenomorph/proc/init_voice()
	if(!client)
		return
	if(!SStts.tts_enabled)
		return
	tts_voice = sanitize_inlist(client.prefs?.xeno_voice, SStts.available_speakers, pick(SStts.available_speakers))
	tts_voice_pitch = client.prefs?.xeno_pitch

/mob/living/carbon/xenomorph/proc/generate_name()
	. = ..()
	init_voice()


/mob/living/carbon/xenomorph/queen/generate_name()
	. = ..()
	init_voice()
