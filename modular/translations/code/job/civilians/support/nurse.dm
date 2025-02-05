/datum/job/civilian/nurse
	title = JOB_NURSE
	supervisors = "the chief medical officer"
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You are tasked with keeping the Marines healthy and strong.</a> You are also an expert when it comes to medication and treatment, and can do minor surgical procedures. Focus on assisting doctors and triaging wounded marines."

// Разделение на Гендеры Медсестра/Медбрат
/datum/equipment_preset/uscm_ship/uscm_medical/nurse/male
	assignment = JOB_NURSE_RU_MALE

/datum/equipment_preset/uscm_ship/uscm_medical/nurse/female
	assignment = JOB_NURSE_RU_FEMALE

// Здесь нету pre_equip
/datum/job/civilian/doctor/spawn_and_equip(mob/new_player/player)
	if (player.gender == MALE)
		gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/nurse/male
	else if(player.gender == FEMALE)
		gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/nurse/female
	. = ..()

