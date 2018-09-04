(deffacts vector
	(datos 1 2 3 4 5 6 7 )
	(datos 3 8 2 1 23 4 13)
)

(defrule detecOrden
	?h1<-(datos $?cabeza ?x ?y&:(> ?x ?y) $?cola)	
	=>
	(printout t "El hecho (datos " $?cabeza ?x ?y $?cola ") no está ordenado")
	(retract ?h1) ;Para que no repita la salida una vez por pareja encontrada
)