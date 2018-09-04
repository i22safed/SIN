;ejercicio 7 

(deffacts hechos
(datos 6 d hola 3 fa 44 f 9 s 7 20 fa juan 43)
)

(defrule eliminaValoresNoNumericos
	?h1<-(datos $?delante ?x&~:(numberp ?x) $?detras)
	
	;segunda opcion (not(test(numberp ?x)))
	=>
	(retract ?h1)
	(assert(datos $?delante $?detras ))
	
)