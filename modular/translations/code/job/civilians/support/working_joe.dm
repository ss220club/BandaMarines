#define STANDARD_VARIANT "Working Joe"
#define HAZMAT_VARIANT "Hazmat Joe"

/datum/job/civilian/working_joe
	disp_title = JOB_WORKING_JOE_RU
	supervisors = "ARES и APOLLO"
	job_options = list(STANDARD_VARIANT = "JOE", HAZMAT_VARIANT = "HAZ")

/datum/job/civilian/working_joe/generate_entry_message(mob/living/carbon/human/H)
	if(standard)
		. = {"You are a <a href='[generate_wiki_link()]'>Working Joe.</a> You are held to a higher standard and are required to obey not only the Server Rules but Marine Law, Roleplay Expectations and Synthetic Rules.  Your primary task is to maintain the cleanliness of the ship, putting things in their proper place. Alternatively, your primary task may be to assist with manual labor in limited capacity, or clerical duties. Your capacities are limited, but you have all the equipment you need, and the central AI has a plan! Stay in character at all times. Use the APOLLO link to communicate with your uplink!"}
	else
		. = {"You are a <a href='[generate_wiki_link()]'>Working Joe</a> for Hazardous Environments!  You are held to a higher standard and are required to obey not only the Server Rules but Marine Law, Roleplay Expectations and Synthetic Rules.  You are a variant of the Working Joe built for tougher environments and fulfill the specific duty of dangerous repairs or maintenance. Your primary task is to maintain the reactor, SMES and AI Core. Your secondary task is to respond to hazardous environments, such as an atmospheric breach or biohazard spill, and assist with repairs when ordered to by either an AI Mainframe, or a Commisioned Officer.  You should not be seen outside of emergencies besides in Engineering and the AI Core! Stay in character at all times. Use the APOLLO link to communicate with your uplink!"}


/datum/job/antag/upp/dzho_automaton
	disp_title = JOB_UPP_JOE_RU
	supervisors = "1VAN/3 и командным составом СПН"

/datum/job/antag/upp/dzho_automaton/generate_entry_message(mob/living/carbon/human/H)
	. = {"You are a <a>Dzho Automaton.</a> You are held to a higher standard and are required to obey not only the Server Rules but UPP Law, Roleplay Expectations and Synthetic Rules. Your primary task is to maintain the ship, patrol and other tasks given to you by UPP officer staff. Alternatively, your primary task may be to assist with manual labor in limited capacity, or clerical duties. You can perform brig duties and security duties if needed. You have a firearm permit and can use lethal force where applicable. Your capacities are limited, but you have all the equipment you need, and the central AI has a plan! Stay in character at all times.!"}

