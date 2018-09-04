;ejercicio 9

(deffacts hechos 
	(dato 1)
	(dato 5)
	(dato verde)
	(todos-los-datos)
)

(defrule union

	?h1<-(dato ?n1)
	?h2<-(todos-los-datos $?todo)
	=>
	(retract ?h1 ?h2)
	(assert(todos-los-datos ?n1 $?todo))
	
)