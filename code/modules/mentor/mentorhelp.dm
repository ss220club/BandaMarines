GLOBAL_DATUM_INIT(mentorhelp_manager, /datum/mentorhelp_manager, new)

/datum/mentorhelp_manager
	var/list/active_tickets = list()
	var/list/archived_tickets = list()
	var/ticket_counter = 1

/datum/mentorhelp_manager/proc/get_ticket_by_id(id)
	if(active_tickets["[id]"])
		return active_tickets["[id]"]
	return archived_tickets["[id]"]

/datum/mentorhelp_manager/proc/get_active_ticket_by_ckey(ckey)
	if(!ckey)
		return null
	for(var/id in active_tickets)
		var/datum/mentorhelp/MH = active_tickets[id]
		if(MH && ckey(MH.author_key) == ckey)
			return MH
	return null

/datum/mentorhelp_manager/proc/create_ticket(client/author, message)
	var/datum/mentorhelp/MH = new(author)
	MH.initial_message = message
	MH.latest_message = message
	author.current_mhelp = MH
	return MH

// Represents a mentorhelp thread
/datum/mentorhelp
	var/id = 0

	// The client/player who initiated (authored) the mentorhelp thread
	var/client/author = null
	// The author's key
	var/author_key = ""
	var/author_ic_name = ""
	var/author_role = ""
	var/author_faction = ""

	// The mentor who's responding to this mentorhelp thread
	// If this is null, it means no mentor has responded yet
	var/client/mentor = null
	var/mentor_key = ""
	var/mentor_ic_name = ""

	// If this thread is still open
	var/open = TRUE
	var/initial_message = ""
	var/latest_message = ""
	var/subject = ""
	var/list/ticket_interactions = list()

	var/opened_at = ""
	var/closed_at = ""

	var/time_activity = list("opened_at" = null, "closed_at" = null)

	var/list/messages = list() //SS220 EDIT

/datum/mentorhelp/New(client/thread_author)
	..()

	if(!thread_author)
		qdel(src)
		return

	var/datum/mentorhelp/existing = GLOB.mentorhelp_manager.get_active_ticket_by_ckey(thread_author.ckey)
	if(existing)
		to_chat(thread_author, SPAN_WARNING("You already have an active mentor help ticket. Please wait for a mentor to respond."))
		qdel(src)
		return

	opened_at = world.time
	time_activity["opened_at"] = "[worldtime2text(opened_at)]"

	author = thread_author
	author_key = thread_author.key
	GLOB.mentorhelp_tickets += src //SS220 EDIT

	if(thread_author.mob)
		author_ic_name = thread_author.mob.real_name || thread_author.mob.name || "Unknown"
		var/mob/M = thread_author.mob
		var/datum/faction/F = GLOB.faction_datums[M.faction]
		if(F)
			author_faction = F.name
		else if(M.faction)
			author_faction = "[M.faction]"
		else
			author_faction = FACTION_NEUTRAL

		if(isobserver(M))
			author_role = "Ghost"
		else if(isxeno(M))
			var/mob/living/carbon/xenomorph/X = M
			author_role = X.caste_type
		else if(ishuman(M))
			var/mob/living/carbon/human/HUM = M
			if(HUM.comm_title)
				author_role = HUM.comm_title
			else if(HUM.job)
				author_role = HUM.job
		else if(M.job)
			author_role = M.job

	id = GLOB.mentorhelp_manager.ticket_counter++

	GLOB.mentorhelp_manager.active_tickets["[id]"] = src

	if(thread_author.mob)
		author_ic_name = thread_author.mob.real_name || thread_author.mob.name || "Unknown"
		var/mob/M = thread_author.mob
		var/datum/faction/F = GLOB.faction_datums[M.faction]
		if(F)
			author_faction = F.name
		else if(M.faction)
			author_faction = "[M.faction]"
		else
			author_faction = FACTION_NEUTRAL

		if(isobserver(M))
			author_role = "Ghost"
		else if(isxeno(M))
			var/mob/living/carbon/xenomorph/X = M
			author_role = X.caste_type
		else if(ishuman(M))
			var/mob/living/carbon/human/HUM = M
			if(HUM.comm_title)
				author_role = HUM.comm_title
			else if(HUM.job)
				author_role = HUM.job
		else if(M.job)
			author_role = M.job

	id = GLOB.mentorhelp_manager.ticket_counter++

	GLOB.mentorhelp_manager.active_tickets["[id]"] = src

/datum/mentorhelp/Destroy()
	GLOB.mentorhelp_tickets -= src //SS220 EDIT
	if(open && GLOB.mentorhelp_manager.active_tickets["[id]"] == src)
		GLOB.mentorhelp_manager.active_tickets -= "[id]"
	else if(GLOB.mentorhelp_manager.archived_tickets["[id]"] == src)
		GLOB.mentorhelp_manager.archived_tickets -= "[id]"

	author.current_mhelp = null
	author = null
	mentor = null
	return ..()

