/proc/ru_span(str, list/attr = list(), type = "")
	world.log = file("[GLOB.log_directory]/TEST.log")
	if (!str || !length(str))
		return
	var/translated_str = GLOB.ru_span[str]
	if(isnull(translated_str))
		world.log << "НЕТ ПЕРЕВОДА! [type] = [str]"
		translated_str = str

	if(length(attr))
		for(var/i in 1 to length(attr))
			var/arg_value = attr[i]
			// Если аргумент тоже имеет перевод, подставляем его
			if(length(GLOB.ru_span_args) && !isnum(arg_value) && GLOB.ru_span_args[arg_value])
				world.log << "arg_value: [arg_value]"
				arg_value = GLOB.ru_span_args[arg_value] || arg_value
			translated_str = replacetext(translated_str, "$[i]", arg_value)

	return translated_str
