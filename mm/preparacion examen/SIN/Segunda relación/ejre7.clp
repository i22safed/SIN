(deffacts datos-a-analizar
	(datos 4 holis 5 3'145 veintisietele�eh 9 8 7)
)

(defrule compruebaNumerico
	?hecho<-(datos $?cabeza ?x&:(not(numberp ?x)) $?cola)
	=>
	(retract ?hecho)
	(assert (datos $?cabeza $?cola))
)