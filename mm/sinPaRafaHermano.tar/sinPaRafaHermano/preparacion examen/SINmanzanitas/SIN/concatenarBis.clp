;Concatenar dos vectores y ordenarlo de menor a mayor


(deffacts hechos
(vector vector1 1 2 4 5 2 7 )
(vector vector2 3 5 6 11 13 14 4 8)
(vector todos-los-datos )
)





(defrule concatenarVectores
	(vector ?nombre $?principio ?x $?final)
	?v<-(vector todos-los-datos $?valores)
	(not(vector todos-los-datos $? ?x $?)) ;para controlar que el dato no este en el vector
	=>
	(retract ?v)
	(assert ( vector todos-los-datos $?valores ?x)))




(defrule ordenar
	?h1<- (vector todos-los-datos $?principio ?x $?medio ?y&:(> ?x ?y) $?final)
	=>
	(retract ?h1)
	(assert (vector todos-los-datos $?principio ?y $?medio ?x $?final )))