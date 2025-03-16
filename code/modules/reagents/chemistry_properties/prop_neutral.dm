/datum/chem_property/neutral
	rarity = PROPERTY_DISABLED
	category = PROPERTY_TYPE_IRRITANT
	value = -1

/datum/chem_property/neutral/cryometabolizing
	name = PROPERTY_CRYOMETABOLIZING
	code = "CMB"
	description = "Химическое вещество пассивно метаболизируется без каких-либо других эффектов при температуре выше 170 Кельвинов. Однако ниже химическое вещество будет метаболизироваться с повышенным эффектом."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_METABOLITE
	value = 1

/datum/chem_property/neutral/cryometabolizing/pre_process(mob/living/M)
	if(M.bodytemperature > BODYTEMP_CRYO_LIQUID_THRESHOLD)
		return list(REAGENT_CANCEL = TRUE)
	return list(REAGENT_BOOST = POTENCY_MULTIPLIER_LOW * level)

/datum/chem_property/neutral/thanatometabolizing
	name = PROPERTY_THANATOMETABOL
	code = "TMB"
	description = "Для функционирования этого химического вещества требуется либо низкий уровень кислорода, либо низкий кровоток. Эффективность этого свойства повлияет на эффективность других свойств."
	rarity = PROPERTY_RARE
	category = PROPERTY_TYPE_METABOLITE
	value = 1

/datum/chem_property/neutral/thanatometabolizing/pre_process(mob/living/M)
	if(M.stat != DEAD && M.oxyloss < 50 && floor(M.blood_volume) > BLOOD_VOLUME_OKAY)
		return list(REAGENT_CANCEL = TRUE)
	var/effectiveness = 1
	if(M.stat != DEAD)
		effectiveness = clamp(max(M.oxyloss / 10, (BLOOD_VOLUME_NORMAL - M.blood_volume) / BLOOD_VOLUME_NORMAL) * 0.1 * level, 0.1, 1)
	return list(REAGENT_FORCE = TRUE, REAGENT_EFFECT = effectiveness)

/datum/chem_property/neutral/excreting
	name = PROPERTY_EXCRETING
	code = "EXT"
	description = "Выводит все химические вещества, содержащиеся в кровотоке, используя почки для превращения их в мочу."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_IRRITANT

/datum/chem_property/neutral/excreting/pre_process(mob/living/M)
	return list(REAGENT_PURGE = level)

/datum/chem_property/neutral/nutritious
	name = PROPERTY_NUTRITIOUS
	code = "NTR"
	description = "Соединение можно использовать в качестве питания для клеточного метаболизма или расщеплять на него."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_METABOLITE
	value = 0

/datum/chem_property/neutral/nutritious/pre_process(mob/living/M)
	if(M.stat == DEAD)
		return

	if(M.nutrition + (holder.nutriment_factor * level) >= NUTRITION_MAX)
		M.nutrition = NUTRITION_MAX
		return
	else
		M.nutrition += holder.nutriment_factor * level

/datum/chem_property/neutral/nutritious/reset_reagent()
	holder.nutriment_factor = initial(holder.nutriment_factor)
	..()

/datum/chem_property/neutral/nutritious/update_reagent()
	holder.nutriment_factor += level
	..()

/datum/chem_property/neutral/ketogenic
	name = PROPERTY_KETOGENIC
	code = "KTG"
	description = "Активирует кетоз, заставляя печень быстро сжигать жирные кислоты и спирты в организме, что приводит к потере веса. В высоких концентрациях может вызвать кетоацидоз, что приводит к накоплению кислот и снижению уровня pH в крови."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_METABOLITE

/datum/chem_property/neutral/ketogenic/process(mob/living/M, potency = 1)
	M.nutrition = max(M.nutrition - POTENCY_MULTIPLIER_VHIGH * potency, 0)
	M.overeatduration = 0
	if(M.reagents.remove_all_type(/datum/reagent/ethanol, potency, 0, 1)) //Ketosis causes rapid metabolization of alcohols
		M.confused = min(M.confused + potency,10*potency)
		M.drowsyness = min(M.drowsyness + potency,15*potency)

