


; Mostrar los vectores que estan ordenados y los que no 


(deffacts vectores

	(vector v1 1 2 3 4 5)
	(vector v2 1 6 73 10 5)
	(vector v3 1 302 3 47 5)
	(vector v4 5))


(defrule imprimeSiOrdenado
	(vector ?nombre $?)
	(forall (vector ?nombre $? ?x ?y $?)
		(test (>= ?y ?x)))
	=>
	(printout t "El vector " ?nombre " está ordenado" crlf)
)

(defrule detectaNoOrdenado
	?h1<-(vector ?nombre $? ?x ?y&:(> ?x ?y) $?)
	=>
	(printout t "El vector " ?nombre " no está ordenado" crlf )
	(retract ?h1)
)

; ====================================================================

; Ordenar vector de mierda 

(deffacts vector 
	
	(vector v1 10 2 4 6 9)
	(vector v2 1 5 6 10 20)
	(vector v3 1 2 3 4 5 6 7)

)

(defrule ordena-vector

	?h1<-(vector ?nombre $?cabeza ?x ?y&:(> ?x ?y) $?cola)	
	=>
	(retract ?h1)
	(assert (vector ?nombre $?cabeza ?y ?x $?cola))

)


; ====================================================================


; Unir los hechos numericos

(deffacts hechos 

	(dato 1)
	(dato 2)
	(dato verde) 
	(dato pascual)
	(todos-datos)
	
)


(defrule insertar-datos

	(dato ?x&:(numberp ?x))
	?h<-(todos-datos $?valores)
	(not (todos-datos $? ?x $?))
	=> 
	(retract ?h)
	(assert (todos-datos ?x $?valores))

)
