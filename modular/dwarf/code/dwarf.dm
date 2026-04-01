
/obj/item/reagent_container/food/snacks/dwarf_mushroom
	name = "Странный гриб"
	desc = "Пульсирующий нарост, чьи споры кажутся неестественно тяжелыми. Кажется, если его съесть, мир вокруг станет... чуточку больше."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "amanita"

/obj/item/reagent_container/food/snacks/dwarf_mushroom/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 1)

/obj/item/reagent_container/food/snacks/dwarf_mushroom/On_Consume(mob/M)  
	..()  
	if(istype(M, /mob/living/carbon) && !HAS_TRAIT(M, "dwarf"))  
		add_dwarfism(M)  
	else if(istype(M, /mob/living/carbon))  
		to_chat(M, SPAN_NOTICE("На вкус как обычный сухой гриб. Ничего не произошло."))  

/obj/item/reagent_container/food/snacks/cure_dwarf_mushroom
	name = "Особый гриб"
	desc = "Особый гриб, который, как считается, помогает от всего."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "reishi"

/obj/item/reagent_container/food/snacks/cure_dwarf_mushroom/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 1)

/obj/item/reagent_container/food/snacks/cure_dwarf_mushroom/On_Consume(mob/M)  
	..()  
	if(istype(M, /mob/living/carbon) && HAS_TRAIT(M, "dwarf"))  
		cure_dwarfism(M)  
	else if(istype(M, /mob/living/carbon))  
		to_chat(M, SPAN_NOTICE("На вкус как обычный сухой гриб. Ничего не произошло."))  

/proc/add_dwarfism(mob/living/carbon/C)
	if(!istype(C))
		return
	if(!HAS_TRAIT(C, "dwarf"))
		ADD_TRAIT(C, "dwarf", "mushroom")
		var/matrix/mat = matrix()
		mat.Scale(0.7, 0.7)
		animate(C, transform = mat, time = 20)
		playsound(C, 'modular/sounds/sound/effects/swap.ogg',  25, 1)
		C.visible_message(SPAN_DANGER("[C] внезапно уменьшается!"), SPAN_NOTICE("Всё вокруг кажется огромным..."))

/proc/cure_dwarfism(mob/living/carbon/C)
	if(!istype(C))
		return
	if(HAS_TRAIT(C, "dwarf"))
		REMOVE_TRAIT(C, "dwarf", "mushroom")
		animate(C, transform = matrix(), time = 20)
		playsound(C, 'modular/sounds/sound/effects/staff_healing.ogg',  25, 1)
		C.visible_message(SPAN_DANGER("[C] внезапно возвращается к нормальному размеру!"), SPAN_NOTICE("Мир снова стал привычного размера."))
