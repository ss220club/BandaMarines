/datum/job/fax_responder
	disp_title = JOB_FAX_RESPONDER
	supervisors = "CMSS13 Administration Staff"

/datum/job/fax_responder/on_config_load()
	entry_message_body = "<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_FAX_RESPONDER]'>Your job</a> is to answer faxes sent to your fax machine. You are answering on behalf of the CMSS13 staff team and are therefore expected to behave appropriately. Failure to adhere to expectations may result in loss of the role or a server ban. Non-staff players of this role are not able to authorise ERTs through their faxes."
	return ..()

/datum/job/fax_responder/uscm_hc
	disp_title = JOB_FAX_RESPONDER_USCM_HC_RU

/datum/job/fax_responder/uscm_pvst
	disp_title = JOB_FAX_RESPONDER_USCM_PVST

/datum/job/fax_responder/wy
	disp_title = JOB_FAX_RESPONDER_WY

/datum/job/fax_responder/upp
	disp_title = JOB_FAX_RESPONDER_UPP

/datum/job/fax_responder/twe
	disp_title = JOB_FAX_RESPONDER_TWE

/datum/job/fax_responder/clf
	disp_title = JOB_FAX_RESPONDER_CLF

/datum/job/fax_responder/cmb
	disp_title = JOB_FAX_RESPONDER_CMB

/datum/job/fax_responder/press
	disp_title = JOB_FAX_RESPONDER_PRESS
