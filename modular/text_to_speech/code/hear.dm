/mob/hear_say(message, verb = "says", datum/language/language = null, alt_name = "", italics = 0, mob/speaker = null, sound/speech_sound, sound_vol)
	. = ..()
	if(!speaker)
		return
	if(!say_understands(speaker, language))
		return
	speaker.cast_tts(src, message)

/mob/hear_radio(
	message, verb="says",
	datum/language/language=null,
	part_a, part_b,
	mob/speaker = null,
	hard_to_hear = 0, vname ="",
	command = 0, no_paygrade = FALSE)
	. = ..()
	if(hard_to_hear || !speaker)
		return
	if(!say_understands(speaker, language))
		return
	speaker.cast_tts(src, message, src, TTS_LOCALYZE_RADIO, SOUND_EFFECT_RADIO, postSFX = 'modular/text_to_speech/code/sound/radio_chatter.ogg')

/proc/sanitize_tts_symbols(message)
	var/regex/finding_stress = regex(@{"\+(?=[а-яА-ЯёЁ])"}, "g")
	message = finding_stress.Replace_char(message, "")

	var/regex/finding_many_dots = regex(@{"\.{4,}"}, "g")
	message = finding_many_dots.Replace_char(message, "...")
	return message
