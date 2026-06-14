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
	if(speaker == src)
		return
	if(!say_understands(speaker, language))
		return
	speaker.cast_tts(src, message, src, is_local = FALSE, is_radio = TRUE, postSFX = 'modular/text_to_speech/code/sound/radio_chatter.ogg')
