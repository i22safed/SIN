(deffacts datos-a-analizar
	(dato 1)
	(dato 3)
	(dato 5)
	(todosDatos )
)
(defrule metetodosDatos
	?datos<-(dato ?x&: (numberp ?x))
	?hecho<-(todosDatos $?relleno)
	(not (todosDatos $?cabeza ?x $?cola))
	=>
	(retract ?hecho)
	(assert (todosDatos $?relleno ?x))
)