/*
 * Helpers
 */

// Helper to check that the author is still around
// Closes the thread if they're not
/datum/mentorhelp/proc/check_author()
	if(!author)
		close()
		return FALSE
	return TRUE

// Helper to check that the thread is still open
/datum/mentorhelp/proc/check_open(client/C)
	if(!open)
		to_chat(C, SPAN_NOTICE("Этот тикет в «MentorHelp» закрыт!"))
		return FALSE
	return TRUE

/datum/mentorhelp/proc/get_author_ic_name()
	if(author && author.mob)
		author_ic_name = author.mob.real_name || author.mob.name || "Unknown"
	return author_ic_name || "Unknown"

/datum/mentorhelp/proc/get_display_name(client/viewer, subject)
	var/subject_key = ""
	var/subject_ic = ""

	if(istype(subject, /client))
		var/client/C = subject
		subject_key = C.username()
		if(C.mob)
			subject_ic = C.mob.real_name || C.mob.name
	else if(istype(subject, /mob))
		var/mob/M = subject
		subject_key = M.username()
		subject_ic = M.real_name || M.name
	else if(istext(subject))
		subject_key = subject

	if(!subject_key || ckey(subject_key) == ckey(author_key))
		if(viewer && CLIENT_IS_STAFF(viewer))
			return author_key ? "[author_key]/([author_ic_name || "Unknown"])" : "Unknown"
		return author_ic_name || "Unknown"

	if(!subject_ic && mentor_key && ckey(subject_key) == ckey(mentor_key))
		subject_ic = mentor_ic_name

	if(viewer && CLIENT_IS_STAFF(viewer))
		return subject_ic ? "[subject_key]/([subject_ic])" : subject_key

	return subject_key

/datum/mentorhelp/proc/get_author_role()
	if(author && author.mob)
		var/mob/M = author.mob
		if(isobserver(M))
			author_role = "Ghost"
		else if(isxeno(M))
			var/mob/living/carbon/xenomorph/X = M
			author_role = X.caste_type
		else if(ishuman(M))
			var/mob/living/carbon/human/HUM = M
			if(HUM.comm_title)
				author_role = HUM.comm_title
			else if(HUM.job)
				author_role = HUM.job
		else if(M.job)
			author_role = M.job
	return author_role

/datum/mentorhelp/proc/get_author_faction()
	if(author && author.mob)
		var/mob/M = author.mob
		var/datum/faction/F = GLOB.faction_datums[M.faction]
		if(F)
			author_faction = F.name
		else if(M.faction)
			author_faction = "[M.faction]"
	return author_faction

/datum/mentorhelp/proc/log_message(msg, from_key, to_key, include_in_ticket = TRUE, plain_msg = null, message_type = "mentor")
	var/plain_text = plain_msg || strip_html(msg)
	var/log_msg = plain_text

	var/html_msg = msg
	if(!plain_msg)
		html_msg = "[SPAN_MENTORHELP("[from_key] -> [to_key]:")] [msg]"
	else if(from_key && to_key)
		html_msg = "[SPAN_MENTORHELP("[from_key] -> [to_key]:")] [plain_text]"

	if(from_key && to_key)
		var/from_ic = ""
		var/to_ic = ""
		if(from_key == author_key)
			from_ic = " ([get_author_ic_name()])"
		else if(mentor && from_key == mentor.key)
			from_ic = " ([mentor_ic_name])"

		if(to_key == author_key)
			to_ic = " ([get_author_ic_name()])"
		else if(mentor && to_key == mentor.key)
			to_ic = " ([mentor_ic_name])"

		log_msg = "[from_key]/([from_ic]) -> [to_key]/([to_ic]): [plain_text]"
	log_mhelp(log_msg)

	if(include_in_ticket)
		var/html_message = "[time_stamp()]: [html_msg]"
		var/list/structured_data = list(
			"timestamp" = worldtime2text(world.time),
			"author" = from_key || "System",
			"message" = plain_text,
			"html_message" = html_msg,
			"type" = message_type
		)

		ticket_interactions[html_message] = structured_data

		latest_message = plain_text

