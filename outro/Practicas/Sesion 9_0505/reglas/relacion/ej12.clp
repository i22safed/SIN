
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 12. Haz un programa que dado un conjunto de hechos de tipo dato y un único valor numérico, 		   ;
; imprima los valores numéricos por pantalla de menor a mayor. Vigila que el programa funciona 		   ;
; correctamente incluso con la estrategia de ejecución de reglas Random. 				   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	(deffacts datos "Datos a comprobar"
		(dato 1)
		(dato 8)
		(dato 3))

	(defrule ordenaDatos "Imprimimos los datos antes declarados de menor a mayor"
	?d<-(dato ?x) (not(dato ?y&:(> ?x ?y)))
	=>
	(printout t "Este es el dato: " ?x crlf)
	(retract ?d)
	)