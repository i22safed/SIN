;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 13. Haz un programa que resuelva el ejercicio 9, pero que sólo utilice los hechos con valores		   ;
; numéricos y los inserte de forma ordenada (de menor a mayor) en el hecho todos-losdatos.		   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	(deffacts datos "Datos a comprobar"

		(dato 3)
		(dato 1)
		(dato 2) 
		(todos-datos ))

	(defrule ordenaDatos "Imprimimos los datos antes declarados de menor a mayor"
	(dato ?x) (not (todos-datos $?cabeza ?x $?cola))
	
		?d<-(todos-datos $?z)
		(forall (dato ?y&: (< ?y ?x))
		(todos-datos $?cabeza ?y $?cola))
		
	=>
		
		(retract ?d)
		(assert (todos-datos $?z ?x)))