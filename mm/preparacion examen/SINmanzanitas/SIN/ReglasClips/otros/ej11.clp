(deffacts hecho
	(dato 8)
	(dato 1)
	(dato 5)
	(dato verde)
	(dato 45)
	(todos-datos))

(defrule insertaOrden
	(dato ?x)
	?v<-(todos-datos $?valores)
	(not(todos-datos $? ?x $?))
	=>
	(retract ?v)
	(assert(todos-datos $?valores ?x))
)