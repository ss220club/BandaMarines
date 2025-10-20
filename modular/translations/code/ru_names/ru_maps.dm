GLOBAL_LIST_EMPTY(ru_map_names)

/proc/ru_map_names_toml(name, prefix, suffix, override_base)
    var/formatted_name = format_text(name)
    if(isnull(GLOB.ru_map_names))
        return list()

    if(!length(GLOB.ru_map_names))
        var/maps_path = "modular/translations/code/translation_data/ru_names/maps.toml"
        if(!fexists(maps_path))
            return list()
        var/list/file_data = rustg_read_toml_file(maps_path)
        for(var/key in file_data)
            GLOB.ru_map_names[key] = file_data[key]

    if(GLOB.ru_map_names[formatted_name])
        var/list/entry = GLOB.ru_map_names[formatted_name]

        var/base = override_base || "[prefix][name][suffix]"
        var/nominative_form = entry["nominative"] || name
        var/genitive_form = entry["genitive"] || nominative_form
        var/dative_form = entry["dative"] || nominative_form
        var/accusative_form = entry["accusative"] || nominative_form
        var/instrumental_form = entry["instrumental"] || nominative_form
        var/prepositional_form = entry["prepositional"] || nominative_form

        return list(
            "base" = base,
            NOMINATIVE = "[prefix][nominative_form][suffix]",
            GENITIVE = "[prefix][genitive_form][suffix]",
            DATIVE = "[prefix][dative_form][suffix]",
            ACCUSATIVE = "[prefix][accusative_form][suffix]",
            INSTRUMENTAL = "[prefix][instrumental_form][suffix]",
            PREPOSITIONAL = "[prefix][prepositional_form][suffix]",
        )