/datum/mentorhelp/proc/notify(text, to_thread_mentor = TRUE, to_mentors = TRUE, to_staff = TRUE, unformatted_text = null)
	var/list/hitlist = list()
	if(to_thread_mentor && mentor)
		hitlist |= mentor
	for(var/client/candidate in GLOB.admins)
		if(to_mentors && CLIENT_IS_MENTOR(candidate))
			hitlist |= candidate
		else if(to_staff && CLIENT_IS_STAFF(candidate))
			hitlist |= candidate

	var/unformatted = unformatted_text || text
	var/latest_msg_unformatted = unformatted

	for(var/client/receiver in hitlist)
		if(istype(receiver))
			var/msg_to_send = text
			if(!CLIENT_IS_STAFF(receiver))
				if(author_key)
					msg_to_send = replacetext(msg_to_send, author_key, get_author_ic_name())
			var/displaymsg = "[SPAN_MENTORHELP("<span class='prefix'>MENTOR LOG:</span> <span class='message'>[msg_to_send]</span>")]"
			to_chat(receiver, displaymsg)

	if(!to_mentors)
		if(author_key)
			latest_msg_unformatted = replacetext(latest_msg_unformatted, author_key, get_author_ic_name())
		latest_message = latest_msg_unformatted

	var/html_message = "[time_stamp()]: [text]"
	var/list/structured_data = list(
		"timestamp" = worldtime2text(world.time),
		"author" = "System",
		"message" = unformatted,
		"type" = "system"
	)
	ticket_interactions[html_message] = structured_data

/datum/mentorhelp/proc/broadcast_request(client/opener)
	if(!opener || !open || !check_author())
		return FALSE // Invalid
	if(mentor)
		return TRUE // No need

	var/message = strip_html(html_decode(
			tgui_input_text(opener, "Сообщение:", "MentorHelp", null, 500, TRUE)
		)) //SS220 - EDIT
	if(!message)
		return FALSE
	//BANDAMARINES LOGIS EDIT START
	var/list/mentor_counts = get_admin_counts(R_MENTOR)
	var/logis_mhelp_line = logis_mentorhelp_ticket_line(opener, message, length(mentor_counts["present"]))
	if(logis_mhelp_line)
		log_to_logis("ADMIN", logis_mhelp_line)
	//BANDAMARINES LOGIS EDIT END
	if(!initial_message)
		initial_message = message

	latest_message = message

	broadcast_unhandled(message, opener)
	return TRUE

/datum/mentorhelp/proc/broadcast_unhandled(msg, client/sender)
	if(!mentor && open)
		message_handlers(msg, sender)
		addtimer(CALLBACK(src, PROC_REF(broadcast_unhandled), msg, sender), 5 MINUTES)

/datum/mentorhelp/proc/message_handlers(msg, client/sender, client/recipient, with_sound = TRUE, staff_only = FALSE, include_keys = TRUE)
	if(!sender || !check_author())
		return
	// SS220 EDIT - START
	var/message_entry = list(
		"sender" = sender.key,
		"recipient" = recipient?.key || "All mentors",
		"text" = msg,
		"timestamp" = world.time
	)
	messages += list(message_entry)
	// SS220 EDIT - END

	var/msg_type = "mentor"
	if(sender == author)
		msg_type = "legacy"
	else if(!sender)
		msg_type = "system"

	if(recipient)
		log_message(msg, sender.key, recipient.key, msg_type)
	else
		log_message(msg, sender.key, "Всем менторам", msg_type)

	// Sender feedback
	var/feedback_recipient_text
	if(recipient)
		var/display_text = get_display_name(sender, recipient)
		feedback_recipient_text = "<a href='byond://?src=\ref[src];action=message'>[display_text]</a>"
	else
		feedback_recipient_text = "mentors"
	to_chat(sender, "[SPAN_MENTORHELP("<span class='prefix'>MentorHelp:</span> сообщение [feedback_recipient_text]:")] [SPAN_MENTORBODY(msg)]")

	// Recipient direct message
	if(recipient)
		if(with_sound && (recipient.prefs?.toggles_sound & SOUND_ADMINHELP))
			sound_to(recipient, 'sound/effects/mhelp.ogg')
		to_chat(recipient, wrap_message(msg, sender, recipient))

	for(var/client/admin_client in GLOB.admins)
		var/formatted = msg
		var/soundfile

		if(!admin_client || admin_client == recipient)
			continue

		// Initial broadcast
		else if(!staff_only && !recipient && CLIENT_HAS_RIGHTS(admin_client, R_MENTOR))
			formatted = wrap_message(formatted, sender, admin_client)
			soundfile = 'sound/effects/mhelp.ogg'

		// Eavesdrop
		else if(CLIENT_HAS_RIGHTS(admin_client, R_MENTOR) && (!staff_only || CLIENT_IS_STAFF(admin_client)) && admin_client != sender)
			if(include_keys)
				var/sender_text = get_display_name(admin_client, sender)
				var/recipient_text = recipient ? get_display_name(admin_client, recipient) : "All mentors"
				formatted = SPAN_MENTORHELP(sender_text + " -> " + recipient_text + ": ") + msg

		else
			continue

		if(soundfile && with_sound && (admin_client.prefs?.toggles_sound & SOUND_ADMINHELP))
			sound_to(admin_client, soundfile)
		to_chat(admin_client, formatted)
	return

