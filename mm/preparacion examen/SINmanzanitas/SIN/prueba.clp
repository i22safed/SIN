;Concatenar dos vectores y ordenarlo de menor a mayor


(deffacts hechos
(vector vector1 1 2 4 5 2 7 )
(vector vector2 3 5 6 11 13 14 4 8)
)


(defrule concatenarVectores
	(vector vector1 $?a)
	(vector vector2 $?b)
	=>
	(assert ( vector todos-los-datos $?a $?b)))


(defrule ordenar
	?h1<- (vector todos-los-datos $?principio ?x ?y&:(> ?x ?y) $?final)
	=>
	(retract ?h1)
	(assert (vector todos-los-datos $?principio ?y ?x $?final ))

)