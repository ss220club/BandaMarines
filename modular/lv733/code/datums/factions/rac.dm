/datum/faction/rac
	name = "RAC - Royal Armored Cavalry"
	faction_tag = FACTION_RAC
	base_icon_file = 'modular/lv733/icons/roaf_hud.dmi'

/datum/faction/rac/modify_hud_holder(image/holder, mob/living/carbon/human/human)
	var/icon/override_icon_file
	var/hud_icon_state
	var/_role = human.job
	if(!_role)
		var/obj/item/card/id/id_card = human.get_idcard()
		if(id_card)
			_role = id_card.rank

	switch(_role)
		if(JOB_TWE_RAC_COMMANDER)
			hud_icon_state = "co"
		if(JOB_TWE_RAC_SQUAD_LEADER)
			hud_icon_state = "sl"
		if(JOB_TWE_RAC_MEDIC)
			hud_icon_state = "medic"
		if(JOB_TWE_RAC_RIFLEMAN)
			hud_icon_state = "rifleman"
		if(JOB_TWE_RAC_DRIVER)
			hud_icon_state = "driver"
		if(JOB_TWE_RAC_ENGI)
			hud_icon_state = "eng"
		if(JOB_TWE_RAC_SYNTH)
			hud_icon_state = "synth"

	if(hud_icon_state)
		holder.overlays += image(override_icon_file ? override_icon_file : base_icon_file, human, "rof_[hud_icon_state]")
