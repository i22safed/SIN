;ejercicio 13

(deffacts constructorHechosIniciales
	(dato 4)
	(dato 3)
	(dato 1)
	(todos-los-datos)
)

(defrule reglaForall
	?dir <- (todos-los-datos $?valores)
	(dato ?x)
	(not 
		(todos-los-datos $? ?x $?))
		(forall (dato ?y&:(< ?y ?x))
			(todos-los-datos $? ?y $?)
		)
	
	=>

	(retract ?dir)
	(assert (todos-los-datos $?valores ?x))
)