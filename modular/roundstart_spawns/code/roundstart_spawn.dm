/datum/roundstart_spawn
	var/list/object_to_spawn = list() // Объекты которые спавним
	var/obj/attached_to_type // Объект к которому привязываем для спавна.
	var/range = 1 // В каком радиусе кидаем объект
	var/ignore_walls = FALSE // Выбираем локацию спавна где нет стен.
	var/ignore_objects = FALSE // Выбираем локацию спавна где ничего нет.

	// Количество доступное для спавна
	var/min_spawns = 0	// От этого начинается отсчет зависимости числа игроков
	var/max_spawns = 3 // Независимо сколько игроков, объектов спавнится не больше этого
	var/current_spawns = 0 // Сколько уже заспавнено

	// Зависимость от числа игроков
	var/required_players = 40 // Требование количества игроков для +1 спавна

/datum/roundstart_spawn/proc/process_spawns()
    if(!length(object_to_spawn) || !attached_to_type)
        return FALSE // Нельзя спавнить без объекта или точки привязки

    // Рассчитываем сколько нужно заспавнить (на основе игроков)
    var/num_players = LAZYLEN(GLOB.new_player_list)
    var/num_to_spawn = clamp(round(num_players / required_players), min_spawns, max_spawns)
    if(num_to_spawn <= current_spawns)
        return FALSE

    // Находим все объекты attached_to_type на карте
    var/list/attached_objects = list()
    for(var/obj/A in world)
        if(istype(A, attached_to_type))
            attached_objects += A

    if(!length(attached_objects))
        return FALSE // Нет объектов для привязки на карте

    for(var/i in 1 to num_to_spawn)
        // Выбираем случайный объект из списка для привязки
        var/obj/attached_obj = pick(attached_objects)
        var/turf/spawn_turf = find_valid_spawn_turf(attached_obj)

        if(!spawn_turf)
            spawn_turf = get_turf(attached_obj) // Если не нашли подходящий — спавним прямо на attached_obj

        if(spawn_turf)
            for(var/O in object_to_spawn)
                new O(spawn_turf)
            current_spawns++
            //message_admins("[ADMIN_COORDJMP(spawn_turf)] - Spawned [object_to_spawn] at [AREACOORD(spawn_turf)].")

    return TRUE

/datum/roundstart_spawn/proc/find_valid_spawn_turf(obj/attached_obj)
    var/turf/center = get_turf(attached_obj)
    if(!center)
        return null

    var/list/valid_turfs = list()

    // Сначала проверяем тайлы ВОКРУГ центра (не включая сам центр)
    for(var/turf/T in orange(range, center)) // orange() в отличии от range() даёт кольцо вокруг центра без центра
        if(!ignore_walls && isclosedturf(T))
            continue
        if(!ignore_objects && (locate(/obj) in T) || (locate(/mob) in T))
            continue
        valid_turfs += T

    // Если нашли подходящие тайлы вокруг — возвращаем случайный
    if(length(valid_turfs))
        return pick(valid_turfs)

    return center
