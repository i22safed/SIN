;3.- Haz un programa que dado un único hecho datos con un número
;    indefinido de valores (ejemplo: (datos hola 1 3 nuevo 1 adios)),
;    elimine todas las apariciones del valor 1.


(deffacts hecho

	(datos hola 1 1 3 nuevo 1 adios 1)

)

(defrule elimina-unos

	
	?h<-(datos $?x 1 $?y) ; Comprobamos elemento a elemento que haya un 
			      ; uno entre dos valores 

	=>

	(retract ?h)	; Elimina hechos de la base de hechos, se debe 
			; especificar el nombre o el indice del hecho 
			; se pueden eliminar 

	(assert (datos $?x $?y))  ; Introduce datos en la base de
				  ; hechos. Se puede utilizar tambien
			  	  ; deffacts 

)