;ejercicio1
(deftemplate persona
	(slot id)
	(slot nombre)
	(multislot padres)
	(slot pareja)
)
;ejercicio2
(deffacts hechos-iniciales
	(persona (id 1) (nombre Pedro) (pareja Maria))
	(persona (id 2) (nombre Maria) (pareja Pedro))
	(persona (id 3) (nombre Juan) (padres Pedro Maria) (pareja Antonia))
	(persona (id 4) (nombre Antonia) (pareja Juan))
	(persona (id 5) (nombre Andres) (padres Pedro Maria) (pareja Carlota))
	(persona (id 6) (nombre Carlota) (pareja Andres))
	(persona (id 7) (nombre Manolo) (padres Juan Antonia))
)
;ejercicio 3
(defrule get-hijos
	(get_hijos ?x)
	(persona (nombre ?n) (padres $? ?x $?))
	=>
	(printout t "El hijo es : " ?n crlf)
)
;ejercicio 4
(defrule get-nietos
	(get_nietos ?x)
	(persona (nombre ?n) (padres $? ?x $?))
	(persona (nombre ?n2) (padres $? ?n $?))
	=>
	(printout t "El nieto es: " ?n2 crlf)
)
;ejercicio 5
(defrule get-cunado
	(get_cunado ?x)
	(persona (nombre ?x) (padres ?y ?z))
	(persona  (nombre ?n&~?x) (padres ?y ?z) (pareja ?p))
	=>
	(printout t "EL cunado es: " ?p crlf)
)
	
