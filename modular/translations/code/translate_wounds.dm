/proc/ru_wounds_desc(wound_desc, declent = NOMINATIVE, plural = TRUE)
	if(GLOB.ru_wound_descs["[wound_desc][plural ? "s" : ""]"])
		return GLOB.ru_wound_descs["[wound_desc][plural ? "s" : ""]"][declent] || wound_desc
	return wound_desc

/proc/ru_wounds_desc_list(list/wound_desc_list)
	. = list()
	for(var/desc in wound_desc_list)
		. += ru_wounds_desc(desc)
