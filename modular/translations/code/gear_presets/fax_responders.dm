/datum/equipment_preset/fax_responder/load_id(mob/living/carbon/human/new_human, client/mob_client)
	if(assignment)
		switch(assignment)
			if(JOB_FAX_RESPONDER)
				assignment = JOB_FAX_RESPONDER_RU
			if(JOB_FAX_RESPONDER_USCM_HC)
				assignment = JOB_FAX_RESPONDER_USCM_HC_RU
			if(JOB_FAX_RESPONDER_USCM_PVST)
				assignment = JOB_FAX_RESPONDER_USCM_PVST_RU
			if(JOB_FAX_RESPONDER_WY)
				assignment = JOB_FAX_RESPONDER_WY_RU
			if(JOB_FAX_RESPONDER_UPP)
				assignment = JOB_FAX_RESPONDER_UPP_RU
			if(JOB_FAX_RESPONDER_TWE)
				assignment = JOB_FAX_RESPONDER_TWE_RU
			if(JOB_FAX_RESPONDER_CLF)
				assignment = JOB_FAX_RESPONDER_CLF_RU
			if(JOB_FAX_RESPONDER_CMB)
				assignment = JOB_FAX_RESPONDER_CMB_RU
			if(JOB_FAX_RESPONDER_PRESS)
				assignment = JOB_FAX_RESPONDER_PRESS_RU
	. = ..()
