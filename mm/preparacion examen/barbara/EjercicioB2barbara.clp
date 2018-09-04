;EjercicioVectorSimetricoPar

(deffacts hechos
	(vector v1 1 7 4 9 8 9 3 7 2 1)
	(vector v2 2 3 4 5 6 7)
	(vector v3 2 1 3 7 8 7 1 1 4 7)
	(vector v4 3 2 7 3 1 3 5 2 8)
)

(defrule esSimetrico
	(vector ?nombre $?valores)
	(test(=(mod(length$ $?valores) 2) 0))
	(not(exists (vector ?nombre $?ant ?x $?med ?y $?post)
		(test(neq ?x ?y))
		(test(=(length$ $?ant) (- (length$ $?post) 1)))
		(test(=(mod(length$ $?ant) 2) 1))
		
		)
	)
	=>
	(printout t "El vector "?nombre" es simétrico en sus posiciones pares" crlf)
)

(defrule esSimetrico2
	(vector ?nombre $?valores)
	(test(=(mod(length$ $?valores) 2) 1))
	(not(exists (vector ?nombre $?ant ?x $?med ?y $?post)
		(test(neq ?x ?y))
		(test(=(length$ $?ant) (length$ $?post)))
		(test(=(mod(length$ $?ant) 2) 1))
		)
	)
	=>
	(printout t "El vector "?nombre" es simétrico en sus posiciones pares 2" crlf)
)