/datum/action/xeno_action/activable/throw_hugger
	desc = "Достаёт лицехвата из хранилища или кидает его на расстояние %RANGE%\
		<br>Использование на лицехватах или морферах добавляет их в хранилище."

/datum/action/xeno_action/activable/throw_hugger/apply_replaces_in_desc()
	replace_in_desc("%RANGE%", 4, DESCRIPTION_REPLACEMENT_DISTANCE)

/datum/action/xeno_action/activable/retrieve_egg
	desc = "Достаёт яйцо из хранилища.\
		<br>Использование на морфере перенесёт яйцо в морфер."

/datum/action/xeno_action/onclick/set_hugger_reserve
	desc = "Ограничивает количество доступных лицехватов для наблюдателей."
