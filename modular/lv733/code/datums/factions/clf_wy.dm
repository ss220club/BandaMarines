/datum/faction/clf_wy
	name = "CLF-WP - Colonial Liberation Front of WP"
	faction_tag = FACTION_CLF_WY
	base_icon_file = 'icons/mob/hud/factions/clf.dmi'

/datum/faction/clf_wy/modify_hud_holder(image/holder, mob/living/carbon/human/human)
	var/icon/override_icon_file
	var/hud_icon_state
	var/_role = human.job
	if(!_role)
		var/obj/item/card/id/id_card = human.get_idcard()
		if(id_card)
			_role = id_card.rank

	switch(_role)
		if(JOB_CLF_WY_CURATOR)
			hud_icon_state = "cellcom"
		if(JOB_CLF_WY_LEADER)
			hud_icon_state = "sl"
		if(JOB_CLF_WY_ENGI)
			hud_icon_state = "engi"
		if(JOB_CLF_WY_MEDIC)
			hud_icon_state = "med"
		if(JOB_CLF_WY_REBEL)
			hud_icon_state = "spec"
		if(JOB_CLF_WY_SYNTH)
			hud_icon_state = "synth"

	if(hud_icon_state)
		holder.overlays += image(override_icon_file ? override_icon_file : base_icon_file, human, "clf_[hud_icon_state]")
