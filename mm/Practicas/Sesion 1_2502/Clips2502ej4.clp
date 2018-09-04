; Ejemplo de como sumar los 7 numeros naturales


( deffacts h1 ; Constructor de hechos 

	(n 0) ; Hecho ordenado 
	(suma 0) 

)

(defrule r1 
?f1<-(n ?x) ; Elemento condicional patron (ECP)
	    ; A la variable ?x se le ligará los valores de los hechos emparejados 
	    ; A la variable ?f se le liga la direccion de hecho con el que empareje 
	    ; el ECP 



?f2<-(suma ?s)
(test (< ?x 7)); Elemento condicionante del test 

=>

(printout t "n= " ?x crlf) 		; Accion de imprimir 

	(assert (n (+ ?x 1)))		; Afirmacion de un hecho nuevo ( n resultado-de-la-suma)

		(retract ?f1)		; Elimina el hecho cuya direccion esta en la variable ?f1
		(retract ?f2)		; Elimina el hecho cuya direccion esta en la variable ?f2

	(assert (suma (+ ?s ?x)))

)