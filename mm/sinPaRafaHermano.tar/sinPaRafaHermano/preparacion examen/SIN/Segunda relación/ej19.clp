(deffacts vector
	(datos allahu 1 2 3 4 5 6 7 )
	(datos akbar 3 8 2 1 23 4 13)
)

(defrule imprimeOrdenado
	(datos ?nombre $?)
	(forall(datos ?nombre $?cabeza ?x ?y $?cola)
	(test (<= ?x ?y)	
	=>
	(printout t "El hecho (datos " ?nombre $?cabeza ?x ?y $?cola ") está ordenado")
)