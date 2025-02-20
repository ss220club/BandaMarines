/mob/proc/remove_bump_attacks()
	var/datum/component/bump_attack/component = GetComponent(/datum/component/bump_attack)
	if(component)
		qdel(component)

/mob/proc/add_bump_attacks()
	return

/mob/living/carbon/xenomorph/add_bump_attacks()
	if(CONFIG_GET(flag/bump_attacks))
		AddComponent(/datum/component/bump_attack)

/mob/living/carbon/xenomorph/add_abilities()
	add_bump_attacks()
	. = ..()
