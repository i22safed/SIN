(deffacts datos-a-analizar
	(datos 1 4 7 8 3)
	(datos 2 8 7 6 5)
)

(defrule imprimeMayor
	(datos ?x&:(evenp ?x) $?z ?y&:(numberp ?y))
	(test (<= ?x ?y))
	=>
	(printout t "El conjunto de datos que cumple la condición ->" ?x $?z ?y crlf))

