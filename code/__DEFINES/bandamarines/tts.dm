#define SOUND_EFFECT_NONE 0
#define SOUND_EFFECT_RADIO 1
#define SOUND_EFFECT_ROBOT 2
#define SOUND_EFFECT_RADIO_ROBOT 3
#define SOUND_EFFECT_MEGAPHONE 4
#define SOUND_EFFECT_MEGAPHONE_ROBOT 5
#define SOUND_EFFECT_HIVEMIND 6

#define TTS_DEFAULT_ANNOUNCER_KEY "default"
#define TTS_ARES_ANNOUNCER_KEY "ares"
#define TTS_QUEEN_MOTHER_ANNOUNCER_KEY "queen_mother"
#define TTS_SILENT_ANNOUNCER_KEY "silent"

GLOBAL_LIST_INIT_TYPED(tts_announcers, /datum/announcer, list(
	TTS_DEFAULT_ANNOUNCER_KEY = new /datum/announcer,
	TTS_ARES_ANNOUNCER_KEY = new /datum/announcer/ares,
	TTS_QUEEN_MOTHER_ANNOUNCER_KEY = new /datum/announcer/queen_mother,
	TTS_SILENT_ANNOUNCER_KEY = new /datum/announcer/silent,
))
