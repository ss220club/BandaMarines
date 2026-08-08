/datum/equipment_preset/corpse/colonist/random/load_gear(mob/living/carbon/human/new_human)
	var/list/allowed_types = list()
	for(var/surv_type in SSmapping.configs[GROUND_MAP].survivor_types)
		if(!ispath(surv_type, /datum/equipment_preset/survivor/isrg))
			allowed_types += surv_type

	var/random_surv_type = pick(length(allowed_types) ? allowed_types : SSmapping.configs[GROUND_MAP].survivor_types)
	var/datum/equipment_preset/survivor/surv_equipment = new random_surv_type
	surv_equipment.load_gear(new_human)
