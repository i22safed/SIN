;ejercicio 17

(deftemplate plantas 
	(slot nombre
		   (type STRING)
		   (default ?NONE)
		   (allowed-strings "Hortensia" "Adelfa" "Laurel" "Madreselva" "Gardenia" "Enebro" "Pimentero" "Escaramujo" "Aucuba" "Azalea"))
	(multislot caracteristicas
			(type STRING)
			(allowed-strings "Frio" "Sombra" "Suelo Humedo" "Suelo acido" "Ciudad" "Maceta" "Cuidado facil" "Crece rapido" "Sequedad"))
)


(deffacts hechos
(plantas (nombre "Hortensia") (caracteristicas "Sombra" "Ciudad" "Maceta" "Crece rapido"))
(plantas (nombre "Adelfa") (caracteristicas "Ciudad" "Maceta" "Cuidado facil" ))
(plantas (nombre "Laurel") (caracteristicas "Frio" "Sequedad" "Suelo Humedo" "Ciudad" "Cuidado facil" "Crece rapido"))
(plantas (nombre "Enebro") (caracteristicas "Frio" "Sequedad" "Suelo Humedo" "Ciudad" "Cuidado facil"))
)

(deffacts caracteristicas-deseadas
(caracteristica-deseada "Frio")
(caracteristica-deseada "Crece rapido")
)

(defrule comprobar-planta
(plantas (nombre ?y))
(forall (caracteristica-deseada ?x)
(plantas (nombre ?y) (caracteristicas $? ?x $?)) 
)
=>
(printout t "La planta " ?y " cuenta con las caracteristicas indicadas" crlf)
)

	

