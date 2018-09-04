;ejercicio 6

(deffacts hechos 
	(vector vector1 1 2 bu 3 an 5 2 4)
	(vector vector2 ad d 4 5 2 3) 
	(vector vector3 1 8 2dasd dja)
)

(defrule detecta
	(vector ?nombreVector $?delante ?x $?medio&:(oddp(length$ $?medio)) ?y $?detras)
	(or
		(test(eq ?x 3))
		(test(eq ?x 4))	
	)

	(or 
		(test(eq ?y 3))
		(test(eq ?y 4))
	
	)
	=>
	(printout t "nombre vector correcto: "?nombreVector crlf)	
)

	
	