(deftemplate sensor
	(slot codigo (type INTEGER) (range 1 10))
	(slot estado (allowed-values correcto incorrecto)))
(deffacts hechos
	(sensor (codigo 1) (estado correcto))
	(sensor (codigo 2) (estado incorrecto))
	(sensor (codigo 3) (estado correcto))
	(sensor (codigo 4) (estado correcto))
	(sensor (codigo 5) (estado incorrecto))
	(sensor (codigo 6) (estado correcto))
	(sensor (codigo 7) (estado incorrecto))
	(sensor (codigo 8) (estado correcto))
	(sensor (codigo 9) (estado correcto))
	(sensor (codigo 10) (estado correcto))
)
(defrule detectaError
	;Hay tres sensores incorrectos
	(exists
		(sensor (codigo ?x) (estado incorrecto))
		(sensor (codigo ?y&~?x) (estado incorrecto))
		(sensor (codigo ?z&~?y&~?x) (estado incorrecto))
	)
	=>
	(printout t "ERROR" crlf))