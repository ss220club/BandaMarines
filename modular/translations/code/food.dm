/obj/item/reagent_container/food/snacks/mre_pack/meal1
	desc = "Поднос стандартной еды ККМП. На подносе лежат черствый кукурузный хлеб, томатная паста и какая-то зелёная жиза."

/obj/item/reagent_container/food/snacks/mre_pack/meal2
	desc = "Поднос стандартной еды ККМП. На подносле лежат почти сырая свинина, склизкая кукуруза и водянистое картофельное пюрэ."

/obj/item/reagent_container/food/snacks/mre_pack/meal3
	desc = "Поднос стандартной еды ККМП. На подносе лежат подгоревшие спагетти, вялые марковки и две картошки фри."

/obj/item/reagent_container/food/snacks/mre_pack/meal4
	desc = "Поднос стандартной еды ККМП. На подносе лежат холодная пицца, мокрые зеленые бобы и дерьмовое яйцо. Бери что-то кроме пиццы, жирдяй."

/obj/item/reagent_container/food/snacks/mre_pack/meal5
	desc = "Поднос стандартной еды ККМП. На подносе лежат сырая курица, сухой рис и слегка подавленный кусок брокколи."

/obj/item/reagent_container/food/snacks/mre_pack/meal6
	desc = "ККМП не подаёт тофу, хипарь недоделанный. Флаг знаменует ваше поражение."

/obj/item/reagent_container/food/snacks/protein_pack
	desc = "Наиболее фальшиво выглядящий покрытый шоколадом протеиновый батончик, который вы когда-либо видели. Порошок, использованный в батончике, является заменителем заменителя заменяющего молочную сыворотку."

/obj/item/reagent_container/food/drinks/flask
	desc = "Металлическая фляжка с поразительность вместимостью."

/obj/item/reagent_container/food/drinks/flask/marine
	desc = "Металлическая фляжка c гравировкой логотипа ККМП. Вероятно заполнена суспензией из воды, моторного масла и медицинского спирта."

/obj/item/reagent_container/food/drinks/flask/weylandyutani
	desc = "Металлическая фляжка c гравировкой логотипа Вейланд-Ютани. В раздатчиках военных кораблей США данные фляжки вероятно появились из-за какого-то корпората-подхалима."

/obj/item/reagent_container/food/drinks/flask/canteen
	desc = "Вы делаете глоток из своей верной фляжки ККМП..."

GLOBAL_LIST_INIT(ru_mre_components, list(
	"boneless pork ribs" = "свинные ребрышки", "grilled chicken" = "курочка-гриль", "pizza square" = "квадратная пицаа", "кусочки спагетти",
	"куриные палочки", "cracker" = "сухари", "cheese spread" = "сырная паста", "rice onigiri" = "онигири", "mashed potatoes" = "картофельное пюрэ",
	"risotto" = "ризотто", "biscuit" = "бисквит", "meatballs" = "фрикадельки", "pretzels" = "крендельки", "peanuts" = "арахис",
	"sushi" = "суши", "spiced apples" = "яблочные дольки", "chocolate brownie" = "шоколадный брауни", "sugar cookie" = "сладкое печенье",
	"coco bar" = "кокосовый балончик", "flan" = "пирог", "honey flan" = "медовик"
	))

/obj/item/storage/box/MRE
	desc = "Готовая к употреблению пища. Одноразовый армейский рацион, предназначенный для снабжения солдата необходимым уровнем питательных веществ для целого дня напряженной работы. Срок годности по меньшей мере на 20 лет превышает ожидаемый срок службы."

/obj/item/storage/box/MRE/declent_ru(declent)
	. = name
	if(declent == "gender")
		. = gender
	if(!length(ru_names))
		return .
	return get_declented_value(ru_names, declent, .)

/obj/item/reagent_container/food/snacks/packaged_meal/declent_ru(declent)
	. = name
	if(declent == "gender")
		. = gender
	if(!length(ru_names))
		return .
	return get_declented_value(ru_names, declent, .)
