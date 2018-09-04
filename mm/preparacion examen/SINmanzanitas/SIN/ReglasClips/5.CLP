;ejercicio5

(deffacts hechos
	(datos juan 11 1 hola pepe 5 6 20)
	(datos 1 20 1 hola 1 1 5 hola adios)
)

(defrule borrarunos
	?h1<-(datos $?ant ?x $?med)
	(and (test(integerp ?x))
		(test(= ?x 1))
	)
	=>
	(retract ?h1)
	(assert(datos $?ant $?med))
)