// Makes the sender input a message and sends it
/datum/mentorhelp/proc/input_message(client/sender)
	if(!sender || !check_open(sender))
		return

	if(sender != author)
		if(!CLIENT_IS_MENTOR(sender))
			return

		// If the mentor forgot to mark the mentorhelp, mark it for them
		if(!mentor)
			mark(sender)

		// Some other mentor is already taking care of this thread
		else if(mentor != sender)
			to_chat(sender, SPAN_MENTORHELP("<b>УВЕДОМЛЕНИЕ:</b> Ментор начал отвечать на этот тикет!"))
			return

	var/target = mentor
	if(sender == mentor)
		target = author

	var/message = tgui_input_text(sender, "Please enter your message:", "Mentor Help", null, null, TRUE)
	if(message)
		message = strip_html(html_decode(message))
		message_handlers(message, sender, target)
	return

// Sanitizes and wraps the message with some info and links, depending on the sender...?
/datum/mentorhelp/proc/wrap_message(message, client/sender, client/recipient = null)
	var/message_title = "MentorPM"
	var/message_sender_key = ""
	var/message_sender_options = ""

	// The message is being sent to the mentor and should be formatted as a mentorhelp message
	if(sender == author)
		message_title = "MentorHelp"
		var/display_text = get_display_name(recipient, sender)
		message_sender_key = "<a href='byond://?src=\ref[src];action=message'>[display_text]</a>"

		// If there's a mentor, let them mark it. If not, let them unmark it
		message_sender_options = " (<a href='byond://?src=\ref[src];action=mark'>Mark/Unmark</a>"
		message_sender_options += " | <a href='byond://?src=\ref[src];action=close'>Close</a> | <a href='byond://?src=\ref[src];action=autorespond'>AutoResponse</a>)"
	else
		var/display_text = get_display_name(recipient, sender)
		message_sender_key = "<a href='byond://?src=\ref[src];action=message'>[display_text]</a>"

	var/message_header = SPAN_MENTORHELP("<span class='prefix'>[message_title] от [message_sender_key]:</span> <span class='message'>[message_sender_options]</span><br>") // SS220 EDIT ADDICTION
	var/message_body = "&emsp;[SPAN_MENTORBODY("<span class='message'>[message]</span>")]<br>" // SS220 EDIT ADDICTION
	// Et voila! Beautiful wrapped mentorhelp messages
	return (message_header + message_body)

/*
 * Marking
 */

// Marks the mentorhelp thread and notifies the author that the thread is being responded to
/datum/mentorhelp/proc/mark(client/thread_mentor)
	if(!check_author())
		return

	if(!check_open(thread_mentor))
		return

	// Already marked
	if(mentor)
		if(mentor == thread_mentor)
			to_chat(thread_mentor, SPAN_MENTORHELP("<b>NOTICE:</b> You are already handling this thread!"))
			return
		var/choice = tgui_alert(thread_mentor, "This mentorhelp is already claimed by [mentor.username()]. Do you want to override and take over?", "Claim Mentorhelp", list("Override", "Cancel"))
		if(choice != "Override")
			return
		var/client/prev_mentor = mentor
		mentor = thread_mentor
		mentor_key = mentor.username()
		if(thread_mentor.mob)
			mentor_ic_name = thread_mentor.mob.real_name || thread_mentor.mob.name || "Unknown"

		log_mhelp("[mentor.key] has overridden [prev_mentor.key] on [author_key]'s mentorhelp")
		notify("[SPAN_GREEN(mentor.username())] has overridden [SPAN_GREEN(prev_mentor.username())] on [SPAN_RED(author_key)]'s mentorhelp.",
			unformatted_text = "[mentor.username()] has overridden [prev_mentor.username()] on [author_key]'s mentorhelp.")
		to_chat(author, SPAN_MENTORHELP("NOTICE: [get_display_name(author, mentor)] has taken over your thread and is preparing to respond."))
		return

	if(!thread_mentor)
		return

	if(istype(thread_mentor, /mob))
		var/mob/M = thread_mentor
		thread_mentor = M.client

	if(!istype(thread_mentor))
		return

	// Not a mentor/staff
	if(!CLIENT_IS_MENTOR(thread_mentor))
		return

	mentor = thread_mentor
	mentor_key = mentor.username()
	if(thread_mentor.mob)
		mentor_ic_name = thread_mentor.mob.real_name || thread_mentor.mob.name || "Unknown"

	log_mhelp("[mentor.key] has marked [author_key]'s mentorhelp")
	notify("[SPAN_GREEN(mentor.username())] начал отвечать на тикет [SPAN_RED(author_key)] в «MentorHelp».",
		unformatted_text = "[mentor.username()] начал отвечать на тикет [author_key] в «MentorHelp».") // SS220 EDIT ADDICTION
	to_chat(author, SPAN_MENTORHELP("УВЕДОМЛЕНИЕ: [get_display_name(author, mentor)] начал отвечать на ваш тикет.")) // SS220 EDIT ADDICTION

