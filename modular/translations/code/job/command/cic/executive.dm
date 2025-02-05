//Executive Officer
/datum/job/command/executive
	disp_title = JOB_XO_RU

/datum/job/command/executive/generate_entry_message(mob/living/carbon/human/H)
	entry_message_body = "<a href='[generate_wiki_link()]'>You are second in command aboard the [MAIN_SHIP_NAME],</a> and are in next in the chain of command after the Commanding Officer. Where applicable, you must abide by the <a href='[CONFIG_GET(string/wikiarticleurl)][URL_WIKI_CO_RULES]'>Commanding Officer Code of Conduct</a>. You may need to fill in for other duties if areas are understaffed, and you are given access to do so. Make the USCM proud!"
	return ..()

/datum/job/command/executive/announce_entry_message(mob/living/carbon/human/H)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(all_hands_on_deck), "Attention all hands, [H.get_paygrade(0)] [H.real_name] on deck!"), 1.5 SECONDS)
	return ..()
