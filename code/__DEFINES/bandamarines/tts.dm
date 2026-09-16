#define TTS_DEFAULT_ANNOUNCER_KEY "default"
#define TTS_ARES_ANNOUNCER_KEY "ares"
#define TTS_QUEEN_MOTHER_ANNOUNCER_KEY "queen_mother"
#define TTS_SILENT_ANNOUNCER_KEY "silent"
#define TTS_CUSTOM_ANNOUNCER_KEY "custom"

GLOBAL_LIST_INIT_TYPED(tts_announcers, /datum/announcer, list(
	TTS_DEFAULT_ANNOUNCER_KEY = new /datum/announcer,
	TTS_ARES_ANNOUNCER_KEY = new /datum/announcer/ares,
	TTS_QUEEN_MOTHER_ANNOUNCER_KEY = new /datum/announcer/queen_mother,
	TTS_SILENT_ANNOUNCER_KEY = new /datum/announcer/silent,
	TTS_CUSTOM_ANNOUNCER_KEY = new /datum/announcer/custom,
))

#define TTS_SOUND_EFFECT_PRIORITY_TONGUE 1
#define TTS_SOUND_EFFECT_PRIORITY_MASK 2
#define TTS_SOUND_EFFECT_PRIORITY_MEGAPHONE 3
#define TTS_SOUND_EFFECT_PRIORITY_RADIO 4

//from base of atom/movable/update_voice_effect(): (should_apply_voice_effect)
#define COMSIG_MOVABLE_UPDATE_VOICE_EFFECT "movable_update_voice_effect"
