/datum/job/marine
	supervisors = "the acting squad leader"

/datum/job/marine/generate_entry_message(mob/living/carbon/human/current_human)
	if(current_human.assigned_squad)
		entry_message_intro = "You are a [title]!<br>You have been assigned to: <b><font size=3 color=[current_human.assigned_squad.equipment_color]>[lowertext(current_human.assigned_squad.name)] squad</font></b>.[Check_WO() ? "" : " Make your way to the cafeteria for some post-cryosleep chow, and then get equipped in your squad's prep room." ]"
	return ..()

/datum/timelock/squad
	name = "Squad Roles"