// Unmarks the mentorhelp thread and notifies the author that the thread is no longer being handled by a mentor
/datum/mentorhelp/proc/unmark(client/thread_mentor)
	if(!check_author())
		return

	if(!check_open(thread_mentor))
		return

	// Already not marked
	if(!mentor)
		return

	// If we're not the thread mentor and not a staff member
	if((!thread_mentor || thread_mentor != mentor) && !CLIENT_IS_STAFF(thread_mentor))
		return

	log_mhelp("[mentor.key] has unmarked [author_key]'s mentorhelp")
	notify("[SPAN_GREEN(mentor.username())] перестал отвечать на тикет [SPAN_RED(author_key)] в «MentorHelp».",
		unformatted_text = "[mentor.username()] перестал отвечать на тикет [author_key] в «MentorHelp».")
	to_chat(author, SPAN_MENTORHELP("УВЕДОМЛЕНИЕ: [get_display_name(author, mentor)] перестал отвечать на ваш тикет."))
	mentor = null
	mentor_key = ""
	mentor_ic_name = ""

/*
 * Misc.
 */

/datum/mentorhelp/proc/reopen()
	if(!check_author())
		return

	if(open)
		to_chat(usr, SPAN_WARNING("This ticket is already open!"))
		return

	if(GLOB.mentorhelp_manager.get_active_ticket_by_ckey(author_key))
		to_chat(usr, SPAN_WARNING("This user already has an open mentor ticket. Please close it first or use the existing one."), confidential = TRUE)
		return FALSE


	if(!author && author_key)
		for(var/client/C in GLOB.clients)
			if(C.ckey == author_key)
				author = C
				break

	var/datum/mentorhelp/existing_mh = GLOB.mentorhelp_manager.get_active_ticket_by_ckey(author_key)
	if(existing_mh && existing_mh != src)
		if(tgui_alert(usr, "[get_display_name(usr.client, author)] already has an open mentorhelp thread. Would you like to close it and reopen this one?", "Existing Mentorhelp Found", list("Yes", "No")) == "Yes")
			existing_mh.close(usr.client)
		else
			to_chat(usr, SPAN_NOTICE("Using the existing mentorhelp thread for [get_display_name(usr.client, author)]."), confidential = TRUE)
			return FALSE

	open = TRUE
	closed_at = null
	time_activity["closed_at"] = null


	if(GLOB.mentorhelp_manager.archived_tickets["[id]"] == src)
		GLOB.mentorhelp_manager.archived_tickets -= "[id]"
		GLOB.mentorhelp_manager.active_tickets["[id]"] = src

	if(author)
		author.current_mhelp = src

	log_mhelp("[usr.key] reopened [author_key]'s mentorhelp thread")
	notify("[SPAN_GREEN(usr.username())] has reopened this mentorhelp thread.",
		unformatted_text = "[usr.username()] has reopened this mentorhelp thread.")

// Closes the thread and notifies the author/mentor that it has been closed
/datum/mentorhelp/proc/close(client/closer)
	if(!open)
		return

	// Thread was closed because the author is gone
	if(!author)
		notify("[SPAN_RED(author_key)] тикет в «MentorHelp» был закрыт, в связи с потерей соединения с пользователем.") // SS220 EDIT ADDICTION
		log_mhelp("[author_key]'s mentorhelp thread was closed because of a disconnection")
		open = FALSE
		if(GLOB.mentorhelp_manager.active_tickets["[id]"] == src)
			GLOB.mentorhelp_manager.active_tickets -= "[id]"
			GLOB.mentorhelp_manager.archived_tickets["[id]"] = src
		closed_at = world.time
		time_activity["closed_at"] = "[worldtime2text(closed_at)]"
		return

	// Make sure it's being closed by staff or the mentor handling the thread
	if(mentor && closer && (closer != mentor) && (closer != author) && !CLIENT_IS_STAFF(closer))
		to_chat(closer, SPAN_MENTORHELP("<b>УВЕДОМЛЕНИЕ:</b> другой ментор уже ответил на этот тикет!"))
		return

	if(!open)
		return

	mentor = null
	open = FALSE

	if(GLOB.mentorhelp_manager.active_tickets["[id]"] == src)
		GLOB.mentorhelp_manager.active_tickets -= "[id]"
		GLOB.mentorhelp_manager.archived_tickets["[id]"] = src

	if(closer)
		log_mhelp("[closer.key] closed [author_key]'s mentorhelp")
		if(closer == author)
			to_chat(author, SPAN_NOTICE("You have closed your mentorhelp thread."))
			notify("[SPAN_RED(author_key)] закрыл свой тикет в «MentorHelp».",
				unformatted_text = "[author_key] закрыл свой тикет в «MentorHelp».")
			return
		else
			to_chat(author, SPAN_NOTICE("Ваш тикет в «MentorHelp» был закрыт: [get_display_name(author, closer)]."))
			notify("[SPAN_GREEN(closer.username())] закрывает тикет [SPAN_RED(author_key)] в «MentorHelp».",
				unformatted_text = "[closer.username()] закрывает тикет [author_key] в «MentorHelp».")
			return
	to_chat(author, SPAN_NOTICE("Ваш тикет в «MentorHelp» был закрыт."))
	notify("[SPAN_RED(author_key)] тикет в «MentorHelp» был закрыт.",
			unformatted_text = "[author_key] тикет в «MentorHelp» был закрыт.") // SS220 EDIT ADDICTION
	closed_at = world.time
	time_activity["closed_at"] = "[worldtime2text(closed_at)]"

	// Clear the client reference if they're still connected
	if(author && author.current_mhelp == src)
		author.current_mhelp = null

