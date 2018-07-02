(deffacts hecho
	(datos a 1 hola adios 1 4 1 huehue 1 2 4 1 1 1)
)

(defrule eleminaUno
	?nuevo<-(datos $?cabeza ?x&:(numberp ?x) $?cola)
	(test(= ?x 1))
	=>
	(retract ?nuevo)
	(assert (datos $?cabeza $?cola))
)