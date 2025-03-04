/datum/preferences
	var/shout_orders

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "shout_orders")
		shout_orders = !shout_orders
	. = ..()

/datum/action/human_action/issue_order/action_activate()
	. = ..()

	var/client/client = owner.client
	if(!client.prefs.shout_orders)
		return

	var/message
	switch(order_type)
		if(COMMAND_ORDER_MOVE)
			message = pick("ДВИГАЕМ БУЛКАМИ!", "ШЕВЕЛИМСЯ!", "ДВИГАЕМСЯ, ДВИГАЕМСЯ!", "ПОШЕЛ, ПОШЕЛ, ПОШЕЛ!", "ВПЕРЕД! БЫСТРЕЕ!", "ДВИГАЙ, ДВИГАЙ, ДВИГАЙ!", "БЕГОМ, МАРШ!", "ШИРЕ ШАГ!", "ШЕВЕЛИМ ЛАСТАМИ!", "ШЕВЕЛИМ НОЖКАМИ, ДАМЫ!")
		if(COMMAND_ORDER_HOLD)
			message = pick("ДЕРЖИМ УДАР!", "БЕРЕЧЬ ГОЛОВУ!", "ПРИГОТОВИТЬСЯ К СТОЛКНОВЕНИЮ!", "ДЕРЖАТЬСЯ!", "ДЕРЖИТЕ СТРОЙ!", "НЕ СДАВАТЬСЯ!", "ПРИГОТОВИТЬСЯ К УДАРУ!")
		if(COMMAND_ORDER_FOCUS)
			message = pick("НЕ ПАЛИТЕ ПО СВОИМ!", "СОСРЕДОТОЧИТЬ ОГОНЬ!", "СТРЕЛЬБА НА ПОРАЖЕНИЕ!", "ПРИМКНУТЬ ШТЫКИ!", "ОГОНЬ ПО ГОТОВНОСТИ!", "ОРУЖИЕ НА ИЗГОТОВКУ!", "ЦЕЛЬСЯ!", "ВНИМАНИЕ!", "ОГОНЬ!", "ГОТОВЬТЕСЬ К БОЮ!", "НАКОРМИТЕ ИХ СВИНЦОМ!", "УНИЧТОЖИТЬ ЦЕЛЬ!")

	if(message)
		owner.say(message)
