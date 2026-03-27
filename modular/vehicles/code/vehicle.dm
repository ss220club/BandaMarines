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

// Значки на миникарте для буханок
/obj/vehicle/multitile/uscm_van/update_minimap_icon(modules_broken)
	if(!minimap_icon_state)
		return
	SSminimaps.remove_marker(src)
	minimap_icon_state = initial(minimap_icon_state)
	if(health <= 0 || modules_broken)
		minimap_icon_state += "_wreck"
	SSminimaps.add_marker(src, minimap_flags, image('modular/vehicles/icons/map_icons.dmi', null, minimap_icon_state, HIGH_FLOAT_LAYER))



/obj/item/reagent_container/food/snacks/grown/harebell/dwarf
	name = "Странный гриб"
	desc = "Пульсирующий нарост, чьи споры кажутся неестественно тяжелыми. Кажется, если его съесть, мир вокруг станет... чуточку больше."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "amanita"
	filling_color = "#FF0000"
	plantname = "harebells"

/obj/item/reagent_container/food/snacks/grown/harebell/dwarf/On_Consume(mob/living/carbon/M, mob/living/user)
	..()
	if(istype(M) && !HAS_TRAIT(M, "dwarf"))
		ADD_TRAIT(M, "dwarf", "mushroom")
		var/matrix/mat = matrix()
		mat.Scale(0.7, 0.7)
		animate(M, transform = mat, time = 20)
		M.visible_message(span_danger("[M] внезапно уменьшается!"), span_notice("Всё вокруг кажется огромным..."))

/obj/item/reagent_container/food/snacks/grown/harebell/cure_dwarf
	name = "Особый гриб"
	desc = "Особый гриб, который, как считается, помогает от всего."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "reishi"
	filling_color = "#FF4800"
	plantname = "harebells"

/obj/item/reagent_container/food/snacks/grown/harebell/cure_dwarf/On_Consume(mob/living/carbon/M, mob/living/user)
	..()
	if(istype(M) && HAS_TRAIT(M, "dwarf"))
		cure_dwarfism(M)
	else if(istype(M))
		to_chat(M, span_notice("На вкус как обычный сухой гриб. Ничего не произошло."))

/proc/cure_dwarfism(mob/living/carbon/C)
	if(!istype(C))
		return
	if(HAS_TRAIT(C, "dwarf"))
		REMOVE_TRAIT(C, "dwarf", "mushroom")
		REMOVE_TRAIT(C, "passtable", "mushroom")
		animate(C, transform = matrix(), time = 20)
		C.visible_message(span_danger("[C] внезапно возвращается к нормальному размеру!"), span_notice("Мир снова стал привычного размера."))
