///TTS preference is disabled entirely, no sound will be played.
#define TTS_SOUND_OFF "Выключен"
///TTS preference is enabled, and will give full text-to-speech.
#define TTS_SOUND_ENABLED "Включен"
///TTS preference is set to only play blips of a sound, rather than speech.
#define TTS_SOUND_BLIPS "Blips Only"
///TTS filter to activate start/stop radio clicks on speech.
#define TTS_FILTER_RADIO "radio"
///TTS filter to activate a silicon effect on speech.
#define TTS_FILTER_SILICON "silicon"

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
#define TTS_CUSTOM_ANNOUNCER_KEY "custom"

GLOBAL_LIST_INIT_TYPED(tts_announcers, /datum/announcer, list(
	TTS_DEFAULT_ANNOUNCER_KEY = new /datum/announcer,
	TTS_ARES_ANNOUNCER_KEY = new /datum/announcer/ares,
	TTS_QUEEN_MOTHER_ANNOUNCER_KEY = new /datum/announcer/queen_mother,
	TTS_SILENT_ANNOUNCER_KEY = new /datum/announcer/silent,
	TTS_CUSTOM_ANNOUNCER_KEY = new /datum/announcer/custom,
))
