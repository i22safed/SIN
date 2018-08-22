
;
; 6. Haz un programa que dado un conjunto de hechos
; (vector <nombreVector> <val1> ... <valN>), detecte aquellos
; hechos cuyos valores no están ordenados de menor a mayor e
; imprima el mensaje “El vector <nombreVector> no está ordenado”.
; Se entenderá que en la base de hechos no habrá dos hechos
; vector con mismo nombre de vector.
;

(deffacts hechos 
	(vector v1 1 2 4 5 6 7 10)
	(vector v2 5 1 2 4 6 7 8)
	(vector v3 1 1 1 1 1 1 1)
	(vector v4 1 6)
	(vector v5 1 2 3 4 5 6 7)

)
	


(defrule regla

	?h<-(vector ?nombre&:(symbolp ?nombre) $?cabesa ?x ?y&:(> ?x ?y) $?final)
	=>
	(retract ?h)
	(printout t "El vector " ?nombre " no esta ordenado" crlf)

)


(defrule regla1

	?h1<-(vector ?nombre&:(symbolp ?nombre) $?cabesa ?x ?y&:(<= ?x ?y) $?final)

	=>
	(retract ?h1)
	(printout t "El vector " ?nombre " esta ordenado" crlf)

)
