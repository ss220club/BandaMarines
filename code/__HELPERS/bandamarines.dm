/// Macro from Lummox used to get height from a MeasureText proc.
/// resolves the MeasureText() return value once, then resolves the height, then sets return_var to that.

#define PATH_TO_TRANSLATE_DATA "modular/translations/code/translation_data"
#define WXH_TO_HEIGHT_2(measurement, return_var) \
	do { \
		var/_measurement = measurement; \
		return_var = text2num(copytext(_measurement, findtextEx(_measurement, "x") + 1)); \
	} while(FALSE);

/proc/ru_span(str, list/attr = list(), type = "")
	world.log = file("[GLOB.log_directory]/TEST.log")
	if (!str || !length(str))
		return
	if(!length(GLOB.ru_span))
		var/span_path = "[PATH_TO_TRANSLATE_DATA]/ru_span.toml"
		if(length(span_path) || fexists(file(span_path)))
			var/list/span_file_data = rustg_read_toml_file(span_path)
			var/list/span_messages = span_file_data["span_verbs"]
			for(var/span_key in span_messages)
				if(GLOB.ru_span[span_key])
					continue
				GLOB.ru_span += list("[span_key]" = span_messages[span_key])
	if(!length(GLOB.ru_span_args))
		var/span_args_path = "[PATH_TO_TRANSLATE_DATA]/ru_span_args.toml"
		if(length(span_args_path) || fexists(file(span_args_path)))
			var/list/span_args_file_data = rustg_read_toml_file(span_args_path)
			var/list/span_args_messages = span_args_file_data["span_args_verbs"]
			for(var/span_args_key in span_args_messages)
				if(GLOB.ru_span_args[span_args_key])
					continue
				GLOB.ru_span_args += list("[span_args_key]" = span_args_messages[span_args_key])
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
#undef PATH_TO_TRANSLATE_DATA
