;Ejercicio 19
(deffacts vectores
	(vector v1 3 4 1 2 5 29 2 1)
	(vector v2 6 8 9 4)
	(vector v3 6 8 9 13)
	(vector v4 -7 -4 0 3 28))

(defrule detectaNoOrdenado
	(vector ?nombre $? ?x ?y&:(< ?y ?x) $?)
	=>
	(printout t "El vector " ?nombre "no está ordenado" crlf))

(defrule detectaOrdenado
	(vector ?nombre $?)
	(forall (vector ?nombre $? ?x ?y $?)
		(test (>= ?y ?x)))
	=>
	(printout t "El vector " ?nombre " está ordenado" crlf))