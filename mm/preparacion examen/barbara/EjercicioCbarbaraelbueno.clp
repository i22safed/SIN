(deftemplate coche
	(multislot nombre)
	(multislot caracteristicas)
)


	

(deffacts hechos
	(coche (nombre fiat marea) (caracteristicas robusto grande rapido))
	(coche (nombre lancia duster) (caracteristicas grande automatico familiar))
	(coche (nombre audi A8) (caracteristicas automatico rapido deportivo))
	(coche (nombre mercedes sls) (caracteristicas deportivo robusto rapido))
	(coche (nombre mercedes fiesta) (caracteristicas deportivo robusto rapido))
	(caracteristica-deseada Pepe robusto)
	(caracteristica-deseada Pepe grande)
	(caracteristica-deseada Pepe rapido)
	(caracteristica-deseada Rafa deportivo)
	(caracteristica-deseada Rafa rapido)
	(caracteristica-deseada Rafa robusto)
	(caracteristica-deseada Rafa automatico)
)

(defrule asignar-coche
	(coche (nombre $?nombre) (caracteristicas $? ?x $?))
	(caracteristica-deseada ?nomPerso ?x)
	(forall (caracteristica-deseada ?nomPerso ?x)
			(coche (nombre $?nombre) (caracteristicas $? ?x $?))
	
	)
	(not(asignado $?nombre ?nomPerso))
	=>
	(assert(asignado $?nombre ?nomPerso))
	(printout t "El coche " $?nombre " es asginado a " ?nomPerso crlf)
)
	
