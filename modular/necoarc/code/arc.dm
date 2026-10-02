/datum/species/monkey/necoarc
	name = "Necoarc"
	name_plural = "Necoarc"
	

	icobase = 'modular/necoarc/icon/r_NecoArc.dmi'
	deform = 'modular/necoarc/icon/r_NecoArc.dmi'

	tail = null

/datum/species/monkey/necoarc/handle_post_spawn(mob/living/carbon/human/H)
	. = ..()
	give_action(H, /datum/action/necoarc_emote_panel)
	H.set_languages(ALL_SYNTH_LANGUAGES)
	H.skills = new /datum/skills/necoarc(H)

/datum/species/monkey/necoarc/open_emote_panel()
	var/datum/necoarc_emote_panel/ui = new(usr)
	ui.ui_interact(usr)

/mob/living/carbon/human/necoarc/Initialize(mapload)
	. = ..(mapload, new_species = "Necoarc")

/datum/emote/living/carbon/human/necoarc
	species_type_allowed_typecache = list(/datum/species/monkey/necoarc)
	emote_type = EMOTE_AUDIBLE
	audio_cooldown = 0.3 SECONDS
	
	var/category = ""
	var/override_say = ""
	var/no_panel = FALSE

/datum/emote/living/carbon/human/necoarc/run_emote(mob/user, params, type_override, intentional = FALSE)
	. = TRUE

	if(!can_run_emote(user, TRUE, intentional))
		return FALSE

	var/msg = select_message_type(user, message, intentional)

	if(params && message_param)
		msg = select_param(user, params)

	if(replace_pronouns)
		msg = replace_pronoun(user, msg)

	if(say_message)
		user.say(say_message)

	var/tmp_sound = get_sound(user)

	if(TIMER_COOLDOWN_CHECK(user, type))
		to_chat(user, SPAN_NOTICE("Вы уже использовали эмоцию. Подождите немного, прежде чем попробовать снова."))
		return

	if(tmp_sound && should_play_sound(user, intentional))
		if(TIMER_COOLDOWN_CHECK(user, type))
			return

		TIMER_COOLDOWN_START(user, type, audio_cooldown)
		playsound(user, tmp_sound, volume, vary)

	log_emote("[user.name]/[user.ckey] : [msg ? msg : key]")

	if(!msg)
		return

	var/paygrade = user.get_paygrade()
	var/formatted_message = "<b>[paygrade][user]</b> [msg]"
	var/user_turf = get_turf(user)
	var/list/seeing_obj = list()

	if(user.client)
		for(var/mob/ghost as anything in GLOB.dead_mob_list)
			if(!ghost.client || isnewplayer(ghost))
				continue
			if(ghost.client.prefs.toggles_chat & CHAT_GHOSTSIGHT && !(ghost in viewers(user_turf, null)))
				ghost.show_message(formatted_message)

	if(emote_type & EMOTE_AUDIBLE)
		var/formatted_deaf_message = "<b>[paygrade][user]</b> [alt_message ? alt_message : key_third_person] silently."
		user.audible_message(formatted_message, deaf_message = formatted_deaf_message)
	else if(emote_type & EMOTE_VISIBLE)
		user.visible_message(formatted_message, blind_message = SPAN_EMOTE("You see how <b>[user]</b> [msg]"))

	if(emote_type & EMOTE_IMPORTANT)
		for(var/mob/living/viewer in viewers())
			if(is_blind(viewer) && isdeaf(viewer))
				to_chat(viewer, msg)

	if(intentional)
		if(emote_type & EMOTE_VISIBLE)
			var/list/viewers = get_mobs_in_view(7, user)
			for(var/mob/current_mob in viewers)
				for(var/obj/object in current_mob.contents)
					if((object.flags_atom & USES_SEEING))
						seeing_obj |= object
				if(!(current_mob.client?.prefs.toggles_langchat & LANGCHAT_SEE_EMOTES))
					viewers -= current_mob
			run_langchat(user, viewers)
		else if(emote_type & EMOTE_AUDIBLE)
			var/list/heard = get_mobs_in_view(7, user)
			for(var/mob/current_mob in heard)
				for(var/obj/object in current_mob.contents)
					if((object.flags_atom & USES_HEARING))
						seeing_obj |= object
				if(current_mob.ear_deaf)
					heard -= current_mob
					continue
				if(!(current_mob.client?.prefs.toggles_langchat & LANGCHAT_SEE_EMOTES))
					heard -= current_mob
			run_langchat(user, heard)

	for(var/obj/object as anything in seeing_obj)
		object.see_emote(user, msg, (emote_type & EMOTE_AUDIBLE))

	SEND_SIGNAL(user, COMSIG_MOB_EMOTED(key))

/datum/skills/necoarc
	name = "necoarc"
	skills = list(
		SKILL_CQC = SKILL_CQC_MAX,
		SKILL_MELEE_WEAPONS = SKILL_MELEE_MAX,
		SKILL_FIREARMS = SKILL_FIREARMS_MAX,
		SKILL_SPEC_WEAPONS = SKILL_SPEC_ALL,
		SKILL_ENDURANCE = SKILL_ENDURANCE_MAX,
		SKILL_ENGINEER = SKILL_ENGINEER_MAX,
		SKILL_CONSTRUCTION = SKILL_CONSTRUCTION_MAX,
		SKILL_LEADERSHIP = SKILL_LEAD_MAX,
		SKILL_OVERWATCH = SKILL_OVERWATCH_MAX,
		SKILL_MEDICAL = SKILL_MEDICAL_MAX,
		SKILL_SURGERY = SKILL_SURGERY_MAX,
		SKILL_RESEARCH = SKILL_RESEARCH_MAX,
		SKILL_ANTAG = SKILL_ANTAG_MAX,
		SKILL_PILOT = SKILL_PILOT_MAX,
		SKILL_NAVIGATIONS = SKILL_NAVIGATIONS_MAX,
		SKILL_POLICE = SKILL_POLICE_MAX,
		SKILL_POWERLOADER = SKILL_POWERLOADER_MAX,
		SKILL_VEHICLE = SKILL_VEHICLE_MAX,
		SKILL_JTAC = SKILL_JTAC_MAX,
		SKILL_EXECUTION = SKILL_EXECUTION_MAX,
		SKILL_INTEL = SKILL_INTEL_MAX,
		SKILL_DOMESTIC = SKILL_DOMESTIC_MAX,
		SKILL_FIREMAN = SKILL_FIREMAN_MAX,
	)
