
/obj/item/reagent_container/food/snacks/grown/harebell/dwarf
	name = "Странный гриб"
	desc = "Пульсирующий нарост, чьи споры кажутся неестественно тяжелыми. Кажется, если его съесть, мир вокруг станет... чуточку больше."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "amanita"
	filling_color = "#FF0000"
	plantname = "Странный гриб"

/obj/item/reagent_container/food/snacks/grown/harebell/dwarf/On_Consume(mob/living/carbon/M, mob/living/user)
	..()
	if(istype(M) && !HAS_TRAIT(M, "dwarf"))
		add_dwarfism(M)
	else if(istype(M))
		to_chat(M, span_notice("На вкус как обычный сухой гриб. Ничего не произошло."))

/obj/item/reagent_container/food/snacks/grown/harebell/cure_dwarf
	name = "Особый гриб"
	desc = "Особый гриб, который, как считается, помогает от всего."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "reishi"
	filling_color = "#FF4800"
	plantname = "Особый гриб"

/obj/item/reagent_container/food/snacks/grown/harebell/cure_dwarf/On_Consume(mob/living/carbon/M, mob/living/user)
	..()
	if(istype(M) && HAS_TRAIT(M, "dwarf"))
		cure_dwarfism(M)
	else if(istype(M))
		to_chat(M, span_notice("На вкус как обычный сухой гриб. Ничего не произошло."))

/proc/add_dwarfism(mob/living/carbon/C)
	if(!istype(C))
		return
	if(istype(C) && !HAS_TRAIT(C, "dwarf"))
		ADD_TRAIT(C, "dwarf", "mushroom")
		var/matrix/mat = matrix()
		mat.Scale(0.7, 0.7)
		animate(C, transform = mat, time = 20)
		playsound(C, 'modular/sounds/sound/effects/swap.ogg',  25, 1)
		C.visible_message(span_danger("[C] внезапно уменьшается!"), span_notice("Всё вокруг кажется огромным..."))

/proc/cure_dwarfism(mob/living/carbon/C)
	if(!istype(C))
		return
	if(HAS_TRAIT(C, "dwarf"))
		REMOVE_TRAIT(C, "dwarf", "mushroom")
		animate(C, transform = matrix(), time = 20)
		playsound(C, 'modular/sounds/sound/effects/staff_healing.ogg',  25, 1)
		C.visible_message(span_danger("[C] внезапно возвращается к нормальному размеру!"), span_notice("Мир снова стал привычного размера."))
