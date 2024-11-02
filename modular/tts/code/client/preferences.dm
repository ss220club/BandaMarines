
/datum/preferences
	// TTS
	var/voice = "Random"
	var/voice_pitch = 0
	var/xeno_voice = "Random"
	var/xeno_pitch = 0
	var/synth_voice = "Random"
	var/synth_pitch = 0
	var/tts_mode = TTS_SOUND_ENABLED
	var/tts_hivemind_mode = TTS_HIVEMIND_LEADERS
	var/tts_radio_mode = TTS_RADIO_BIG_VOICE_ONLY

	COOLDOWN_DECLARE(tts_test_cooldown)


/datum/preferences/proc/tts_hivemind_to_text(value)
	switch(value)
		if(TTS_HIVEMIND_OFF)
			return "Disabled"
		if(TTS_HIVEMIND_QUEEN)
			return "Queen"
		if(TTS_HIVEMIND_LEADERS)
			return "Queen and leaders"
		if(TTS_HIVEMIND_ALL)
			return "Everyone"
