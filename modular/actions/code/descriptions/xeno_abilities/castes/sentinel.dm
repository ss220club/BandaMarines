#define NEUROTOXIN_DESC "<br><br>Нейротоксин наносит <b>0.2</b> урона гипоксией в секунду за нейротоксин.\
	<br>Максимальное количество нейротоксина - <b>30</b>"

/datum/action/xeno_action/activable/slowing_spit
	desc = "Наносит %NEURO_COUNT% нейротоксина.\
		<br>Значительно замедляет цель (%SLOWDOWN%)."

/datum/action/xeno_action/activable/slowing_spit/apply_replaces_in_desc()
	desc += NEUROTOXIN_DESC
	replace_in_desc("%SLOWDOWN%", convert_effect_time(4, SUPERSLOW), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%NEURO_COUNT%", "[/datum/ammo/xeno/toxin::increment_amount]")
	var/datum/ammo/xeno/spit = GLOB.ammo_list[/datum/ammo/xeno/toxin] // hardcoded
	desc += "[spit.get_description()]"

/*
/datum/action/xeno_action/activable/scattered_spit
	desc = "Слабый нейротоксин ограниченной дистанции (%DISTANCE%), стреляющий веером.\
		<br>Кратковременно оглушает цель (%STUN%)."

/datum/action/xeno_action/activable/scattered_spit/apply_replaces_in_desc()
	replace_in_desc("%DISTANCE%", /datum/ammo/xeno/toxin/shotgun::max_range, DESCRIPTION_REPLACEMENT_DISTANCE)
	replace_in_desc("%STUN%", convert_effect_time(0.7, STUN), DESCRIPTION_REPLACEMENT_TIME)
*/

/datum/action/xeno_action/onclick/paralyzing_slash
	desc = "Усиливает ваши следующие %AMOUNT% удара в течении %DURATION%\
		<br>При попадании цель получит %NEURO_COUNT% нейротоксина."

/datum/action/xeno_action/onclick/paralyzing_slash/apply_replaces_in_desc()
	desc += NEUROTOXIN_DESC
	replace_in_desc("%AMOUNT%", /datum/behavior_delegate/sentinel_base::max_buffed_slashes)
	replace_in_desc("%DURATION%", buff_duration / (1 SECONDS), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%NEURO_COUNT%", /datum/behavior_delegate/sentinel_base::increment_amount)

/datum/action/xeno_action/activable/tail_stab/sentinel

/datum/action/xeno_action/activable/tail_stab/sentinel/apply_replaces_in_desc()
	var/mob/living/carbon/xenomorph/xeno = owner
	replace_in_desc("%TAIL_DAMAGE%", xeno.melee_damage_upper)
	. = ..()
	desc += "<br><br>Использует нейротоксин в цели, снимая половину нейротоксина.\
		<br>Наносит от %MIN_DAMAGE_NEURO% до %MAX_DAMAGE_NEURO% урона ожогами взависимости от количества оставшегося нейротоксина.\
		<br>Если в цели осталось %NEEDED_NEURO% нейротоксина, вы получите %ARMOR% брони и ускорение на %BUFF_DURATION%"
	desc += NEUROTOXIN_DESC
	replace_in_desc("%BUFF_DURATION%", duration / (1 SECONDS), DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%ARMOR%", armor_buff_amount)
	replace_in_desc("%MIN_DAMAGE_NEURO%", 1.2)
	replace_in_desc("%MAX_DAMAGE_NEURO%", 1.2 * /datum/effects/sentinel_neuro_stacks::max_stacks)
	replace_in_desc("%NEEDED_NEURO%", 10) // Hardcoded


/datum/action/xeno_action/activable/draining_bite
	desc = "Укус, который снимает 30% нейротоксина с цели и оглушая, вплоть до %STUN_DURATION_MAX% при максимуме нейротоксина."

/datum/action/xeno_action/activable/draining_bite/apply_replaces_in_desc()
	desc += NEUROTOXIN_DESC
	replace_in_desc("%STUN_DURATION_MAX%", /datum/effects/sentinel_neuro_stacks::max_stacks / 10 - 1, DESCRIPTION_REPLACEMENT_TIME)

#undef NEUROTOXIN_DESC
