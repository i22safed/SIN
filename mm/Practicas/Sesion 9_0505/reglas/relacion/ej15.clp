
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 15. Escribe un programa para ayudar a una persona a decidir que plantas podria plantar. La	             ;
; siguiente tabla indica las caracteristicas de una serie de plantas (tolerancia al frio, tolerancia         ;
; a la sombra, tolerancia al clima seco...). 								     ;
; La entrada al programa debe consistir en un conjunto de hechos (caracteristica-deseada <caracteristica>)   ;
; que indiquen caracteristicas que se desee que tenga una planta. El programa debe mostrar por               ;
; pantalla el nombre de las plantas que cuenten con las caracteristicas indicadas, aunque                    ;
; aparte de esas cuenten con otras caracteristicas.							     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Definimos una plantilla para almacena el nombre y sus respectivas caracteristicas

(deftemplate planta
	(slot nombre)
	(multislot caracteristicas)
)

(deffacts plantas

(planta (nombre hortensia)	(caracteristicas sombra ciudad maceta creceRapido))
(planta (nombre adelfa)		(caracteristicas ciudad maceta cuidadoFacil creceRapido))
(planta (nombre laurel)		(caracteristicas frio sombra sequedad humedad ciudad cuidadoFacil creceRapido))
(planta (nombre madreselva)	(caracteristicas ciudad maceta cuidadoFacil creceRapido))
(planta (nombre gardenia)	(caracteristicas sombra acidez maceta))
(planta (nombre enebro)		(caracteristicas frio sequedad acidez maceta))
(planta (nombre pimentero)	(caracteristicas frio sombra humedad acidez ciudad cuidadoFacil))
(planta (nombre escaramujo)	(caracteristicas frio sombra humedad ciudad cuidadoFacil))
(planta (nombre acuba)		(caracteristicas sombra sequedad maceta cuidadoFacil))
(planta (nombre azalea)		(caracteristicas sombra humedad acidez maceta)))


; Declaramos las caracteristicas deseadas que queremos que quiere el jardinero

(deffacts caracteristicas-deseadas

	(caracteristica-deseada sombra)
	(caracteristica-deseada acidez)
	(caracteristica-deseada maceta))


;Definimos la regla para comprobar las caracteristicas deseadas y decirte que planta puedes plantar


(defrule quePlantamos(planta (nombre ?nombre))

	(forall
		(caracteristica-deseada ?c1)
		(planta (nombre ?nombre) (caracteristicas $? ?c1 $?)))

	(forall
		(planta (nombre ?nombre) (caracteristicas $? ?c2 $?))
		(caracteristica-deseada ?c2))

	=>

	(printout t "Puedes plantar la planta: " ?nombre crlf))
