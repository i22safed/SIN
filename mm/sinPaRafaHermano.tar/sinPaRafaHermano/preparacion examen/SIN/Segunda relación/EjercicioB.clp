:EjercicioB


(deffacts hechos
	
	(vector coches 0 1 3 2 6 3 7 2 8 1 4)
	
	(vector casas 2 5 4 2 5 1 8)

)





(defrule esSimetrico
	
	(vector ?nombre $?val)
	
	(not(exists(vector ?nombre $?ant ?x $?mid ?y $?post)
			
		(test(neq ?x ?y))
			
		(test(eq (length$ $?ant) (length$ $?post)))
			
		(test(= (mod(length$ $?ant) 2) 1))
)
	
)
	
	=>
	
	(printout t "El vector "?nombre" es simétrico en sus posiciones pares" crlf)

)
