/datum/prefab_document
	var/contents

GLOBAL_REFERENCE_LIST_INDEXED(prefab_papers, /obj/item/paper/prefab, document_title)
/obj/structure/filingcabinet/documentation
	name = "documents cabinet"
	color = "#e78738"

	/// The categories available from this cabinet. Manually populated.
	var/list/available_categories = list()
	/// The possible options that can be withdrawn. Automatically populated by get_possible_documents().
	var/list/available_documents = list()
	/// Number of prefab documents that can be withdrawn. Cap intended to prevent people spamming infinite copies.
	var/remaining_documents = 30

/obj/structure/filingcabinet/documentation/Initialize()
	. = ..()
	get_possible_documents()

/obj/structure/filingcabinet/documentation/proc/get_possible_documents()
	available_documents.Cut()
	for(var/docname in GLOB.prefab_papers)
		var/obj/item/paper/prefab/document = GLOB.prefab_papers[docname]
		if(!istype(document))
			continue
		if(!document.is_prefab || !document.doc_datum_type || (document.name == "paper"))
			continue
		if(!document.document_category || !(document.document_category in available_categories))
			continue
		available_documents += docname
	return

/obj/structure/filingcabinet/documentation/attack_hand(mob/user as mob)
	var/choice = tgui_alert(user, "Do you wish to open the cabinet, or retrieve a document template?", "Action", list("Open", "Document"), 20 SECONDS)
	switch(choice)
		if("Open")
			if(!length(contents))
				to_chat(user, SPAN_NOTICE("[src] is empty."))
				return

			user.set_interaction(src)
			var/dat = "<center><table>"
			for(var/obj/item/P in src)
				dat += "<tr><td><a href='byond://?src=\ref[src];retrieve=\ref[P]'>[P.name]</a></td></tr>"
			dat += "</table></center>"
			show_browser(user, dat, name, "filingcabinet", width = 350, height = 300)
			return
		if("Document")
			if(remaining_documents <= 0)
				to_chat(user, SPAN_WARNING("[src] has no remaining official forms!"))
				return
			give_document(user)
			return

/obj/structure/filingcabinet/documentation/proc/give_document(mob/user as mob)
	if(remaining_documents <= 0)
		to_chat(user, SPAN_WARNING("[src] has no remaining official forms!"))
		return FALSE
	var/chosen = tgui_input_list(usr, "What document do you need?", "Choose Document", available_documents)
	var/selected = GLOB.prefab_papers[chosen].type
	if(!user.Adjacent(src))
		return
 
	var/obj/item/paper/prefab/document = new selected
	document.forceMove(user.loc)
	user.put_in_hands(document)
	to_chat(user, SPAN_NOTICE("You take [document] out of [src]."))
	remaining_documents--
	return TRUE

/obj/structure/filingcabinet/documentation/military_police
	available_categories = list(PAPER_CATEGORY_MP)

/obj/structure/filingcabinet/documentation/uscm
	available_categories = list(PAPER_CATEGORY_USCM)

/obj/structure/filingcabinet/documentation/uscm_mp
	available_categories = list(PAPER_CATEGORY_USCM, PAPER_CATEGORY_MP)

/obj/structure/filingcabinet/documentation/liaison
	available_categories = list(PAPER_CATEGORY_LIAISON)
	remaining_documents = 45 //CL likely using more of these than most people.

/obj/structure/filingcabinet/documentation/highcom
	remaining_documents = 60

/obj/structure/filingcabinet/documentation/highcom/wy
	available_categories = list(PAPER_CATEGORY_WEYYU_HC)

/obj/structure/filingcabinet/documentation/highcom/uscm
	available_categories = list(PAPER_CATEGORY_USCM_HC)

/obj/structure/filingcabinet/documentation/highcom/provost
	available_categories = list(PAPER_CATEGORY_PROVOST)

/obj/structure/filingcabinet/documentation/highcom/upp
	available_categories = list(PAPER_CATEGORY_UPP_HC)

/obj/structure/filingcabinet/documentation/highcom/twe
	available_categories = list(PAPER_CATEGORY_TWE_HC)

/obj/structure/filingcabinet/documentation/highcom/cmb
	available_categories = list(PAPER_CATEGORY_CMB_HC)

/obj/structure/filingcabinet/documentation/highcom/press
	available_categories = list(PAPER_CATEGORY_PRESS_HC)

/obj/structure/filingcabinet/documentation/highcom/clf
	available_categories = list(PAPER_CATEGORY_CLF_HC)


