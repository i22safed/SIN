; 10.-	Haz un programa que dado un conjunto de hechos de tipo dato
;        y un único valor numérico, imprima los valores numéricos
;        por pantalla de menor a mayor. Vigila que el programa
;        funciona correctamente incluso con la estrategia de ejecución
;        de reglas Random.


(deffacts hechos 

	(dato 1)
	(dato 30)
	(dato 10)
	(dato 6)
	(dato 3)
	(dato 100)
	(dato 2)
	(dato 44)

)

(defrule imprime-menor-mayor

	?h<-(dato ?x)			; Emparejamos con cualquiera de los datos 
					; de la base de hechos 

	(not(dato ?y&:(< ?y ?x)))	; Emparejamos con el siguiente hecho 
					; comprobando que Y (siguiente a imprimir) 
					; no sea menor que el anterior X

					; La variable Y empareja con el siguiente
					; que no sea menor que X 
					
					; No repite por que con el retract lo borra 
					; de la base de hechos 

					; Con esta condición nos quitamos de que imprima 
					; un valor de Y menor que X ya que no se 
					; cumpliría la codición imprimir  de menor a mayor 

	=>

	(retract ?h)			; Retractamos de la base de hechos 
	(printout t ?x crlf)		; Imprimimos

)
