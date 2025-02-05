#define MILITARY_VARIANT "Military Correspondent"
#define CIVILIAN_VARIANT "Civilian Correspondent"

/datum/job/civilian/reporter
	disp_title = JOB_COMBAT_REPORTER_RU
	supervisors = "the acting commanding officer"
	job_options = list(CIVILIAN_VARIANT = "Civ", MILITARY_VARIANT = "Mil")

	// ??? Тут надо глянуть по префам опшинов

/datum/job/civilian/reporter/generate_entry_message(mob/living/carbon/human/H)
	if(military)
		. = {"The USCM has assigned you to the [MAIN_SHIP_NAME] to better handle messaging on how things run in the Neroid Sector. Get out there and show the universe that the USCM is doing great things!"}
	else
		. = {"What a scoop! You've been assigned to the [MAIN_SHIP_NAME] to see what kinda mischief they'd get into and it seems trouble is here!
This could be the story of the sector! 'Brave Marines responding to dangerous distress signal!' It'd surely get Mr. Parkerson to notice you in the office if you brought him a story like this!"}
