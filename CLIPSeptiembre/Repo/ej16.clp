



;
; 16.- Complementa el ejercicio 8 para que también se detecten
;     los vectores que sí están ordenados. Es decir, sin modificar los
;     hechos ni crear hechos auxiliares, se debe imprimir un mensaje
;     por cada vector (vector <nombreVector> <val1> ... <valN>),
;     indicando si sus elementos están ordenados o no.
;     Se entenderá que en la base de hechos no habrá dos
;     hechos vector con mismo nombre de vector.


(deffacts hechos 

	(vector v1 1 2 4 65 6 7 8)
	(vector v2 8 9 0 6 3 1)
	(vector v3 1 2 3 4 5 6)
	(vector v4 1 2 3 4 56 78 90)

) 

(defrule regla 

	(vector ?nombre $?)
	(forall (vector ?nombre $? ?x ?y $?)
		(test (>= ?y ?x)))
	=>
	(printout t "El vector " ?nombre " está ordenado" crlf)

)