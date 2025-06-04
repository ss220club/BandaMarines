/datum/chem_property
	/// List consists of ("name", "именительный", "родительный", "дательный", "винительный", "творительный", "предложный", "gender")
	var/list/ru_names

/datum/chem_property/New()
	. = ..()
	ru_names = ru_names_toml(name)

/datum/chem_property/declent_ru(declent)
	. = name
	if(declent == "gender")
		. = NEUTER
	if(!length(ru_names) || ru_names["base"] != name)
		return .
	return get_declented_value(ru_names, declent, .)