/datum/chem_property/neutral/ketogenic/process_overdose(mob/living/M, potency = 1, delta_time)
	M.nutrition = max(M.nutrition - 5 * potency * delta_time, 0)
	M.apply_damage(potency, TOX)
	if(prob(2.5 * potency * delta_time) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.vomit()

/datum/chem_property/neutral/ketogenic/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/neuroinhibiting
	name = PROPERTY_NEUROINHIBITING
	code = "NIH"
	description = "Подавляет неврологические процессы в мозге, такие как зрение, слух и речь, что может привести к различным связанным с этим нарушениям. Восстановление потребует хирургического вмешательства."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_TOXICANT
	value = -1
	max_level = 7

/datum/chem_property/neutral/neuroinhibiting/process(mob/living/M, potency = 1, delta_time)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.chem_effect_flags & CHEM_EFFECT_RESIST_NEURO)
			return
	if(potency > 1)
		M.sdisabilities |= DISABILITY_BLIND
	else
		M.disabilities |= NEARSIGHTED
	if(potency > 2)
		M.sdisabilities |= DISABILITY_DEAF
	if(potency > 3)
		M.sdisabilities |= DISABILITY_MUTE

/datum/chem_property/neutral/neuroinhibiting/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_damage(0.5 * potency * delta_time, BRAIN)
	M.disabilities |= NERVOUS

/datum/chem_property/neutral/neuroinhibiting/process_critical(mob/living/M, potency = 1)
	M.apply_damage(POTENCY_MULTIPLIER_MEDIUM * potency, BRAIN)

/datum/chem_property/neutral/alcoholic
	name = PROPERTY_ALCOHOLIC
	code = "AOL"
	description = "Связывается с нейротрансмиттерами глутамата и гамма-аминомасляной кислотой (ГАМК), замедляя реакцию функций мозга на раздражители. Этот эффект также известен как интоксикация."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT
	value = 0

/datum/chem_property/neutral/alcoholic/process(mob/living/mob, potency = 1, delta_time)
	if(ishuman(mob))
		var/mob/living/carbon/human/human = mob
		if(human.chem_effect_flags & CHEM_EFFECT_RESIST_NEURO)
			return

	mob.dizziness = min(mob.dizziness + POTENCY_MULTIPLIER_VVLOW * potency * delta_time, POTENCY_MULTIPLIER_VHIGH * potency)
	mob.drowsyness = min(mob.drowsyness + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_VHIGH * potency)

	if(prob(50 * delta_time) || potency >= 5)
		mob.confused = min(mob.confused + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_VHIGH * potency)
		mob.slurring = min(mob.slurring + POTENCY_MULTIPLIER_VLOW * potency * delta_time, POTENCY_MULTIPLIER_VHIGH * potency)

/datum/chem_property/neutral/alcoholic/process_overdose(mob/living/mob, potency = 1, delta_time)
	mob.apply_damage(POTENCY_MULTIPLIER_VLOW * potency * delta_time, TOX)
	mob.apply_damage(POTENCY_MULTIPLIER_LOW * potency * delta_time, OXY)

	mob.dizziness = min(mob.dizziness + POTENCY_MULTIPLIER_VLOW * potency * delta_time, POTENCY_MULTIPLIER_HIGHEXTREMEINTER * potency)
	mob.drowsyness = min(mob.drowsyness + potency * delta_time, POTENCY_MULTIPLIER_HIGHEXTREMEINTER * potency)

	if(prob(POTENCY_MULTIPLIER_MEDIUM * delta_time))
		mob.sleeping = min(mob.sleeping + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_HIGHEXTREMEINTER * potency)

	if(prob(POTENCY_MULTIPLIER_MEDIUM * potency * delta_time) && ishuman(mob))
		var/mob/living/carbon/human/human = mob
		human.vomit()

	if(prob(75 * delta_time) || potency >= 5)
		mob.confused = min(mob.confused + potency * delta_time, POTENCY_MULTIPLIER_HIGHEXTREMEINTER * potency)
		mob.slurring = min(mob.slurring + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_HIGHEXTREMEINTER * potency)

