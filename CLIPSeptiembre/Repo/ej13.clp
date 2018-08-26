



;
;13.-	Una planta industrial tiene diez sensores identificados
;	por un código numérico entre 1 y 10. Cada sensor puede
;	encontrarse en un estado correcto o incorrecto. Escribe
;	una plantilla que permita representar la información relativa
;	a los sensores y un conjunto de reglas que imprima un mensaje
;	de advertencia si tres o más sensores se encuentran en un
;	estado incorrecto. Sólo debe mostrarse un mensaje de error
;	aunque haya más de tres sensores en estado incorrecto.
;


(deftemplate sensor

	(slot estado (allowed-symbols correcto incorrecto))
	(slot id (range 1 10))

)

(deffacts hechos-sensor

	(sensor (estado correcto)(id 2))
	(sensor (estado incorrecto)(id 4))
	(sensor (estado correcto)(id 8))
	(sensor (estado incorrecto)(id 9))
	(sensor (estado correcto)(id 10))
	(sensor (estado incorrecto)(id 3))


)

(defrule comprobar-estado
	(exists
		(sensor (id ?x) (estado incorrecto))
		(sensor (id ?y&~?x) (estado incorrecto))
		(sensor (id ?z&~?y&~?x) (estado incorrecto))
	)
	=>
	(printout t "Tres o más sensores se encuentran en estado 			incorrecto" crlf)
)





