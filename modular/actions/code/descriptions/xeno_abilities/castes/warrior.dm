/datum/action/xeno_action/activable/fling
	desc = "Кинуть цель вперёд от вас (%FLING_DISTANCE%). Оглушает цель (%FLING_STUN%). Замедляет цель (%FLING_SLOWDOWN%)."

/datum/action/xeno_action/activable/fling/apply_replaces_in_desc()
	replace_in_desc("%FLING_STUN%", convert_effect_time(stun_power, STUN), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%FLING_SLOWDOWN%", convert_effect_time(slowdown, SLOW), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%FLING_DISTANCE%", fling_distance, DESCRIPTION_REPLACEMENT_DISTANCE)

/datum/action/xeno_action/activable/lunge
	desc = "Сделать рывок к цели (%LUNGE_DISTANCE%). Оглушает цель (%LUNGE_STUN%). Вы автоматически возьмёте эту цель в захват."

/datum/action/xeno_action/activable/lunge/apply_replaces_in_desc()
	replace_in_desc("%LUNGE_DISTANCE%", grab_range, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%LUNGE_STUN%", convert_effect_time(2, STUN), DESCRIPTION_REPLACEMENT_TIME) // Hardcoded in warrior's grab code

/datum/action/xeno_action/activable/warrior_punch
	desc = "Отталкивающий удар, наносящий %PUNCH_DAMAGE_MIN%-%PUNCH_DAMAGE_MAX% урона. Разрушает шины на конечности. Замедляет цель (%PUNCH_SLOWDOWN%). На мгновение дезориентирует цель."

/datum/action/xeno_action/activable/warrior_punch/apply_replaces_in_desc()
	replace_in_desc("%PUNCH_DAMAGE_MIN%", base_damage)
	replace_in_desc("%PUNCH_DAMAGE_MAX%", base_damage + damage_variance)
	replace_in_desc("%PUNCH_SLOWDOWN%", convert_effect_time(3, SLOW), DESCRIPTION_REPLACEMENT_TIME) // Hardcoded

/datum/action/xeno_action/onclick/toggle_plates
	desc = "Опускает плиты. Если плиты опущены, скорость передвижения уменьшается, а бонус направленной брони удваивается. Не позволяет откинуть вас."

/datum/action/xeno_action/activable/plate_bash
	desc = "Ударить плитами. Дистанция равна %RANGE% (%RANGE_CREST%, если плиты опущене). \
		<br>При попадании наносит %DAMAGE% урона, толкает цель на %THROW% (%THROW_CREST%, если плиты опущены). \
		<br>Если плиты опущены, также оглушает на %KNOCKDOWN%, а перезарядка будет удвоена."

/datum/action/xeno_action/activable/plate_bash/apply_replaces_in_desc()
	replace_in_desc("%RANGE%", 2, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%RANGE_CREST%", 1, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%DAMAGE%", base_damage)
	replace_in_desc("%THROW%", 1, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%THROW_CREST%", 1 + 2, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%KNOCKDOWN%", convert_effect_time(1, WEAKEN), DESCRIPTION_REPLACEMENT_TIME)

/datum/action/xeno_action/onclick/tail_swing
	desc = "Ударить хвостом вокруг себя, толкая и опрокидывая (%KNOCKDOWN%) носителей и гранаты вокруг себя. Наносит %DAMAGE% урона. \
		<br>Нельзя использовать с опущенными плитами. \
		<br>Если попадание было только по гранате, перезарядка будет в три раза быстрее."

/datum/action/xeno_action/onclick/tail_swing/apply_replaces_in_desc()
	replace_in_desc("%KNOCKDOWN%", convert_effect_time(1, WEAKEN), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%DAMAGE%", 15)

/datum/action/xeno_action/onclick/reflective_shield
	desc = "Опущенные плиты позволят с шансом %REFLECT_CHANCE%% (%REFLECT_CHANCE_SIDE%% сбоку и %REFLECT_CHANCE_BACK%% с тыла) отражать обычные снаряды в течении %DURATION% \
	<br>Отраженные снаряды наносят %REFLECTED_DAMAGE%% урона. \
	<br>Не отражает ракеты и стенопробивные снаряды."

/datum/action/xeno_action/onclick/reflective_shield/apply_replaces_in_desc()
	replace_in_desc("%REFLECT_CHANCE%", SHIELDER_REFLECTION_BASE_CHANCE)
	replace_in_desc("%REFLECT_CHANCE_SIDE%", SHIELDER_REFLECTION_BASE_CHANCE * SHIELDER_SIDE_REFLECTION_PROCENTAGE)
	replace_in_desc("%REFLECT_CHANCE_BACK%", SHIELDER_REFLECTION_BASE_CHANCE * SHIELDER_BACK_REFLECTION_PROCENTAGE)
	replace_in_desc("%REFLECTED_DAMAGE%", SHIELDER_REFLECTED_BULLET_DAMAGE * 100)
	replace_in_desc("%DURATION%", SHIELDER_REFLECTION_DURATION / (1 SECONDS), DESCRIPTION_REPLACEMENT_TIME)

/datum/action/xeno_action/activable/plate_slam
	desc = "Зажмите своими плитами находящуюся вплотную цель через %WINDUP% При успехе, стоячая цель будет оглушена на %DURATION%, а лежачая на %DURATION_FLOORED%"

/datum/action/xeno_action/activable/plate_slam/apply_replaces_in_desc()
	replace_in_desc("%WINDUP%", 3, DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%DURATION%", 7, DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%DURATION_FLOORED%", 10, DESCRIPTION_REPLACEMENT_TIME)
