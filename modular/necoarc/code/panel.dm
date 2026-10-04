/datum/action/necoarc_emote_panel
	name = "Open Necoarc Sound Panel"
	icon_file = 'icons/mob/hud/actions_yautja.dmi'
	button_icon_state = "pred_template"
	action_icon_state = "looc_toggle"

/datum/action/necoarc_emote_panel/action_activate()
	. = ..()

	var/mob/living/carbon/human/human_owner = owner
	var/datum/species/monkey/necoarc/necoarc_species = human_owner.species

	necoarc_species.open_emote_panel()

/datum/necoarc_emote_panel
	/// Static list of every Necoarc emote typepath
	var/static/list/necoarc_emotes
	/// Static list of categories
	var/static/list/necoarc_categories = list()
	/// Panel allows you to spam, so a manual CD is added here
	COOLDOWN_DECLARE(panel_emote_cooldown)

/datum/necoarc_emote_panel/New()
	if(length(necoarc_emotes))
		return

	var/list/emotes_to_add = list()

	for(var/datum/emote/living/carbon/human/necoarc/emote as anything in subtypesof(/datum/emote/living/carbon/human/necoarc))
		if(!initial(emote.key) || initial(emote.no_panel))
			continue

		if(!(initial(emote.category) in necoarc_categories))
			necoarc_categories += initial(emote.category)

		emotes_to_add += emote

	necoarc_emotes = emotes_to_add

/datum/necoarc_emote_panel/proc/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "Emotes", "Necoarc Audio Panel")
		ui.open()

/datum/necoarc_emote_panel/ui_data(mob/user)
	var/list/data = list()

	data["on_cooldown"] = !COOLDOWN_FINISHED(src, panel_emote_cooldown)

	return data

/datum/necoarc_emote_panel/ui_state(mob/user)
	return GLOB.conscious_state

/datum/necoarc_emote_panel/ui_static_data(mob/user)
	var/list/data = list()

	data["categories"] = necoarc_categories
	data["theme"] = "crtred"
	data["emotes"] = list()

	for(var/datum/emote/living/carbon/human/necoarc/emote as anything in necoarc_emotes)
		data["emotes"] += list(list(
			"id" = initial(emote.key),
			"text" = (initial(emote.override_say) || initial(emote.say_message) || initial(emote.key)),
			"category" = initial(emote.category),
			"path" = "[emote]",
		))

	return data

/datum/necoarc_emote_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	switch(action)
		if("emote")
			var/datum/emote/living/carbon/human/necoarc/path

			if(!params["emotePath"])
				return FALSE

			path = text2path(params["emotePath"])

			if(!path || !COOLDOWN_FINISHED(src, panel_emote_cooldown))
				return

			if(!(path in subtypesof(/datum/emote/living/carbon/human/necoarc)))
				return FALSE

			COOLDOWN_START(src, panel_emote_cooldown, 2.5 SECONDS)
			ui.user.emote(initial(path.key))

			return TRUE

/datum/emote/living/carbon/human/necoarc/bubuuu
	key = "bubuuu"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco bu buuu!"
	say_message = "Bu~~ Buuu!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco bu buuu.ogg'

/datum/emote/living/carbon/human/necoarc/doridori
	key = "doridori"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco dori dori dori"
	say_message = "dori-dori-dori-dori."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco dori dori dori.ogg'

/datum/emote/living/carbon/human/necoarc/iiiisa
	key = "iiiisa"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco iiiiisAAAAA"
	say_message = "iiiiisAAAAA!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco iiiiisAAAAA.ogg'

/datum/emote/living/carbon/human/necoarc/mmmmmudamuda
	key = "mmmmmudamuda"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco mmMM Muda muDa"
	say_message = "mmMM~~ Muda-muda."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco mmMM Muda muDa.ogg'

/datum/emote/living/carbon/human/necoarc/nyanyanya
	key = "nyanyanya"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco NYA NYA NYA"
	say_message = "nya-nya-nya."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco NYA NYA NYA.ogg'

/datum/emote/living/carbon/human/necoarc/nyanyanya2
	key = "nyanyanya2"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco NYA NYA NYA 2"
	say_message = "nya-nya-nya."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco NYA NYA NYA2.ogg'

/datum/emote/living/carbon/human/necoarc/nyanya
	key = "nyanya"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco NYA NYA"
	say_message = "nya-nya."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco NYA NYA.ogg'

/datum/emote/living/carbon/human/necoarc/nya
	key = "nya"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco NYA"
	say_message = "nya."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco NYA.ogg'

/datum/emote/living/carbon/human/necoarc/nyanyaa
	key = "nyanyaa"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco NYANYAA NYA NYa"
	say_message = "Nyanyanyanya- nya-- nya."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco NYANYAA NYA NYa.ogg'

/datum/emote/living/carbon/human/necoarc/quiajuuubn
	key = "quiajuuubn"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco quiajuuubn"
	say_message = "guiahuuu!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco quiajuuubn.ogg'

/datum/emote/living/carbon/human/necoarc/sayesa1
	key = "sayesa1"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco Sa Yesa 1"
	say_message = "Sa Yes-a."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco Sa Yesa 1.ogg'

/datum/emote/living/carbon/human/necoarc/sayesa2
	key = "sayesa2"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco Sa Yesa 2"
	say_message = "Sa Yes-a."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco Sa Yesa 2.ogg'

/datum/emote/living/carbon/human/necoarc/ungia
	key = "ungia"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco ungia!"
	say_message = "ung-nya!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco ungia!.ogg'

/datum/emote/living/carbon/human/necoarc/uuuuhhniiia
	key = "uuuuhhniiia"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco UUUUUUUHHHHNIIIAAAAA!!!!"
	say_message = "uuuuuUUU-NIA-NYAAAAA!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco UUUUUUUHHHHNIIIAAAAA!!!!.ogg'

/datum/emote/living/carbon/human/necoarc/yanyanyaan
	key = "yanyanyaan"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco yanyan yaan"
	say_message = "yan~ nya~nyan."
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco yanyan yaan.ogg'

/datum/emote/living/carbon/human/necoarc/gurannyaa
	key = "gurannyaa"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco guran nyaaa"
	say_message = "guran nyaaa~~"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco guran nyaaa.ogg'

/datum/emote/living/carbon/human/necoarc/hoooonoooo
	key = "hoooonoooo"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco hooooonoooooooo!!!"
	say_message = "hooonoooo!!!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco hooooonoooooooo!!!.ogg'

/datum/emote/living/carbon/human/necoarc/bibibii
	key = "bibibii"
	category = NECOARC_EMOTE_CATEGORY_SPECIES
	override_say = "Neco BIBIBII!!"
	say_message = "BI-BI-BI!!!"
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE
	sound = 'modular/necoarc/sound/Neco BIBIBII!!.ogg'
