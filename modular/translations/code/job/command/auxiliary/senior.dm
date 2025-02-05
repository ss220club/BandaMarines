/datum/job/command/senior
	disp_title = JOB_SEA_RU
	job_options = list("Gunnery Sergeant" = "GySGT", "Master Sergeant" = "MSgt", "First Sergeant" = "1Sgt", "Master Gunnery Sergeant" = "MGySgt", "Sergeant Major" = "SgtMaj")

/datum/job/command/senior/on_config_load()
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You are</a> held to a higher standard and are required to obey not only the Server Rules but <a href='"+LAW_PLACEHOLDER+"'>Marine Law</a> and <a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_SOP]'>Standard Operating Procedure</a>. Failure to do so may result in your Mentorship Removal. Your primary job is to teach others the game and its mechanics, and offer advice to all USCM Departments and Personnel on-board."
	return ..()

/datum/job/command/senior/announce_entry_message(mob/living/carbon/human/H)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(all_hands_on_deck), "Attention all hands, [H.get_paygrade(0)] [H.real_name] on deck!", MAIN_AI_SYSTEM, sound('sound/misc/attention_jingle.ogg')), 1.5 SECONDS)
	return ..()