/datum/chem_property/neutral/alcoholic/process_critical(mob/living/mob, potency = 1, delta_time)
	mob.apply_damage(POTENCY_MULTIPLIER_LOW * potency * delta_time, TOX)
	mob.apply_damage(potency * delta_time, OXY)

	mob.confused = min(mob.confused + POTENCY_MULTIPLIER_MEDIUM * potency * delta_time, POTENCY_MULTIPLIER_EXTREME * potency)
	mob.dizziness = min(mob.dizziness + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_EXTREME * potency)
	mob.drowsyness = min(mob.drowsyness + POTENCY_MULTIPLIER_MEDIUM * potency * delta_time, POTENCY_MULTIPLIER_EXTREME * potency)
	mob.slurring = min(mob.slurring + potency * delta_time, POTENCY_MULTIPLIER_EXTREME * potency)

	if(prob(POTENCY_MULTIPLIER_VHIGH * potency * delta_time))
		mob.sleeping = min(mob.sleeping + POTENCY_MULTIPLIER_LOW * potency * delta_time, POTENCY_MULTIPLIER_EXTREME * potency)

	if(prob(POTENCY_MULTIPLIER_VHIGH * potency * delta_time) && ishuman(mob))
		var/mob/living/carbon/human/human = mob
		human.vomit()

	if(ishuman(mob))
		var/mob/living/carbon/human/human = mob
		var/datum/internal_organ/liver/liver = human.internal_organs_by_name["liver"]
		if(liver)
			liver.take_damage(POTENCY_MULTIPLIER_LOW * potency, TRUE)

/datum/chem_property/neutral/hallucinogenic
	name = PROPERTY_HALLUCINOGENIC
	code = "HLG"
	description = "Вызывает переживания, подобные восприятию, которые происходят без внешнего раздражителя, яркие и ясные, с полной силой и воздействием нормального восприятия, хотя и не под произвольным контролем."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT

/datum/chem_property/neutral/hallucinogenic/process(mob/living/M, potency = 1, delta_time)
	if(prob(5 * delta_time))
		M.emote(pick("twitch","drool","moan","giggle"))
	if(potency > CREATE_MAX_TIER_1)
		M.hallucination = min(M.hallucination + potency, potency * 10)
		M.make_jittery(5)
	M.druggy = min(M.druggy + 0.5 * potency * delta_time, potency * 10)

/datum/chem_property/neutral/hallucinogenic/process_overdose(mob/living/M, potency = 1, delta_time)
	if(isturf(M.loc) && !istype(M.loc, /turf/open/space) && (M.mobility_flags & MOBILITY_MOVE) && !M.is_mob_restrained())
		step(M, pick(GLOB.cardinals))
	M.hallucination += 10
	M.make_jittery(5)

/datum/chem_property/neutral/hallucinogenic/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_damage(0.5 * potency * delta_time, BRAIN)
	M.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/relaxing
	name = PROPERTY_RELAXING
	code = "RLX"
	description = "Оказывает седативное действие на нервно-мышечные соединения, угнетая силу мышечных сокращений. Высокие концентрации могут вызвать дыхательную недостаточность и остановку сердца."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT

/datum/chem_property/neutral/relaxing/process(mob/living/M, potency = 1, delta_time)
	M.reagent_move_delay_modifier += potency
	if(prob(5 * delta_time))
		M.emote("yawn")
	M.recalculate_move_delay = TRUE

/datum/chem_property/neutral/relaxing/process_overdose(mob/living/M, potency = 1, delta_time)
	//heart beats slower
	M.reagent_move_delay_modifier += POTENCY_MULTIPLIER_MEDIUM * potency
	if(prob(10))
		to_chat(M, SPAN_WARNING("Вы чувствуете себя невероятно слабым!"))

/datum/chem_property/neutral/relaxing/process_critical(mob/living/M, potency = 1, delta_time)
	//heart stops beating, lungs stop working
	if(prob(7.5 * potency * delta_time))
		M.apply_effect(potency, PARALYZE)
	M.apply_damage(0.5 * potency * delta_time, OXY)
	if(prob(2.5 * delta_time))
		to_chat(M, SPAN_WARNING("Вы едва можете дышать!"))
	M.apply_internal_damage(POTENCY_MULTIPLIER_LOW * potency, "heart")

