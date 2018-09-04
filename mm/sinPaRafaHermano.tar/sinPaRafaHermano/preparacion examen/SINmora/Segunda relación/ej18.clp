(deftemplate planta
	(slot nombre)
	(multislot caracteristicas)
)

(deffacts plantas
	(planta (nombre hortensia)
		(caracteristicas sombra ciudad maceta creceRapido))
	(planta (nombre adelfa)
		(caracteristicas ciudad maceta cuidadoFacil creceRapido))
	(planta (nombre laurel)
		(caracteristicas frio sombra sequedad sueloHumedo ciudad cuidadoFacil creceRapido))
	(planta (nombre madreselva)
		(caracteristicas ciudad maceta cuidadoFacil creceRapido))
	(planta (nombre gardenia)
		(caracteristicas sombra sueloAcido maceta))
	(planta (nombre enebro)
		(caracteristicas frio sequedad sueloAcido maceta))
	(planta (nombre pimentero)
		(caracteristicas frio sombra sueloHumedo sueloAcido ciudad cuidadoFacil))
	(planta (nombre escaramujo)
		(caracteristicas frio sombra sueloHumedo ciudad cuidadoFacil))
	(planta (nombre acuba)
		(caracteristicas sombra sequedad maceta cuidadoFacil))
	(planta (nombre azalea)
		(caracteristicas sombra sueloHumedo sueloAcido maceta))
)


(deffacts caracteristicas-deseadas
	(caracteristica-deseada sombra)
	(caracteristica-deseada sueloAcido)
	(caracteristica-deseada maceta)
)

;Definimos la regla para comprobar las caracteristicas deseadas y decirte que planta puedes plantar


(defrule dimePlantaPlantar
	(planta (nombre ?nombre))
	(forall
		(caracteristica-deseada ?c1)
		(planta (nombre ?nombre) (caracteristicas $? ?c1 $?))
	)
	(forall
		(planta (nombre ?nombre) (caracteristicas $? ?c2 $?))
		(caracteristica-deseada ?c2)
	)
	=>
	(printout t "Puedes plantar un " ?nombre crlf)
)