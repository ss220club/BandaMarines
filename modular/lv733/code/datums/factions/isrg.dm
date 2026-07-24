/datum/faction/isrg
	name = "ISRG - Imperial Search and Recovery Group"
	faction_tag = FACTION_ISRG
	base_icon_file = 'modular/lv733/icons/isrg_hud.dmi'

/datum/mob_hud/faction/isrg
	faction_to_check = FACTION_ISRG

/datum/modpack/lv733/initialize()
	GLOB.huds[MOB_HUD_FACTION_ISRG] = new /datum/mob_hud/faction/isrg()

/datum/faction/isrg/modify_hud_holder(image/holder, mob/living/carbon/human/human)
	var/icon/override_icon_file
	var/hud_icon_state
	var/_role = human.job
	if(!_role)
		var/obj/item/card/id/id_card = human.get_idcard()
		if(id_card)
			_role = id_card.rank

	switch(_role)
		if(JOB_ISRG_COMMANDER)
			hud_icon_state = "co"
		if(JOB_ISRG_LEADER)
			hud_icon_state = "leader"
		if(JOB_ISRG_K9)
			hud_icon_state = "k9"
		if(JOB_ISRG_RESCUER)
			hud_icon_state = "rescuer"
		if(JOB_ISRG_SMARTGUNNER)
			hud_icon_state = "smart"
		if(JOB_ISRG_SYNTH)
			hud_icon_state = "synth"

	if(hud_icon_state)
		holder.overlays += image(override_icon_file ? override_icon_file : base_icon_file, human, "isrg_[hud_icon_state]")