/datum/chem_property/neutral/hyperthermic
	name = PROPERTY_HYPERTHERMIC
	code = "HPR"
	description = "При метаболизме в организме вызывает экзотермическую реакцию, повышающую внутреннюю температуру тела. Предупреждение: во время реакции химические вещества могут воспламениться."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_METABOLITE
	volatile = TRUE

/datum/chem_property/neutral/hyperthermic/process(mob/living/M, potency = 1, delta_time)
	if(prob(5 * delta_time))
		M.emote("gasp")
		to_chat(M, SPAN_DANGER("<b>Внутри у вас неприятно жарко!</b>"))
	M.bodytemperature = min(T120C, M.bodytemperature + POTENCY_MULTIPLIER_MEDIUM * potency)
	if(potency >= CREATE_MAX_TIER_1)
		M.make_dizzy(potency * POTENCY_MULTIPLIER_MEDIUM)
		M.apply_effect(potency,AGONY,0)
	M.recalculate_move_delay = TRUE

/datum/chem_property/neutral/hyperthermic/process_overdose(mob/living/M, potency = 1)
	M.bodytemperature = min(T120C, M.bodytemperature + POTENCY_MULTIPLIER_VHIGH * potency)
	M.apply_effect(POTENCY_MULTIPLIER_MEDIUM * potency,AGONY,0)

/datum/chem_property/neutral/hyperthermic/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/hypothermic
	name = PROPERTY_HYPOTHERMIC
	code = "HPO"
	description = "При метаболизме в организме вызывает эндотермическую реакцию, снижающую внутреннюю температуру тела."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_METABOLITE

/datum/chem_property/neutral/hypothermic/process(mob/living/M, potency = 1, delta_time)
	if(prob(5 * delta_time))
		M.emote("shiver")
	M.bodytemperature = max(0, M.bodytemperature - POTENCY_MULTIPLIER_MEDIUM * potency)
	M.recalculate_move_delay = TRUE

/datum/chem_property/neutral/hypothermic/process_overdose(mob/living/M, potency = 1)
	M.bodytemperature = max(0, M.bodytemperature - POTENCY_MULTIPLIER_VHIGH * potency)
	M.drowsyness  = max(M.drowsyness, 30)

/datum/chem_property/neutral/hypothermic/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/balding
	name = PROPERTY_BALDING
	code = "BLD"
	description = "Повреждает волосяные фолликулы кожи, вызывая сильную алопецию, также называемую облысением."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_IRRITANT
	value = 0
	max_level = 2

/datum/chem_property/neutral/balding/process(mob/living/M, potency = 1, delta_time)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if((H.h_style != "Bald" || H.f_style != "Shaved"))
			to_chat(M, SPAN_WARNING("У тебя выпадают волосы!"))
			H.h_style = "Bald"
			H.f_style = "Shaved"
			H.update_hair()

/datum/chem_property/neutral/balding/process_overdose(mob/living/M, potency = 1)
	M.adjustCloneLoss(POTENCY_MULTIPLIER_LOW * potency)

/datum/chem_property/neutral/balding/process_critical(mob/living/M, potency = 1, delta_time)
	M.adjustCloneLoss(0.5 * potency * delta_time)

/datum/chem_property/neutral/fluffing
	name = PROPERTY_FLUFFING
	code = "FLF"
	description = "Ускоряет деление клеток волосяных фолликулов, что приводит к беспорядочному и чрезмерному росту волос."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_IRRITANT
	value = 0

