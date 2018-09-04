;Ejercicio 21
 
(deffacts hechos 
	(vector 1 2 3 25 4 5 6)
)
(defrule eldelmedio
	(vector $?delante ?x $?detras)
	(test(= (length$ $?delante)
		(length$ $?detras)))
	=>
	(printout t ?x crlf))