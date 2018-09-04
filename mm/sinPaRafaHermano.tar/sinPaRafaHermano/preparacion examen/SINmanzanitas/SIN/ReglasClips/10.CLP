;ejercicio10

(deffacts hechos 
	(vector vector1 2 6 5 1)
)

(defrule orden 
	?h1<-(vector ?nombreVector $?delante ?x ?y&:(> ?x ?y) $?valores)
	
	=>
	(retract ?h1)
	(assert(vector ?nombreVector $?delante ?y ?x $?valores))
	
)

