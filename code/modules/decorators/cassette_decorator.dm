/datum/decorator/cassette
	var/list/cassette_data

/datum/config_entry/string/playlist_path

/datum/decorator/cassette/is_active_decor()
	cassette_data = file2list(CONFIG_GET(string/playlist_path))
	return length(cassette_data) > 0

/datum/decorator/cassette/get_decor_types()
	return typesof(/obj/item/device/cassette_tape)

/datum/decorator/cassette/decorate(obj/item/device/cassette_tape/cassette)
	if(!cassette_data)
		return
	cassette.desc = replacetext(cassette_data[cassette.id], "\\n", "\n")