/datum/chem_property/neutral/fluffing/process(mob/living/M, potency = 1, delta_time)
	if(prob(2.5 * potency * delta_time) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.h_style = "Bald"
		H.f_style = "Shaved"
		H.h_style = pick(GLOB.hair_styles_list)
		H.f_style = pick(GLOB.facial_hair_styles_list)
		H.update_hair()
		to_chat(M, SPAN_NOTICE("Ваша голова ощущается по-другому..."))

/datum/chem_property/neutral/fluffing/process_overdose(mob/living/M, potency = 1, delta_time)
	if(prob(2.5 * potency * delta_time))
		to_chat(M, SPAN_WARNING("Вы чувствуете зуд по всему телу!"))
		M.take_limb_damage(potency) //Hair growing inside your body

/datum/chem_property/neutral/fluffing/process_critical(mob/living/M, potency = 1, delta_time)
	to_chat(M, SPAN_WARNING("Вы чувствуете, будто что-то проникает в ваш череп!"))
	M.apply_damage(0.5 * potency * delta_time, BRAIN) //Hair growing into brain

/datum/chem_property/neutral/allergenic
	name = PROPERTY_ALLERGENIC
	code = "ALG"
	description = "Создает в организме гиперактивный иммунный ответ, приводящий к раздражению."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_IRRITANT
	value = 0

/datum/chem_property/neutral/allergenic/process(mob/living/M, potency = 1)
	if(prob(POTENCY_MULTIPLIER_VHIGH * potency))
		M.emote(pick("sneeze","blink","cough"))

/datum/chem_property/neutral/euphoric
	name = PROPERTY_EUPHORIC
	code = "EPH"
	description = "Вызывает выброс гормонов эндорфинов, что приводит к сильному возбуждению и счастью."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_STIMULANT
	value = 1

/datum/chem_property/neutral/euphoric/on_delete(mob/living/M)
	..()

	M.pain.reset_pain_reduction()

/datum/chem_property/neutral/euphoric/process(mob/living/M, potency = 1, delta_time)
	if(!..())
		return

	M.pain.apply_pain_reduction(PAIN_REDUCTION_MULTIPLIER * potency) //Endorphins are natural painkillers
	if(prob(POTENCY_MULTIPLIER_VHIGH * potency))
		M.emote(pick("laugh","giggle","chuckle","grin","smile","twitch"))

/datum/chem_property/neutral/euphoric/process_overdose(mob/living/M, potency = 1)
	if(prob(POTENCY_MULTIPLIER_VHIGH * potency))
		M.emote("collapse") //ROFL

/datum/chem_property/neutral/euphoric/process_critical(mob/living/M, potency = 1)
	M.apply_damage(POTENCY_MULTIPLIER_VHIGH * potency, OXY)
	to_chat(M, SPAN_WARNING("Ты так смеешься, что не можешь дышать!"))

/datum/chem_property/neutral/emetic
	name = PROPERTY_EMETIC
	code = "EME"
	description = "Действует на кишечную нервную систему, вызывая рвоту, форсированное опорожнение желудка."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_IRRITANT

/datum/chem_property/neutral/emetic/process(mob/living/M, potency = 1, delta_time)
	if(prob(0.5 * holder.volume * potency * delta_time) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.vomit() //vomit() already has a timer on in

/datum/chem_property/neutral/emetic/process_overdose(mob/living/M, potency = 1)
	M.apply_damage(POTENCY_MULTIPLIER_LOW * potency, TOX)

/datum/chem_property/neutral/emetic/process_critical(mob/living/M, potency = 1)
	M.apply_damage(POTENCY_MULTIPLIER_LOW * potency, TOX)

/datum/chem_property/neutral/psychostimulating
	name = PROPERTY_PSYCHOSTIMULATING
	code = "PST"
	description = "Стимулирует психологические функции, вызывая повышение осознанности, концентрации и антидепрессивный эффект."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT
	value = 0
	max_level = 7

/datum/chem_property/neutral/psychostimulating/process(mob/living/M, potency = 1, delta_time)
	if(holder.volume <= 0.1 && holder.data != -1)
		holder.data = -1
		if(potency == 1)
			to_chat(M, SPAN_WARNING("Твой разум кажется немного менее стабильным..."))
		else if(potency == 2)
			to_chat(M, SPAN_WARNING("Ты теряешь концентрацию..."))
		else if(potency == 3)
			to_chat(M, SPAN_WARNING("Твой разум чувствует себя гораздо менее стабильным..."))
		else
			to_chat(M, SPAN_WARNING("Ты теряешь идеальную концентрацию..."))
	else
		if(world.time > holder.data + ANTIDEPRESSANT_MESSAGE_DELAY)
			holder.data = world.time
			if(potency == 1)
				to_chat(M, SPAN_NOTICE("Твой разум кажется стабильным... немного стабильным."))
				M.confused = max(M.confused-1,0)
			else if(potency == 2)
				to_chat(M, SPAN_NOTICE("Твой разум кажется сосредоточенным и неделимым."))
				M.confused = max(M.confused-2,0)
			else if(potency == 3)
				to_chat(M, SPAN_NOTICE("Твой разум чувствует себя гораздо более стабильным."))
				M.confused = max(M.confused-3,0)
			else
				to_chat(M, SPAN_NOTICE("Твой разум кажется совершенно сосредоточенным."))
				M.confused = 0

/datum/chem_property/neutral/psychostimulating/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_damage(0.5 * potency * delta_time, BRAIN)

/datum/chem_property/neutral/psychostimulating/process_critical(mob/living/M, potency = 1, delta_time)
	M.hallucination = min(200, M.hallucination)
	M.apply_damage(POTENCY_MULTIPLIER_VHIGH * potency, BRAIN)

/datum/chem_property/neutral/antihallucinogenic
	name = PROPERTY_ANTIHALLUCINOGENIC
	code = "AHL"
	description = "Стабилизирует нарушения восприятия, такие как галлюцинации, вызванные токсином, разрушающим разум."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT
	value = 1

/datum/chem_property/neutral/antihallucinogenic/process(mob/living/M, potency = 1)
	M.reagents.remove_reagent("mindbreaker", 5)
	M.reagents.remove_reagent("space_drugs", 5)
	M.hallucination = max(0, M.hallucination - POTENCY_MULTIPLIER_EXTREME * potency)
	M.druggy = max(0, M.druggy - POTENCY_MULTIPLIER_EXTREME * potency)

/datum/chem_property/neutral/antihallucinogenic/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_damage(0.5 * potency * delta_time, TOX)

/datum/chem_property/neutral/antihallucinogenic/process_critical(mob/living/M, potency = 1)
	M.apply_damages(potency, potency, POTENCY_MULTIPLIER_HIGH * potency)

/datum/chem_property/neutral/hypometabolic
	name = PROPERTY_HYPOMETABOLIC
	code = "OMB"
	description = "Для метаболизма этого химического вещества требуется больше времени, в результате чего оно находится в кровотоке дольше на единицу."
	rarity = PROPERTY_UNCOMMON
	category = PROPERTY_TYPE_METABOLITE
	value = 2

/datum/chem_property/neutral/hypometabolic/reset_reagent()
	holder.custom_metabolism = initial(holder.custom_metabolism)
	..()

/datum/chem_property/neutral/hypometabolic/update_reagent()
	holder.custom_metabolism = max(holder.custom_metabolism / (1 + 0.35 * level), 0.005)
	..()

/datum/chem_property/neutral/sedative
	name = PROPERTY_SEDATIVE
	code = "SDT"
	description = "Заставляет организм выделять мелатонин, что приводит к повышенной сонливости."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT

/datum/chem_property/neutral/sedative/process(mob/living/M, potency = 1, delta_time)
	if(M.confused < 25 && M.sleeping < 20)
		M.confused += POTENCY_MULTIPLIER_MEDIUM * potency
	if(M.confused > 25)
		M.AdjustSleeping(POTENCY_MULTIPLIER_MEDIUM * potency)
		M.confused -= POTENCY_MULTIPLIER_MEDIUM * potency //so when they wake up they aren't still confused
	else if(prob(25))
		M.emote("yawn")

/datum/chem_property/neutral/sedative/process_overdose(mob/living/M, potency = 1, delta_time)
	M.adjust_effect(0.5 * potency * delta_time, PARALYZE)

/datum/chem_property/neutral/sedative/process_critical(mob/living/M, potency = 1)
	M.apply_damage(POTENCY_MULTIPLIER_VHIGH * potency, OXY)

/datum/chem_property/neutral/hyperthrottling
	name = PROPERTY_HYPERTHROTTLING
	code = "HTR"
	description = "Заставляет мозг работать со скоростью, в несколько тысяч раз превышающей нормальную. По какой-то причине это позволяет понимать все языки, на которых говорили до них, даже не зная языка."
	rarity = PROPERTY_RARE
	category = PROPERTY_TYPE_STIMULANT
	value = 3

/datum/chem_property/neutral/hyperthrottling/process(mob/living/M, potency = 1, delta_time)
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	M.reagent_move_delay_modifier += POTENCY_MULTIPLIER_HIGH * potency
	M.recalculate_move_delay = TRUE
	M.druggy = min(M.druggy + 0.5 * potency * delta_time, 10)
	if(H.chem_effect_flags & CHEM_EFFECT_HYPER_THROTTLE)
		return
	H.chem_effect_flags |= CHEM_EFFECT_HYPER_THROTTLE
	to_chat(M, SPAN_NOTICE("Вы чувствуете, что находитесь во сне. Как будто мир стоит на месте."))
	M.universal_understand = TRUE //Brain is working so fast it can understand the intension of everything it hears

/datum/chem_property/neutral/hyperthrottling/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_damage(1.5 * potency * delta_time, BRAIN)

/datum/chem_property/neutral/hyperthrottling/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_effect(potency * delta_time, PARALYZE)

/datum/chem_property/neutral/encephalophrasive
	name = PROPERTY_ENCEPHALOPHRASIVE
	code = "ESP"
	description = "Значительно увеличивает амплитуду гамма- и бета-мозговых волн, позволяя хозяину транслировать свои мысли."
	rarity = PROPERTY_LEGENDARY
	category = PROPERTY_TYPE_STIMULANT
	value = 8

/datum/chem_property/neutral/encephalophrasive/on_delete(mob/living/chem_host)
	..()

	chem_host.pain.recalculate_pain()
	remove_action(chem_host, /datum/action/human_action/psychic_whisper)
	to_chat(chem_host, SPAN_NOTICE("Боль в голове утихает, и вы чувствуете себя странно одиноким."))

/datum/chem_property/neutral/encephalophrasive/reaction_mob(mob/chem_host, method=INGEST, volume, potency)
	if(method == TOUCH)
		return
	if(!ishuman_strict(chem_host))
		return

	give_action(chem_host, /datum/action/human_action/psychic_whisper)
	to_chat(chem_host, SPAN_NOTICE("Появляется ужасная головная боль, и внезапно возникает ощущение, будто ваш разум находится за пределами черепа."))

/datum/chem_property/neutral/encephalophrasive/process(mob/living/chem_host, potency = 1, delta_time)
	chem_host.pain.apply_pain(1 * potency)

/datum/chem_property/neutral/encephalophrasive/process_overdose(mob/living/chem_host, potency = 1, delta_time)
	chem_host.apply_damage(0.5 * potency * POTENCY_MULTIPLIER_VHIGH * delta_time, BRAIN)

/datum/chem_property/neutral/encephalophrasive/process_critical(mob/living/chem_host, potency = 1, delta_time)
	chem_host.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/viscous
	name = PROPERTY_VISCOUS
	code = "VIS"
	description = "Химическое вещество густое и липкое из-за высокого поверхностного натяжения. При проливании он не распространится очень далеко. Это уменьшит радиус химического пожара."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_REACTANT|PROPERTY_TYPE_COMBUSTIBLE

/datum/chem_property/neutral/viscous/reset_reagent()
	holder.chemfiresupp = initial(holder.chemfiresupp)
	holder.radiusmod = initial(holder.radiusmod)
	..()

/datum/chem_property/neutral/viscous/update_reagent()
	holder.chemfiresupp = TRUE
	holder.radiusmod -= 0.025 * level
	..()

//PROPERTY_DISABLED (in generation)
/datum/chem_property/neutral/thermostabilizing
	name = PROPERTY_THERMOSTABILIZING
	code = "TSL"
	description = "Вызывает смесь эндотермических и экзотермических реакций в кровотоке для стабилизации внутренней температуры тела."
	rarity = PROPERTY_DISABLED
	category = PROPERTY_TYPE_REACTANT
	value = 1

/datum/chem_property/neutral/thermostabilizing/process(mob/living/M, potency = 1, delta_time)
	if(M.bodytemperature > T37C)
		M.bodytemperature = max(T37C, M.bodytemperature - (20 * potency * delta_time * TEMPERATURE_DAMAGE_COEFFICIENT))
		M.recalculate_move_delay = TRUE
	else if(M.bodytemperature < T37C)
		M.bodytemperature = min(T37C, M.bodytemperature + (20 * potency * delta_time * TEMPERATURE_DAMAGE_COEFFICIENT))
		M.recalculate_move_delay = TRUE

/datum/chem_property/neutral/thermostabilizing/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_effect(20, PARALYZE)

/datum/chem_property/neutral/thermostabilizing/process_critical(mob/living/M, potency = 1, delta_time)
	M.drowsyness  = max(M.drowsyness, 30)

/datum/chem_property/neutral/focusing
	name = PROPERTY_FOCUSING
	code = "FCS"
	description = "Удаляет распространенные алкогольные вещества из кровотока и повышает концентрацию внимания."
	rarity = PROPERTY_COMMON
	category = PROPERTY_TYPE_STIMULANT
	value = 0

/datum/chem_property/neutral/focusing/process(mob/living/M, potency = 1)
	M.reagents.remove_all_type(/datum/reagent/ethanol, potency, 0, 1)
	M.stuttering = max(M.stuttering - POTENCY_MULTIPLIER_MEDIUM * potency, 0)
	M.confused = max(M.confused - POTENCY_MULTIPLIER_MEDIUM * potency, 0)
	M.ReduceEyeBlur(POTENCY_MULTIPLIER_MEDIUM * potency)
	M.drowsyness = max(M.drowsyness - POTENCY_MULTIPLIER_MEDIUM * potency, 0)
	M.dizziness = max(M.dizziness - POTENCY_MULTIPLIER_MEDIUM * potency, 0)
	M.jitteriness = max(M.jitteriness - POTENCY_MULTIPLIER_MEDIUM * potency, 0)
	if(potency >= POTENCY_MAX_TIER_1)
		M.SetEyeBlind(0)
		M.silent = 0

/datum/chem_property/neutral/focusing/process_overdose(mob/living/M, potency = 1)
	M.apply_damage(potency, TOX)

/datum/chem_property/neutral/focusing/process_critical(mob/living/M, potency = 1)
	M.apply_damage(potency * POTENCY_MULTIPLIER_HIGH, TOX)

/datum/chem_property/neutral/transformative
	name = PROPERTY_TRANSFORMATIVE
	code = "TRF"
	description = "Восстанавливает поврежденную ткань, создавая при этом небольшое количество слабого токсина в качестве побочного продукта, который затем просачивается в кровоток и повреждает реципиента."
	rarity = PROPERTY_RARE
	starter = FALSE
	value = 3
	cost_penalty = FALSE
	var/heal_amount = 0.75

/datum/chem_property/neutral/transformative/process(mob/living/M, potency = 1, delta_time)
	var/true_heal = heal_amount * potency * delta_time
	if(M.getBruteLoss())
		M.apply_damage(-true_heal, BRUTE)
		M.apply_damage(true_heal * 0.1, TOX)
	if(M.getFireLoss())
		M.apply_damage(-true_heal, BURN)
		M.apply_damage(true_heal * 0.1, TOX)

/datum/chem_property/neutral/transformative/process_overdose(mob/living/M, potency = 1)
	M.apply_damage(heal_amount * (potency * POTENCY_MULTIPLIER_LOW), TOX)

/datum/chem_property/neutral/transformative/process_critical(mob/living/M, potency = 1, delta_time)
	M.apply_damage(heal_amount * potency * delta_time, TOX)

/datum/chem_property/neutral/unknown
	name = PROPERTY_UNKNOWN
	code = "UNK"
	description = "Химическое вещество обладает уникальным свойством, которое невозможно определить с помощью симулятора синтеза. Это свойство может больше не работать, если химическое вещество будет изменено."
	rarity = PROPERTY_DISABLED
	category = PROPERTY_TYPE_ANOMALOUS|PROPERTY_TYPE_UNADJUSTABLE

/datum/chem_property/neutral/unknown/process_overdose(mob/living/M, potency = 1, delta_time)
	M.apply_damage(0.5 * potency * delta_time, BRUTE)

/datum/chem_property/neutral/unknown/process_critical(mob/living/M, potency = 1)
	M.apply_damages(POTENCY_MULTIPLIER_HIGH * potency, POTENCY_MULTIPLIER_HIGH * potency, POTENCY_MULTIPLIER_HIGH * potency)
