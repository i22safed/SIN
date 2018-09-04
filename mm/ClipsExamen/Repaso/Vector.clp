

; Operaciones con vectores:

; 1)El mayor elemento de un vector.
; 
; Primeramente definimos el vector en la base de hechos 


	(deffacts elementos

		( v 1 2 4 5 12 3 0 9 8)) 


; A continuación definimos la regla que nos permita definir el mayor elemento del vector 

	
	(defrule elementoMayor 
	
		( v $?anterior ?x $?siguiente)
		(not (v $?anterior1 ?y&:(> ?y ?x) $?despues1))

	=>

		(printout t ?x crlf))

	
