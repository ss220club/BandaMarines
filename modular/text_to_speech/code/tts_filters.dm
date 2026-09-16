/atom/movable
	var/list/voice_effect

/atom/movable/Initialize(mapload, ...)
	. = ..()
	if(voice_effect && !length(voice_effect))
		stack_trace("[src] has assigned var/voice_effect = ([voice_effect]), but it is not a list()!")

/obj/item/clothing/mask/gas
	voice_effect = list(/datum/singleton/sound_effect/gasmask)

/datum/singleton/sound_effect/gasmask
	suffix = "_gasmask"
	ffmpeg_arguments = "lowpass=f=750,volume=2"
	priority = TTS_SOUND_EFFECT_PRIORITY_MASK

/obj/item/clothing/mask/gas/clown_hat
	voice_effect = null

/obj/item/clothing/head/welding/should_apply_voice_effect()
	return !up

/obj/item/clothing/head/welding/toggle(mob/living/user)
	. = ..()
	if(!.)
		return
	update_voice_effect()

/datum/singleton/sound_effect/sechailer
	suffix = "_sechailer"
	ffmpeg_arguments = @{"[0:a] asetrate=%SAMPLE_RATE%*0.7,aresample=16000,atempo=1/0.7,lowshelf=g=-20:f=500,highpass=f=500,aphaser=in_gain=1:out_gain=1:delay=3.0:decay=0.4:speed=0.5:type=t [out]; [out]atempo=1.2,volume=15dB,lowpass=f=3000,alimiter=limit=0.999 [final]; anoisesrc=a=0.01:d=60 [noise]; [final][noise] amix=inputs=2:duration=shortest:weights='1 0.1':normalize=0,alimiter=limit=0.999,lowpass=f=3000"}
	priority = TTS_SOUND_EFFECT_PRIORITY_MASK

/mob/living/simple_animal/small/parrot/Initialize(mapload)
	. = ..()
	voice_effect = list(/datum/singleton/sound_effect/poly)

/datum/singleton/sound_effect/poly
	suffix = "_poly"
	ffmpeg_arguments = "rubberband=pitch=1.5"
	priority = TTS_SOUND_EFFECT_PRIORITY_TONGUE

/obj/structure/machinery/cm_vending
	voice_effect = list(/datum/singleton/sound_effect/vending)

/datum/singleton/sound_effect/vending
	suffix = "_vending"
	ffmpeg_arguments = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"
	priority = TTS_SOUND_EFFECT_PRIORITY_TONGUE
