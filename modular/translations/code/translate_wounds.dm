/proc/ru_wounds_desc(wound_desc)
	return GLOB.ru_wound_descs[lowertext(UNLINT(wound_desc))] || wound_desc

/proc/ru_wounds_desc_list(list/wound_desc_list)
	. list()
	for(var/desc in wound_desc_list)
		. += ru_wounds_desc(desc)

/datum/wound
	var/list/ru_names
	var/static/list/cashed_ru_desc_list = list()

/datum/wound/New(damage)
	. = ..()
	ru_names_rename(desc)

/datum/wound/ru_names_rename(desc)
	if(desc in cashed_ru_desc_list)
		ru_names = cashed_ru_desc_list[desc]
		return
	if(GLOB.ru_wound_descs[desc])
		ru_names = GLOB.ru_wound_descs[desc]
		cashed_ru_desc_list[desc] = ru_names

/datum/wound/declent_ru(declent)
	. = desc
	if(!length(ru_names))
		return .
	return get_declented_value(ru_names, declent, .)

/datum/wound/init_stage(initial_damage)
	. = ..()
	ru_names_rename(desc)

/datum/wound/open_wound(damage)
	. = ..()
	ru_names_rename(desc)

/datum/wound/heal_damage(amount, heals_internal)
	. = ..()
	ru_names_rename(desc)
