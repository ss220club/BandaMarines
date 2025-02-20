/datum/config_entry/flag/bump_attacks
	default = FALSE

/datum/admins/proc/toggle_bump_attacks()
	set name = "Toggle Bump Attacks"
	set desc = "Enables/Disables Bump Attacks"
	set category = "Admin"
	if(!(usr.client.admin_holder?.rights & R_ADMIN))
		return

	var/confirm = tgui_alert(usr, "Вы уверены, что хотите [CONFIG_GET(flag/bump_attacks) ? "выключить" : "включить"] Bump Attacks?", "Toggle Bump Attacks", list("Да", "Нет"))
	if(confirm == "Нет")
		return

	CONFIG_SET(flag/bump_attacks, !CONFIG_GET(flag/bump_attacks))
	for(var/mob/player in GLOB.player_list)
		if(CONFIG_GET(flag/bump_attacks))
			player.add_bump_attacks()
		else
			player.remove_bump_attacks()

	to_world(SPAN_NOTICE("На сервере теперь [CONFIG_GET(flag/bump_attacks) ? "включены" : "выключены"] Bump Attacks!"))
	log_admin("[key_name(usr)] переключил Bump Attacks. Новое значение - [CONFIG_GET(flag/bump_attacks)]")
