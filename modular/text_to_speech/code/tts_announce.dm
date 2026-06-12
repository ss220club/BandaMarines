#define TTS_SEED_DEFAULT_ANNOUNCE /datum/tts_seed/silero/kalechos_echo
#define TTS_SEED_ARES_ANNOUNCE /datum/tts_seed/silero/volibear
#define TTS_SEED_YAUTJA_ANNOUNCE /datum/tts_seed/silero/wrathion_echo
#define TTS_SEED_QUEEN_MOTHER_ANNOUNCE /datum/tts_seed/silero/alextraza_echo

/datum/announcer
	var/tts_seed = TTS_SEED_DEFAULT_ANNOUNCE
	var/list/sound_effects = list()
	var/mob/ammouncer

/datum/announcer/proc/Message(message, garbled_message, receivers, garbled_receivers)
	if(!tts_seed)
		return
	var/message_tts = message
	var/garbled_message_tts = garbled_message
	//message = message.Join("+")
	//garbled_message = garbled_message.Join("+")

	if(ammouncer)
		for(var/mob/M in receivers)
			ammouncer.cast_tts(listener = M, message = message_tts, location = M, is_local = FALSE, additional_effects = sound_effects, traits = TTS_TRAIT_RATE_MEDIUM, tts_seed_override = tts_seed, tts_channel_override = CHANNEL_TTS_ANNOUNCEMENT)
		for(var/mob/M in garbled_receivers)
			ammouncer.cast_tts(listener = M, message = garbled_message_tts, location = M, is_local = FALSE,, additional_effects = sound_effects, traits = TTS_TRAIT_RATE_MEDIUM, tts_seed_override = tts_seed, tts_channel_override = CHANNEL_TTS_ANNOUNCEMENT)
		return

	for(var/mob/M in receivers)
		SStts220.get_tts(speaker = M, listener = M, message = message_tts, tts_seed = tts_seed, is_local = FALSE, effect_types = sound_effects, traits = TTS_TRAIT_RATE_MEDIUM, channel_override = CHANNEL_TTS_ANNOUNCEMENT)
	for(var/mob/M in garbled_receivers)
		SStts220.get_tts(speaker = M, listener = M, message = garbled_message_tts, tts_seed = tts_seed, is_local = FALSE, effect_types = sound_effects, traits = TTS_TRAIT_RATE_MEDIUM, channel_override = CHANNEL_TTS_ANNOUNCEMENT)


// Announcers

/datum/announcer/ares
	tts_seed = TTS_SEED_ARES_ANNOUNCE
	sound_effects = list(/datum/singleton/sound_effect/robot, /datum/singleton/sound_effect/radio)

/datum/announcer/queen_mother
	tts_seed = TTS_SEED_QUEEN_MOTHER_ANNOUNCE

/datum/announcer/yautja
	tts_seed = TTS_SEED_YAUTJA_ANNOUNCE
	sound_effects = list(/datum/singleton/sound_effect/robot)

/datum/announcer/custom
	sound_effects = list(/datum/singleton/sound_effect/radio)

/// Беззвучный анонсер на случай, если не нужно проигрывать ттс
/datum/announcer/silent

/datum/announcer/silent/Message(message, garbled_message, receivers, garbled_receivers)
	return
