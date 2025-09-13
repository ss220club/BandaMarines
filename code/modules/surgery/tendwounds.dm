//For closing an open incision first.
/datum/surgery/suture_incision
	name = "Suture Incision"
	possible_locs = ALL_LIMBS
	invasiveness = list(SURGERY_DEPTH_SHALLOW)
	required_surgery_skill = SKILL_SURGERY_NOVICE
	pain_reduction_required = PAIN_REDUCTION_MEDIUM
	steps = list(/datum/surgery_step/suture_incision)
	lying_required = FALSE
	self_operable = TRUE

//------------------------------------

/datum/surgery_step/suture_incision
	name = "Suture Incision"
	desc = "suture the incision"
	tools = SURGERY_TOOLS_SUTURE
	//Suturing incisions closed is distinctly faster than cauterise-swaphand-suture, but slower than cautery alone, meaning it's only better if wanting to both close and suture the incision.
	time = 3.5 SECONDS
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/surgery/hemostat1.ogg'

/datum/surgery_step/suture_incision/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("You begin to suture the incision on $1's $2 with $3.", list(target, ru_name_affected_limb, ru_name_tool)), // SS220 EDIT ADDICTION
		SPAN_NOTICE("$1 begins to suture the incision on your $2 with $3.", list(user, ru_name_affected_limb, ru_name_tool)), // SS220 EDIT ADDICTION
		SPAN_NOTICE("$1 begins to suture the incision on $2's $3 with $4.", list(user, target, ru_name_affected_limb, ru_name_tool))) // SS220 EDIT ADDICTION

	target.custom_pain("It feels like your $1 is being stabbed with needles - because it is!", list(ru_name_affected_limb)) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began suturing an incision in [key_name(target)]'s [surgery.affected_limb.display_name] with \the [tool].")

/datum/surgery_step/suture_incision/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/added_sutures = SEND_SIGNAL(surgery.affected_limb, COMSIG_LIMB_ADD_SUTURES, TRUE)
	if(!added_sutures) //No suture datum to answer the signal
		new /datum/suture_handler(surgery.affected_limb)
		added_sutures = SEND_SIGNAL(surgery.affected_limb, COMSIG_LIMB_ADD_SUTURES, TRUE) //This time, with feeling.

	switch(target_zone)
		if("head")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_open")
		if("chest")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_open")
	if(added_sutures & SUTURED_FULLY)
		user.affected_message(target,
			SPAN_NOTICE("You close the incision on $1's $2.", list(target, ru_name_affected_limb)), // SS220 EDIT ADDICTION
			SPAN_NOTICE("$1 closes the incision on your $2.", list(user, ru_name_affected_limb)), // SS220 EDIT ADDICTION
			SPAN_NOTICE("$1 closes the incision on $2's $3.", list(user, target, ru_name_affected_limb))) // SS220 EDIT ADDICTION

		log_interact(user, target, "[key_name(user)] finished suturing an incision in [key_name(target)]'s [surgery.affected_limb.display_name] with \the [tool], ending [surgery].")
	else
		user.affected_message(target,
			SPAN_NOTICE("You close the incision on $1's $2, but some injuries remain.", list(target, ru_name_affected_limb)), // SS220 EDIT ADDICTION
			SPAN_NOTICE("$1 closes the incision on your $2, but some injuries remain.", list(user, ru_name_affected_limb)), // SS220 EDIT ADDICTION
			SPAN_NOTICE("$1 closes the incision on $2's $3, but some injuries remain.", list(user, target, ru_name_affected_limb))) // SS220 EDIT ADDICTION

		log_interact(user, target, "[key_name(user)] finished suturing an incision in [key_name(target)]'s [surgery.affected_limb.display_name] with \the [tool], ending [surgery].")

	target.incision_depths[target_zone] = SURGERY_DEPTH_SURFACE

/datum/surgery_step/suture_incision/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	log_interact(user, target, "[key_name(user)] failed to suture the incision in [key_name(target)]'s [surgery.affected_limb.display_name] with \the [tool].")
	return FALSE
