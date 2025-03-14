#define PANIC_BUNKER_SETTINGS_FILE "modular/panic_bunker/settings/panic_bunker.json"
#define READ_JSON_FILE(PATH) (json_decode(file2text(PATH)))
#define WRITE_JSON_FILE(TEXT, PATH) (text2file(json_encode(TEXT),PATH))

GLOBAL_LIST_EMPTY(panic_bunker_bypass)

/proc/log_and_alert(message)
    log_admin(message)
    message_admins(message)

/datum/config_entry/flag/panic_bunker_enabled

/datum/config_entry/number/panic_bunker_min_alive_playtime_hours
	min_val = 1
	max_val = 100

/datum/controller/configuration/proc/LoadPanicBunker()
	var/list/settings = READ_JSON_FILE(PANIC_BUNKER_SETTINGS_FILE)
	CONFIG_SET(flag/panic_bunker_enabled, settings["panic_bunker_enabled"])
	CONFIG_SET(number/panic_bunker_min_alive_playtime_hours, settings["panic_bunker_min_alive_playtime_hours"])
	GLOB.panic_bunker_bypass |= settings["panic_bunker_bypass_ckeys"]

/client/proc/toggle_panic_bunker()
	set name = "Toggle Panic Bunker"
	set desc = "Enables/Disables Panic Bunker"
	set category = "Server.Panic"

	if(!check_rights(R_SERVER))
		return

	var/datum/panic_bunker/panic_bunker = new
	panic_bunker.toggle_panic_bunker(src)

/client/proc/change_panic_bunker_time()
	set name = "Change Panic Bunker Time"
	set desc = "Changes Panic Bunker Time"
	set category = "Server.Panic"

	if(!check_rights(R_SERVER))
		return

	var/datum/panic_bunker/panic_bunker = new
	panic_bunker.change_panic_bunker_time(src)

/client/proc/edit_panic_bunker_bypass()
	set name = "Edit Panic Bunker Bypass"
	set desc = "Edit Panic Bunker Bypass"
	set category = "Server.Panic"

	if(!check_rights(R_SERVER))
		return

	var/datum/panic_bunker/panic_bunker = new
	panic_bunker.edit_panic_bunker_bypass(src)
