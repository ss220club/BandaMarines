/obj/item/storage/belt/shotgun/black/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/slug(src)

/obj/item/storage/belt/shotgun/black/full/random/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		var/random_shell_type = pick(GLOB.shotgun_handfuls_12g)
		new random_shell_type(src)
