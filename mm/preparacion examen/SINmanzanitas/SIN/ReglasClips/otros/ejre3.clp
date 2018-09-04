(deffacts datos-a-analizar
	(datos 1 3)
	(datos 3 1)
	(datos 5 9)
	(datos 8 7)
)

(defrule imprimeMayor
	(datos ?x&:(numberp ?x) ?y&:(numberp ?y))
	(test (< ?x ?y))
	=>
	(printout t "La pareja de datos cumple la condición ->" ?x" , "?y crlf))

