(deftemplate sensor
	(slot estado 
		(allowed-values correcto incorrecto)
	)
	(slot codigo
		(type INTEGER)
		(range 1 10)
	)
)

(deffacts sensores
	(sensor (estado incorrecto) (codigo 1))
	(sensor (estado correcto) (codigo 2))
	(sensor (estado incorrecto) (codigo 3))
	(sensor (estado correcto) (codigo 4))
	(sensor (estado incorrecto) (codigo 5))
	(sensor (estado incorrecto) (codigo 6))
	(sensor (estado correcto) (codigo 7))
	(sensor (estado correcto) (codigo 8))
	(sensor (estado incorrecto) (codigo 9))
	(sensor (estado incorrecto) (codigo 10))
)

(defrule compruebaSensores
	(sensor(codigo ?x) (estado incorrecto))
	(sensor (codigo ?y&~?x) (estado incorrecto))
	(sensor (codigo ?z&~?y&~?x) (estado incorrecto))
	=>
	(printout t "Fallan 3 o más sensores. Error" crlf)
)