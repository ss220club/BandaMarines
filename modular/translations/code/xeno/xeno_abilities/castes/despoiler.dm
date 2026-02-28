/datum/action/xeno_action/activable/tail_stab/despoiler

/datum/action/xeno_action/activable/tail_stab/despoiler/apply_replaces_in_desc()
	. = ..()
	desc += " <br><br>Также наносит %DAMAGE_PER_TIER% урона за уровень кислоты с пробитием брони %ARMOR_PIERCE_PER_TIER% за уровень кислоты."
	replace_in_desc("%DAMAGE_PER_TIER%", 15)
	replace_in_desc("%ARMOR_PIERCE_PER_TIER%", 15)

// Handled in basic acid
/datum/action/xeno_action/activable/corrosive_acid/strong

/datum/action/xeno_action/activable/acid_barrage
	desc = "Удерживайте для зарядки и отпустите для запуска плевков спреем, во время зарядки скорость уменьшена.\
		<br>Количество плевков зависит от уровня усиления (от %MIN_VOLLEY% до %MAX_VOLLEY% снарядов).\
		<br>Усиление увеличивает количество на %EMPOWER_VOLLEY%.\
		<br>При попадании наносит %DAMAGE% урона и накладывает кислоту. При промахе создаёт лужу кислоты.\
		<br>Лужа наносит %AOE_DAMAGE% урона при наступлении на неё и замедляет."

/datum/action/xeno_action/activable/acid_barrage/apply_replaces_in_desc()
	replace_in_desc("%MIN_VOLLEY%", min_volley)
	replace_in_desc("%MAX_VOLLEY%", max_volley)
	replace_in_desc("%EMPOWER_VOLLEY%", empower_modifier)
	replace_in_desc("%DAMAGE%", /datum/ammo/xeno/acid/despoiler::damage)
	replace_in_desc("%AOE_DAMAGE%", /obj/effect/lingering_acid::damage)

/datum/action/xeno_action/activable/pounce/caustic_embrace

/datum/action/xeno_action/activable/pounce/caustic_embrace/apply_replaces_in_desc()
	. = ..()
	desc += "<br><br>При окончании рывка наносит по всем удар по U-образной дуге с уроном %U_DAMAGE%.\
	<br>С шансом %CHANCE_TO_AOE% создаёт лужу кислоты.\
	<br>При усилении, дальность рывка увеличивается до %RANGE_EMPOWER%, а атака будет нанесена только по одной цели.\
	<br>Усиленная атака дополнительно наносит удар когтями, оглушает цель на %STUN_DURATION%, и накладывает усиленную кислоту."
	replace_in_desc("%U_DAMAGE%", damage)
	replace_in_desc("%RANGE_EMPOWER%", empowered_distance, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%STUN_DURATION%", convert_effect_time(weaken_duration, WEAKEN), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%CHANCE_TO_AOE%", "30%")

/datum/action/xeno_action/onclick/oozing_wounds
	desc = "Создает спрей из кислоты и лужи с шансом %CHANCE_TO_AOE% вокруг себя. Радиус равен %TIER1_RANGE%, при 70% здоровья - %TIER2_RANGE%, а при 30% здоровья - %TIER3_RANGE% \
	<br>Спрей наносит %DAMAGE% урона и накладывает кислоту.\
	<br>При усилении спрей оглушает на %STUN_DURATION% и накладывает усиленную кислоту"

/datum/action/xeno_action/onclick/oozing_wounds/apply_replaces_in_desc()
	replace_in_desc("%DAMAGE%", /obj/effect/xenomorph/spray/despoiler::damage_amount)
	replace_in_desc("%STUN_DURATION%", convert_effect_time(/obj/effect/xenomorph/spray/despoiler/empowered::stun_duration, WEAKEN), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%CHANCE_TO_AOE%", "20%")
	replace_in_desc("%TIER1_RANGE%", "1", DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%TIER2_RANGE%", "2", DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%TIER3_RANGE%", "3", DESCRIPTION_REPLACEMENT_DISTANCE)

/datum/action/xeno_action/onclick/catalyze
	desc = "На %DURATION% усиливает следующую способность. Активация использует один уровень пассивной способности."

/datum/action/xeno_action/onclick/catalyze/apply_replaces_in_desc()
	replace_in_desc("%DURATION%", duration / 10, DESCRIPTION_REPLACEMENT_TIME)
