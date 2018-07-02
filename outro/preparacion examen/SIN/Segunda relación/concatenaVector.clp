(deffacts vectores 
	(vector 2 5 7 4 2)
	(vector 7 8 5 0 1)
	(todos-datos )
)


(defrule concatenaVector
	(vector $?cabeza ?x $?cola)
	?v<-(todos-datos $?valores)
	(not(todos-datos $? ?x $?))
	=>
	(retract ?v)
	(assert(todos-datos $?valores ?x))
)

(defrule ordenaVector
	?h<-(todos-datos $?cabeza ?x $?medio ?y&: (> ?x ?y) $?cola)
	=>
	(retract ?h)
	(assert(todos-datos $?cabeza ?y $?medio ?x $?cola))
)