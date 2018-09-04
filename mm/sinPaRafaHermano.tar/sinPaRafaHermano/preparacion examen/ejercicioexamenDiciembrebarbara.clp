;ejercicio examen


(deftemplate datos
	(multislot values (type INTEGER))
)

(deftemplate todos-los-datos
	(multislot values (type INTEGER))
)


(deffacts hechos
	(datos (values 3 33))
	(datos (values 45 3 27))
)

(defrule primero
	(datos (values $?ant ?x $?post))
	(not(todos-los-datos (values $?)))
	=>
	(assert(todos-los-datos (values ?x)))
)


(defrule concatenar
	(datos (values $?ant ?x $?post))
	?h1<-(todos-los-datos (values $?valores))
	(not(todos-los-datos (values $? ?x $?)))
	=>
	(retract ?h1)
	(assert(todos-los-datos (values $?valores ?x)))
)

(defrule ordenar
	?h1<-(todos-los-datos (values $?ant ?x $?med ?y&:(< ?y ?x) $?post))
	=>
	(retract ?h1)
	(assert(todos-los-datos (values $?ant ?y $?med ?x $?post)))
)

