(deftemplate persona
	(slot nombre
		(type STRING)
		(default ?NONE))
	(slot apellido
		(type STRING)
		(default ?NONE))
	(slot color-ojos
		(type SYMBOL)
		(allowed-values verdes marrones azules)
		(default marrones))
	(slot edad
		(type INTEGER)
		(default 18))
	(slot altura
		(type FLOAT)
		(default 1.70)))

