GLOBAL_LIST_INIT(faxresp_verbs, list(
	/client/proc/create_custom_paper_fax))
/client/add_admin_verbs()
	. = ..()
	if(check_whitelist_status(WHITELIST_FAX_RESPONDER))
		add_verb(src, GLOB.faxresp_verbs)
		