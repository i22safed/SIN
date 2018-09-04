(deffacts datos "Datos a comprobar"
	(dato 1)
	(dato 8)
	(dato 3) 
	(todos-datos )
)

(defrule ordenaDatos "Imprimimos los datos antes declarados de menor a mayor"
	(dato ?x) (not (todos-datos $?cabeza ?x $?cola))
	?d<-(todos-datos $?z)
	(forall (dato ?y&: (< ?y ?x))
	(todos-datos $?cabeza ?y $?cola)
)
=>
(retract ?d)
(assert (todos-datos $?z ?x))
)