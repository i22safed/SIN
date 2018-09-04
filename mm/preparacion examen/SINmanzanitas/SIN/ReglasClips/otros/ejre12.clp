(deffacts datos-a-analizar
	(dato 5)
	(dato 3)
	(dato 7)
	(dato 4)
)
(defrule metetodosDatos
	?dato1<-(dato ?x&: (numberp ?x))
	(not(dato ?y&: (> ?x ?y)))
	=>
	(printout t ?x crlf)
	(retract ?dato1)
)