//Procedures in this file: Opening and closing incisions. Clamping bleeds. Opening and closing ribcage/skull etc., proof of concept do-nothing non-human surgery.

//////////////////////////////////////////////////////////////////
// INCISION SURGERIES //
//////////////////////////////////////////////////////////////////

/datum/surgery/open_incision
	name = "Open Incision"
	priority = SURGERY_PRIORITY_MAXIMUM
	possible_locs = ALL_LIMBS
	invasiveness = list(SURGERY_DEPTH_SURFACE)
	required_surgery_skill = SKILL_SURGERY_NOVICE
	steps = list(
		/datum/surgery_step/incision,
		/datum/surgery_step/clamp_bleeders_step,
		/datum/surgery_step/retract_skin,
	)
	lying_required = FALSE
	self_operable = TRUE
	pain_reduction_required = PAIN_REDUCTION_MEDIUM

//------------------------------------

/datum/surgery_step/incision
	name = "Make Incision"
	desc = "сделать разрез"
	tools = SURGERY_TOOLS_INCISION
	time = 2 SECONDS
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/incision/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION

	switch(tool_type)
		if(/obj/item/tool/surgery/scalpel/manager)
			user.affected_message(target,
				SPAN_NOTICE("Вы начинаете делать программный разрез на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать программный разрез на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать программный разрез на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

			target.custom_pain("Вы чувствуете ужасно острую боль в [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
		if(/obj/item/tool/surgery/scalpel/laser)
			user.affected_message(target,
				SPAN_NOTICE("Вы начинаете делать лазерный разрез на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать лазерный разрез на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать лазерный разрез на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

			target.custom_pain("Вы чувствуете ужасно жгучую боль в [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
		else
			user.affected_message(target,
				SPAN_NOTICE("Вы начинаете делать разрез на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать разрез на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] начинает делать разрез на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

			target.custom_pain("Вы чувствуете ужасно рвущую боль в [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION

	log_interact(user, target, "[key_name(user)] начинает делать разрез на [surgery.affected_limb.display_name] [key_name(target)].")

/datum/surgery_step/incision/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION

	switch(tool_type)
		if(/obj/item/tool/surgery/scalpel/manager)
			user.affected_message(target,
				SPAN_NOTICE("Вы завершаете делать программный разрез на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать программный разрез на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать программный разрез на [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION

			surgery.status += 2 //IMS completes all steps.
		if(/obj/item/tool/surgery/scalpel/laser)
			user.affected_message(target,
				SPAN_NOTICE("Вы завершаете делать лазерный разрез на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать лазерный разрез на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать лазерный разрез на [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION

			surgery.status++ //A laser scalpel may cauterise as it cuts.
		else
			user.affected_message(target,
				SPAN_NOTICE("Вы завершаете делать разрез на [ru_name_affected_limb] [target]."), //SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать разрез на вашей [ru_name_affected_limb]."), //SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] завершает делать разрез на [ru_name_affected_limb] [target].")) //SS220 EDIT ADDICTION

			if(!(surgery.affected_limb.status & LIMB_SYNTHSKIN))
				var/datum/effects/bleeding/external/incision_bleed = new(target, surgery.affected_limb, 10)
				incision_bleed.duration = 10 MINUTES //A weak bleed, but it doesn't stop on its own.
				surgery.affected_limb.bleeding_effects_list += incision_bleed
			else
				surgery.status++ // synth skin doesn't cause bleeders

	target.incision_depths[target_zone] = SURGERY_DEPTH_SHALLOW //Descriptionwise this is done by the retractor, but putting it here means people can examine to see if an unfinished surgery has been done.
	user.add_blood(target.get_blood_color(), BLOOD_HANDS)
	log_interact(user, target, "[key_name(user)] made an incision in [key_name(target)]'s [surgery.affected_limb.display_name], beginning [surgery].")

/datum/surgery_step/incision/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION

	switch(tool_type)
		if(/obj/item/tool/surgery/scalpel/manager)
			user.affected_message(target,
				SPAN_WARNING("Ваша рука дёргается, когда система искрит, проделывая ужасную дыру в [ru_name_affected_limb] [target]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, когда система искрит, проделывая ужасную дыру в вашей [ru_name_affected_limb]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, когда система искрит, проделывая ужасную дыру в [ru_name_affected_limb] [target]!")) //SS220 EDIT ADDICTION

			target.apply_damage(15, BRUTE, target_zone)
			target.apply_damage(15, BURN, target_zone)
		if(/obj/item/tool/surgery/scalpel/laser)
			user.affected_message(target,
				SPAN_WARNING("Ваша рука дёргается, когда лазерный скальпель искрит, оставляя большой ожог на [ru_name_affected_limb] [target]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, когда лазерный скальпель искрит, оставляя большой ожог на вашей [ru_name_affected_limb]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, когда лазерный скальпель искрит, оставляя большой ожог на [ru_name_affected_limb] [target]!")) //SS220 EDIT ADDICTION

			target.apply_damage(7.5, BRUTE, target_zone)
			target.apply_damage(12.5, BURN, target_zone)
		else
			user.affected_message(target,
				SPAN_WARNING("Ваша рука дёргается, оставляя большой разрез на [ru_name_affected_limb] [target]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, оставляя большой разрез на вашей [ru_name_affected_limb]!"), //SS220 EDIT ADDICTION
				SPAN_WARNING("Рука [user] дёргается, оставляя большой разрез на [ru_name_affected_limb] [target]!")) //SS220 EDIT ADDICTION

			target.apply_damage(10, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to make an incision in [key_name(target)]'s [surgery.affected_limb.display_name], aborting [surgery].")
	return FALSE

//------------------------------------

/datum/surgery/clamp_bleeders
	name = "Clamp Bleeders"
	priority = SURGERY_PRIORITY_HIGH
	possible_locs = ALL_LIMBS
	invasiveness = list(SURGERY_DEPTH_SHALLOW, SURGERY_DEPTH_DEEP)
	required_surgery_skill = SKILL_SURGERY_NOVICE
	steps = list(/datum/surgery_step/clamp_bleeders_step)
	lying_required = FALSE
	self_operable = TRUE
	pain_reduction_required = PAIN_REDUCTION_MEDIUM

/datum/surgery/clamp_bleeders/can_start(mob/user, mob/living/carbon/patient, obj/limb/L, obj/item/tool)
	for(var/datum/effects/bleeding/external/B in L.bleeding_effects_list)
		return TRUE
	return FALSE

//------------------------------------

/datum/surgery_step/clamp_bleeders_step
	name = "Clamp Bleeders"
	desc = "остановить кровотечение"
	//Tools used to clamp bleeders by either clamping them shut or tying them shut. Fixovein is a substitute but also a real surgery tool.
	tools = list(
		/obj/item/tool/surgery/hemostat = SURGERY_TOOL_MULT_IDEAL,
		/obj/item/tool/wirecutters = SURGERY_TOOL_MULT_SUBSTITUTE,
		/obj/item/stack/cable_coil = SURGERY_TOOL_MULT_BAD_SUBSTITUTE,
	)
	///Tools used to stem bleeders by specifically tying them up. List used for specific messaging as there's two of these.
	var/ligation_tools = list(/obj/item/stack/cable_coil)
	time = 2 SECONDS
	preop_sound = 'sound/surgery/hemostat1.ogg'
	success_sound = 'sound/surgery/hemostat1.ogg'
	failure_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/clamp_bleeders_step/skip_step_criteria(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	return TRUE //This step is optional.

/datum/surgery_step/clamp_bleeders_step/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	if(tool_type in ligation_tools)
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете зашивать кровеносные сосуды на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает зашивать кровеносные сосуды на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает зашивать кровеносные сосуды на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете зажимать кровеносные сосуды на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает зажимать кровеносные сосуды на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает зажимать кровеносные сосуды на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как что-то пульсирует под вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began clamping bleeders in [key_name(target)]'s [surgery.affected_limb.display_name], possibly beginning [surgery].")

/datum/surgery_step/clamp_bleeders_step/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	if(tool_type in ligation_tools)
		user.affected_message(target,
			SPAN_NOTICE("Вы завершаете зашивать кровеносные сосуды на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] завершает зашивать кровеносные сосуды на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] завершает зашивать кровеносные сосуды на [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_NOTICE("Вы завершаете зажимать кровеносные сосуды на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] завершает зажимать кровеносные сосуды на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] завершает зажимать кровеносные сосуды на [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION

	log_interact(user, target, "[key_name(user)] clamped bleeders in [key_name(target)]'s [surgery.affected_limb.display_name], possibly ending [surgery].")

	var/surface_modifier = target.buckled?.surgery_duration_multiplier
	if(!surface_modifier)
		surface_modifier = SURGERY_SURFACE_MULT_AWFUL
		for(var/obj/surface in get_turf(target))
			if(surface_modifier > surface.surgery_duration_multiplier)
				surface_modifier = surface.surgery_duration_multiplier

	if(surface_modifier == SURGERY_SURFACE_MULT_IDEAL)
		surgery.affected_limb.remove_all_bleeding(TRUE, FALSE)
		return

	var/bleeding_multiplier_bad_surface = surface_modifier - 1
	for(var/datum/effects/bleeding/external/external_bleed in surgery.affected_limb.bleeding_effects_list)
		external_bleed.blood_loss *= bleeding_multiplier_bad_surface
		to_chat(user, SPAN_WARNING("Остановка кровотечения займёт больше времени."))


/datum/surgery_step/clamp_bleeders_step/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_WARNING("Ваша рука дёргается, рвя кровеносные сосуды на [ru_name_affected_limb] [target] и вызывая сильное кровотечение!"), // SS220 EDIT ADDICTION
		SPAN_WARNING("Рука [user] дёргается, рвя кровеносные сосуды на вашей [ru_name_affected_limb] и вызывая сильное кровотечение!"), // SS220 EDIT ADDICTION
		SPAN_WARNING("Рука [user] дёргается, рвя кровеносные сосуды на [ru_name_affected_limb] [target] и вызывая сильное кровотечение!")) // SS220 EDIT ADDICTION

	target.apply_damage(4, BRUTE, target_zone)
	surgery.affected_limb.add_bleeding(null, FALSE, 15)
	log_interact(user, target, "[key_name(user)] failed to clamp bleeders in [key_name(target)]'s [surgery.affected_limb.display_name], possibly ending [surgery].")
	return FALSE

//------------------------------------

/datum/surgery_step/retract_skin
	name = "Widen Incision"
	desc = "расширить разрез"
	time = 2 SECONDS
	//Tools used to pry open specifically incisions. Contains INCISION tools at lengthy delays, mainly so surgeons can dramatically slash open incisions with them.
	tools = list(\
		/obj/item/tool/surgery/retractor = SURGERY_TOOL_MULT_IDEAL,
		/obj/item/tool/surgery/hemostat = SURGERY_TOOL_MULT_SUBOPTIMAL,
		/obj/item/tool/crowbar = SURGERY_TOOL_MULT_SUBSTITUTE,
		/obj/item/tool/wirecutters = SURGERY_TOOL_MULT_BAD_SUBSTITUTE,
		/obj/item/maintenance_jack = SURGERY_TOOL_MULT_BAD_SUBSTITUTE,
		/obj/item/tool/kitchen/utensil/fork = SURGERY_TOOL_MULT_AWFUL,
		/obj/item/attachable/bayonet = SURGERY_TOOL_MULT_AWFUL,
		/obj/item/tool/surgery/scalpel = SURGERY_TOOL_MULT_AWFUL,
		/obj/item/tool/kitchen/knife = SURGERY_TOOL_MULT_AWFUL,
		/obj/item/weapon/throwing_knife = SURGERY_TOOL_MULT_AWFUL,
		/obj/item/shard = SURGERY_TOOL_MULT_AWFUL
		)
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/retract_skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	if(target_zone == "groin")
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете оттягивать кожу и ткани вокруг разреза на нижней части живота [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает оттягивать кожу и ткани вокруг разреза на нижней части вашего живота, используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает оттягивать кожу и ткани вокруг разреза на нижней части живота [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете оттягивать кожу и ткани вокруг разреза на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает оттягивать кожу и ткани вокруг разреза на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает оттягивать кожу и ткани вокруг разреза на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как растягивается и натягивается кожа на вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began retracting skin in [key_name(target)]'s [surgery.affected_limb.display_name].")

/datum/surgery_step/retract_skin/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	// SS220 START EDIT ADDICTION
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name)
	var/h_his = target.ru_p_them()
	//switch(target.gender)
	//	if(MALE)
	//		h_his = "his"
	//	if(FEMALE)
	//		h_his = "her"
	// SS220 END EDIT ADDICTION

	switch(target_zone)
		if("chest")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")
			user.affected_message(target,
				SPAN_NOTICE("Вы оттягиваете кожу и ткани вокруг разреза на груди [target], обнажая [h_his] грудную клетку."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на вашей груди, обнажая грудную клетку."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на груди [target], обнажая [h_his] грудную клетку.")) // SS220 EDIT ADDICTION
		if("head")
			user.affected_message(target,
				SPAN_NOTICE("Вы оттягиваете кожу и ткани вокруг разреза на голове [target], обнажая [h_his] череп."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на вашей голове, обнажая череп."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на голове [target], обнажая [h_his] череп.")) // SS220 EDIT ADDICTION
			target.overlays += image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
		if("groin")
			user.affected_message(target,
				SPAN_NOTICE("Вы оттягиваете кожу и ткани вокруг разреза на нижней части живота [target], обнажая [h_his] внутренние органы."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на нижней части вашего живота, обнажая внутренние органы."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на нижней части живота [target], обнажая [h_his] внутренние органы.")) // SS220 EDIT ADDICTION
		else
			user.affected_message(target,
				SPAN_NOTICE("Вы оттягиваете кожу и ткани вокруг разреза на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
				SPAN_NOTICE("[user] оттягивает кожу и ткани вокруг разреза на [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION

	log_interact(user, target, "[key_name(user)] retracted skin in [key_name(target)]'s [surgery.affected_limb.display_name], ending [surgery].")

/datum/surgery_step/retract_skin/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	// SS220 START EDIT ADDICTION
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/h_his = target.ru_p_them()
	//switch(target.gender)
	//	if(MALE)
	//		h_his = "his"
	//	if(FEMALE)
	//		h_his = "her"
	// SS220 END EDIT ADDICTION

	switch(target_zone)
		if("head")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
			user.affected_message(target,
				SPAN_WARNING("Вы разрываете кожу и ткани вокруг разреза на голове [target], обнажая [h_his] череп!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на вашей голове, обнажая череп!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на голове [target], обнажая [h_his] череп!")) // SS220 EDIT ADDICTION

		if("groin")
			user.affected_message(target,
				SPAN_WARNING("Вы разрываете кожу и ткани вокруг разреза на нижней части живота [target], обнажая [h_his] внутренние органы!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на нижней части вашего живота, обнажая внутренние органы!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на нижней части живота [target], обнажая [h_his] внутренние органы!")) // SS220 EDIT ADDICTION

		if("chest")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")
			user.affected_message(target,
				SPAN_WARNING("Вы разрываете кожу и ткани вокруг разреза на груди [target], обнажая [h_his] грудную клетку!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на вашей груди, обнажая вашу грудную клетку!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на груди [target], обнажая [h_his] грудную клетку!")) // SS220 EDIT ADDICTION

		else
			user.affected_message(target,
				SPAN_WARNING("Вы разрываете кожу и ткани вокруг разреза на [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на вашей [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
				SPAN_WARNING("[user] разрывает кожу и ткани вокруг разреза на [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

	target.apply_damage(15, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] violently retracted skin in [key_name(target)]'s [surgery.affected_limb.display_name], ending [surgery].")
	return TRUE //Failing to finish this step doesn't fail it, it just means you do it a lot more violently.

//------------------------------------

/datum/surgery/close_incision
	name = "Close Incision"
	priority = SURGERY_PRIORITY_MINIMUM
	possible_locs = ALL_LIMBS
	required_surgery_skill = SKILL_SURGERY_NOVICE
	steps = list(/datum/surgery_step/cauterize)
	lying_required = FALSE
	self_operable = TRUE
	pain_reduction_required = PAIN_REDUCTION_MEDIUM

//------------------------------------

/datum/surgery_step/cauterize
	name = "Close Incision"
	desc = "прижечь разрез"
	tools = SURGERY_TOOLS_CAUTERIZE
	time = 2.5 SECONDS
	var/tools_lit = list(
		/obj/item/tool/lighter,
		/obj/item/clothing/mask/cigarette,
		/obj/item/tool/weldingtool,
		)
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'
	failure_sound = 'sound/items/welder.ogg'

/datum/surgery_step/cauterize/tool_check(mob/user, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if((. in tools_lit) && !tool.heat_source) //Light your damned tools.
		return FALSE

/datum/surgery_step/cauterize/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы начинаете прижигать разрез на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает прижигать разрез на вашей [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает прижигать разрез на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как пригорает кожа на вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began cauterizing an incision in [key_name(target)]'s [surgery.affected_limb.display_name], beginning [surgery].")

/datum/surgery_step/cauterize/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы завершаете прижигать разрез на [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] завершает прижигать разрез на вашей [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] завершает прижигать разрез на [target] [ru_name_affected_limb].")) // SS220 EDIT ADDICTION
	switch(target_zone)
		if("head")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_open")
		if("chest")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_open")

	target.incision_depths[target_zone] = SURGERY_DEPTH_SURFACE
	surgery.affected_limb.remove_all_bleeding(TRUE, FALSE)
	target.pain.recalculate_pain()
	log_interact(user, target, "[key_name(user)] cauterized an incision in [key_name(target)]'s [surgery.affected_limb.display_name], ending [surgery].")

/datum/surgery_step/cauterize/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_WARNING("Ваша рука дёргается, оставляя небольшой ожог на [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
		SPAN_WARNING("Рука [user] дёргается, оставляя небольшой ожог на вашей [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
		SPAN_WARNING("Рука [user] дёргается, оставляя небольшой ожог на [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

	target.apply_damage(3, BURN, target_zone)
	log_interact(user, target, "[key_name(user)] failed to cauterize an incision in [key_name(target)]'s [surgery.affected_limb.display_name], aborting [surgery].")
	return FALSE

//////////////////////////////////////////////////////////////////
// BONE-OPENING SURGERIES //
//////////////////////////////////////////////////////////////////

/datum/surgery/open_encased
	name = "Open Bone"
	priority = SURGERY_PRIORITY_LOW
	possible_locs = list("chest","head")
	required_surgery_skill = SKILL_SURGERY_TRAINED
	steps = list(
		/datum/surgery_step/saw_encased,
		/datum/surgery_step/open_encased_step,
		/datum/surgery_step/mend_encased,
	)
	pain_reduction_required = PAIN_REDUCTION_HEAVY

//------------------------------------

/datum/surgery_step/saw_encased
	name = "Saw Bone"
	desc = "разрезать кость"
	/*Tools used to cut ribs/skull. Same tools as SEVER_BONE, but with sawing tools being better than chopping ones.
	You're trying to cut through, but keep it and what's behind it intact.*/
	tools = list(
		/obj/item/tool/surgery/circular_saw = SURGERY_TOOL_MULT_IDEAL,
		/obj/item/attachable/bayonet = SURGERY_TOOL_MULT_SUBOPTIMAL,
		/obj/item/weapon/twohanded/fireaxe = SURGERY_TOOL_MULT_SUBSTITUTE,
		/obj/item/weapon/sword/machete = SURGERY_TOOL_MULT_SUBSTITUTE,
		/obj/item/tool/hatchet = SURGERY_TOOL_MULT_BAD_SUBSTITUTE,
		/obj/item/tool/kitchen/knife/butcher = SURGERY_TOOL_MULT_BAD_SUBSTITUTE,
	)
	time = 4 SECONDS
	preop_sound = 'sound/surgery/saw.ogg'
	success_sound = 'sound/surgery/hemostat1.ogg'
	failure_sound = 'sound/effects/bone_break6.ogg'

/datum/surgery_step/saw_encased/skip_step_criteria(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/limb/affecting = target.get_limb(check_zone(user.zone_selected))
	if(affecting.status & LIMB_BROKEN)
		return TRUE //Don't need the saw if it's already fractured.

/datum/surgery_step/saw_encased/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы начинаете отпиливать [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает отпиливать вашу [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает отпиливать [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как давление нарастает в костях вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION

	if(surgery.affected_limb.status & LIMB_BROKEN)
		to_chat(user, SPAN_NOTICE("Кость уже сломана, поэтому вы можете просто извлечь её."))
	log_interact(user, target, "[key_name(user)] began cutting through [key_name(target)]'s [surgery.affected_limb.encased], attempting [surgery].")

/datum/surgery_step/saw_encased/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы завершаете отпиливать [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] завершает отпиливать вашу [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] завершает отпиливать [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION

	log_interact(user, target, "[key_name(user)] cut through [key_name(target)]'s [surgery.affected_limb.encased], beginning [surgery].")

/datum/surgery_step/saw_encased/failure(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	if(surgery.affected_limb.status & LIMB_BROKEN) //Can't shatter what is already broken.
		//var/affected_bone = surgery.affected_limb.name == "chest" ? "ribs" : "skull" // SS220 EDIT ADDICTION
		user.affected_message(target,
			SPAN_WARNING("Вы разрезаете сломанную [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("[user] разрезает вашу сломанную [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("[user] разрезает сломанную [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

	else
		user.affected_message(target,
			SPAN_WARNING("Вы ломаете [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("[user] ломает вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("[user] ломает [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

		surgery.affected_limb.fracture(100)

	user.animation_attack_on(target)
	if(tool.hitsound)
		playsound(target.loc, tool.hitsound, 25, TRUE)
	target.apply_damage(20, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] violently cut through [key_name(target)]'s [surgery.affected_limb.encased], beginning [surgery].")
	return TRUE

//------------------------------------

//This step can be skipped, and ends the surgery when completed. In rib-opening surgery, it can be skipped to abort the operation.
//In rib-closing surgery, it can be skipped to finish closing the ribcage, or completed to abort the operation.
/datum/surgery_step/open_encased_step
	name = "Open Bone"
	desc = "раздвинуть кости"
	tools = SURGERY_TOOLS_PRY_ENCASED
	time = 2 SECONDS
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/effects/bone_break4.ogg'

/datum/surgery_step/open_encased_step/skip_step_criteria(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	return TRUE

/datum/surgery_step/open_encased_step/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы начинаете вынимать [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает вынимать вашу [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает вынимать [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как ткани отходят от костей вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began opening [key_name(target)]'s [surgery.affected_limb.encased], possibly beginning [surgery].")

/datum/surgery_step/open_encased_step/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	var/brain = surgery.affected_limb.body_part == BODY_FLAG_HEAD ? TRUE : FALSE
	var/h_him = target.ru_p_them()
	user.affected_message(target,
		SPAN_NOTICE("Вы держите [ru_name_affected_limb] [target] открытым, обнажая [brain ? "мозг" : "внутренние органы"]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] держит вашу [ru_name_affected_limb] открытой, обнажая [brain ? "мозг" : "внутренние органы"]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] держит [ru_name_affected_limb] [target] открытым, обнажая [h_him] [brain ? "мозг" : "внутренние органы"].")) // SS220 EDIT ADDICTION
	switch(target_zone)
		if("head")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "skull_surgery_open")
		if("chest")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "chest_surgery_open")

	target.incision_depths[target_zone] = SURGERY_DEPTH_DEEP
	complete(target, surgery) //This finishes the surgery.

	if(prob(10)) //RNG slip chance.
		surgery.affected_limb.fracture(100)
	log_interact(user, target, "[key_name(user)] opened [key_name(target)]'s [surgery.affected_limb.encased], ending [surgery].")

/datum/surgery_step/open_encased_step/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	if(surgery.affected_limb.status & LIMB_BROKEN)
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ломая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

	surgery.affected_limb.fracture(100)
	target.apply_damage(15, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to open [key_name(target)]'s [surgery.affected_limb.encased].")

//------------------------------------

/datum/surgery/close_encased
	name = "Close Bone"
	priority = SURGERY_PRIORITY_MINIMUM
	possible_locs = list("chest","head")
	invasiveness = list(SURGERY_DEPTH_DEEP)
	required_surgery_skill = SKILL_SURGERY_TRAINED
	steps = list(
		/datum/surgery_step/close_encased_step,
		/datum/surgery_step/open_encased_step,
		/datum/surgery_step/mend_encased,
	)
	pain_reduction_required = PAIN_REDUCTION_HEAVY

//------------------------------------

/datum/surgery_step/close_encased_step
	name = "Close Bone"
	desc = "вправить кости"
	tools = SURGERY_TOOLS_PRY_ENCASED
	time = 2 SECONDS
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/effects/bone_break7.ogg'

/datum/surgery_step/close_encased_step/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы начинаете вправлять [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает вправлять вашу [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] начинает вправлять [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

	target.custom_pain("Вы чувствуете, как давление нарастает в костях вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	log_interact(user, target, "[key_name(user)] began closing [key_name(target)]'s [surgery.affected_limb.encased], attempting to begin [surgery].")

/datum/surgery_step/close_encased_step/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	user.affected_message(target,
		SPAN_NOTICE("Вы вправляете [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] вправляет вашу [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
		SPAN_NOTICE("[user] вправляет [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION
	switch(target_zone)
		if("head")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "skull_surgery_open")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "skull_surgery_closed")
		if("chest")
			target.overlays -= image('icons/mob/humans/dam_human.dmi', "chest_surgery_open")
			target.overlays += image('icons/mob/humans/dam_human.dmi', "chest_surgery_closed")

	target.incision_depths[target_zone] = SURGERY_DEPTH_SHALLOW
	log_interact(user, target, "[key_name(user)] closed [key_name(target)]'s [surgery.affected_limb.encased], beginning [surgery].")

/datum/surgery_step/close_encased_step/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	if(surgery.affected_limb.status & LIMB_BROKEN)
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ломая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

	surgery.affected_limb.fracture(100)
	target.apply_damage(15, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to close [key_name(target)]'s [surgery.affected_limb.encased], aborting [surgery].")

//------------------------------------

/datum/surgery_step/mend_encased
	name = "Mend Bone"
	desc = "восстановить поврежденные кости"
	tools = SURGERY_TOOLS_BONE_MEND
	time = 3 SECONDS
	preop_sound = 'sound/handling/clothingrustle1.ogg'
	success_sound = 'sound/handling/bandage.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'

//Use materials to mend bones, same as /datum/surgery_step/mend_bones
/datum/surgery_step/mend_encased/extra_checks(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, repeating, skipped)
	. = ..()
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.display_name, PREPOSITIONAL, surgery.affected_limb.display_name) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	if(istype(tool, /obj/item/tool/surgery/bonegel)) //If bone gel, use some of the gel
		var/obj/item/tool/surgery/bonegel/gel = tool
		if(!gel.use_gel(gel.mend_bones_fix_cost))
			to_chat(user, SPAN_BOLDWARNING("[ru_name_tool] закончился!")) // SS220 EDIT ADDICTION
			return FALSE

	else //Otherwise, use metal rods
		var/obj/item/stack/rods/rods = user.get_inactive_hand()
		if(!istype(rods))
			to_chat(user, SPAN_BOLDWARNING("У вас должны быть металлические прутья, чтобы починить [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION
			return FALSE
		if(!rods.use(2)) //Refunded on failure
			to_chat(user, SPAN_BOLDWARNING("У вас должно быть больше металлических прутьев, чтобы починить [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION
			return FALSE

/datum/surgery_step/mend_encased/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	var/ru_name_tool = tool.declent_ru() // SS220 EDIT ADDICTION
	if(tool_type == /obj/item/tool/surgery/bonegel)
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете лечить [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает лечить вашу [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает лечить [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

		target.custom_pain("Вы чувствуете, как что-то жжёт внутри вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_NOTICE("Вы начинаете устанавливать металлическую пластину на [ru_name_affected_limb] [target], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает устанавливать металлическую пластину на вашу [ru_name_affected_limb], используя [ru_name_tool]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] начинает устанавливать металлическую пластину на [ru_name_affected_limb] [target], используя [ru_name_tool].")) // SS220 EDIT ADDICTION

		target.custom_pain("Вы чувствуете, как что-то закручивается внутрь вашей [ru_name_affected_limb]!", 1) // SS220 EDIT ADDICTION
		playsound(target.loc, 'sound/items/Screwdriver.ogg', 25, TRUE)

	log_interact(user, target, "[key_name(user)] began mending [key_name(target)]'s [surgery.affected_limb.encased].")

/datum/surgery_step/mend_encased/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	if(tool_type == /obj/item/tool/surgery/bonegel)
		user.affected_message(target,
			SPAN_NOTICE("Вы вылечили [ru_name_affected_limb] [target]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] вылечил вашу [ru_name_affected_limb]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] вылечил [ru_name_affected_limb] [target].")) // SS220 EDIT ADDICTION
	else
		var/improvised_desc = pick("древний хирург", "палач СПН", "сумасшедший цирюльник")
		user.affected_message(target,
			SPAN_NOTICE("Вы наспех укрепляете кости [ru_name_affected_limb] [target], словно какой-то [improvised_desc]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] наспех укрепляет кости вашей [ru_name_affected_limb], словно какой-то [improvised_desc]."), // SS220 EDIT ADDICTION
			SPAN_NOTICE("[user] наспех укрепляет кости [ru_name_affected_limb] [target], словно какой-то [improvised_desc].")) // SS220 EDIT ADDICTION

	if(surgery.affected_limb.status & LIMB_BROKEN)
		to_chat(user, SPAN_NOTICE("Вы вылечили повреждения, нанесённые при извлечении органов, однако кость всё ещё сломана."))
	log_interact(user, target, "[key_name(user)] mended [key_name(target)]'s [surgery.affected_limb.encased], ending [surgery].")

/datum/surgery_step/mend_encased/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	var/ru_name_affected_limb = declent_ru_initial(surgery.affected_limb.encased, ACCUSATIVE, surgery.affected_limb.encased) // SS220 EDIT ADDICTION
	if(surgery.affected_limb.status & LIMB_BROKEN)
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ещё больше повреждая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION
	else
		user.affected_message(target,
			SPAN_WARNING("Ваша рука дёргается, ломая [ru_name_affected_limb] [target]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая вашу [ru_name_affected_limb]!"), // SS220 EDIT ADDICTION
			SPAN_WARNING("Рука [user] дёргается, ломая [ru_name_affected_limb] [target]!")) // SS220 EDIT ADDICTION

		surgery.affected_limb.fracture(100)

	target.apply_damage(10, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to mend [key_name(target)]'s [surgery.affected_limb.encased].")

	if(tool_type != /obj/item/tool/surgery/bonegel)
		to_chat(user, SPAN_NOTICE("Металлические прутья, использованные на [ru_name_affected_limb] [target], отваливаются.")) // SS220 EDIT ADDICTION
		var/obj/item/stack/rods/rods = new /obj/item/stack/rods(get_turf(target))
		rods.amount = 2 //Refund 2 rods on failure
		rods.update_icon()

/*Proof of concept. Functions but does nothing useful.
If fiddling with, uncomment /mob/living/attackby surgery code also. It's pointless processing to have live without any surgeries for it to use.*/
//////////////////////////////////////////////////////////////////
// NONHUMAN SURGERIES //
//////////////////////////////////////////////////////////////////
/*
/datum/surgery/open_test_incision
	name = "Open Test Incision"
	priority = SURGERY_PRIORITY_MAXIMUM
	possible_locs = ALL_LIMBS
	invasiveness = list(SURGERY_DEPTH_SURFACE)
	required_surgery_skill = SKILL_SURGERY_NOVICE
	steps = list(/datum/surgery_step/test_incision)
	pain_reduction_required = NONE //Xenos cannot process painkillers.
	requires_bodypart = FALSE //Xenos have no limbs.
	target_mobtypes = list(/mob/living/carbon/xenomorph, /mob/living/simple_animal/cat/Jones)
	lying_required = FALSE

/datum/surgery_step/test_incision
	name = "Make Incision (Nonhuman)"
	desc = "make an incision"
	tools = SURGERY_TOOLS_INCISION
	time = 2 SECONDS

/datum/surgery_step/test_incision/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_NOTICE("You start to make an incision on [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("[user] starts making an incision on your [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("[user] starts making an incision on [target]'s [parse_zone(target_zone)] with \the [tool]."))

	log_interact(user, target, "[key_name(user)] began making an incision in [key_name(target)]'s [parse_zone(target_zone)].")

/datum/surgery_step/test_incision/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_NOTICE("You finish the incision on [target]'s [parse_zone(target_zone)]."),
		SPAN_NOTICE("[user] finishes the incision on your [parse_zone(target_zone)]."),
		SPAN_NOTICE("[user] finishes the incision on [target]'s [parse_zone(target_zone)]."))

	target.incision_depths[target_zone] = SURGERY_DEPTH_SHALLOW
	user.add_blood(target.get_blood_color(), BLOOD_HANDS)
	log_interact(user, target, "[key_name(user)] made an incision in [key_name(target)]'s [parse_zone(target_zone)], beginning [surgery].")

/datum/surgery_step/test_incision/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_WARNING("Your hand slips, slicing [target]'s [parse_zone(target_zone)] in the wrong place!"),
		SPAN_WARNING("[user]'s hand slips, slicing your [parse_zone(target_zone)] in the wrong place!"),
		SPAN_WARNING("[user]'s hand slips, slicing [target]'s [parse_zone(target_zone)] in the wrong place!"))

	target.apply_damage(10, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to make an incision in [key_name(target)]'s [parse_zone(target_zone)], aborting [surgery].")
	return FALSE

//------------------------------------

/datum/surgery/mend_test_organ
	name = "Mend Organ (Nonhuman)"
	priority = SURGERY_PRIORITY_HIGH
	possible_locs = list("chest")
	required_surgery_skill = SKILL_SURGERY_TRAINED
	target_mobtypes = list(/mob/living/simple_animal/cat/Jones)
	steps = list(/datum/surgery_step/mend_test_organ_step)
	pain_reduction_required = NONE //Xenos cannot process painkillers.
	requires_bodypart = FALSE //Xenos have no limbs.
	lying_required = FALSE

//------------------------------------

/datum/surgery_step/mend_test_organ_step
	name = "Repair Damaged Organs"
	desc = "repair the organ damage"
	tools = list(
		/obj/item/stack/medical/advanced/bruise_pack = SURGERY_TOOL_MULT_IDEAL,
		/obj/item/stack/medical/advanced/bruise_pack/predator = SURGERY_TOOL_MULT_SUBSTITUTE,
		/obj/item/stack/medical/bruise_pack = SURGERY_TOOL_MULT_AWFUL,
	)
	time = 3 SECONDS

/datum/surgery_step/mend_test_organ_step/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_NOTICE("You begin attempting to treat [target]'s heart with [tool]."),
		SPAN_NOTICE("[user] begins an attempt to treat your heart with [tool]."),
		SPAN_NOTICE("[user] begins an attempt to treat [target]'s heart with [tool]."))

	playsound(target.loc, 'sound/handling/bandage.ogg', 25, TRUE)
	log_interact(user, target, "[key_name(user)] began mending organs in [key_name(target)]'s [parse_zone(target_zone)], beginning [surgery].")

/datum/surgery_step/mend_test_organ_step/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_WARNING("Despite all your training, all you can find is a small shriveled chunk of black stone where [target]'s heart should be!"),
		SPAN_WARNING("[user] searches desperately, but can't find your heart."),
		SPAN_WARNING("[user] searches desperately, but can't find [target]'s heart!"))

	target.universal_speak = TRUE
	target.say("You can't find what never existed, you two-legged fool.")
	target.universal_speak = FALSE

	log_interact(user, target, "[key_name(user)] \"treated organs\" in an incision in [key_name(target)]'s [parse_zone(target_zone)], ending [surgery].")

/datum/surgery_step/mend_test_organ_step/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_WARNING("Your hand slips, bruising the organs in [target]'s [parse_zone(target_zone)]!"),
		SPAN_WARNING("[user]'s hand slips, bruising the organs in your [parse_zone(target_zone)]!"),
		SPAN_WARNING("[user]'s hand slips, bruising the organs in [target]'s [parse_zone(target_zone)]!"))

	target.apply_damage(10, BRUTE, target_zone)
	log_interact(user, target, "[key_name(user)] failed to mend organs in [key_name(target)]'s [parse_zone(target_zone)], aborting [surgery].")
	return FALSE

//------------------------------------

/datum/surgery/close_test_incision
	name = "Close Incision (Nonhuman)"
	priority = SURGERY_PRIORITY_MINIMUM
	possible_locs = ALL_LIMBS
	required_surgery_skill = SKILL_SURGERY_NOVICE
	steps = list(/datum/surgery_step/cauterize/close_test_incision_step)
	self_operable = TRUE
	pain_reduction_required = NONE //Xenos cannot process painkillers.
	requires_bodypart = FALSE //Xenos have no limbs.
	target_mobtypes = list(/mob/living/carbon/xenomorph, /mob/living/simple_animal/cat/Jones)
	lying_required = FALSE

//------------------------------------

/datum/surgery_step/cauterize/close_test_incision_step/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_NOTICE("You start cauterizing the incision on [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("[user] starts to cauterize the incision on your [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("[user] starts to cauterize the incision on [target]'s [parse_zone(target_zone)] with \the [tool]."))

	log_interact(user, target, "[key_name(user)] began cauterizing an incision in [key_name(target)]'s [parse_zone(target_zone)], beginning [surgery].")

/datum/surgery_step/cauterize/close_test_incision_step/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_NOTICE("You cauterize the incision on [target]'s [parse_zone(target_zone)]."),
		SPAN_NOTICE("[user] cauterizes the incision on your [parse_zone(target_zone)]."),
		SPAN_NOTICE("[user] cauterizes the incision on [target]'s [parse_zone(target_zone)]."))

	target.incision_depths[target_zone] = SURGERY_DEPTH_SURFACE
	log_interact(user, target, "[key_name(user)] cauterized an incision in [key_name(target)]'s [parse_zone(target_zone)], ending [surgery].")

/datum/surgery_step/cauterize/close_test_incision_step/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, tool_type, datum/surgery/surgery)
	user.affected_message(target,
		SPAN_WARNING("Your hand slips, leaving a small burn on [target]'s [parse_zone(target_zone)]!"),
		SPAN_WARNING("[user]'s hand slips, leaving a small burn on your [parse_zone(target_zone)]!"),
		SPAN_WARNING("[user]'s hand slips, leaving a small burn on [target]'s [parse_zone(target_zone)]!"))

	target.apply_damage(3, BURN, target_zone)
	log_interact(user, target, "[key_name(user)] failed to cauterize an incision in [key_name(target)]'s [parse_zone(target_zone)], aborting [surgery].")
	return FALSE
*/