//########################################
//########################################
//########################################
/obj/item/paper/prefab // Abstract type (document_title and doc_datum_type are null)
	is_prefab = TRUE
	deffont = "Courier New"
	signfont = "Times New Roman"

/obj/item/paper/prefab/Initialize()
	. = ..()
	name = document_title || "BLANK"

// ########## Provost MP Forms  ########## \\

/obj/item/paper/prefab/carbon/military_police
	name = "Blank MP Document"
	document_category = PAPER_CATEGORY_MP

/obj/item/paper/prefab/carbon/military_police/ops_report
	document_title = "PR201 - Отчет об операции" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/mp/ops_report

/obj/item/paper/prefab/carbon/military_police/appeal_form
	document_title = "PR301a - Апелляционная форма" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/mp/appeal_form

/obj/item/paper/prefab/carbon/military_police/dao_request
	document_title = "PR301b - Приказ на отложенное действие" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/mp/dao_request

/obj/item/paper/prefab/carbon/military_police/confiscation_receipt
	document_title = "PR356 - Расписка о конфискации" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/mp/confiscation_receipt

/obj/item/paper/prefab/carbon/military_police/apology_notice
	document_title = "NJ910 - Уведомление об извинениях" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/mp/apology_notice

// ########## Provost HC Forms  ########## \\

/obj/item/paper/prefab/provost
	name = "Blank Provost Document"
	document_category = PAPER_CATEGORY_PROVOST

/obj/item/paper/prefab/provost/standard
	document_title = "PR202 - Сообщение главного управления Военной Полиции" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/highcom/standard

/obj/item/paper/prefab/provost/arrest_warrant
	document_title = "PR211 - Ордер на арест" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/highcom/arrest_warrant

/obj/item/paper/prefab/provost/custody_transfer
	document_title = "PR238 - Приказ о передаче под стражу" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/highcom/custody_transfer

/obj/item/paper/prefab/provost/dao_response
	document_title = "PR301c - Приказ на отложенное действие" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/provost/highcom/dao_response

// ########## USCM Standard Forms  ########## \\

/obj/item/paper/prefab/uscm
	name = "Blank USCM Document"
	document_category = PAPER_CATEGORY_USCM

/obj/item/paper/prefab/uscm/ops_report
	document_title = "UAM421 - Отчет об операции" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/uscm/ops_report

// ########## USCM HC Forms  ########## \\

/obj/item/paper/prefab/uscm_highcom
	name = "Blank USCMHC Document"
	document_category = PAPER_CATEGORY_USCM_HC

/obj/item/paper/prefab/uscm_highcom/arrest_warrant
	document_title = "UAM211 - Ордер на арест" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/uscm/highcom/arrest_warrant

/obj/item/paper/prefab/uscm_highcom/custody_transfer
	document_title = "UAM238 - Приказ о передаче под стражу" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/uscm/highcom/custody_transfer

/obj/item/paper/prefab/uscm_highcom/standard
	document_title = "UAM422 - Сообщение Верховного Командования КМП" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/uscm/highcom/standard

// ########## Wey-Yu Liaison Forms  ########## \\

/obj/item/paper/prefab/liaison
	name = "Blank WY Document"
	document_category = PAPER_CATEGORY_LIAISON

/obj/item/paper/prefab/liaison/ops_report
	document_title = "WY435 - Отчет корпоративного связного" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/ops_report

/obj/item/paper/prefab/liaison/preserve_intent
	document_title = "WY439 - Заявление о намерении сохранить" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/preserve_intent

/obj/item/paper/prefab/liaison/liability
	document_title = "WY440 - Заявление об отказе от ответственности" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/liability

/obj/item/paper/prefab/liaison/nda_short
	document_title = "WY441 - Соглашение о конфиденциальности" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/nda_short

/obj/item/paper/prefab/liaison/nda_long
	document_title = "WY442 - Соглашение о неразглашении" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/nda_long

/obj/item/paper/prefab/liaison/nda_long/uscm
	document_title = "WY442-B - Non Disclosure Agreement (USCM)"
	doc_datum_type = /datum/prefab_document/wey_yu/liaison/nda_long/uscm

// ########## Wey-Yu HC Forms  ########## \\

/obj/item/paper/prefab/wey_yu
	name = "Blank WYC Document"
	document_category = PAPER_CATEGORY_WEYYU_HC

/obj/item/paper/prefab/wey_yu/standard
	document_title = "WY101 - Сообщение Директората" // BANDAMARINES Translate
	doc_datum_type = /datum/prefab_document/wey_yu/highcom/standard
