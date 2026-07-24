/datum/announcer/lv733_rees
	tts_seed = /datum/tts_seed/silero/engineer
	sound_effects = list(/datum/singleton/sound_effect/radio)

/datum/announcer/lv733_arakawa
	tts_seed = /datum/tts_seed/silero/kerrigan
	sound_effects = list(/datum/singleton/sound_effect/radio)

GLOBAL_DATUM_INIT(lv733_announcer_rees, /datum/announcer/lv733_rees, new)
GLOBAL_DATUM_INIT(lv733_announcer_arakawa, /datum/announcer/lv733_arakawa, new)

/proc/lv733_announce_rees(message, title, sound_to_play)
	marine_announcement(message, title, sound_to_play, announcer = GLOB.lv733_announcer_rees)

/proc/lv733_announce_arakawa(message, title, sound_to_play)
	marine_announcement(message, title, sound_to_play, announcer = GLOB.lv733_announcer_arakawa)

/datum/modpack/lv733/initialize()
	RegisterSignal(SSdcs, COMSIG_GLOB_POST_SETUP, PROC_REF(on_post_setup))

/datum/modpack/lv733/proc/on_post_setup(datum/source)
	SIGNAL_HANDLER
	if(SSmapping.configs[GROUND_MAP].map_name != MAP_LV733_WHITCHLER_POINT)
		return
	SSticker.mode.lore_announcement_lv733()

/datum/game_mode/colonialmarines/proc/lore_announcement_lv733()
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lv733_announce_rees), "&^!!#---, говорит старший инженер Реес, гарнизон ИТМ «Блэкбуш». Мы #@##s---- периметр у &^@%###---. Состав: @#!!&#&--- заблокированы. Запрашиваем поддержку и эвакуацию !!&#---. Приём.", "Гарнизон ИТМ «Блэкбуш», ст. инженер Реес", 'sound/AI/commandreport.ogg'), 23 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_announcement), "Дети мои. Другая часть этой колонии пропитана запахом отчаяния. Солдаты хозяев забаррикадировались за камнем и сталью, словно испуганные насекомые. Стены их не спасут — туннели под их ногами принадлежат нам. Поглотите их. Пусть эта колония станет нашим гнездом.", "everything", QUEEN_MOTHER_ANNOUNCE), 23 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lv733_announce_rees), "Алмайер, на связи гарнизон «Блэкбуш». Боеприпасы на исходе. Авиационная поддержка так и не прибыла. Прошу инструкций, приём.", "Гарнизон ИТМ «Блэкбуш», ст. инженер Реес", 'sound/AI/commandreport.ogg'), 35 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_announcement), "Я слышу тишину с запада. Гарнизон носителей, что держался за городсок чертой больше не сопротивляется.\n\nЭто сделали ваши сёстры. Вы не одни. Рой един.", "everything", QUEEN_MOTHER_ANNOUNCE), 35 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lv733_announce_arakawa), "Алмаер, говорит Капитан Аракава, ДК ИТМ «Фого». Гарнизон «Блэкбуш» подтверждён на тренировочной ЛЗ «Дельта». Первый рейс уходит через восемь минут.\n\nВсем наземным подразделениям — удержать текущие позиции на время эвакуации.", "ДК ИТМ «Фого», Капитан Кэндзи Аракава", 'sound/AI/commandreport.ogg'), 42 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(marine_announcement), "МЭЙДЭЙ. Говорит транспорт «Гера», борт два-два. Поражены при наборе высоты. Двигатели отказали.\n\nПадаем в сторону городского сектора— &^@%###--- —на борту— &^@%$sss----", "Транспорт ИТМ «Гера», борт 2-2", 'sound/AI/commandreport.ogg'), 50 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(trigger_lv733_ship_crash)), 50 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_announcement), "Вы чувствуете это, дети мои? Один из летающих ульев хозяев упал с неба прямо в городские владения.\n\nТам могут быть выжившие", "everything", QUEEN_MOTHER_ANNOUNCE), 52 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lv733_announce_arakawa), "Всем подразделениям, говорит «Фого». Борт два-два потерян. Место крушения — городской сектор, ваш район операций.\n\nРесурсов на немедленную поисково-спасательную операцию нет. Выжившие с борта предоставлены сами себе до прихода подкрепления.", "ДК ИТМ «Фого», Капитан Кэндзи Аракава", 'sound/AI/commandreport.ogg'), 53 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_announcement), "Дети мои. Я ощущаю усталость их воинов. Их движения стали медленнее. Их решения — хуже.", "everything", QUEEN_MOTHER_ANNOUNCE), 80 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lv733_announce_arakawa), "Алмайер, на связи «Фого». Командование флота подтвердило: ближайшие силы поддержки прибудут не ранее чем через сорок восемь — семьдесят два часа.\n\nПодкрепление идёт. Но вам придётся продержаться самостоятельно. Сделайте всё возможное. «Фого» — конец связи.", "ДК ИТМ «Фого», Капитан Кэндзи Аракава", 'sound/AI/commandreport.ogg'), 80 MINUTES)
