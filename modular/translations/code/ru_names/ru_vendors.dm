/obj/structure/machinery/cm_vending/sorted/populate_product_list_and_boxes(scale)
	. = ..()
	entries_to_ru()

// [1] = Name
// [2] = Amount
// [3] = Item path
/obj/structure/machinery/cm_vending/sorted/proc/entries_to_ru()
	if(!length(listed_products))
		return
	for(var/list/entry in listed_products)
		var/new_name = declent_ru_initial(entry[1])
		// We have override name for this, such as "Flare Pouch (Full)"
		if(!isnull(new_name))
			entry[1] = new_name
			continue
		// Try to get translated item name
		if(entry[3] && ispath(entry[3], /atom))
			var/atom/entry_item = entry[3]
			new_name = declent_ru_initial(entry_item::name)
			// Use untranslated name then
			if(isnull(new_name))
				continue
			entry[1] = capitalize(new_name)
