


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


)
