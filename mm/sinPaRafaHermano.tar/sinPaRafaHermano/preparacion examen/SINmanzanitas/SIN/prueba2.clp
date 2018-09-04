;Concatenar dos vectores y ordenarlo de menor a mayor


(deffacts hechos
(vector vector1 1 2 4 5 2 7 )
(vector vector2 3 5 6 11 13 14 4 8)
(vector todos-los-datos )
)


(defrule concatenarVectores
	(vector ?nombre $?x)
	?v<-(vector todos-los-datos $?valores)
	(not(vector todos-los-datos $? $?x $?))
	=>
	(retract ?v)
	(assert ( vector todos-los-datos $?valores $?x)))



(defrule ordenar
	?h1<- (vector ?nombre $?principio ?x ?y&:(> ?x ?y) $?final)
	=>
	(retract ?h1)
	(assert (vector ?nombre $?principio ?y ?x $?final )))
