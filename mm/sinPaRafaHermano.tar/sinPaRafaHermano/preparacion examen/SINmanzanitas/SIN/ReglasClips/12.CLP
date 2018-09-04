;ejercicio12

(deffacts hechos 
	(dato 3)
	(dato 1)
	(dato 2)
	(dato 4)
)

(defrule ordenDatos
	(dato ?x)
	(dato ?y&:(< ?x ?y))
	=>
	(assert(dato ?y))
	(assert(dato ?x))
	(printout t "dato "?x)
	
)
