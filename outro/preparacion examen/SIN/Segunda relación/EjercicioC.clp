;EjercicioC

(deftemplate coche
	(slot nombre)
	(multislot caracteristicas)
)

(deffacts hechos
	(coche(nombre ford) (caracteristicas grande lujoso rapido))
	(coche(nombre toyota) (caracteristicas lujoso rapido pequeño))
	(coche(nombre audi) (caracteristicas fuerte lujoso rapido))
	(caracteristica-deseada lujoso)
	(caracteristica-deseada grande)
	(caracteristica-deseada rapido)
	(caracteristica-deseada bonito)
	(caracteristica-deseada antiguo)
)
;Apartado 1
(defrule cocheDeseado
	(coche (nombre ?n))
	(forall(coche (nombre ?n)(caracteristicas $? ?x $?))
		(caracteristica-deseada ?x)
	)
	=>
	(printout t "El coche " ?n " tiene las caracteristicas deseadas" crlf)
)
;Apartado 2
(defrule caracErroneas
	(caracteristica-deseada ?x)
	(forall (coche (nombre ?n) (caracteristicas $? ?y $?))
		(caracteristica-deseada ?x&~?y)
	)
	=>
	(printout t "La caracteristica "?x" no es deseada por ningun coche" crlf)
)