(deffacts datos-a-analizar
	(vector chevereUno 1 2 3 4 5 6)
	(vector chevereDos 7 3 8 9 2 1)
)
(defrule compruebaNumerico
	?hecho<-(vector ?nombre $?cabeza ?x&:(numberp ?x) ?y&:(> ?x ?y) $?cola)
	=>
	(printout t "El vector" ?nombre " no está ordenado.")
	(retract ?hecho)
)