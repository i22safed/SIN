
;
; 11.- Haz un programa que resuelva el ejercicio 9, pero que sólo
;      utilice los hechos con valores numéricos y los inserte de
;      forma ordenada (de menor a mayor) en el hecho todos-los-datos.
;      (Se presupone un único hecho todos-los-datos)
;



(deffacts hechos 

	(dato 10)
	(dato 5)
	(dato verde)
	(dato "azul")
	(dato 42)
	(dato 3300)
	(todos-los-datos)

)


(defrule insertaOrdenado
	(dato ?x&:(numberp ?x))     			; Emparejamos el hecho dato con la variable ?x

	?h<-(todos-los-datos $?valores)			; Emparejamos el hecho todos-los-datos con la 
							; variable multicampo $?valores guardando su 
							; dirección de hecho 

	(not (todos-los-datos $? ?x $?))		; Comprobamos que no este entre los valores que
							; almacena la variable todos-los-datos 

	(not (and					; Comprobamos que el dato Y sea de tipo numerico 
		(dato ?y&:(numberp ?y)&:(< ?y ?x))	; y que no sea Y menor que X
		(not (todos-los-datos $? ?y $?))))	; Comprobamos ademas que Y no esté entre los  
	=>						; valores ya elegidos	

							; El formato del and es como otro condicional 
							; (and (condicion1) (condicion2))

							
	(retract ?h)
	(assert (todos-los-datos $?valores ?x))		; Afirmamos el hecho donde metemos a los valores 
							; que ya hay el nuevo 
)
