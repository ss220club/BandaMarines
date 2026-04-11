//Job options for doctors based on their specialty. They can all manufacture chemicals, administer medication, and operate on patients, but the variants have specialities that they prioritize in.

#define DOCTOR_VARIANT JOB_DOCTOR_RU // SS220 EDIT TRANSLATE - Original: // "Doctor" // "I do not have a specialty; I go where I am needed most."
#define PHARMACIST_VARIANT JOB_PHARMACIST_RU // SS220 EDIT TRANSLATE - Original: "Pharmaceutical Physician" // "I specialize in chemistry and medicine."
#define SURGEON_VARIANT JOB_SURGEON_RU // SS220 EDIT TRANSLATE - Original: "Surgeon" // "I specialize in surgery and triage."

// Doctor
/datum/job/civilian/doctor
	title = JOB_DOCTOR
	total_positions = 5
	spawn_positions = 5
	allow_additional = 1
	scaled = 1
	supervisors = "the chief medical officer"
	selection_class = "job_doctor"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor

	// job option
	job_options = list(DOCTOR_VARIANT = "Врч", PHARMACIST_VARIANT = "Фрм", SURGEON_VARIANT = "Хир")
	/// The doctor variant of the doctor role that was selected in handle_job_options
	var/doctor_variant

//check the job option. and change the gear preset
/datum/job/civilian/doctor/handle_job_options(option)
	doctor_variant = option
	switch(option)
		if(SURGEON_VARIANT)
			gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor/surgeon
			disp_title = JOB_SURGEON_RU
		if(PHARMACIST_VARIANT)
			gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor/pharmacist
			disp_title = JOB_PHARMACIST_RU
		else
			gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor
			disp_title = JOB_DOCTOR_RU

//check what job option you took and generate the corresponding the good texte.
/datum/job/civilian/doctor/generate_entry_message(mob/living/carbon/human/target)
	switch(doctor_variant)
		if(SURGEON_VARIANT)
			. = {"Вы кадровый офицер ККМП. <a href='[generate_wiki_link()]'>Вы врач, специализирующийся на хирургии.</a> Ваша основная задача заключается в том, чтобы поддерживать здоровье морпехов, вправляя сломанные кости, залечивая кровяные сосуды и органы, вытаскивая инородные предметы из тел пациентов. Вы также сведущи в фармакологии и создании препаратов; если в фармакологическом и триажном отделениях не хватает персонала, и вам некого туда поставить на замену, в ваших обязанностях создание новых препаратов и назначение лечения для пациентов. Если вы не знаете, что делать, используйте "mentorhelp", чтобы ментор мог вам помочь."}
		if(PHARMACIST_VARIANT)
			. = {"Вы кадровый офицер ККМП. <a href='[generate_wiki_link()]'>Вы врач, специализирующийся на фармакологии и химии.</a> Ваша основная задача заключается в создании препаратов и химикатов для медицинского отдела и морпехов, помимо этого вы же должны контролировать применение препаратов пациентами в зависимости от тяжести их диагноза. Вы также сведущи в хирургии; если врачей не хватает, чтобы оперировать раненых, то после создания установленной нормы лекарств, вы обязаны отправиться в хирургический отдел. Если вы не знаете, что делать, используйте "mentorhelp", чтобы ментор мог вам помочь."}
		else
			. = {"Вы кадровый офицер ККМП. <a href='[generate_wiki_link()]'>Вы врач.</a> Вы не специализируетесь на какой-либо области, но несмотря на это вы остаетесь профессионалом своего дела с обширными знаниями в фармакологии, препаратах, триаже и хирургии. Ваша основная задача заключается в опознании угрозы здоровью пациента и его дальнейшем лечении в зависимости от тяжести диагноза. Однако в ваши обязанности также входит создание химикатов и реагентов, а также оперирование раненых, если в фармакологическом и хирургическом отделениях не хватает персонала. Если вы не знаете, что делать, используйте "mentorhelp", чтобы ментор мог вам помочь."}

/datum/job/civilian/doctor/set_spawn_positions(count)
	spawn_positions = doc_slot_formula(count)

/datum/job/civilian/doctor/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = doc_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/civilian/doctor, list(
	JOB_MEDIC_ROLES = 1 HOURS
))

/datum/job/civilian/doctor/generate_entry_conditions(mob/living/M, whitelist_status)
	. = ..()
	if(!islist(GLOB.marine_officers[JOB_DOCTOR]))
		GLOB.marine_officers[JOB_DOCTOR] = list()
	GLOB.marine_officers[JOB_DOCTOR] += M
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_leader_candidate))

/datum/job/civilian/doctor/proc/cleanup_leader_candidate(mob/M)
	SIGNAL_HANDLER
	GLOB.marine_officers[JOB_DOCTOR] -= M

/obj/effect/landmark/start/doctor
	name = JOB_DOCTOR
	icon_state = "doc_spawn"
	job = /datum/job/civilian/doctor
