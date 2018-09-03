



;
; Ejercicio Remix-Repaso
;

;========================================================

; Agrupa los valores en un solo hecho 

(deffacts hechos 

	(dato 1)
	(dato 0)
	(dato 3)
	(dato 5)
	(dato 2)
	(todos-los-datos)

)

(defrule agrupa-ordenado 

	?h2<-(todos-los-datos $?valores ?x)
	(dato ?valor&:(< ?x ?valor))

	=> 
	(retract ?h2)
	(assert (todos-los-datos $?valores ?x))
)







;======================================================== 