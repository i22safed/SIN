


(deffacts hecho
	(v1 1 2 3 2 5 6 4)
	(v2 2 4 3 2 4 5 9)
	(todos-los-datos))


(defrule unir

	(v1 $? ?x $?)
	(v2 $? ?y $?)
	(not(test(= ?x ?y)))
	?h1<-(todos-los-datos $?datos)		; A la variable multicampo se le asignara el valor con el que empareje 
	(not(todos-los-datos $? ?y $?))		; y a h1 se le asigna la direccion con el hecho que empareje

=>

	(retract ?h1)
	(assert(todos-los-datos ?y $?datos)))


/// con exists es igual

(defrule unir

	(v1 $? ?x $?)
	(v2 $? ?y $?)
	(not(test(= ?x ?y)))
	?h1<-(todos-los-datos $?datos)
	(not(exists(todos-los-datos $? ?y $?)))

=>

	(retract ?h1)
	(assert(todos-los-datos ?y $?datos)))