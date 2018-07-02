(deffacts datos-a-analizar
	(dato 1)
	(dato 3)
	(dato 5)
	(todosDatos )
)
(defrule metetodosDatos
	?datos<-(dato ?x&: (numberp ?x))
	?hecho<-(todosDatos $?relleno)
	=>
	(retract ?hecho)
	(assert (todosDatos $?relleno ?x))
	(retract ?datos)
)