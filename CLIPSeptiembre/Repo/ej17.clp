

;
; 17. Haz un programa que dado un único hecho vector con un
;     número indefinido de valores numéricos, imprima el valor que se
;     sitúa justo en medio, o la media de los dos valores de
;     en medio.
;

(deffacts numeros 

	(vector v1 1 2 34 7 3 5 7)
	(vector v2 1 2 4 56 62 23)
	(vector v3 71 3 5 62 1 3 56)
	(vector v4 6 4 6 8 2 1 8)
	(vector v5 9 8 7 1 5 2 4 4)

)

(defrule detecta-medio

	(declare (salience 2))
	(vector ?nombre $?cabesa ?medio $?final&:(= (length$ $?cabesa)(length$ $?final)))
	=> 
	(printout t "El valor del medio es " ?medio crlf)

)

(defrule media-medio

	(vector ?nombre $?cabesa ?x ?y $?final&:(= (length$ $?cabesa)(length$ $?final)))
	=> 
	(printout t "La media de los dos valores del medio es " (/ (+ ?x ?y) 2) crlf)
	
)


