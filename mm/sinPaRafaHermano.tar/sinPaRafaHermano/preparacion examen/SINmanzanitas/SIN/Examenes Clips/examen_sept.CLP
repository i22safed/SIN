(deftemplate persona
	(slot id)
	(slot nombre)
	(multislot padres)
	(slot pareja)
)
(deffacts hechos
	(persona (nombre Pedro) (pareja Maria))
	(persona (nombre Maria) (pareja Perdo))
	(persona (nombre Juan) (padres Pedro Maria) (pareja Antonia))
	(persona (nombre Antonia) (pareja Juan))
	(persona (nombre Andres) (padres Pedro Maria) (pareja Carlota))
	(persona (nombre Carlota) (pareja Andres))
	(persona (nombre Manolo) (padres Juan Antonia))

)
(assert (get_hijos Maria))

(defrule hijos
	(get_hijos ?x)
	(persona(nombre ?n) (padres $? ?x $?))
	=>
	(printout t ?n crlf)
)
;ejercicio 4
(defrule nietos
	(get_nietos ?x)
	(persona (nombre ?n) (padres $? ?x $?))
	(persona (nombre ?n2) (padres $? ?n $?))
	=>
	(printout t ?n2 crlf)
)
	
;ejercicio 4
(defrule cunado
	(get_cunado ?x)
	(persona (nombre ?x) ( padres $?y))
	(persona (nombre ?z&:(neq ?x ?z)) (padres $?y) (pareja ?p))
	=>
	(printout t ?p crlf))