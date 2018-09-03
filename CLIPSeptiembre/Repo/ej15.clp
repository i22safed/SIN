

;
; 15.- Haz un programa en base a la informaci�n del ejercicio
;      anterior, pero ahora se imprimir�n s�lo aquellas plantas
;      que cumplan exactamente con todas las caracter�sticas
;      deseadas (no puede contener otras caracter�sticas)
;

; SOLUCI�N NO FUNKA 

(deftemplate planta
    (slot nombre)
    (multislot caracteristicas))

(deffacts plantas
	(planta (nombre hortensia) (caracteristicas sombra ciudad maceta cuidado_facil crece_rapido))
	(planta (nombre helecho) (caracteristicas sombra ciudad maceta))
	(caracteristica-deseada sombra ciudad maceta)
)


(defrule escogePlanta
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y)
		(planta (nombre ?x)
			(caracteristicas $? ?y $?))

	(forall (planta (nombre ?x)
			(caracteristicas $? ?y $?))
			(caracteristica-deseada ?y)))
	=>
	(printout t "Puedes plantar una " ?x crlf)

)