/datum/mentorhelp/proc/Respond(msg, client/mentor)
	if(!check_author())
		return

	if(!check_open(mentor))
		return

	if(!CLIENT_IS_MENTOR(mentor))
		return

	if(!src.mentor)
		mark(mentor)

	msg = strip_html(html_decode(msg))
	if(!msg)
		return

	message_handlers(msg, mentor, author)

	return TRUE

/datum/mentorhelp/Topic(href, list/href_list)
	if(!usr)
		return
	var/client/C = usr.client
	if(!istype(C))
		return

	switch(href_list["action"])
		if("message")
			input_message(C)
		if("autorespond")
			autoresponse(C)
		if("mark")
			if(!mentor)
				mark(C)
			else
				unmark(C)
		if("close")
			if(C == author || C == mentor || CLIENT_IS_STAFF(C))
				close(C)
				//SS220 EDIT - START
				C << browse(null, "window=mentorchat_[REF(src)]")
		if("open_chat")
			if(!check_open(C) || !CLIENT_IS_MENTOR(C))
				return
			show_chat_window(C)
		if("send_chat_message")
			if(!check_open(C))
				to_chat(C, SPAN_MENTORHELP("Этот тикет закрыт!"))
				return
			if(C != author && C != mentor && !CLIENT_IS_STAFF(C))
				to_chat(C, SPAN_MENTORHELP("Вы не можете отправлять сообщения в этот тикет!"))
				return
			var/message = strip_html(href_list["chat_msg"])
			if(!message || !length(trim(message)))
				to_chat(C, SPAN_MENTORHELP("Сообщение не может быть пустым!"))
				return
			var/client/recipient = (C == author) ? mentor : author
			if(!recipient && C == author)
				recipient = null
			if(C != author && !mentor)
				mark(C)
			else if(C != author && mentor != C)
				to_chat(C, SPAN_MENTORHELP("<b>УВЕДОМЛЕНИЕ:</b> Другой ментор уже отвечает на этот тикет!"))
				return
			message_handlers(message, C, recipient)
			show_chat_window(C)
			if(recipient && recipient != C)
				show_chat_window(recipient)
				//SS220 EDIT - END
/*
 * Autoresponse
 * Putting this here cause it's long and ugly
 */

// responder is the guy responding to the thread, i.e. the mentor triggering the autoresponse
/datum/mentorhelp/proc/autoresponse(client/responder)
	if(!check_author())
		return

	if(!check_open(responder))
		return

	if(!CLIENT_IS_MENTOR(responder))
		return

	// If the mentor forgot to mark the mentorhelp, mark it for them
	if(!mentor)
		mark(responder)
	else if(mentor != responder)
		to_chat(responder, SPAN_NOTICE("<b>УВЕДОМЛЕНИЕ:</b> Ментор начал отвечать на этот тикет!"))
		return

	var/choice = tgui_input_list(usr, "Выберите шаблон для ответа игроку.", "АвтоОтвет", GLOB.mentorreplies) // SS220 EDIT ADDICTION
	var/datum/autoreply/mentor/response = GLOB.mentorreplies[choice]

	if(!response || !istype(response))
		return

	if(!check_author())
		return

	if(!check_open(responder))
		return

	if(!CLIENT_IS_MENTOR(responder))
		return

	// Re-mark if they unmarked it while the dialog was open (???)
	if(!mentor)
		mark(responder)
	else if(mentor != responder)
		to_chat(responder, SPAN_NOTICE("<b>УВЕДОМЛЕНИЕ:</b> Ментор начал отвечать на этот тикет!"))
		return

	var/msg = "Ментор отметил вопрос как: «[response.title]»!" // SS220 EDIT ADDICTION
	msg += "[response.message]"

	message_handlers(msg, responder, author)


