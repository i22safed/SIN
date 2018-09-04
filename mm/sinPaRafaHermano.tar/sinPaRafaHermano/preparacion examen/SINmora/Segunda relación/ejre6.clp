(deffacts datos-a-analizar
	(vector numeloOcho 7 6 4 5 5 3)
	(vector numeroUno 5 4 7 3 8 9)
)

(defrule compruebaNumeros3y4
	(vector ?nombre $?cabeza ?x&:(numberp ?x) $?enmedio ?y&:(numberp ?y) $?cola)
	(test (or
		(and(= ?x 3)(= ?y 4)) ;Que el 3 se encuentre primero y el 4 segundo o viceversa
		(and(= ?x 4)(= ?y 3))
		)
	)
	(test (= (mod(length$ $?enmedio) 2) 1))
	=>
	(printout t "El vector que cumple la regla es el->"vector ?nombre crlf))