(deffacts hechos
	(vector hola 1 2 3 4 5 6 7 8)
	(vector adios 1 5 3 2 6 7 8 4)
	(vector pepe 11 12 13 14 15 16)
	(vector luis 4 3 5 6 7 2 4 11 )
)


(defrule NoOrdenado
	(vector ?nombre $?)
	( exists (vector ?nombre $?primero ?x  ?y $?ultimo)
	(test (> ?x ?y)))
	=>
	(printout t "el vector " ?nombre " no esta ordenado" crlf)
)


(defrule Ordenado
	(vector ?nombre $?)
	( forall (vector ?nombre $?primero ?x  ?y $?ultimo)
	(test (<= ?x ?y)))
	=>
	(printout t "el vector " ?nombre "  esta ordenado" crlf)
)
