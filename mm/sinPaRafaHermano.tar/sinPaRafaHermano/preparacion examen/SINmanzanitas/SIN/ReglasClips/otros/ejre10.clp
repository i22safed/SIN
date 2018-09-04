(deffacts datos-a-analizar
	(vector 3 5 4 8 2 9 1)
)
(defrule metetodosDatos
	?hecho<-(vector $?cabeza ?x&:(numberp ?x) $?medio ?y&:(> ?x ?y) $?cola)
	=>
	(retract ?hecho)
	(assert (vector $?cabeza ?y $?medio ?x $?cola))
)