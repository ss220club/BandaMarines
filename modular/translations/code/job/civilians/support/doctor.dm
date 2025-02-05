//job options for doctors surgeon pharmacy technician(preparation of medecine and distribution)

#define DOCTOR_VARIANT "Doctor"
#define SURGEON_VARIANT "Surgeon"

// Doctor
/datum/job/civilian/doctor
	title = JOB_DOCTOR
	supervisors = "the chief medical officer"
	job_options = list(DOCTOR_VARIANT = "Doc", SURGEON_VARIANT = "Sur")

//check what job option you took and generate the corresponding the good texte.
/datum/job/civilian/doctor/generate_entry_message(mob/living/carbon/human/H)
	if(doctor)
		. = {"You're a commissioned officer of the USCM. <a href='[generate_wiki_link()]'>You are a doctor and tasked with keeping the marines healthy and strong, usually in the form of surgery.</a> You are a jack of all trades in medicine: you can medicate, perform surgery and produce pharmaceuticals. If you do not know what you are doing, mentorhelp so a mentor can assist you."}
	else
		. = {"You're a commissioned officer of the USCM. <a href='[generate_wiki_link()]'>You are a surgeon and tasked with keeping the marines healthy and strong, usually in the form of surgery.</a> You are a doctor that specializes in surgery, but you are also very capable in pharmacy and triage. If you do not know what you are doing, mentorhelp so a mentor can assist you."}
