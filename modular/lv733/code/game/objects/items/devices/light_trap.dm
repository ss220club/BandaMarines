/obj/item/device/light_trap
	name = "proximity light trap"
	desc = "A device that reacts to nearby movement with variable blinking speed."
	icon = 'icons/obj/items/lighting.dmi'
	icon_state = "chem"

	w_class = SIZE_SMALL
	anchored = TRUE
	density = FALSE

	var/active = TRUE
	var/light_on = FALSE
	var/light_range = 4
	var/light_power = 1.5
	var/light_color = "#00ff00"
	var/range_trigger = 3
	var/base_blink_delay = 0.6 SECONDS
	var/min_blink_delay = 0.15 SECONDS
	var/next_blink = 0

/obj/item/device/light_trap/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	set_light(0)

/obj/item/device/light_trap/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/device/light_trap/proc/get_closest_distance()
	var/min_dist = null
	for(var/mob/living/target in range(range_trigger, src))
		if(target.stat == DEAD)
			continue

		var/distance = get_dist(src, target)
		if(isnull(min_dist) || distance < min_dist)
			min_dist = distance

	return min_dist

/obj/item/device/light_trap/process()
	if(!active)
		return

	var/dist = get_closest_distance()
	if(isnull(dist))
		light_on = FALSE
		set_light(0)
		return

	if(world.time < next_blink)
		return

	var/ratio = clamp(dist / range_trigger, 0, 1)
	var/blink_delay = lerp(min_blink_delay, base_blink_delay, ratio)
	next_blink = world.time + blink_delay
	light_on = !light_on

	if(light_on)
		set_light(light_range, light_power, light_color)
	else
		set_light(0)
