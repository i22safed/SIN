(deftemplate barco
	(slot tipo
		(type SYMBOL)
		(allowed-values patrullera dragaminas fragata acorazado destructor portaaviones)
		(default ?NONE))
	(slot estado
		(allowed-values indemne tocado hundido)
		(default ?NONE))
	(slot casillasOcupadas
		(type INTEGER)
		(range 0 4)
		(default ?NONE))
	(slot fila
		(type STRING)
		(default ?NONE))
	(slot columna
		(type INTEGER)
		(default ?NONE)))
		