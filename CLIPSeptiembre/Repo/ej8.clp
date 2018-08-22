

; 8.- Haz un programa que dado un conjunto hechos
; (vector <nombreVector> <val1> ... <valN>)
; con valores numéricos, ordene sus valores de menor a mayor.


(deffacts hechos 

	(vector v1 1 2 9 7 5 4 3 10 30 100))


(defrule ordena-menor-mayor 

	?h <- (vector ?nombre $?begin ?x ?y&:(>= ?x ?y) $?end)

	=> 

	(retract ?h)
	(assert(vector ?nombre $?begin ?y ?x $?end))

)

(defrule ordena-mayor-menor 

	?h <- (vector ?nombre $?begin ?x ?y&:(<= ?x ?y) $?end)

	=> 

	(retract ?h)
	(assert(vector ?nombre $?begin ?y ?x $?end))

)