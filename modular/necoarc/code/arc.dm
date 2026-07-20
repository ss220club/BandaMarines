/datum/species/monkey/necoarc
	name = "Necoarc"
	name_plural = "Necoarc"

	icobase = 'modular/necoarc/icon/r_NecoArc.dmi'
	deform = 'modular/necoarc/icon/r_NecoArc.dmi'

	tail = null

/mob/living/carbon/human/necoarc/Initialize(mapload) //SS220 ADD
	. = ..(mapload, new_species = "Necoarc") //SS220 ADD