/datum/ammo/xeno/proc/get_description()
	var/desc = "[name]"
	desc += "<br>Дальность: <b>[max_range] кл.</b>."
	desc += "<br>Урон: [damage ? "[damage] [damage_type]" : "отсутствует"]."
	if(damage && damage_falloff)
		desc += " Уменьшается на [damage_falloff] за каждую пройденную клетку."

	if(flags_ammo_behavior & AMMO_SKIPS_ALIENS)
		desc += "<br>Проходит сквозь сестёр."
	if(length(debilitate))
		desc += "<br>Накладывает статус-эффекты:"
		// Stun
		if(debilitate[1])
			desc += "<br>   Оглушение: [convert_effect_time(debilitate[1], STUN)] <b>сек.</b>"
		// Weaken
		if(debilitate[2])
			desc += "<br>   Опрокидывание: [convert_effect_time(debilitate[2], WEAKEN)] <b>сек.</b>"
		// Sleep
		if(debilitate[3])
			desc += "<br>   Нокаут: [convert_effect_time(debilitate[3], WEAKEN)] <b>сек.</b>"
		// Irradiate
		/* Not used
		if(debilitate[4])
			desc += "<br>Оглушает на [convert_effect_time(debilitate[4], STUN)] <b>сек.</b>"
		*/
		// Stutter
		if(debilitate[5])
			desc += "<br>   Заикание: [convert_effect_time(debilitate[5], STUN)] <b>сек.</b>"
		// Eyeblur
		if(debilitate[6])
			desc += "<br>   Затуманивает зрения: [convert_effect_time(debilitate[6], STUN)] <b>сек.</b>"
		// Drowsy
		if(debilitate[7])
			desc += "<br>   Сонность: [convert_effect_time(debilitate[7], STUN)] <b>сек.</b>"
		// Agony
		if(debilitate[8])
			desc += "<br>   Боль: [debilitate[8]]."
		desc += "<br>"

	return desc

/datum/ammo/xeno/boiler_gas/get_description()
	var/desc = ..()
	var/neurodose = /obj/effect/particle_effect/smoke/xeno_weak::neuro_dose
	desc += "<br>Радиус взрыва: [smokerange]. Замедляет носителей в области, медленно ослабляет и душит их. Затуманивает зрение. Накладывает <b>[neurodose]</b> стаков нейротоксина каждую секунду. \
		<br>Нейротоксин постепенно ослабевает цель, наносит урон токсинами, вызывает галлюцинации, а при <b>19</b> стаках ослепляет, и при <b>50</b> стаках убивает."
	return desc

/datum/ammo/xeno/boiler_gas/acid/get_description()
	var/desc = call(src, /datum/ammo/xeno::get_description())()
	var/damage = /obj/effect/particle_effect/smoke/xeno_burn::gas_damage
	desc += "<br>Радиус взрыва: [smokerange]. Накладывает кислоту на барикады в области. Наносит [damage] урона в секунду при вдыхании носителями, а также дополнительно <b>15-20</b> урона в секунду по телу."
	return desc
