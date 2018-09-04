(deffacts datos-a-analizar
	(dato 1)
	(dato 3)
	(dato holis)
	(dato 5)
	(dato adiosito)
	(todosDatos )
)
(defrule metetodosDatos
	?datos<-(dato ?x&: (numberp ?x))
	(dato ?y&: (numberp ?y))
	?hecho<-(todosDatos $?relleno)
	(not(dato ?y&: (> ?x ?y)))
	=>
	(retract ?hecho)
	(assert (todosDatos $?relleno ?x))
	(retract ?datos)
)