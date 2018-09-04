; Ejemplo para ver como funciona el motor de inferencia 
; - Como el motor de inferencia realiza el mecanismo de inferencia 
; de comparación de patrones 
; - Como se liga el valor de un campo a una variable 
; - Ver elemento condicional del test
; - Ver operadores aritmeticos 
; - Ver como se liga la direccion de un hecho a una variable
; - Ver como retractar un hecho 

; =================================================================
; Presentar por pantalla los diez primeros numeros naturales 


( deffacts h1; constructor de hechos 

	(n 0); Hecho ordenado

) 

(defrule r1 

	?f<-(n ?x)	; Elemento condicional de patron(ECP)
			; A la variable ?x se le ligará valores de los hechos que emparejen
			; A la variable ?f se le liga la direccion de hecho con el que empareje el ECP

(test ( z ?x 10)); Elemento condicional del test 

=>

(printout t "n= " ?x crlf) ; Accion de imprimir 

(assert (n (+ ?x 1))); 	   ; Afirmacion de un hecho nuevo ( n resultado_de_la_suma)  

(retract ?f) 		   ; Elmina el hecho de cuya direccion está en la variable ?f

) 