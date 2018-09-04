:EjercicioB


(deffacts hechos
	
	(vector coches 0 1 3 2 6 3 7 2 8 1 4)
	
	(vector casas 2 1 4 2 5 1 8)

)





(defrule esSimetrico
	
	(vector ?nombre $?val)
	
	(not(exists(vector ?nombre $?cabeza ?x $?medio ?y $?cola)
			
		(test(neq ?x ?y))
			
		(test(eq (length$ $?cabeza) (length$ $?cola)))
			
		(test (oddp (length$ $?cabeza
)
)))
	)
	=>
	
	(printout t "El vector "?nombre" es simétrico en sus posiciones pares" crlf)

)
