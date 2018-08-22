
;
; 9.- Haz un programa que resuelva el ejercicio 7 pero
; sin eliminar los hechos (dato 1), (dato 5), (dato verde)....
; (Se presupone un único hecho todos-los-datos)
;


(deffacts hechos 

	(dato 1)
	(dato 5)
	(dato verde)
	(todos-los-datos))


(defrule uneValores
	(dato ?x)				; Guardamos el dato en ?x (empareja con 
						; cualquiera de los 3 primeros)

	?h2 <-(todos-los-datos $?valores)	; Guarda la direccion del hecho 
						; todos-los-datos $?valores

	(not (todos-los-datos $? ?x $?))	; Comprueba que el valor
						; valor anterior dato ?x está. 
						; Se satisface si no se satisface 
						; el contenido Si no está no se ejecuta 
						; la regla.
						; Si no comprobamos que esté, siempre mete 
						; el mismo numero y entra en bucle infinito 
	=>

	(retract ?h2)				; Retractamos el hecho ?h2

	(assert (todos-los-datos ?x $?valores))	; Afirmamos el hecho todos-los-datos
						; ?x $?valores, por lo tanto estamos
						; metiendo los anteriores mas el actual 

	; Creo lo que hace viene a hacer es una "copia" del hecho 


)