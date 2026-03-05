/datum/action/xeno_action/onclick/xenohide/use_ability(atom/target)
	. = ..()
	if(.)
		owner.update_icons()
