

;
; 15.- Haz un programa en base a la información del ejercicio
;      anterior, pero ahora se imprimirán sólo aquellas plantas
;      que cumplan exactamente con todas las características
;      deseadas (no puede contener otras características)
;

; SOLUCIÓN NO FUNKA 

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