/datum/species/vulpkanin
	name = "Vulpkanin"
	name_plural = "Vulpkanin"
	icobase = 'modular/species/icons/body.dmi'
	draw_grayscale = TRUE
	// primitive_form = /datum/species/monkey/vulpkanin
	tail = "vulptail"
	unarmed_type = /datum/unarmed_attack/claws
	flesh_color = "#966464"
	base_color = "#CF4D2F"

	has_organ = list(
		"heart" =    /datum/internal_organ/heart/vulpkanin,
		"lungs" =    /datum/internal_organ/lungs/vulpkanin,
		"liver" =    /datum/internal_organ/liver/vulpkanin,
		"kidneys" =  /datum/internal_organ/kidneys/vulpkanin,
		"brain" =    /datum/internal_organ/brain/vulpkanin,
		"eyes" =     /datum/internal_organ/eyes/vulpkanin /*Most Vulpkanin see in full colour as a result of genetic augmentation, although it cost them their darksight (darksight = 2)												unless they choose otherwise by selecting the colourblind disability in character creation (darksight = 8 but colourblind).*/
		)

/mob/living/carbon/human/vulpkanin/Initialize(mapload)
	. = ..(mapload, new_species = "Vulpkanin")
