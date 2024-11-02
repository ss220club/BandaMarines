#define VV_HK_SELECT_TTS_VOICE "select_tts_voice"

#define TTS_TRAIT_PITCH_WHISPER (1<<1)
#define TTS_TRAIT_RATE_FASTER (1<<2)
#define TTS_TRAIT_RATE_MEDIUM (1<<3)

#define TTS_TRAIT_ROBOTIZE "tts_trait_robotize"

#define TTS_CATEGORY_OTHER "Другое"
#define TTS_CATEGORY_WARCRAFT3 "WarCraft 3"
#define TTS_CATEGORY_HALFLIFE2 "Half-Life 2"
#define TTS_CATEGORY_HALFLIFE_ALYX "Half-Life Alyx"
#define TTS_CATEGORY_STARCRAFT "StarCraft"
#define TTS_CATEGORY_PORTAL2 "Portal 2"
#define TTS_CATEGORY_STALKER "STALKER"
#define TTS_CATEGORY_DOTA2 "Dota 2"
#define TTS_CATEGORY_LOL "League of Legends"
#define TTS_CATEGORY_FALLOUT "Fallout"
#define TTS_CATEGORY_FALLOUT2 "Fallout 2"
#define TTS_CATEGORY_POSTAL2 "Postal 2"
#define TTS_CATEGORY_TEAMFORTRESS2 "Team Fortress 2"
#define TTS_CATEGORY_ATOMIC_HEART "Atomic Heart"
#define TTS_CATEGORY_OVERWATCH "Overwatch"
#define TTS_CATEGORY_SKYRIM "Skyrim"
#define TTS_CATEGORY_RITA "Rita"
#define TTS_CATEGORY_METRO "Metro"
#define TTS_CATEGORY_HEROESOFTHESTORM "Heroes of the Storm"
#define TTS_CATEGORY_HEARTHSTONE "Hearthstone"
#define TTS_CATEGORY_VALORANT "Valorant"
#define TTS_CATEGORY_EVILISLANDS "Evil Islands"
#define TTS_CATEGORY_WITCHER "Witcher"
#define TTS_CATEGORY_LEFT4DEAD "Left 4 Dead"
#define TTS_CATEGORY_SPONGEBOB "SpongeBob"
#define TTS_CATEGORY_TINYBUNNY "Tiny Bunny"
#define TTS_CATEGORY_BALDURS_GATE_3 "Baldur's gate 3"
#define TTS_CATEGORY_PORTAL "Portal"
#define TTS_CATEGORY_TMNT "Teenage mutant ninja turtle"
#define TTS_CATEGORY_STAR_WARS "Star Wars"
#define TTS_CATEGORY_TRANSFORMERS "Transformers"
#define TTS_CATEGORY_LOTR "The Lord of the rings"
#define TTS_CATEGORY_SHREK "Shrek"
#define TTS_CATEGORY_POTC "Pirates of the Caribbean"
#define TTS_CATEGORY_HARRY_POTTER "Harry Potter"
#define TTS_CATEGORY_HOGWARTS "Hogwarts legacy"
#define TTS_CATEGORY_X3 "X3"
#define TTS_CATEGORY_OVERLORD2 "The Overlord 2"
#define TTS_CATEGORY_MARVEL "Marvel"
#define TTS_CATEGORY_WOW "World of Warcraft"
#define TTS_CATEGORY_TREASURE_ISLAND "Treasure Island"
#define TTS_CATEGORY_BOYS_WORD "Слово пацана"
#define TTS_CATEGORY_STRONGHOLD "Stronghold Crusade"

#define TTS_GENDER_ANY "Любой"
#define TTS_GENDER_MALE "Мужской"
#define TTS_GENDER_FEMALE "Женский"

#define TTS_PHRASES list(\
		"Так звучит мой голос.",\
		"Так я звучу.",\
		"Я.",\
		"Поставьте свою подпись.",\
		"Пора за работу.",\
		"Дело сделано.",\
		"Станция Нанотрейзен.",\
		"Офицер СБ.",\
		"Капитан.",\
		"Вульпканин.",\
		"Съешь же ещё этих мягких французских булок, да выпей чаю.",\
		"Клоун, прекрати разбрасывать банановые кожурки офицерам под ноги!",\
		"Капитан, вы уверены что хотите назначить клоуна на должность главы персонала?",\
	)

#define BIG_WORKER_TIER 220
#define LITTLE_WORKER_TIER 110

#define BIG_WORKER_TTS_LEVEL 3
#define LITTLE_WORKER_TTS_LEVEL 1
#define DONATOR_LEVEL_MAX 5


// Colonial Marines

#define VOLUME_TTS 5

///TTS preference is disbaled entirely, no sound will be played.
#define TTS_SOUND_OFF "Disabled"
///TTS preference is enabled, and will give full text-to-speech.
#define TTS_SOUND_ENABLED "Enabled"
///TTS preference is set to only play blips of a sound, rather than speech.
#define TTS_SOUND_BLIPS "Blips Only"

///TTS filter to activate start/stop radio clicks on speech.
#define TTS_FILTER_RADIO "radio"
///TTS filter to activate a silicon effect on speech.
#define TTS_FILTER_SILICON "silicon"


#define TTS_FILTER_XENO @{"[0:a] asplit [out0][out2]; [out0] asetrate=%SAMPLE_RATE%*0.8,aresample=%SAMPLE_RATE%,atempo=1/0.8,aformat=channel_layouts=mono [p0]; [out2] asetrate=%SAMPLE_RATE%*1.2,aresample=%SAMPLE_RATE%,atempo=1/1.2,aformat=channel_layouts=mono[p2]; [p0][0][p2] amix=inputs=3"}

#define TTS_HIVEMIND_ALL 3
#define TTS_HIVEMIND_LEADERS 2
#define TTS_HIVEMIND_QUEEN 1
#define TTS_HIVEMIND_OFF 0

#define TTS_RADIO_ALL 2
#define TTS_RADIO_BIG_VOICE_ONLY 1
#define TTS_RADIO_OFF 0

#define TTS_FLAG_HIVEMIND (1<<0)
#define TTS_FLAG_RADIO (1<<1)
#define TTS_FLAG_MERGE_DUPLICATES (1<<2)
