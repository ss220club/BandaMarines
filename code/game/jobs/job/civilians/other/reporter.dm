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

	job_options = list(CIVILIAN_VARIANT = "Грж", MILITARY_VARIANT = "Вое", JOB_COMBAT_REPORTER_RU = "Пол")
	/// If this job is a military variant of the reporter role
	var/military = FALSE

/datum/job/civilian/reporter/handle_job_options(option)
	// SS220 EDIT START
	switch(option)
		if(MILITARY_VARIANT)
			gear_preset = /datum/equipment_preset/uscm_ship/reporter_uscm
			disp_title = JOB_MILITARY_REPORTER_RU
			military = TRUE
		if(JOB_COMBAT_REPORTER_RU)
			gear_preset = /datum/equipment_preset/uscm_ship/reporter/field
			disp_title = JOB_COMBAT_REPORTER_RU
			military = TRUE
		else
			gear_preset = initial(gear_preset)
			disp_title = JOB_CIVILIAN_REPORTER_RU
			military = initial(military)
	// SS220 EDIT END

/datum/job/civilian/reporter/generate_entry_message(mob/living/carbon/human/H)
	if(military)
		. = {"ККМП США прикомандировало вас к [MAIN_SHIP_NAME], чтобы вы наладили информирование населения о том, как идут дела в секторе Нероид. Ступайте и покажите вселенной, что ККМП совершает великие деяния!"}
	else
		. = {"Вот это удача! Тебя прикомандировали к [MAIN_SHIP_NAME], чтобы посмотреть, в какие неприятности они вляпаются, и, похоже, проблемы не заставили себя ждать!
Эта история может стать настоящей сенсацией! «Бравая морская пехота отвечает на опасный сигнал бедствия!» Это точно заставит мистера Паркерсона заметить тебя в агентстве, если ты принесешь ему историю, наподобие этой!"}

/obj/effect/landmark/start/reporter
	name = JOB_COMBAT_REPORTER
	icon_state = "cc_spawn"
	job = /datum/job/civilian/reporter

AddTimelock(/datum/job/civilian/reporter, list(
	JOB_HUMAN_ROLES = 10 HOURS,
))
