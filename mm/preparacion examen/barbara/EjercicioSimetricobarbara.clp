;Ejercicio simetrico

(deffacts hechos
	(vector v1 1 8 1 9 1 1 9 1 8 1)
	(vector v2 2 4 3 5 2 1 2)
	(vector v3 8 9 1 2 3 1 3 2 1 9 8)
)

(defrule esSimetrico
	(vector ?nombre $?)
	(not(exists(vector ?nombre $?ant ?x $?med ?y $?post)
			(test(neq ?x ?y))
			(test(eq (length$ $?ant) (length$ $?post)))
		)
	)
	=>
	(printout t "El vector "?nombre" es simétrico" crlf)
)