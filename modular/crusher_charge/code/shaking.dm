//Shaking
/mob/living/carbon/xenomorph/var/xeno_jitter_timer_id = TIMER_ID_NULL

/mob/living/carbon/xenomorph/proc/xeno_jitter(jitter_time = 25)
	set waitfor = 0

	// Cancel any jitter already in progress so chains don't overlap.
	stop_xeno_jitter()

	_xeno_jitter_tick(jitter_time)

/mob/living/carbon/xenomorph/proc/_xeno_jitter_tick(jitter_time)
	set waitfor = 0

	pixel_x = old_x + rand(-3, 3)
	pixel_y = old_y + rand(-1, 1)
	jitter_time--

	if(jitter_time > 0)
		xeno_jitter_timer_id = addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/carbon/xenomorph, _xeno_jitter_tick), jitter_time), 1, TIMER_STOPPABLE)
	else
		xeno_jitter_timer_id = TIMER_ID_NULL
		//endwhile - reset the pixel offsets to zero
		pixel_x = old_x
		pixel_y = old_y

/// Cancels any active xeno_jitter chain and resets pixel offsets to their base values.
/// Safe to call when no jitter is active (no-op in that case).
/mob/living/carbon/xenomorph/proc/stop_xeno_jitter()
	if(xeno_jitter_timer_id != TIMER_ID_NULL)
		deltimer(xeno_jitter_timer_id)
		xeno_jitter_timer_id = TIMER_ID_NULL
		pixel_x = old_x
		pixel_y = old_y
