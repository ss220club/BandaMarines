// Внимание!
// Если добавляешь MULTIVEHICLE, то добавляй их в GLOB.all_multi_vehicles
// Чтобы они отслеживались в get_multi_vehicles()
/proc/get_spec_vehicles()
	var/list/spec_vehicles = GLOB.all_spec_vehicles.Copy()
	var/list/names = list()
	var/list/namecounts = list()
	var/list/vehicles = list()
	for(var/obj/vehicle/SV in spec_vehicles)
		var/name = SV.name
		if(name in names)
			namecounts[name]++
			name = "[name] #([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		vehicles[name] = SV

	return vehicles


// ==========================================

// Пересечение ловушек теперь ловит и тех кто посажен за кровать / стул / транспорт
/obj/effect/alien/resin/trap/Crossed(atom/A)
	// !!! Потом выпилить если примут фикс на оффы
	if((isStructure(A) && istype(A, /obj/structure/bed)) || (isVehicle(A) && !isVehicleMultitile(A))) // у нас есть передвижные кровати и коляски от них
		var/obj/O = A
		if(O.buckled_mob)
			var/mob/living/M = O.buckled_mob
			O.unbuckle()
			M.forceMove(get_turf(O))
			M.apply_effect(2, WEAKEN)
			to_chat(M, SPAN_HIGHDANGER("Вы въехали на ловушку!"))
		if(istype(O, /obj/vehicle/motorbike))
			var/obj/vehicle/motorbike/OM = O
			if(istype(OM.sidecar, /obj/structure/bed/chair/sidecar/passenger) && OM.sidecar.buckled_mob) // заменить на passenger
				var/mob/living/M = OM.sidecar.buckled_mob //нужно ли делать проверку на тип дочурки?
				OM.unbuckle() // Просто сбрасываем позади
				M.apply_effect(2, WEAKEN)
				to_chat(M, SPAN_HIGHDANGER("Вы упали с тележки после того, как байк въехал на ловушку!"))
	. = ..()

// ==========================================

// Давим окна на машинке
/obj/structure/barricade/wooden/handle_vehicle_bump(obj/vehicle/multitile/V)
	visible_message(SPAN_DANGER("\The [V] crushes [src]!"))
	playsound(V, 'sound/effects/woodhit.ogg', 20)
	take_damage(maxhealth)
	return TRUE

/obj/structure/window_frame/handle_vehicle_bump(obj/vehicle/multitile/V)
	visible_message(SPAN_DANGER("\The [V] crushes [src]!"))
	playsound(V, 'sound/effects/metal_crash.ogg', 20)
	take_damage(max_health)
	return TRUE

// Значки на миникарте для модульной техники
/obj/vehicle/multitile/modul/update_minimap_icon(modules_broken)
	if(!minimap_icon_state)
		return
	SSminimaps.remove_marker(src)
	minimap_icon_state = initial(minimap_icon_state)
	if(health <= 0 || modules_broken)
		minimap_icon_state += "_wreck"
	SSminimaps.add_marker(src, minimap_flags, image('modular/vehicles/icons/map_icons.dmi', null, minimap_icon_state, HIGH_FLOAT_LAYER))

// Вещи в вендор
var/list/cm_vending_vehicle_crew_humvee
GLOBAL_LIST_INIT(cm_vending_vehicle_crew_humvee, list(
	list("STARTING KIT SELECTION:", 0, null, null, null),

	list("PRIMARY WEAPON", 0, null, null, null),
	list("M24-RC1 Remote Cannon", 0, /obj/effect/essentials_set/humvee/autocannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("SECONDARY WEAPON", 0, null, null, null),
	list("M-77F Flare Launcher", 0, /obj/effect/essentials_set/humvee/humvee_flare_launcher, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),
//	list("M24-RC1 Thermobaric Launcher", 0, /obj/effect/essentials_set/humvee/humvee_launcher, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("SUPPORT MODULE", 0, null, null, null),
	list("M24-JTMV Overhead Lights", 0, /obj/item/hardpoint/support/humvee_overhead_lights, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("ARMOR", 0, null, null, null),
	list("M24-JTMV Snowplow", 0, /obj/item/hardpoint/armor/humvee_snowplow, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("REPLACEMENT WHEELS", 0, null, null, null),
	list("Replacement M24-JTMV Wheels", 0, /obj/item/hardpoint/locomotion/humvee_wheels, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_MANDATORY)))

// ==========================================