/proc/message_mentors(message)
	for(var/client/mentor in GLOB.clients)
		if(CLIENT_IS_MENTOR(mentor))
			to_chat(mentor, message)
	return TRUE

/proc/mentorhelp_by_id(id)
	if(!id)
		return null
	return GLOB.mentorhelp_manager.get_ticket_by_id(id)


/datum/mentorhelp/proc/set_subject(subject, client/responder)
	if(!CLIENT_IS_MENTOR(responder))
		return
	src.subject = sanitize(subject)
	return TRUE

/datum/mentorhelp/proc/defer_to_admins(client/deferrer)
	if(!check_author())
		return

	if(!check_open(deferrer))
		return

	if(!CLIENT_IS_MENTOR(deferrer))
		return

	if(mentor && mentor != deferrer)
		to_chat(deferrer, SPAN_WARNING("This ticket is currently marked by [mentor.username()]. Please override their mark to interact with this ticket!"))
		return

	if(author.current_ticket)
		to_chat(deferrer, SPAN_WARNING("This user already has an active adminhelp ticket. Please close it first or use the existing one."))
		return

	var/options = tgui_alert(deferrer, "Use the first message in this ticket, or a custom option?", "Defer to Admins", list("First Message", "Custom"))
	if(!options)
		return

	var/defer_header = "[deferrer.username()] has deferred a ticket ([author_key]) to admins"

	var/message = ""
	switch(options)
		if("First Message")
			message = "[defer_header]\n\n[initial_message]"
		if("Custom")
			var/custom_msg = tgui_input_text(deferrer, "Text to Send to Admins", "Defer to Admins")
			if(!custom_msg)
				return
			message = "[defer_header]\n\n[custom_msg]\n\nOriginal message: [initial_message]"

	if(!message)
		return

	var/datum/admin_help/help_ticket = new /datum/admin_help(message, author, FALSE)
	help_ticket.subject = subject
	help_ticket.AddInteraction("Deferred from Mentorhelp by [deferrer.username()].", plain_message = "Deferred from Mentorhelp by [deferrer.username()]", message_type = "system")

	notify("[SPAN_RED(deferrer.username())] deferred this ticket to admins.",
		unformatted_text = "[deferrer.username()] deferred this ticket to admins.")
	to_chat(author, SPAN_MENTORHELP("[get_display_name(author, deferrer)] has deferred your ticket to Admins."))
	log_mhelp("[deferrer.key] deferred [author_key]'s mentorhelp to admins.")
	for(var/client/admin in GLOB.admins)
		if(CLIENT_IS_MENTOR(admin) || CLIENT_IS_STAFF(admin))
			to_chat(admin, SPAN_MENTORHELP("[get_display_name(admin, deferrer)] has deferred [get_display_name(admin, author)]'s ticket to Admins."))
	close(deferrer)
//SS220 EDIT START
/client/verb/mentor_view_open_tickets()
	set name = "View Open Tickets"
	set category = "Admin.Mentor"
	if(!check_rights(R_MENTOR))
		return

	var/html = "<html><head>"
	html += "<meta charset='UTF-8'>"
	html += "<style>"
	html += "body { background-color: #2b2b2b; color: #e0e0e0; font-family: Arial, sans-serif; }"
	html += "h2 { color: #ffb02e; }"
	html += "table { width: 100%; border-collapse: collapse; }"
	html += "th, td { padding: 8px; text-align: left; border: 1px solid #444; }"
	html += "th { background-color: #3a3a3a; color: #ffb02e; }"
	html += "tr:nth-child(even) { background-color: #333; }"
	html += "tr:nth-child(odd) { background-color: #2b2b2b; }"
	html += "a { color: #ffb02e; text-decoration: none; }"
	html += "a:hover { text-decoration: underline; }"
	html += "i { color: #888; }"
	html += ".auto-response-btn { color: #ff8800; margin-left: 10px; }"
	html += ".auto-response-btn:hover { color: #cc6600; text-decoration: underline; }"
	html += "</style></head><body>"
	html += "<h2>Open MentorHelp Tickets</h2>"
	html += "<table>"
	html += "<tr><th>Sender</th><th>Mentor</th><th>Status</th><th>Actions</th></tr>"
	var/open_count = 0
	for(var/datum/mentorhelp/MH in GLOB.mentorhelp_tickets)
		if(MH.open)
			open_count++
			html += "<tr>"
			html += "<td>[MH.author_key]</td>"
			html += "<td>[MH.mentor ? MH.mentor.key : "None"]</td>"
			html += "<td>[MH.open ? "Open" : "Closed"]"
			html += "<td>"
			html += "<a href='byond://?src=\ref[MH];action=open_chat'>Message</a>"
			if(MH.open)
				html += " <a href='byond://?src=\ref[MH];action=autorespond' class='auto-response-btn'>AutoResponse</a>"
			html += "</td>"
			html += "</tr>"
	html += "</table>"
	html += "<i>Total open tickets: [open_count]</i>"
	html += "</body></html>"

	usr << browse(html, "window=mentoropentickets;size=600x500")

