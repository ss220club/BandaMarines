#define MILITARY_VARIANT JOB_MILITARY_REPORTER_RU	// SS220 EDIT TRANSLATE
#define CIVILIAN_VARIANT JOB_CIVILIAN_REPORTER_RU	// SS220 EDIT TRANSLATE

/datum/job/civilian/reporter
	title = JOB_COMBAT_REPORTER
	total_positions = 1
	spawn_positions = 1
	selection_class = "job_cl"
	supervisors = "the acting commanding officer"
	gear_preset = /datum/equipment_preset/uscm_ship/reporter
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	selection_class = "job_cl"

	job_options = list(CIVILIAN_VARIANT = "Грж", MILITARY_VARIANT = "Вое", JOB_COMBAT_REPORTER_RU = "Пол")
	/// If this job is a military variant of the reporter role
	var/military = FALSE

/datum/job/civilian/reporter/handle_job_options(option)
	// SS220 EDIT START
	switch(option)
		if(CIVILIAN_VARIANT)
			gear_preset = /datum/equipment_preset/uscm_ship/reporter_uscm
			military = TRUE
		if(JOB_COMBAT_REPORTER_RU)
			gear_preset = /datum/equipment_preset/uscm_ship/reporter/field
			military = TRUE
		else
			gear_preset = initial(gear_preset)
			military = initial(military)
	// SS220 EDIT END

/datum/job/civilian/reporter/generate_entry_message(mob/living/carbon/human/H)
	if(military)
		. = {"The USCM has assigned you to the [MAIN_SHIP_NAME] to better handle messaging on how things run in the Neroid Sector. Get out there and show the universe that the USCM is doing great things!"}
	else
		. = {"What a scoop! You've been assigned to the [MAIN_SHIP_NAME] to see what kinda mischief they'd get into and it seems trouble is here!
This could be the story of the sector! 'Brave Marines responding to dangerous distress signal!' It'd surely get Mr. Parkerson to notice you in the office if you brought him a story like this!"}

/obj/effect/landmark/start/reporter
	name = JOB_COMBAT_REPORTER
	icon_state = "cc_spawn"
	job = /datum/job/civilian/reporter

AddTimelock(/datum/job/civilian/reporter, list(
	JOB_HUMAN_ROLES = 10 HOURS,
))
