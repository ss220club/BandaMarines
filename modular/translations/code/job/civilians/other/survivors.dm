/datum/job/civilian/survivor
	title = JOB_SURVIVOR
	job_options = SURVIVOR_VARIANT_LIST

/datum/job/civilian/survivor/announce_entry_message(mob/living/carbon/human/survivor, datum/money_account/account, whitelist_status) //The actual message that is displayed to the mob when they enter the game as a new player.
	if(survivor?.loc && survivor.client)
		//Document syntax cannot have tabs for proper formatting.
		var/entrydisplay = " \
			[SPAN_ROLE_BODY("|______________________|")] \n\
			[SPAN_ROLE_BODY("[generate_entry_message(survivor)]<br>[account ? "Your account number is: <b>[account.account_number]</b>. Your account pin is: <b>[account.remote_access_pin]</b>." : "You do not have a bank account."]")] \n\
			[SPAN_ROLE_BODY("|______________________|")] \
		"
		to_chat_spaced(survivor, html = entrydisplay)

/datum/job/civilian/survivor/synth
	title = JOB_SYNTH_SURVIVOR

/datum/job/civilian/survivor/commanding_officer
	title = JOB_CO_SURVIVOR
