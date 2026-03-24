
/datum/species
	var/draw_grayscale = FALSE

/mob/living/carbon/human
	var/draw_color = COLOR_WHITE
	var/tail_wagging = FALSE
	var/vulpkanin_body_markings = "None"
	var/vulpkanin_head_accessory = "None"
	var/vulpkanin_head_marking = "None"
	var/vulpkanin_facial_hair = "None"
	var/vulpkanin_body_markings_color = COLOR_WHITE
	var/vulpkanin_head_accessory_color = COLOR_WHITE
	var/vulpkanin_head_marking_color = COLOR_WHITE
	var/vulpkanin_facial_hair_color = COLOR_WHITE

/datum/species/handle_dead_death(mob/living/carbon/human/H, gibbed)
	..()
	if(H.tail_wagging)
		H.tail_wagging = FALSE
		H.update_tail_showing()
