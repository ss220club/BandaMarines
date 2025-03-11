//-----------------------------------------------------------
// THIS MODULE REQUIRE CHANGED FILE code\modules\admin\IsBanned.dm
//-----------------------------------------------------------

/datum/modpack/better_player_limit
	name = "Better Player Limit"
	desc = "Change player limit behavior to make it more comfortable for players"
	author = "ThaumicNik"

// Yes, player limit system here works using ban system. This isn't my idea.
/world/IsBanned(key,address,computer_id, type, real_bans_only=FALSE, is_telemetry = FALSE)
	var/ckey = ckey(key)

	// Don't recheck connected clients. Disabling this will lead to semi-random checks of client ban.
	var/client/C = GLOB.directory[ckey]
	if (C && ckey == C.ckey && computer_id == C.computer_id && address == C.address)
		return

	// Admins/streamers are able to bypass this check.
	WAIT_DB_READY
	if(GLOB.admin_datums[ckey] && (GLOB.admin_datums[ckey].rights & R_MOD))
		return ..()

	// If there is no limit or we have less player than our limit value, we go to original proc checks
	if(!(CONFIG_GET(number/limit_players) && CONFIG_GET(number/limit_players) < length(GLOB.clients)))
		return ..()

	// Here we use SSticker.mind in order to check players having a physical body.
	// Ghosts don't have minds, so we don't need to check them.
	for(var/datum/mind/player_mind in SSticker.minds)
		// If not our ckey, skip
		if(player_mind.ckey != ckey)
			continue
		// If alive, go to original proc
		if(player_mind.current.stat != DEAD)
			return ..()
		var/mob/living/carbon/human/player_body = player_mind.current
		// If not human, at this point, player will be considered permanent dead. Skip
		if(!istype(player_body))
			continue
		// Check revivability for humans
		if(player_body.is_revivable())
			return ..()
	return list("reason"="POP CAPPED", "desc"="\nReason: Server is pop capped at the moment at [CONFIG_GET(number/limit_players)] players. Attempt reconnection in 2-3 minutes.")


