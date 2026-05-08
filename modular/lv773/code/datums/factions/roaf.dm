/datum/faction/roaf
	name = "ROAF - Royal Orbital Air Force"
	faction_tag = FACTION_ROAF
	base_icon_file = 'modular/lv773/icons/roaf_hud.dmi'

/datum/faction/roaf/modify_hud_holder(image/holder, mob/living/carbon/human/human)
	var/icon/override_icon_file
	var/hud_icon_state
	var/_role = human.job
	if(!_role)
		var/obj/item/card/id/id_card = human.get_idcard()
		if(id_card)
			_role = id_card.rank

	switch(_role)
		if(JOB_TWE_RAF_LIEUTENANT)
			hud_icon_state = "co"
		if(JOB_TWE_RAF_SQUAD_LEADER)
			hud_icon_state = "sl"
		if(JOB_TWE_RAF_SNIPER)
			hud_icon_state = "sniper"
		if(JOB_TWE_RAF_MEDIC)
			hud_icon_state = "medic"
		if(JOB_TWE_RAF_RIFLEMAN)
			hud_icon_state = "rifleman"
		if(JOB_TWE_RAF_PILOT)
			hud_icon_state = "pilot"
		if(JOB_TWE_RAF_ENGI)
			hud_icon_state = "eng"
		if(JOB_TWE_RAF_SYNTH)
			hud_icon_state = "synth"

	if(hud_icon_state)
		holder.overlays += image(override_icon_file ? override_icon_file : base_icon_file, human, "roaf_[hud_icon_state]")
