
;
;14.- Escribe un programa para ayudar a una persona a decidir qué plantas
;     podría plantar. La siguiente tabla indica las características de una
;     serie de plantas (tolerancia al frío, tolerancia a la sombra,
;     tolerancia al clima seco...). La entrada al programa debe
;     consistir en un conjunto de hechos
;     (característica-deseada <característica>) que indiquen
;     características que se desee que tenga una planta.
;     El programa debe mostrar por pantalla el nombre de las plantas
;     que cuenten con las características indicadas, aunque aparte de
;     esas cuenten con otras características
;

(deftemplate planta
    (slot nombre)
    (multislot caracteristicas))

(deffacts plantas
	(planta (nombre hortensia) (caracteristicas sombra ciudad maceta cuidado_facil crece_rapido))
	(planta (nombre helecho) (caracteristicas campo ciudad maceta cuidado_facil))
	(caracteristicas-deseada campo sombra)
   
)


(defrule escogePlanta
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y)
		(planta (nombre ?x)
			(caracteristicas $? ?y $?)))
	=>
	(printout t "Puedes plantar una " ?x crlf)

)