/datum/mentor/proc/show_open_tickets(mob/user)

/datum/mentorhelp/proc/show_chat_window(client/user)
	if(!check_author() || !check_open(user))
		return

	var/html = "<html><head>"
	html += "<meta charset='UTF-8'>"
	html += "<style>"
	html += "* { box-sizing: border-box; }"
	html += "body { background-color: #2b2b2b; color: #e0e0e0; font-family: Arial, sans-serif; margin: 0; padding: 10px; overflow-y: auto; }"
	html += "h3 { color: #ffb02e; margin: 0; display: inline-block; }"
	html += ".header { display: flex; align-items: center; padding: 10px 0; width: 100%; }"
	html += ".close-btn-container { margin-left: auto; }"
	html += ".close-btn { padding: 5px 10px; background-color: #ff4444; color: #fff; border: none; cursor: pointer; text-decoration: none; }"
	html += ".close-btn:hover { background-color: #cc3333; }"
	html += ".message { margin: 5px 0; padding: 5px; background-color: #333; border-radius: 5px; }"
	html += ".sender { color: #ffb02e; font-weight: bold; }"
	html += ".timestamp { color: #888; font-size: 0.8em; }"
	html += ".input-container { margin-top: 10px; position: sticky; bottom: 10px; background-color: #2b2b2b; padding: 5px 0; display: flex; align-items: center; width: 100%; }"
	html += "input { flex-grow: 1; padding: 8px; background-color: #444; color: #e0e0e0; border: 1px solid #666; margin-right: 5px; height: 34px; }"
	html += "button { padding: 8px 10px; background-color: #ffb02e; color: #fff; border: none; cursor: pointer; height: 34px; margin-left: auto; }"
	html += "button:hover { background-color: #0099cc; }"
	html += "</style>"
	html += "<script>"

	html += "function resizeMessagesArea() {"
	html += "   var headerHeight = document.querySelector(\".header\").offsetHeight;"
	html += "   var inputHeight = document.querySelector(\".input-container\").offsetHeight;"
	html += "   var windowHeight = window.innerHeight;"
	html += "   document.body.style.minHeight = windowHeight + \"px\";"
	html += "}"
	html += "window.addEventListener(\"resize\", resizeMessagesArea);"

	html += "window.onload = function() {"
	html += "   resizeMessagesArea();"
	html += "   window.scrollTo(0, document.body.scrollHeight);"
	html += "};"
	html += "</script>"
	html += "</head><body>"

	html += "<div class='header'>"
	html += "<h3>MentorChat</h3>"
	html += "<div class='close-btn-container'>"
	if(user == author || user == mentor || CLIENT_IS_STAFF(user))
		html += "<a href='byond://?src=\ref[src];action=close' class='close-btn'>Close Ticket</a>"
	html += "</div>"
	html += "</div>"

	if(length(messages) == 0)
		html += "<i>No messages yet. Start chatting below!</i>"
	else
		for(var/list/msg in messages)
			var/time_formatted = time2text(msg["timestamp"], "hh:mm:ss")
			html += "<div class='message'>"
			html += "<span class='timestamp'>[time_formatted]</span> "
			html += "<span class='sender'>[msg["sender"]]</span> - [msg["recipient"]]: "
			html += "[msg["text"]]"
			html += "</div>"

	html += "<div class='input-container'>"
	html += "<form action='byond://?src=\ref[src]' method='get' style='display: flex; width: 100%;'>"
	html += "<input type='hidden' name='src' value='\ref[src]'>"
	html += "<input type='hidden' name='action' value='send_chat_message'>"
	html += "<input type='text' id='chat_msg' name='chat_msg' placeholder='Type your message...'>"
	html += "<button type='submit'>Send</button>"
	html += "</form>"
	html += "</div>"

	html += "</body></html>"

	user << browse(html, "window=mentorchat_[REF(src)];size=1000x600")

/client/verb/mentorhelp_open_chat()
	set name = "Open Mentor Chat"
	set category = "Admin.Mentor"

	var/datum/mentorhelp/MH
	for(var/datum/mentorhelp/ticket in GLOB.mentorhelp_tickets)
		if(ticket.author == src && ticket.open)
			MH = ticket
			break

	if(!MH)
		to_chat(src, SPAN_MENTORHELP("У вас нет открытых тикетов"))
		return

	MH.show_chat_window(src)
	//SS220 EDIT END
