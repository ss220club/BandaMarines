GLOBAL_LIST_INIT(brainrot_notifications, list(
	"Почему у меня такой скудный словарный запас? Стоит сходить в библиотеку и прочесть книгу...",
	"Что, черт побери, я несу?",
	"Я в своём уме? Надо следить за языком.",
	"Неужели я не могу подобрать нужных слов? Позор мне..."
))

/proc/filter_speech(client/user, message)
	if(!config.word_filter_regex)
		return TRUE

	if(!length(message))
		return TRUE

	if(message[1] == "*")
		return TRUE

	var/brainrot_regex = get_brainrot_filter_regex()
	if(!brainrot_regex)
		return TRUE

	var/original_message = copytext(message, 1)
	message = rustutils_regex_replace(message, brainrot_regex, "i", "цветочек")
	if(original_message == message)
		return TRUE

	to_chat(user,
		html = "\n<font color='red' size='4'><b>-- Фильтр Плохих Выражений --</b></font>",
		)
	to_chat(user,
		type = MESSAGE_TYPE_ADMINPM,
		html = "\n<font color='red' size='4'><b>Ваше сообщение было автоматически отфильтровано из-за его содержания. Попытка обойти этот фильтр приведет к бану.</b></font>",
		)
	SEND_SOUND(user, sound('sound/effects/adminhelp_new.ogg'))
	log_admin("[user.ckey] попытался сказать запретное слово: [original_message].")

	var/mob/M = user.mob
	if(M)
		M.emote("drool")
		to_chat(M, span_sinister(pick(GLOB.brainrot_notifications)))

	return FALSE

/proc/get_brainrot_filter_regex()
	if(!fexists(BRAINROT_FILTER_FILE))
		return

	var/static/list/filters = json_decode(wrap_file2text(FILE))(BRAINROT_FILTER_FILE)["brainrot_filter"]
	if(!length(filters))
		return list()

	var/static/brainrot_regex
	if(!brainrot_regex)
		var/list/unique_filters = list()
		unique_filters |= filters
		brainrot_regex = unique_filters.Join("|")

	return brainrot_regex
