GLOBAL_LIST_INIT(telephone_ru_names, list(
	// Almayer
	"Almayer" = "Алмаер",
	"Saferoom" = "",
	"Flight Deck" = "",
	"Ordnance Tech" = "",
	"Kitchen" = "",
	"Requisition" = "",
	"Intelligence Center Telephone" = "",
	"Reporter" = "Корреспондент",

	// Medical & Research Dept.
	"Medical & Research Dept." = "",
	"Medical Storage" = "",
	"Chemistry Laboratory" = "",
	"Main Medbay Reception" = "",
	"Operation Theatre 1" = "",
	"Operation Theatre 2" = "",
	"Operation Theatre 3" = "",
	"Operation Theatre 4" = "",
	"Morgue" = "",
	"Main Research Laboratory" = "",
	"Research Containment" = "",

	// Offices
	"Offices" = "Офисы",
	"RO Office" = "",
	"Senior Enlisted Advisor's Office" = "",
	"Commanding Officer's Office" = "",
	"Executive Officer's Office" = "",
	"Aux. Support Officer's Office" = "",
	"CMO Office" = "",
	"CL Office" = "",
	"CE Office" = "",

	// ARES
	"ARES" = "ARES",
	"AI Core" = "",
	"AI Reception" = "",

	// MP Dept.
	"MP Dept." = "Воен. Пол.",
	"Brig Cells" = "",
	"Brig Main Offices" = "",
	"Brig Warden's Office" = "",
	"Brig CMP's Office" = "",

	// Command
	"Command" = "Командование",
	"Starboard Railgun Control" = "",
	"Port Railgun Control" = "",
	"Alpha Overwatch" = "",
	"Bravo Overwatch" = "",
	"Charlie Overwatch" = "",
	"Delta Overwatch" = "",
	"Combat Information Center" = "",
	"CIC Reception" = "",

	// Dropship
	"Dropship" = "Dropship",
	"Alamo" = "Аламо",
	"Normandy" = "Нормандия",
))

/obj/structure/transmitter
	/// Used for searching in UI using original EN name
	var/phone_id_en

/obj/structure/transmitter/Initialize(mapload, ...)
	. = ..()
	phone_id_en = phone_id
	phone_id = GLOB.telephone_ru_names[phone_id] || phone_id
	phone_category = GLOB.telephone_ru_names[phone_category] || phone_category
