/datum/job/proc/spawn_and_equip(mob/new_player/player)
	CRASH("A job without a set spawn_and_equip proc has handle_spawn_and_equip set to TRUE!")

/datum/job/proc/generate_money_account(mob/living/carbon/human/account_user)

	var/datum/money_account/generated_account
	//Give them an account in the database.
	if(!(flags_startup_parameters & ROLE_NO_ACCOUNT))
		var/obj/item/card/id/card = account_user.get_idcard()
		var/user_has_preexisting_account = account_user.mind?.initial_account
		if(card && !user_has_preexisting_account)
			var/datum/paygrade/account_paygrade = GLOB.paygrades[card.paygrade]
			generated_account = create_account(account_user.real_name, rand(30, 50), account_paygrade)
			card.associated_account_number = generated_account.account_number
			if(account_user.mind)
				var/remembered_info = ""
				remembered_info += "<b>Your account number is:</b> #[generated_account.account_number]<br>"
				remembered_info += "<b>Your account pin is:</b> [generated_account.remote_access_pin]<br>"
				remembered_info += "<b>Your account funds are:</b> $[generated_account.money]<br>"

				if(length(generated_account.transaction_log))
					var/datum/transaction/T = generated_account.transaction_log[1]
					remembered_info += "<b>Your account was created:</b> [T.time], [T.date] at [T.source_terminal]<br>"
				account_user.mind.store_memory(remembered_info)
				account_user.mind.initial_account = generated_account
	return generated_account

/datum/job/proc/generate_entry_message()
	if(!entry_message_intro)
		entry_message_intro = "You are the [title]!"
	if(!entry_message_end)
		entry_message_end = "As the [title] you answer to [supervisors]. Special circumstances may change this!"
	return "[entry_message_intro]<br>[entry_message_body]<br>[entry_message_end]"

/datum/job/proc/announce_entry_message(mob/living/carbon/human/H, datum/money_account/M, whitelist_status) //The actual message that is displayed to the mob when they enter the game as a new player.
	set waitfor = 0
	sleep(10)
	if(H && H.loc && H.client)
		var/title_given
		title_given = lowertext(disp_title)

		//Document syntax cannot have tabs for proper formatting.
		var/entrydisplay = " \
			[SPAN_ROLE_BODY("|______________________|")] \n\
			[SPAN_ROLE_HEADER("You are \a [title_given]")] \n\
			[flags_startup_parameters & ROLE_ADMIN_NOTIFY ? SPAN_ROLE_HEADER("You are playing a job that is important for game progression. If you have to disconnect, please notify the admins via adminhelp.") : ""] \n\
			[SPAN_ROLE_BODY("[generate_entry_message(H)]<br>[M ? "Your account number is: <b>[M.account_number]</b>. Your account pin is: <b>[M.remote_access_pin]</b>." : "You do not have a bank account."]")] \n\
			[SPAN_ROLE_BODY("|______________________|")] \
		"
		to_chat_spaced(H, html = entrydisplay)
